#import "/utils/todo.typ": TODO


= Motivation
#TODO[ // Remove this block
  *Proposal Motivation*
  - Outline why it is (scientifically) important to solve the problem
  - Again use the actors to present your solution, but don't be to specific
  - Do not repeat the problem, instead focus on the positive aspects when the solution to the problem is available
  - Be visionary! 
  - Optional: motivate with existing research, previous work 
]

While prior research has explored using large language models to generate next-step hints for introductory programming exercises @roestNextStepHintGeneration2024, and explanation of malicious shell commands @dengRACONTEURKnowledgeableInsightful2025, applying AI assistance directly within an IDE-integrated terminal represents a novel and unexplored approach in educational research.

By automatically summarizing and explaining the error output of compilers and linters, students can more quickly identify their mistakes and gain clearer guidance on how to resolve them. This allows students to dedicate more time to solving the actual exercise rather than deciphering technical error messages and reduces occurrences of similar errors in the future @beckerEffectiveApproachEnhancing2016.

Another advantage is the direct integration of this tool into an IDE, as the reduced context switching helps the student to maintain focus and work more productively.
This leads to a less intimidating experience for novice programmers, since the output is a part of a familiar interface.
At the same time, the AI model benefits from having context over the whole project, allowing it to provide the student with project-specific assistance. 

Context-aware prompt hints are displayed to the student based on recent interactions (e.g., the last command output), helping users recall and discover terminal commands that support a more efficient workflow.
Lowering the steep learning curve, makes the environment more accessible to beginners, reducing frustration and decreasing the risk of early dropout.

The system is designed to be both flexible and transparent.
For students, this means that instructors can calibrate the level of assistance to encourage deeper learning and problem-solving skills, while still providing support when needed.
For professionals, the same flexibility enables a streamlined workflow where the system hides unnecessary verbosity and maximizes AI assistance for efficiency.
This adaptability ensures the tool is valuable in educational and professional contexts.

