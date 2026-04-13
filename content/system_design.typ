#import "/utils/todo.typ": TODO

= System Design

This chapter describes the system design of the proposed extensions for the Theia IDE. Following the system design document template described by @bruggeObjectorientedSoftwareEngineering2014, this chapter explains how the concepts of the application domain identified in the Requirements chapter are mapped to the solution domain. In particular, it maps the functional requirements (FRs) to subsystem responsibilities and the quality attributes (QAs) to architectural decisions and trade-offs.

== Overview

The system architecture consists of two interdependent layers built as Theia IDE extensions. The first layer is the shell integration subsystem, which instruments the underlying shell process to emit structural markers and parses them in the terminal frontend. This layer transforms the terminal's unstructured byte stream into discrete, addressable command executions. The second layer is the AI terminal assistant subsystem, which builds upon this structured history. It consumes the command blocks to generate automated summaries, error explanations, and solution hints using Large Language Models (LLMs). The AI assistant also integrates with other Theia extensions to enrich the error explanations with code context and provide direct navigation from the assistant view to relevant file locations in the editor.

By separating the system into these layers, the architecture lets the shell integration serve as a foundational API for other Theia extensions, while the AI assistant acts as a distinct consumer of that API.

== Design Goals

The software architecture is guided by both the functional requirements #link(<fr1>)[FR1]-#link(<fr14>)[FR14] and the quality attributes #link(<qa1>)[QA1]-#link(<qa5>)[QA5] defined in the Requirements chapter. #link(<fr1>)[FR1]-#link(<fr6>)[FR6] motivate the shell integration architecture, #link(<fr7>)[FR7]-#link(<fr14>)[FR14] motivate the assistant architecture, and #link(<qa1>)[QA1]-#link(<qa5>)[QA5] shape the detailed decisions regarding shell injection, event handling, UI behavior, prompt design, and LLM integration.

*Usability*
- Error explanations must be comprehensible to students without prior domain knowledge (#link(<qa1>)[QA1]). The system must filter raw stack traces and provide actionable fix steps that guide the student without revealing the full solution.
- The user interface must clearly distinguish AI-generated summaries from raw execution output (#link(<qa2>)[QA2]). In dedicated assistant mode, the user can inspect both side by side; in standalone mode, the user retains access to the relevant execution context even though the raw output is surfaced in a more controlled way.

*Performance*
- The AI summary response must appear within a timeframe acceptable for interactive use (#link(<qa3>)[QA3]). LLM generation must not block the user's primary workflow or the main IDE thread.
- Shell injection must not introduce a measurable or perceptible delay to the terminal startup process (#link(<qa3>)[QA3])
- Parsing the Operating System Command (OSC) markers on the client side must not degrade the rendering performance of the terminal (#link(<qa3>)[QA3]).
- When tasks require keyboard input while still running, the system must forward input and output streams without disruptive lag (#link(<qa3>)[QA3]).

*Reliability*
- The shell startup injection must not break the terminal under any shell configuration. If the integration scripts are missing or the user's shell is unsupported, the system must fall back gracefully to a standard, unstructured terminal (#link(<qa4>)[QA4]).

*Supportability*
- The shell integration layer must expose structured command history through a service so that other extensions can consume terminal context without depending on internal details (#link(<qa5>)[QA5]).

=== Prioritization and Trade-offs

Following @bruggeObjectorientedSoftwareEngineering2014, conflicting design goals require prioritization. In this system, *Reliability* and *Usability* take precedence over maximum *Performance* and feature completeness.

The first trade-off involves generation speed versus the pedagogical quality of the AI output. Generating a high-quality, structured response, including precise file resolution and guided fix steps, supports #link(<fr7>)[FR7]-#link(<fr12>)[FR12] as well as #link(<qa1>)[QA1], but it also increases pressure on #link(<qa3>)[QA3]. The system mitigates this latency by executing the AI agent asynchronously and by updating the UI without blocking the primary workflow. This design therefore favors pedagogically useful output over immediate but less structured responses.

Another trade-off exists between shell integration and terminal reliability. Modifying the pseudoterminal (PTY) layer directly could strengthen capture completeness for #link(<fr1>)[FR1]-#link(<fr4>)[FR4], but it risks destabilizing the terminal for users with complex shell configurations and would weaken #link(<qa4>)[QA4]. Therefore, the design chooses to inject hooks strictly at the shell startup phase via standard configuration files. This prioritizes reliability and fallback safety over absolute capture guarantees.

== Subsystem Decomposition

We decompose the proposed system into two primary subsystems: Shell Integration and AI Terminal Assistant. This decomposition isolates low-level terminal emulation concerns from high-level AI orchestrations.


=== AI Terminal Assistant Subsystem

The AI Terminal Assistant subsystem manages the orchestration of AI-driven features and their integration with the IDE. @assistant-ssd shows the internal structure of this subsystem and highlights how the assistant combines task monitoring, LLM analysis, source resolution, and UI presentation.

- *AI Terminal Assistant Core:* This component acts as the central coordinator. It subscribes to IDE task events via the `Task Monitoring Service`, which handles code execution. Upon task completion it retrieves the relevant `CommandBlock` via the `Command History Service` and initiates the AI analysis.
- *Summary Agent:* Operating as the core AI integration component, the agent accepts recent terminal contents and requests a structured response from the LLM via the LLM Service provided by the `AI-Core Extension`. The output schema enforces a specific format containing the success status, a plain-text summary, and an array of error objects detailing the category, file, line, explanation, and fix steps.
- *Error Source Resolver:* Before displaying results, the subsystem resolves relative file paths from the LLM output against the actual workspace using the file search APIs of the `Workspace Service`. It extracts the surrounding code context for affected lines via the `File Access Service` to improve editor navigation. The Error Source Resolver can also open the error source directly in the editor and adds decorations via the `Editor Decoration Service`.
- *AI Terminal Assistant View:* The frontend UI comprises the `Assistant View Widget`, which hosts the `Summary View` (displaying execution status, error explanations, and fix hints) alongside a context surface that presents the underlying task output either as a visible terminal buffer or as preserved execution context, depending on the active mode.

#figure(
  image("../figures/assistant-ssd.pdf"),
  caption: [This component diagram shows how the AI Terminal Assistant combines task monitoring, LLM-based summarization, local source resolution, and UI rendering. It illustrates that the assistant depends on structured terminal context and enriches it before presenting pedagogical feedback.]
) <assistant-ssd>

*AI Analysis and Enrichment Pipeline*

The AI Analysis and Enrichment Pipeline operates in two distinct assistant modes. The first mode, referred to as the dedicated case, integrates the assistant alongside a visible terminal widget. This configuration provides the highest level of transparency because the user can inspect the summary and the raw task output at the same time. @assistant-a-sequence illustrates the summary creation flow for this configuration.

#figure(
  image("../figures/assistant-a-sequence.svg"),
  caption: [This sequence diagram shows how the dedicated assistant mode generates a summary next to a visible terminal widget. It highlights that the system analyzes a completed task, enriches the LLM output with local source information, and then renders the result in the assistant view.]
) <assistant-a-sequence>

When a user initiates a task, the system routes the execution output to the standard terminal. Upon task completion, the IDE emits an `executionFinished` event, which notifies the AI Terminal Assistant Core. The core subsequently retrieves the most recent command block from the active terminal widget. The assistant passes the content of this command execution to the Summary Agent alongside a predefined prompt. The agent generates a structured summary comprising error explanations, remediation hints, and the relevant filename.

To enhance the utility of this summary, the system passes the filename to the Error Source Resolver, which enriches the data with the absolute file path and specific error lines. The system then forwards this enriched summary, equipped with a function handler to open the exact error location in the editor, to the Assistant View for display.

The secondary mode, or the standalone case, operates without a visible terminal widget. This mode prioritizes focus and support for interactive tasks over full simultaneous visibility of the raw terminal buffer. @assistant-b-sequence depicts the summary creation flow for this scenario and omits the enrichment step for readability.

#figure(
  image("../figures/assistant-b-sequence.svg"),
  caption: [This sequence diagram shows how standalone mode handles assistant-driven executions without a visible terminal widget. It emphasizes the interaction loop between the user and the terminal buffer view during interactive command execution.]
) <assistant-b-sequence>

In this configuration, the system must support interactive terminal sessions, as certain code executions require user input before the command has finished. To satisfy this requirement, we instantiate a new, hidden terminal for each execution and propagate input and output streams directly between this invisible terminal and the assistant component. This design circumvents the limitation that the terminal history mechanism only captures commands after they have finished executing, thereby ensuring continuous interaction during active tasks.

Compared with the dedicated mode, the standalone mode provides a lower level of immediate transparency because the full raw terminal buffer is not shown side by side throughout the execution. However, the system preserves traceability by retaining the relevant execution context and exposing it after completion as the basis of the generated summary. This trade-off is acceptable because the primary purpose of the mode is to reduce visual noise and to still support interactive tasks.

*Educational Prompt Design*

Prompt design is part of the system architecture because it mediates between the LLM's free-form generation and the deterministic contracts required by the UI and service layer. The pedagogical tone of the prompt directly supports #link(<fr10>)[FR10] and #link(<qa1>)[QA1]: the prompt instructs the model to explain errors in accessible language and to provide hints that guide the student without revealing the full solution.

The prompt also supports #link(<fr7>)[FR7]-#link(<fr12>)[FR12] through a strict JSON schema and validation logic. The schema separates summary text, structured error entries, file and line references, and remediation hints so the assistant can render them deterministically. The prompt requires structured filename and line information to support #link(<fr11>)[FR11], and it preserves the link between the AI output and the underlying execution context required by #link(<fr12>)[FR12].

Finally, the prompt avoids direct code rewrites because the thesis interprets #link(<fr10>)[FR10] as a pedagogical guidance requirement rather than an automated fixing requirement. In this sense, prompt design is not only an implementation detail but also a design mechanism through which the assistant satisfies both the educational scope of the thesis and the reliability constraints of the surrounding system.

*AI Terminal Assistant View*

#figure(
  image("../figures/assistant-screen.png"),
  caption: [This screenshot shows the assistant view after a failed task execution. It illustrates how the interface combines status feedback, structured error explanations, remediation hints, and traceability to the underlying execution output.]
) <terminal-assistant-screenshot>

@terminal-assistant-screenshot shows the AI terminal assistant view in a failure case. This view realizes #link(<fr7>)[FR7]-#link(<fr12>)[FR12] by presenting the generated summary, execution status, structured error entries, remediation hints, editor navigation, and access to the underlying execution context. At the same time, it supports #link(<qa1>)[QA1] through plain-language explanations and #link(<qa2>)[QA2] through traceability to raw output. The panel acts as a dedicated surface configured according to the assistant mode. A status indicator border on the left edge provides immediate visual feedback: green for success and red for failure. The panel header displays the build result as a title with an accompanying icon, followed by a brief text summary detailing the project name, executed class, and total error count.

Below the header, the view lists expandable error cards. Each card displays the error category, specific error type, affected file, line number, and contextual action buttons, such as an "Open in Editor" control. Expanding a card reveals the structured explanation text, where labels clarify the pedagogical purpose of each segment. A "Proposed fix" section remains collapsed by default, containing hints designed to resolve the error without outright revealing the solution. Depending on the assistant mode, the view also shows either the raw output of the task side by side or a preserved execution context that documents the output on which the summary is based.

=== Terminal Extension

The Shell Integration subsystem introduces command boundaries into the terminal session, spanning both the server-side and client-side environments of the Theia architecture. @terminal-ssd illustrates how these components interact to provide a structured command history.

#figure(
  image("../figures/terminal-ssd.svg"),
  caption: [This component diagram shows how the shell integration subsystem injects shell hooks, parses OSC markers, and stores structured command blocks. It highlights the path from raw terminal I/O to a reusable command-history API.]
) <terminal-ssd>

- *Shell Integration:* This component intercepts the terminal creation process to inject shell-specific startup scripts. These scripts emit OSC control sequences that encode the command text and mark the start and end of command outputs. The injector handles both `bash` and `zsh` configurations to ensure broad compatibility.
- *Shell:* The shell resides within the Terminal Server and processes user commands. It emits the resulting raw byte stream via the Shell I/O Service. 
- *Terminal Widget:* The client-side component renders the terminal interface. It receives the raw byte stream and parses the OSC sequences to reconstruct structured command blocks, subsequently updating the Command History Store. It also manages the terminal buffer and visual rendering through `xterm.js`.
- *Command History Store:* This store maintains the state model by tracking a list of `CommandBlock` entities. Each block records the command text alongside its start and end markers within the terminal buffer. The store exposes a command history API, allowing other subsystems to query the structured terminal context—such as retrieving the last executed command or accessing a specific command block by its position in the terminal history.

*Shell Integration and Command History Construction*

@terminal-sequence illustrates the interaction between these components during terminal startup and command execution. When the user opens a terminal, the Terminal Widget requests the Terminal Server to create a new terminal session. During this process, the Shell Integration component injects a shell configuration through startup arguments or environment variables. This shell configuration hooks into the command process of the shell and configures it to output escape sequences at command start and prompt start.

Once the shell has started, user commands entered in the Terminal Widget are forwarded via the Terminal Server to the shell. During command execution, the shell emits a `commandStart` control sequence to indicate the start of a command and a `promptStart` control sequence when the terminal prompt is emitted. We interpret this prompt event as the end of the current command execution. The Terminal Widget parses these sequences, reconstructs a CommandBlock from the observed command and its output, and stores the structured representation in the Command History Store.

#figure(
  image("../figures/terminal-sequence.pdf"),
  caption: [This sequence diagram shows how shell startup hooks and OSC markers let the terminal reconstruct discrete command blocks from a continuous byte stream. It explains the runtime path by which the system builds structured command history.]
) <terminal-sequence>


== Terminal UI Enhancements 
#figure(
  image("../figures/hover-action.png"),
  caption: [This screenshot shows the terminal block overlay used for direct terminal work. It demonstrates how the system groups output by command and exposes hover-based quick actions for manual AI invocation and command navigation.]
) <terminal-hover-action-screenshot>

@terminal-hover-action-screenshot shows the terminal block overlay in the standard terminal view. This overlay realizes #link(<fr5>)[FR5] and #link(<fr6>)[FR6] by grouping terminal output into command-specific blocks and exposing command-local quick actions. When the user hovers over any command block, the system reveals an overlay presenting quick actions: copy command text, scroll to the block's start, scroll to the block's end, and "Ask AI about Command," which opens an AI assistant session with the command block as context.

This surface specifically serves users who operate primarily within the terminal and do not require the comprehensive assistant view or automatic task-based summarization.
