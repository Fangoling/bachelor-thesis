#import "/utils/todo.typ": TODO

= Objective
#TODO[ // Remove this block
  *Proposal Objective*
  - Define the main goals of your thesis clearly and concisely.
  - Start with a short overview where you enumerate the goals as bullet points, using action-oriented phrasing (e.g., 1., 2., 3., ...).
  - Avoid the gerund form for verbs (e.g., "Developing Feature XYZ") and noun phrases (e.g., "Feature XYZ Development"). Instead, use action-oriented language such as "Develop Feature XYZ", similar to how you would formulate use cases in UML use case diagrams.
  - Ensure your goals are concrete and specific, avoiding generic statements. Clearly state what you aim to achieve.
  - Expand on each goal in a dedicated subsection. Repeat the corresponding enumerated bullet point number to maintain consistency and provide at least two paragraphs explaining the goal. Focus on being precise and specific in your descriptions.
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
  image("../../figures/assistant-extension-ssd.svg"),
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
  image("../../figures/activitydiagram5.drawio.svg"),
  caption: [Activity diagram of the interaction flow during output summary and error remediation.]
) <activity>

The activity diagram in @activity illustrates the system's interaction flow during output summarization and error remediation.
The diagram serves as a reference for the implementation and demonstrates the different behaviors of the system, depending on the configuration of abstraction and assistance levels.
