#import "/utils/todo.typ": TODO
// #bibliography("/thesis.yml")

= Problem
#TODO[ // Remove this block
  *Problem description*
  - What is/are the problem(s)? 
  - Identify the actors and use these to describe how the problem negatively influences them.
  - Do not present solutions or alternatives yet!
  - Present the negative consequences in detail 
]

Despite their importance, terminals in modern IDEs suffer significant usability challenges that hinder developer productivity and create steep learning curves for newcomers.
Error messages are often cryptic, requiring specialized knowledge to interpret, which prolongs debugging and increases frustration for developers. 
This is problematic for students with less experience and interdisciplinary students, who may be overwhelmed by the volume of work and discouraged by unclear feedback.

Users must memorize a wide range of commands with tool-specific syntax, flags, and parameters that vary across operating systems.
Developers must mentally transition between the IDE's graphical paradigms and the terminal's text-based interaction model, creating additional cognitive load, leading to deterioration in performance @article.
Unlike graphical interfaces with visible affordances, terminal capabilities remain hidden until explicitly learned or discovered through documentation.
Terminals provide minimal progress indicators and often fail to clearly communicate an operations' success or failure status.

These shortcomings directly conflict with Jacob Nielsen's usability heuristics @molichImprovingHumanComputer, which define fundamental principles for designing user-friendly systems. 
- Match Between System and the Real World (Heuristic 2): Instead of using familiar language, terminals rely heavily on domain-specific language, making them inaccessible to novice programmers. 
- Consistency and Standards (Heuristic 4): While modern UIs provide consistent cues, terminals lack affordances such as clear syntax highlighting or standardized feedback.
- Help User Recognize, Diagnose, and Recover from Errors (Heuristic 9): Error handling in terminals is minimal. Users are often left stranded with vague or overly technical error messages, forcing them to consult documentation and interrupt their workflow.
 
Existing Terminal Emulators, such as Warp @WarpAgenticDevelopment, attempt to address these problems with natural language input to execute commands and automatic problem solving depending on the last command output.
However, by directly solving issues for the user, these systems bypass the opportunity for students to develop transferable problem-solving skills, leaving them unprepared for contexts where such tools fail or are unavailable.  

