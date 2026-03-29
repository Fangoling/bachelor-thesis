#import "/utils/todo.typ": TODO

= Abstract
#TODO[ // Remove this block
  *Abstract*
  - Short (1/3-1/2 page) summary of the project 
  - It is fine to repeat yourself here 
]

The terminal is a central tool in the workflow of developers, yet it often presents challenges due to its steep learning curve and overwhelming output.
To address these issues, this work proposes an AI-assisted system to enhance terminal usability.
We implement the system within the Theia IDE, which features an integrated terminal. 

The proposed system utilizes a large language model (LLM) to process outputs, such as those generated during a Java build, to summarize key information, explain errors with remediation hints, and suggest commands based on natural language input.
By providing context-aware guidance and transparent explanation, the system reduces the need to consult external documentation. 
While the primary focus lies on supporting students in educational settings, the concepts explored in this thesis also point towards benefits for professional developers' workflows.
