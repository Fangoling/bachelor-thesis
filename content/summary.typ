#import "/utils/diagram.typ": diagram 
#import "/utils/print_page_break.typ": print_page_break

#print_page_break(print: true)
= Summary <summary>

This chapter reports the thesis status against the defined functional requirements and closes with a short conclusion and outlook.

== Realized Goals

We fully realized the majority of the functional requirements. The subsequent subsections summarize the realized goals grouped by functional area.

*Shell Integration and Terminal Interaction (FR1–FR6)*

The shell integration layer automatically instruments each new terminal session through the injection of startup hooks into bash and zsh (FR1, FR2). The hooks emit OSC markers at command and prompt start, which the terminal client parses to reconstruct structured command blocks from the rendered terminal buffer content (FR3). Each block carries its command text, output, and boundary markers.

The system exposes these blocks through an event-driven API. This API allows other extensions to consume structured terminal history without the need to reimplement the tracking layer (FR4). The terminal also marks command boundaries visually (FR5). A hover overlay provides quick actions such as copying the command, navigating to block boundaries, and opening an AI session with the block as context (FR6).

*AI Terminal Assistant (FR7–FR14)*

For monitored build and runtime output, the assistant generates a summary automatically without requiring user action (FR7). In the implemented system, this automation covers build tasks and debug sessions. The assistant uses a structured LLM response to produce consistent fields for success status and a plain-language summary (FR8). Each error explanation states the affected file, line, and column, provides a student-accessible explanation (FR9), and lists suggested remediation steps that guide the student toward a solution but withhold the exact answer (FR10).

An action button navigates the user to the exact location of the file and applies a line decoration (FR11). The assistant also preserves access to the execution context underlying the AI interpretation, either through a side-by-side terminal view or through preserved execution context in standalone mode (FR12). These two presentation modes realize configurable abstraction in the interface by exposing different levels of terminal detail depending on the selected mode (FR14). For interactive task executions, the assistant propagates input and output streams while the task is still running (FR13).

== Open Goals

The evaluation occurred as an informal think-aloud session with five participants rather than a controlled study with a representative sample of first-semester students. The primary target audience, students with no prior terminal experience, was not represented. A formal user study to measure improvements in comprehension and time-to-resolution relative to a control group remains an open goal.

== Conclusion

Theia's integrated terminal, prior to this work, presented terminal output as a string buffer with no concept of command boundaries or execution history. This absence made it impossible for AI features to reliably identify which command had just been executed and what its output was. AI assistance built upon this buffer representation relied on heuristic line counts and was therefore imprecise and context-unaware.

This thesis bridges that gap in two stages. First, the shell integration layer equips Theia's terminal with the same structural foundation found in industry-standard IDEs: command boundaries and output blocks become addressable data structures. Because the system exposes this layer through an event-driven API, any future extension can react to terminal activity through the same structured interface.

Second, the AI Terminal Assistant builds on this foundation and scopes its automatic analysis to build and runtime outputs, while still supporting manual AI access via direct terminal commands. It produces structured error entries tied to specific files and lines, and it guides students toward a fix while preserving the pedagogical opportunity. Informal student feedback indicates that these educational design choices align with observed student behavior.

== Future Work

The next step is a formal evaluation with first-semester students, because this group was absent from the initial feedback round. A controlled study can compare task completion time, error comprehension, and fix-attempt accuracy with a control group that only uses the plain terminal. Such a study can show whether the current design supports the intended audience and where the interface or the AI output requires revision.

Configurable assistance modes would allow the system to adapt to a student's progression through a course. A beginner can receive the full explanation with remediation steps, a more advanced student can see only the error summary, and an expert can receive only the exit code and file location. An external learning management system can provide the course context needed to automate the transition between these levels.

The system currently generates remediation steps without access to the student's actual code. Integrating workspace access enables the assistant to retrieve the relevant code context before it generates guidance. With this context, the assistant can refer to concrete variable names, method signatures, or incorrect expressions in the student's submission and provide remediation steps with a higher assistance level.

Extending shell integration to fish and Windows (PowerShell and cmd.exe) broadens the reach of the terminal enhancements. Fish requires an event-based hook mechanism instead of rcfile execution, and Windows requires a new injection strategy because it does not provide a POSIX PTY. These changes affect the shell integration layer and do not require architectural changes to the AI assistant itself.
