#import "/utils/todo.typ": TODO

= Schedule
#TODO[ // Remove this block
  *Thesis Schedule*
  - When will the thesis Start
  - Create a rough plan for your thesis (separate the time in iterations with a length of 2-4 weeks)
  - Each iteration should contain several smaller work items - Again keep it high-level and make to keep your plan realistic
  - Make sure the work-items are measurable and deliverable, they should describe features that are vertically integrated
  - Do not include thesis writing or presentation tasks
]

The following milestones will guide the implementation process to achieve the
outlined objectives.
The Bachelor’s thesis starts on X and will be completed on X.
To ensure a structured and timely completion of the project, the following schedule is planned:

#strong("Milestone 1. Intelligently process command output. [Week 1-3, 3 Weeks]")

  A student can see a concise summary of each terminal command output under the raw output with a clear visual distinction. The deliverables include:
  - Extend Theia’s terminal widget to intercept and capture command output.
  - Create an AI prompt template to parse, filter, and summarize terminal output.
  - Display summaries beneath raw outputs using distinct styling.

#strong("Milestone 2. Error remediation. [Week 4-6, 3 Weeks]")

  A student can get a list of error remediation steps in the case of an error output. The deliverables include:
  - Extend Theia's terminal to identify and extract errors from compiler and linter outputs.
  - Create a robust AI prompt template that generates error remediation steps without leaking the exercise solution.
  - Integrate the output of the error remediation into the Terminal UI by displaying it right under the command output.
  - Provide interactive actions (e.g., open related file) that the student can trigger directly in the terminal.

#strong("Milestone 4. Natural Language Input. [Week 7-10, 4 Weeks]")
  
  A developer can interact with the terminal with natural language queries. The output will be explained by a LLM and a student can directly execut it in the terminal. The deliverables include:
  - Extend Theia's terminal with a side panel with a chat-style input interface.
  - Create an AI prompt template that parses inputs and generates terminal commands with corresponding explanations.
  - Integrate the generated command into the side panel as a structured block (command + explanation).
  - Provide actions to insert it into the terminal or execute the command directly.

#strong("Milestone 4. Allow changing abstraction and assistance levels. [Week 11-12, 2 Weeks]")

  A developer will be able to choose between different abstraction and assistance levels. The system will support multiple prompt templates for error remediation. The deliverables include: 
  - Extend Theia's settings with a setting to switch between two modes of abstraction and assistance
  - Design and implement modular AI prompt templates that vary in verbosity and guidance (e.g., minimal hints, guided explanation, detailed remediation).

#strong("Milestone 5. User testing. [Week 13-15] 3 Weeks]")

  Prepare and execute a survey on this system in the context of a Java exercise during a tutorial. Test students with the terminal assistance enabled and disabled. The deliverables include:
  - Design a java exercise with medium difficulty that covers representative use cases of the tool, such as error handling.
  - Prepare a survey with two groups, one with terminal assistance and one without.
  - Collect both quantitative (time spent solving errors, number of errors solved) and qualitative data (perceived mental load).
  - Analyze user feedback for statements that validate or challenge the system's effectiveness. 
  - Document feasible improvements and create a product backlog for out-of-scope features.
  
