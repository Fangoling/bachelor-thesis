#import "/utils/todo.typ": TODO

= Requirements

We describe the requirements for the proposed system following the Object-Oriented Software Engineering methodology by Bruegge and Dutoit @bruggeObjectorientedSoftwareEngineering2014. We formulate these requirements in terms of system behavior and user needs. Derived from the problem statement and motivation outlined in the Introduction, these requirements serve as the basis for the system design and implementation described in subsequent chapters.

== Overview

The proposed system fulfills three primary objectives. First, we establish a structural foundation for the terminal by introducing command boundaries, enabling the environment to treat command executions and their outputs as discrete data objects. Second, we provide AI-powered assistance for students in teaching environments, allowing them to understand build failures and resolve errors without leaving the IDE. Third, we enhance terminal usability by introducing interactive UI features that leverage the structured command history.

== Existing System

The existing system consists of the built-in terminal extension within the Theia IDE, which embeds a terminal emulator and connects it to a shell process. This terminal presents shell output as an unstructured byte stream rendered into a character buffer. Currently, no command history API exists, and the system accesses the terminal output only as a flat text buffer. The environment possesses no intrinsic information regarding which lines belong to which command or where one command output ends and the next begins.

Consequently, any AI feature that operates on terminal output must rely on a heuristic context window and force the language model to interpret the raw context. This approach introduces two systematic failure modes: the heuristic may omit relevant output when a command produces extensive logs, or it may include unrelated lines when multiple commands execute in close succession. In both scenarios, the resulting AI analysis becomes imprecise and unreliable.

The existing terminal also provides no visual differentiation between discrete commands. Users must read through the entire buffer to locate the output of a specific command. The IDE provides no mechanism to copy a distinct command block, scroll directly to the boundaries of a specific execution, or attach structured metadata, such as an exit code, to a command's output.

== Proposed System

We propose extending the Theia IDE with two cooperating subsystems. The shell integration subsystem introduces command boundaries and provides structured terminal context, allowing the IDE to treat command executions as discrete units with associated output. The AI terminal assistant subsystem consumes this structured context to generate output summaries, structured error explanations, and guiding solution hints automatically upon task completion.

=== Functional Requirements

*Shell Integration*

- *FR1 Configure Terminal Session:* The system shall automatically configure each new terminal session for structured command tracking without requiring manual setup from the user. <fr1>
- *FR2 Support Shell Environments:* The system shall support the designated shell environments within the target development platforms, subject to the defined constraints. <fr2>
- *FR3 Record Command Executions:* The terminal shall record each executed command and its corresponding output as a discrete, addressable unit. <fr3>
- *FR4 Expose Command History:* The system shall provide a structured interface for other extensions to access the command history without re-implementing the tracking layer. <fr4>

*Terminal Block UI*

- *FR5 Visualize Command Boundaries:* The terminal shall visually mark the boundaries of individual commands to allow users to distinguish each command and its output at a glance. <fr5>
- *FR6 Provide Command Block Actions:* The user shall be able to hover over a command's output block to access quick actions, including copying the command, scrolling to block boundaries, and opening an AI assistant session using the block as context. <fr6>

*AI Terminal Assistant*

- *FR7 Generate Task Summary:* The system shall automatically generate an AI summary upon the completion of a build task or debug session, without requiring manual invocation. <fr7>
- *FR8 Report Execution Status:* The summary shall indicate whether the task succeeded or failed and provide a plain-language explanation of the terminal output suitable for students without domain knowledge. <fr8>
- *FR9 Structure Error Entries:* When the task output contains errors, the system shall present each error as a structured entry detailing the affected file, the exact location, and a plain-language explanation. <fr9>
- *FR10 Guide Error Resolution:* The system shall provide fix suggestions that guide the student toward a solution without directly revealing the answer, thereby preserving the educational value of the exercise. <fr10>
- *FR11 Navigate to Error Location:* The user shall be able to navigate directly to the affected file and line in the editor by clicking an error entry. <fr11>
- *FR12 Preserve Traceability to Raw Output:* The assistant shall provide access to the raw execution output that underlies the AI interpretation so users can verify the source of the summary. <fr12>
- *FR13 Support Interactive Task I/O:* The system shall support direct propagation of input and output streams for interactive task executions before the command has completed. <fr13>
- *FR14 Configure Assistance Modes:* The system shall support configurable assistance modes, allowing users to control how the assistant presents information within the terminal workflow. <fr14>

=== Quality Attributes

- *QA1 Comprehensibility (Usability):* Error explanations and summaries shall be comprehensible to a first-semester student lacking prior terminal or build-tool experience. <qa1>
- *QA2 Transparency (Usability):* The system shall clearly distinguish AI-generated content from raw execution output. Users shall retain access to the execution context on which the summary is based, even if the full terminal buffer is not shown simultaneously. <qa2>
- *QA3 Responsiveness (Performance):* The AI summary shall appear within a timeframe acceptable for interactive use following task completion. Shell integration shall not introduce a perceptible delay during terminal startup, and interactive tasks shall forward user input and program output without disruptive lag. <qa3>
- *QA4 Configuration Safety (Reliability):* The shell integration shall not cause terminal startup failures or incorrect behavior under any shell configuration encountered in the target environment. If integration assets are missing or the shell is unsupported, the terminal shall start normally without structural features. <qa4>
- *QA5 Extensibility (Supportability):* The structured command history interface shall remain documented and stable, enabling other extensions to consume it without requiring internal knowledge of the shell integration mechanics. <qa5>

=== Constraints

- *C1 Theia Extension Architecture (Implementation Constraint):* The system must integrate into the existing Theia extension and dependency injection architecture.
- *C2 External LLM Dependency (Interface Constraint):* The AI features depend on an external large language model (LLM) provider accessed through the Theia AI Core. The system does not bundle a self-hosted model.
- *C3 Target Platform Scope (Operations Constraint):* The implementation targets `bash` and `zsh` on macOS and Linux. Windows shells (`PowerShell`, `cmd.exe`) and the `fish` shell remain explicitly out of scope.

== System Models

We present the system models for the proposed solution following the methodology by @bruggeObjectorientedSoftwareEngineering2014. These models progress from concrete scenarios that ground the abstract requirements in realistic use, through a use case model capturing actor interactions, to a domain-level analysis object model and a dynamic model describing runtime behavior.

=== Scenarios

*Scenario 1: Beginner Student Encounters a Build Error*

A first-semester student opens the online IDE to work on a programming exercise. The student executes the provided build task, which results in a runtime failure. The terminal fills with compiler output that the student cannot interpret. Automatically, the assistant view opens alongside the task output, displaying a failure status indicator and a concise, plain-language summary of the error. Individual error cards appear below the summary. Each card identifies the affected file and line, explains the error type without assuming prior knowledge, and offers collapsed fix steps that guide the student without revealing the direct solution. 

Seeking to resolve the issue, the student clicks the navigation button. The system opens the corresponding file in the editor, moves the cursor to the exact line, and applies a visual decoration. To further understand the issue, the student expands the fix steps and follows the instructions to inspect variable values using print statements. This guidance enables the student to comprehend the root cause and successfully fix the error.

*Scenario 2: Advanced Student Works with Structured Command History*

A student comfortable with the terminal runs build commands directly in the integrated terminal. The system automatically tracks these command blocks and marks them visually. The student navigates rapidly through extensive terminal output by scrolling to command boundaries and easily copies a previous command to modify and re-execute it. 

Upon encountering a build failure, the student hovers over the command block to access the quick action menu and opens an AI assistant session using the command output as context. The assistant view opens with an error summary and specific fix suggestions, which the student uses to inspect the issue without requiring automatic summarization for every direct terminal command.

=== Use Case Model

#figure(
  image("../figures/assistant-usecase.svg"),
  caption: [The use case model summarizes the main student interactions with the AI Terminal Assistant. It shows error interpretation, navigation, and hint-based remediation within the IDE workflow as use cases of the terminal assistant.]
) <use-case-diagram>

@use-case-diagram shows the interactions between the Student actor and the AI Terminal Assistant.

The Student interacts with the AI terminal assistant to resolve errors. The student can inspect the raw build output or the output summary to determine the success of the last code execution. When the last execution throws an error, the student can review the error explanation to determine the cause of the issue.

The student can then open the file with the error in the editor, which also navigates to the specific error line for detailed inspection, or expand the fix steps to review solution hints.


=== Analysis Object Model


The analysis object model depicted in @analysis-object-model captures the domain-level objects introduced by this work. Rather than representing implementation classes, it describes the core concepts and their relationships within the application domain, adhering to the recommendations of @bruggeObjectorientedSoftwareEngineering2014.

A `CommandBlock` acts as the central structured artifact produced by the shell integration layer. It represents a discrete unit comprising a single command and its corresponding output. `CommandBlocks` serve as the primary entity through which higher-level features access structured terminal interactions.

A `Summary` represents the AI-produced interpretation of a command execution result. It contains an overall success or failure status, a plain-language explanation of the output, and a list of `ErrorDetails` if the system detects errors. The system generates a `Summary` automatically upon task completion and associates it with the triggering command.

An `ErrorDetail` represents a single diagnosed error within a `Summary`. It encapsulates the error type, the affected file name and line number, a structured list of `ErrorExplanations`, and a sequence of guided `FixSteps`. 

An `ErrorExplanation` defines the pedagogical breakdown of the issue (categorized into What, Why, and How) alongside the explanatory content itself. Meanwhile, a `FixStep` provides a plain-language description of an actionable remediation step, which the system reveals when the user requests a hint. 

The `ErrorDetail` also contains a `CodeSnippet`, which extracts the relevant source code responsible for the error. This snippet includes the specific error line accompanied by several lines of surrounding context.

#figure(
  image("../figures/assistant-aom.svg"),
  caption: [The analysis object model defines the core domain entities of the terminal assistant.]
) <analysis-object-model>

=== Dynamic Model

#figure(
  image("../figures/assistant-dynamic.svg"),
  caption: [Activity diagram illustrating the asynchronous feedback loop between the User and the Terminal AI Assistant during code execution and debugging.]
) <dynamic-model>

The dynamic model in @dynamic-model describes the complete interaction flow through the AI terminal assistant, tracing the path from initial task execution to final error resolution.

The flow begins when a user executes a build or run task, either via the IDE task runner or directly within the terminal. Upon task completion, the system detects the exit event and evaluates whether the output contains errors. If an error exists, the system analyzes the relevant execution context and constructs a structured error explanation.

Subsequently, the assistant view updates automatically. It displays the status indicator and the summary text. For each detected error, the view renders an error card containing the affected file name, line number, and a plain-language explanation. The system keeps specific fix steps collapsed by default to encourage independent problem-solving.

From this state, the user can initiate several actions. Clicking an error card navigates the editor to the exact file and line, where the IDE applies a line decoration to highlight the error location. The user reads the structured explanation to comprehend the issue. After inspecting the code and reviewing the explanation, the user may either implement a fix directly or expand the fix steps to receive additional hints.

Conversely, if the task executes successfully, the assistant generates an output summary and displays it in the assistant view without rendering any error cards. The user may then conclude the exercise or continue editing and rebuilding the code, which re-triggers the analysis flow.
