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

While prior research has explored using large language models to generate next-step hints for introductory programming exercises @roestNextStepHintGeneration2024 and explanations of malicious shell commands @dengRACONTEURKnowledgeableInsightful2025, applying AI assistance directly within an IDE-integrated terminal represents a novel and unexplored approach in educational research.

By automatically summarizing and explaining the error output of compilers and linters, students can more quickly identify their mistakes and gain more explicit guidance on how to resolve them @pankiewiczNavigatingCompilerErrors2024.
This feature also allows students to dedicate more time to solving the actual exercise rather than deciphering technical error messages, and reduces the occurrence of similar errors in the future @beckerEffectiveApproachEnhancing2016.
 
Existing Terminal Emulators, such as Warp #footnote[https://warp.dev], attempt to address these problems with natural language input to execute commands and automatic problem solving depending on the last command output.
However, by directly solving issues for the user, these systems bypass the opportunity for students to develop transferable problem-solving skills, leaving them unprepared for contexts where such tools fail or are unavailable.  
