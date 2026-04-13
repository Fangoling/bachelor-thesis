= Summary

This chapter reports the thesis status against the defined functional requirements and closes with a short conclusion and outlook.

== Status

This section summarizes the implementation status of all functional requirements. @tab-fr-status provides the detailed status overview in the same requirement order used in the Requirements chapter. The symbols used are #sym.checkmark (fulfilled), ◑ (partially fulfilled), and #sym.times (open).

#figure(
  table(
    columns: (3em, 1fr, 4em),
    align: (center, left, center),
    table.header(
      [*ID*], [*Title*], [*Status*],
    ),
    [FR1], [Configure Terminal Session], [#sym.checkmark],
    [FR2], [Support Shell Environments], [◑],
    [FR3], [Record Command Executions], [#sym.checkmark],
    [FR4], [Expose Command History], [#sym.checkmark],
    [FR5], [Visualize Command Boundaries], [#sym.checkmark],
    [FR6], [Provide Command Block Actions], [#sym.checkmark],
    [FR7], [Generate Task Summary], [#sym.checkmark],
    [FR8], [Report Execution Status], [#sym.checkmark],
    [FR9], [Structure Error Entries], [#sym.checkmark],
    [FR10], [Guide Error Resolution], [#sym.checkmark],
    [FR11], [Navigate to Error Location], [#sym.checkmark],
    [FR12], [Preserve Traceability to Raw Output], [#sym.checkmark],
    [FR13], [Support Interactive Task I/O], [#sym.checkmark],
    [FR14], [Configure Assistance Modes], [◑],
  ),
  caption: [This table closes the thesis against the functional requirements defined in the Requirements chapter. It shows which requirements the implementation fulfills completely, which remain partial, and preserves the requirement order used in that chapter.]
) <tab-fr-status>

=== Realized Goals

We fully realized the majority of the functional requirements. The subsequent subsections summarize the realized goals grouped by functional area.

*Shell Integration and Terminal Interaction (FR1, FR3–FR6)*

The shell integration layer instrumented each new terminal session automatically through the injection of startup hooks into `bash` and `zsh` (FR1). The hooks emitted OSC markers at command and prompt start, which the terminal frontend parsed to reconstruct structured command blocks from the rendered terminal buffer content (FR3). Each block carried its command text, output, and boundary markers. The system exposed these blocks through an event-driven API. This API allowed other extensions to consume structured terminal history without the need to reimplement the tracking layer (FR4). The terminal also marked command boundaries visually (FR5). A hover overlay provided quick actions such as copying the command, navigating to block boundaries, and opening an AI session with the block as context (FR6).

*AI Terminal Assistant (FR7–FR14)*

When a build task or debug session finished, the assistant generated a summary automatically without requiring user action (FR7). It used a structured LLM response to produce consistent fields for success status and a plain-language summary (FR8). Each error explanation stated the affected file, line, and column, provided a student-accessible explanation (FR9), and listed guided fix steps that directed the student toward a solution but withheld the exact answer (FR10). An action button navigated the user to the exact location of the file and applied a line decoration (FR11). The assistant also preserved access to the execution context underlying the AI interpretation, either through a side-by-side terminal view or through preserved execution context in standalone mode (FR12). For interactive task executions, the assistant propagated input and output streams while the task was still running (FR13).

=== Open Goals

Two areas identified from the requirements analysis remain partially fulfilled within the scope of this thesis.

Regarding FR2, shell integration targets `bash` and `zsh` on macOS and Linux only. Windows shells (`PowerShell`, `cmd.exe`) and the `fish` shell remain explicitly out of scope, as stated in the constraints. Both require a different injection mechanism: `fish` does not source rcfiles in the same way as `bash` and `zsh`, and Windows lacks a POSIX PTY model entirely. This absence renders a direct port of the current shell scripts non-trivial.

For FR14, the assistance level of the AI explanation remains fixed: the AI always produces full explanations with fix steps. Configurable abstraction levels, where a student can request more or less guidance in relation to their confidence, serve as a desirable capability but were not implemented within the scope of this thesis.

The evaluation occurred as an informal think-aloud session with five participants rather than a controlled study with a representative sample of first-semester students. The primary target audience, students with no prior terminal experience, was not represented. A formal user study to measure comprehension improvement and time-to-resolution against a control group remains an open goal.

== Conclusion

Theia's integrated terminal, prior to this work, presented terminal output as a string buffer with no concept of command boundaries or execution history. This absence made it impossible for AI features to reliably identify which command had just executed and what its output was. AI assistance built upon this buffer representation relied on heuristic line counts and was therefore imprecise and context-unaware.

This thesis bridges that gap in two stages. First, the shell integration layer equips Theia's terminal with the same structural foundation found in industry-standard IDEs: command boundaries and output blocks become addressable data structures rather than unparsed text. Because the system exposes this layer through an event-driven API, any future extension can react to terminal activity through the same structured interface. Second, the AI terminal assistant builds on this foundation and scopes its automatic analysis to monitored task executions while still supporting manual AI access for direct terminal commands. It produces structured error entries tied to specific files and lines, and it guides students toward a fix while preserving the pedagogical opportunity. Informal feedback from students indicates that these educational design choices match actual student behavior.

== Future Work

The most important next step is a formal evaluation with first-semester students—the primary target audience absent from the initial feedback round. A controlled study to compare task completion time, error comprehension, and fix attempt accuracy against a control group with access only to the plain terminal provides the evidence needed to validate or revise the current design decisions.

The system currently generates fix steps without access to the student's actual code. Integrating the workspace file system to retrieve the relevant code context would allow the assistant to produce guidance that references specific variable names, method signatures, or incorrect expressions from the student's submission. This addition would make the fix steps more actionable.

Configurable assistance levels would allow the system to adapt to the student's progression through a course. A beginner would receive the full explanation with fix steps, a more advanced student would see only the error summary, and an expert would receive only the exit code and file location. This progression model aligns with educational scaffolding theory and could integrate with an external learning management system to automate the transition between levels.

Extending shell integration to `fish` and Windows (`PowerShell` and `cmd.exe`) would broaden the reach of the terminal enhancements. `fish` requires an event-based hook mechanism rather than rcfile execution, and Windows requires a new injection strategy that accounts for the absence of a POSIX PTY. Both represent self-contained engineering tasks that do not require changes to the AI assistant layer.
