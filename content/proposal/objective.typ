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

The proposed system will be implemented in these steps:
1. Intelligently process command output
2. Explain errors with suggested remediation steps
3. Enable natural language input
4. Switch between different modes of transparency and flexibility

== Intelligently process command output 
The terminal will automatically generate a concise summary of each command’s output in the first stage.
The summary highlights key information such as error messages, warnings, or success indicators while filtering out redundant or verbose details.
To preserve transparency, the summary will appear directly beneath the original command output and will be clearly distinguished through visual cues (e.g., different styling or background shading).
This functionality will be implemented through a dedicated AI prompt template instructing the model to parse, filter, and a summarize terminal output.
A toggle option will allow users to switch between full raw output and summarized view. By default, both the raw and summarized outputs are shown, enabling students to compare the two and learn which elements of the terminal output are most relevant for problem-solving.

This feature helps students better understand the output of compilers and linters by filtering out verbosity that can be more confusing than helpful, particularly for students still learning programming.

== Explain errors with suggested remediation steps
In the second stage, the terminal will automatically suggest actions to solve the errors when an error is detected in the terminal output.
The goal is not to expose the exercise solution, while still providing enough information to help with the issue.
A prompt file will be created that prompts the AI model to summarize the error's output and providing hints to the fix of the error.
The prompt will prevent the solution from leaking to the user. 
A button will be added that opens the relevant files that the user needs to access inorder to solve the error.

This feature helps students to understand how to solve issues and reduce friction during solution finding. 

== Enable natural language input
In this stage, the terminal of the Theia IDE will be extended with a split view.
A dedicated side panel provides a natural language interface where users can formulate interactions with the terminal in plain text.
An AI agent, preconfigured to only generate valid terminal commands, translates these inputs into executable commands accompanied by short explanations of their function.
Generated commands are displayed in the side panel as structured blocks, allowing users to insert them into the terminal for review or execute them directly.

This feature helps developers to more easily interact with the terminal by reducing the mental load of recalling terminal syntax, flags, and parameters.

== Switch between different modes of abstraction and assistance
An option will be integrated with Theia IDE, which allows switching between different modes of abstraction and assistance.
Adjusting the level of abstraction will impact how much of the original terminal output is displayed versus summarized.
Each mode introduces gradual changes rather than abrupt shifts, ensuring that the user experience feels natural.
Different assistance modes determine the degree of support provided during error remediation.
At lower levels, the tool provides minimal hints, while at higher levels, the tool offers richer guidance.

This feature allows the system to be transparent so that instructors can keep the abstraction level low, to nudge students to learn how to act when this tool is not available, while developers use a higher abstraction level to solve errors with less distraction.
The tool also becomes more flexible, as instructors can lower the assistance level that the tool provides to enhance the learning journey of students and professional developers can increase the assistance level to solve issues more quickly. 

