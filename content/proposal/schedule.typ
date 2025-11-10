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
The Bachelor's thesis starts on X and will be completed on X.
To ensure a structured and timely completion of the project, the following schedule is planned:

#strong("Milestone 1. Intelligently process command output. [Week 1-3, 3 Weeks]")

  A student can see a concise summary of each terminal command output under the raw output with a clear visual distinction. The deliverables include:
  - Implement a Theia Terminal Summary Extension to process command outputs.
  - Add a component to display summaries beneath raw outputs.
  - Implement an AI agent and an AI prompt template to summarize command output.

#strong("Milestone 2. Error remediation. [Week 4-6, 3 Weeks]")

  A student can get an error summary in the form of structured error items in the case of an error output. The deliverables include:
  - Extend the AI agent and prompt template of Milestone 1 to identify errors and generate structured error items.
  - Display the output of the error summary within the summary component of the Terminal Summary Extension.
  - Implement action to open related file in an editor window.

#strong("Milestone 3. Allow changing abstraction and assistance levels. [Week 7-8, 2 Weeks]")

  A developer will be able to choose between different abstraction and assistance levels. The system will support multiple prompt templates for error remediation. The deliverables include: 
  - Extend Theia's settings with a setting to switch between two modes of abstraction and assistance.
  - Design and implement modular AI prompt templates that vary in verbosity and guidance.

#strong("Milestone 4. User testing. [Week 9-11, 3 Weeks]")

  Prepare and execute a survey on this system in the context of a Java exercise during a tutorial. Test students with the terminal assistance enabled and disabled. The deliverables include:
  - Prepare a survey with two groups, one with terminal assistance and one without.
  - Collect qualitative data through a survey and interviews.
  - Document feasible improvements and create a product backlog for out-of-scope features.
  

#strong("Milestone 5. Natural Language Input. [Week 11-14, 4 Weeks]")
  
  A developer can interact with the terminal with natural language queries. An AI agent will explain the output, and a student can directly execute it in the terminal. The deliverables include:
  - Extend Theia's terminal with a side panel with a chat-style input interface.
  - Create an AI agent and an AI prompt template that parses inputs and generates terminal commands with corresponding explanations.
  - Integrate the generated command into the side panel as a structured block
  - Implement actions to copy, insert it into the terminal or execute the command directly.
