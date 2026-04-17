#import "/utils/todo.typ": TODO
#import "/utils/diagram.typ": diagram

= Introduction <intro>

The Technical University of Munich introduces students of introductory programming courses to the fundamentals of object-oriented programming with the Java programming language.
During these exercises, students work within an Integrated Development Environment (IDE) that displays Java build and runtime output in its output window.

While modern IDEs simplify software development through graphical interfaces, intelligent code completion, and integrated debugging, the terminal remains essential in the development workflow #footnote[The State of the CLI 2023 Edition #link("https://www.warp.dev/state-of-the-cli-2023")]. 
It complements the IDE, enabling operations that are either unavailable or less efficient in graphical tools by providing capabilities for tasks ranging from build automation to deployment, version control, and system configuration.
Although students typically view the build results through the IDE's build output window, these results originate from processes executed in a terminal environment by the IDE in the background.

To integrate terminal functionality, modern IDEs incorporate a terminal directly within their interfaces. An example is the Theia IDE, a unified cloud and desktop IDE governed by the Eclipse Foundation #footnote[Theia IDE - AI-Native Open-Source Cloud and Desktop IDE #link("https://theia-ide.org")] that follows a modular architecture and consists of Theia extensions. #footnote[https://theia-ide.org/docs/extensions/]
Among them, the Terminal Extension shown in @theia-terminal embeds a terminal in the workbench, allowing developers to run commands without leaving the IDE.

#diagram(
  image("../figures/theia.png"),
  caption: [Theia IDE embeds a terminal directly in the workbench. This integration defines the interaction surface that this thesis extends with structured command history and AI-based error support.],
  short-caption: [Theia IDE Terminal]
) <theia-terminal>

== Problem

Despite their importance, terminals in modern IDEs suffer from usability challenges, as error messages are often cryptic, requiring specialized knowledge to interpret, which prolongs debugging and increases frustration for developers @beckerEffectiveApproachEnhancing2016.
This is problematic for students with less experience and those from interdisciplinary backgrounds, who may be overwhelmed by the volume of work and discouraged by unclear feedback.

Another usability issue arises after the user executes a command: terminals present prompts, commands, and program output as a continuous stream that users must parse manually. Especially in the presence of long build logs or multiple successive executions, students may struggle to determine which output belongs to which command and which parts are relevant for understanding a failure. This increases cognitive load and makes terminal-based debugging more difficult for inexperienced users @article.

The limited integration between the terminal and the IDE also disrupts workflow efficiency.
Developers must constantly switch between command-line interactions and graphical interfaces, breaking concentration and task continuity @abadTaskInterruptionSoftware2018.

== Motivation

While prior research has explored using large language models to generate next-step hints for introductory programming exercises @roestNextStepHintGeneration2024 and explanations of malicious shell commands @dengRACONTEURKnowledgeableInsightful2025, educational research has examined AI assistance in IDE-integrated terminals less extensively.

By automatically summarizing and explaining the error output of compilers and linters, students can more quickly identify their mistakes and gain more explicit guidance on how to resolve them @pankiewiczNavigatingCompilerErrors2024.
This feature also allows students to dedicate more time to solving the actual exercise rather than deciphering technical error messages, and reduces the occurrence of similar errors in the future @beckerEffectiveApproachEnhancing2016.
 
To address these problems, modern terminal emulators like Warp #footnote[https://warp.dev] structure command output into distinct blocks and provide AI-based support for recent terminal output.
Although such features can increase efficiency, educational settings benefit more from explanations that help students interpret errors than from automatic problem solving that bypasses that learning process.

== Objectives

To improve terminal usability through AI assistance, this thesis introduces the AI Terminal Assistant, an extension for the Theia IDE.
The system focuses on automatic support for build and runtime output in beginner-oriented workflows and on-demand support for direct terminal commands for more advanced students.
We organize the thesis objectives in these steps:
1. Establish a structured terminal state
2. Automatically summarize build and runtime output
3. Explain errors with suggested remediation steps
4. Switch levels of abstraction and assistance

=== Establish a Structured Terminal State
In the first stage, the system introduces shell integration to establish a structured terminal state that identifies command boundaries and associates outputs with their corresponding commands.
This stage creates the architectural basis for later assistant features and provides a structured command history for future extensions.

=== Automatically Summarize Build and Runtime Output
In the second stage, we implement the Terminal Assistant Core to analyze build and runtime output automatically and visualize summaries.
The Summary Agent generates a compact summary for build output and runtime output shown in the terminal.
Each summary highlights key information, such as error messages or success indicators, while filtering out verbose details.
The assistant displays the summary together with access to the raw output so that students can compare the AI interpretation with the underlying execution log.

By breaking down complex outputs into digestible summaries, this feature reduces cognitive load, which allows students to focus on relevant information instead of being overwhelmed by verbose and technical details.
It also helps them learn to interpret the output of compilers and linters by displaying a concise summary alongside the raw output.

=== Explain Errors with Suggested Remediation Steps
In the next stage, we extend the Summary Agent to automatically detect errors in the output. The system displays each detected error in a structured format, along with guidance for resolution. 
The goal is to support students in understanding the issue without revealing the complete solution to an exercise.

The system displays each detected error as a structured item, including the file location, a description of the error, and a general hint for remediation.
An "Open in Editor" button navigates the user to the corresponding file in the IDE editor window and highlights the faulty line, while a "Propose Fix" button reveals a more detailed hint to guide the student toward resolving the error independently.

=== Switch Levels of Abstraction and Assistance
This thesis also explores how configurable levels of abstraction and assistance could adapt support to different user needs.
The abstraction level controls how much of the original terminal output the interface displays, while the assistance level controls the detail of the remediation steps.
These configurations would allow the system to adjust how much information and guidance it exposes.

Such a configuration could distinguish between transparency and pedagogical assistance. For beginners, a higher abstraction level may reduce cognitive overload by hiding low-level terminal details, while a lower assistance level can still preserve the learning process by limiting the system to explanations and hints instead of direct solutions. More experienced users, by contrast, may prefer a lower abstraction level with fuller access to raw output, combined with a higher assistance level that offers direct support to speed up debugging.

== Outline
The remainder of this thesis is structured as follows:
- *@background* introduces the technical background on Theia, terminal emulation, shell integration, and the use of LLMs in development tools. 
- *@related* discusses related work and derives the research gap addressed by this thesis.
- *@requirements* defines the system requirements and models the proposed solution from the user and domain perspective.
- *@system* presents the system design, including the shell integration subsystem and the AI Terminal Assistant.
- *@evaluation* evaluates the usability of the implemented system.
- *@summary* concludes the thesis and outlines remaining limitations and future work.