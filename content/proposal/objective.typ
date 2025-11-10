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

Building on the idea of improving the usability of terminals, this thesis seeks to address current limitations by proposing a comprehensive plan to implement AI assistance into the terminal of the Theia IDE.

We will implement the proposed statement in these steps:
1. Intelligently process command output
2. Explain errors with suggested remediation steps
3. Enable natural language input
4. Switch between different levels of abstraction and assistance

== Intelligently process command output
In the first stage, we implement a Theia extension that automatically generates a compact summary for each build and command output.
Each summary highlights key information such as error messages, warnings, or success indicators while filtering out redundant or verbose details.
The summary appears directly below the original output and uses visual cues to preserve full transparency.

By breaking down complex outputs into digestible summaries, this feature helps students focus on relevant information and better understand the output of compilers and linters. 

== Explain errors with suggested remediation steps
In the second stage, we extend the Theia extension to automatically detect errors in the output. The system displays each detected error in a structured format, along with guidance for resolution. 
The goal is to support students in understanding the issue without revealing the complete solution to an exercise.

The system displays each detected error as a structured item, including the file location, a description of the error, and a general hint for remediation.
An "Open File" button navigates the user to the corresponding file in the IDE editor window and highlights the faulty line, while a "Show Hint" button reveals a more detailed hint to guide the student toward resolving the error independently.

== Enable natural language input
This stage extends the terminal of the Theia IDE with a side panel that allows users to interact with the terminal using natural language.
A command suggestion agent, prompted to only generate valid terminal commands, translates user inputs into executable commands accompanied by short explanations of their function.
The system displays the generated commands in the side panel, along with a brief explanation of their function. The component allows the user to copy the commands, insert them into the terminal for review, or execute them directly.

This feature helps developers to more easily interact with the terminal by reducing the mental load of recalling terminal syntax, flags, and parameters.
It also reduces context switching by eliminating the need to consult external documentation for command usage.

== Switch between different levels of abstraction and assistance
We integrate a configuration setting with Theia IDE that exposes two controls: an "abstraction level" and an "assistance level".
Adjusting the abstraction level impacts how much of the original terminal output is displayed (example states: Only Terminal Output, Both, Only Summary), while adjusting the assistance level determines the level of detail in the error remediation steps (example states: Hint, Solution).
Each level introduces gradual changes to ensure a natural user experience.

To maintain transparency, instructors can choose a low abstraction level to encourage independent problem-solving, while developers can choose a higher abstraction level for reduced distraction.
Similarly, this configuration provides flexibility, as instructors can lower the assistance level to foster learning, and professional developers can increase the assistance level to speed up debugging.

The activity diagram in @activity visualizes the system's interaction flow during output summarization and error remediation.
The diagram will be used as a reference for the implementation. It depicts different behaviours of the system depending on the configuration of abstraction and assistance.

#figure(
  image("../../figures/activitydiagram3.drawio.svg"),
  caption: [Activity diagram of the terminal interaction flow during output summary and error remediation.]
) <activity>

