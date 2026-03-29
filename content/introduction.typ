#import "/utils/todo.typ": TODO

= Introduction
#TODO[
  Introduce the topic of your thesis, e.g. with a little historical overview.
]

The Technical University of Munich introduces students of introductory programming courses to the fundamentals of object-oriented programming with the Java programming language.
During these exercises, students work within an Integrated Development Environment (IDE) that displays Java build output in its build output window.

While modern IDEs simplify software development through graphical interfaces, intelligent code completion, and integrated debugging, the terminal remains essential in the development workflow #footnote[The State of the CLI 2023 Edition #link("https://www.warp.dev/state-of-the-cli-2023")]. 
It complements the IDE, enabling operations that are either unavailable or less efficient in graphical tools by providing capabilities for tasks ranging from build automation to deployment, version control, and system configuration.
Although students typically view the build results through the IDE's build output window, these results originate from processes executed in a terminal environment by the IDE in the background.

To integrate terminal functionality seamlessly, modern IDEs incorporate a terminal directly within their interfaces. An example is the Theia IDE, a unified cloud and desktop IDE maintained by Eclipse Source #footnote[Theia IDE - AI-Native Open-Source Cloud and Desktop IDE #link("https://theia-ide.org")] that follows a modular architecture and consists of Theia extensions #footnote[https://theia-ide.org/docs/extensions/].
Among them, the Terminal Extension shown in @theia-terminal embeds a terminal in the workbench, allowing developers to run commands without leaving the IDE.

#figure(
  image("../figures/theia.png"),
  caption: [Theia IDE with an embedded terminal.]
) <theia-terminal>

== Problem
#TODO[
  Describe the problem that you like to address in your thesis to show the importance of your work. Focus on the negative symptoms of the currently available solution.
]

Despite their importance, terminals in modern IDEs suffer from usability challenges, as error messages are often cryptic, requiring specialized knowledge to interpret, which prolongs debugging and increases frustration for developers @beckerEffectiveApproachEnhancing2016.
This is problematic for students with less experience and those from interdisciplinary backgrounds, who may be overwhelmed by the volume of work and discouraged by unclear feedback.

Another usability issue of the terminal is that developers need to memorize a wide range of commands with tool-specific syntax, flags, and parameters that vary across operating systems, which increases the cognitive load on students and reduces their performance @article.
In contrast to graphical interfaces with visible affordances, terminal capabilities remain hidden until explicitly learned or discovered through documentation. #footnote[UX Stackexchange: Why are terminal consoles still used? #link("https://ux.stackexchange.com/questions/101990/why-are-terminal-consoles-still-used")] This steep learning curve limits the accessibility of terminals and makes them less intuitive for students.

The limited integration between the terminal and the IDE also disrupts workflow efficiency.
Developers must constantly switch between command-line interactions and graphical interfaces, breaking concentration and task continuity @abadTaskInterruptionSoftware2018.



== Motivation
#TODO[
  Motivate scientifically why solving this problem is necessary. What kind of benefits do we have by solving the problem?
]

While prior research has explored using large language models to generate next-step hints for introductory programming exercises @roestNextStepHintGeneration2024 and explanations of malicious shell commands @dengRACONTEURKnowledgeableInsightful2025, applying AI assistance directly within an IDE-integrated terminal represents a novel and unexplored approach in educational research.

By automatically summarizing and explaining the error output of compilers and linters, students can more quickly identify their mistakes and gain more explicit guidance on how to resolve them @pankiewiczNavigatingCompilerErrors2024.
This feature also allows students to dedicate more time to solving the actual exercise rather than deciphering technical error messages, and reduces the occurrence of similar errors in the future @beckerEffectiveApproachEnhancing2016.
 
Existing terminal emulators, such as Warp #footnote[https://warp.dev], attempt to address these problems with natural language input to execute commands and automatic problem solving depending on the last command output.
However, by directly solving issues for the user, these systems bypass the opportunity for students to develop transferable problem-solving skills, leaving them unprepared for contexts where such tools fail or are unavailable.  

== Objectives
#TODO[
  Describe the research goals and/or research questions and how you address them by summarizing what you want to achieve in your thesis, e.g. developing a system and then evaluating it.
]

Leveraging Theia's modular architecture, the proposed Terminal Assistant Extension integrates with the existing ecosystem, as illustrated in @subsystem.
The existing extensions relevant to this thesis offer services to read the current terminal content and navigate to files (Terminal Extension), provide build context information (Debug Extension), manage editor decorations (Monaco Extension), and access large language models (AI Core). 

Building on the idea of improving the usability of terminals, this thesis seeks to address current limitations by proposing a comprehensive plan to implement AI assistance into the terminal of the Theia IDE
We will implement the proposed system in these steps:
1. Intelligently process command output
2. Explain errors with suggested remediation steps
3. Enable natural language input
4. Switch levels of abstraction and assistance

#figure(
  image("../figures/assistant-extension-ssd.svg"),
  caption: [Subsystem decomposition of the proposed Terminal Assistant Extension (blue) for Theia IDE next to the relevant existing extensions (green).] 
) <subsystem>

== Intelligently Process Command Output
In the first stage, we implement the Terminal Assistant Core to automatically intercept terminal output and visualize summaries.
It utilizes the Output Analysis Agent that generates a compact summary for each build and command output.
Each summary highlights key information, such as error messages or success indicators, while filtering out verbose details.
The summary appears directly below the original output and uses visual cues to preserve full transparency.

By breaking down complex outputs into digestible summaries, this feature reduces cognitive load, which allows students to focus on relevant information instead of being overwhelmed by verbose and technical details.
It also helps them learn to interpret the output of compilers and linters by displaying a concise summary alongside the raw output.

== Explain Errors with Suggested Remediation Steps
In the second stage, we extend the Output Analysis Agent to automatically detect errors in the output. The system displays each detected error in a structured format, along with guidance for resolution. 
The goal is to support students in understanding the issue without revealing the complete solution to an exercise.

The system displays each detected error as a structured item, including the file location, a description of the error, and a general hint for remediation.
An "Open File" button navigates the user to the corresponding file in the IDE editor window and highlights the faulty line, while a "Show Hint" button reveals a more detailed hint to guide the student toward resolving the error independently.

== Enable Natural Language Input
This stage extends the terminal of the Theia IDE with a side panel that allows users to interact with the terminal using natural language.
A Command Suggestion Agent, prompted to only generate valid terminal commands, translates user inputs into executable commands accompanied by short explanations of their function.
The system displays the generated commands in the side panel, along with a brief explanation of their function. The component allows the user to copy the commands, insert them into the terminal for review, or execute them directly.

This feature helps developers to more easily interact with the terminal by reducing the mental load of recalling terminal syntax, flags, and parameters.
It also reduces context switching by eliminating the need to consult external documentation for command usage.

== Switch Levels of Abstraction and Assistance
We integrate a configuration setting with Theia IDE that exposes two controls: an "abstraction level" and an "assistance level".
Adjusting the abstraction level impacts how much of the original terminal output is displayed (example states: Only Terminal Output, Both, Only Summary), while adjusting the assistance level determines the level of detail in the error remediation steps (example states: Hint, Solution).
Each level introduces gradual changes to ensure a natural user experience.

To maintain transparency, instructors can choose a low abstraction level to encourage independent problem-solving, while developers can choose a higher abstraction level for reduced distraction.
Similarly, this configuration provides flexibility, as instructors can lower the assistance level to foster learning, and professional developers can increase the assistance level to speed up debugging.

#figure(
  image("../figures/activitydiagram5.drawio.svg"),
  caption: [Activity diagram of the interaction flow during output summary and error remediation.]
) <activity>

The activity diagram in @activity illustrates the system's interaction flow during output summarization and error remediation.
The diagram serves as a reference for the implementation and demonstrates the different behaviors of the system, depending on the configuration of abstraction and assistance levels.

== Outline
#TODO[
  Describe the outline of your thesis
]


