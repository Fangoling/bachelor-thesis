#import "/utils/appendix.typ": appendix_note, appendix_question

= User Study Materials <appendix-user-study>

== Interview Guide <Questions>

This section documents the structured interview guide used during the think-aloud user testing sessions described in the evaluation chapter. Each participant interacted with the running tool on the same representative build failure scenario and was asked to verbalize their observations while responding to the following prompts.

#appendix_question(
  1,
  [How often do you work with a terminal in your coursework or projects?],
)[
  This opening question establishes the participant's prior familiarity with terminal-based workflows.
]

#appendix_question(
  2,
  [Is it immediately clear what this tool does and when you would use it?],
)[
  This question probes the first impression of the interface and whether the purpose of the assistant is self-explanatory.
]

#appendix_question(
  3,
  [Walk me through what you see after running this command. What draws your attention first?],
)[
  This prompt is used to observe the visual hierarchy of the interface and the order in which participants process the presented information.
]

#appendix_question(
  4,
  [Is the level of detail in the explanation appropriate - too much, too little, or about right?],
)[
  This question assesses whether the explanation is calibrated to the intended audience and whether its presentation feels proportionate to the error at hand.
]

#appendix_question(
  5,
  [Does the explanation help you understand the error, or does it feel like it just restates what happened?],
)[
  This question focuses on the pedagogical value of the explanation beyond the raw terminal output.
]

#appendix_question(
  6,
  [After reading the fix steps, did they give you enough context to act on them, or did they feel too generic?],
)[
  This question evaluates whether the proposed remediation guidance is actionable and sufficiently concrete.
]

#appendix_question(
  7,
  [Would you prefer the fix steps to always be visible, or do you find the toggle appropriate? Why?],
)[
  This prompt examines whether the disclosure pattern for remediation guidance matches participant expectations.
]

#appendix_question(
  8,
  [Did you use the option to open the file at the relevant line? If yes, how did that feel compared to manually navigating to the file yourself?],
)[
  This question explores the discoverability and perceived usefulness of the navigation affordance.
]

#appendix_question(
  9,
  [Are there situations where you would prefer the plain terminal over this tool? If so, when?],
)[
  This question captures the perceived scope of the assistant and the contexts in which participants consider it valuable.
]

#appendix_question(
  10,
  [What is the one thing you would change or add first?],
)[
  This closing question invites participants to identify the most important improvement from their perspective.
]

== Question-wise Summary of Responses

This section summarizes the results of the qualitative user study conducted with five participants. The findings are organized by interview question and reported as anonymized group-level observations. Frequencies are given in the form *x/5*. Because this is qualitative material, categories are not mutually exclusive and a single participant may contribute to more than one observation under the same question.

#appendix_question(
  1,
  [How often do you work with a terminal in your coursework or projects?],
)[
  - All participants reported working with a terminal on a daily basis or as a core part of their workflow (5/5).
  - One participant specified an interval of roughly every ten minutes, describing the terminal as an essential part of their workflow (1/5).
  - One participant explicitly noted that they are confronted with build outputs multiple times per hour (1/5).
]

#appendix_question(
  2,
  [Is it immediately clear what this tool does and when you would use it?],
)[
  - Participants immediately identified the tool's purpose as providing an error explanation together with its location and context (4/5).
  - One participant described the initial impression of the interface as visually dense and the buffer area as unintuitive (1/5).
]

#appendix_question(
  3,
  [Walk me through what you see after running this command. What draws your attention first?],
)[
  - The red error line was named as the first visual anchor by the large majority of participants (4/5).
  - The enlarged font of the error summary was singled out as a helpful secondary anchor (1/5).
  - One participant reported being drawn first to the inline code snippet, noting that code is easier to read than textual explanations (1/5).
  - Several participants described a two-step reading pattern: the red line first, followed by the textual summary directly below it (3/5).
]

#appendix_question(
  4,
  [Is the level of detail in the explanation appropriate - too much, too little, or about right?],
)[
  - Redundancy between bullet points and between the error name and its explanation was the most frequent criticism (3/5).
  - Participants suggested consolidating repeating points into a single summary and promoting the error name to a heading rather than repeating it (2/5).
  - The amount of text was described as excessive for advanced users, while being considered acceptable or necessary for beginners (2/5).
  - One participant found the explanation slightly technical for a first-semester student but saw this as motivating further research into unfamiliar terminology (1/5).
  - One participant explicitly stated that a shorter explanation would not be pedagogically effective (1/5).
]

#appendix_question(
  5,
  [Does the explanation help you understand the error, or does it feel like it just restates what happened?],
)[
  - The explanation was perceived as genuinely improving understanding rather than merely restating the error (4/5).
  - One participant qualified this by adding that the text volume was still too high for advanced students, even though the content was understood (1/5).
  - No participant reported the explanation as being purely redundant with the raw error message.
]

#appendix_question(
  6,
  [After reading the fix steps, did they give you enough context to act on them, or did they feel too generic?],
)[
  - The fix steps were described as too generic and not sufficiently tied to the concrete code context (4/5).
  - One participant criticized the phrasing of the fix steps, noting that instructions such as *"review the line"* are not actionable because the user already knows where the error is (1/5).
  - Repetition between the explanation and the fix steps was reported as reducing the added value of the fix section (1/5).
  - Despite these criticisms, participants acknowledged that the fix steps are useful in an educational context as a scaffolded path toward the solution (3/5).
  - One participant described the fix steps as *"not a solution, but a way to get to the solution"*, summarizing the overall sentiment (1/5).
]

#appendix_question(
  7,
  [Would you prefer the fix steps to always be visible, or do you find the toggle appropriate? Why?],
)[
  - The toggle for the fix steps was consistently approved, particularly in an educational context (5/5).
  - Participants argued that hiding the fix steps by default encourages the student to first engage with the error explanation and to reason about the problem before consulting the suggested fix (3/5).
  - Concerns were raised about the default-expanded behavior: the fix section was seen as consuming too much vertical space when shown by default, and the build error alone was considered sufficient for the initial view (2/5).
  - One participant distinguished between educational and professional use and recommended defaulting the fix steps to expanded outside of the learning context (1/5).
  - One participant noted that users who do not expand the fix section are unlikely to engage with the tool in general, relativizing the risk of hiding the feature (1/5).
]

#appendix_question(
  8,
  [Did you use the option to open the file at the relevant line? If yes, how did that feel compared to manually navigating to the file yourself?],
)[
  - Poor discoverability of the *open in editor* affordance was the dominant finding (3/5).
  - Participants reported that the button lacks a visual cue for interactivity and is therefore difficult to locate, even when its function is desired (3/5).
  - Once the feature was discovered, it was unanimously preferred over manually navigating to the file (3/5).
  - The benefit was described as particularly significant in larger projects, where manual file search was considered unproductive (1/5).
  - One participant additionally valued the inline error explanation that is revealed on hover within the editor (1/5).
]

#appendix_question(
  9,
  [Are there situations where you would prefer the plain terminal over this tool? If so, when?],
)[
  - For simple or routine tasks, a plain terminal was considered preferable (2/5).
  - Participants stated that advanced users would likely revert to a plain terminal once they no longer benefit from the scaffolded explanations (2/5).
  - The tool was seen as more valuable than the plain terminal for non-trivial errors, because it keeps explanation, fix suggestions, and navigation in a single context instead of requiring a switch to a browser or a chat assistant (2/5).
  - The clear pattern is a use-case split: beginners benefit from the tool, while advanced users fall back to a plain terminal for trivial commands.
]

#appendix_question(
  10,
  [What is the one thing you would change or add first?],
)[
  - Layout and use of space were the most frequently named priorities: the vertical layout was described as wasting horizontal screen real estate, and the buffer was considered not resizable, not properly scrollable, and not movable (3/5).
  - A side-panel arrangement of the assistant was preferred over the current bottom-docked terminal layout, and was considered more intuitive for beginners in particular (2/5).
  - Poor discoverability of interactive elements was raised as a key usability concern, with the suggestion to introduce a single persistent indicator that signals the presence of further actions rather than cluttering the output with permanently visible button labels (2/5).
  - Stronger visual affordances for clickable elements, including the use of distinct colors to communicate interactivity, were requested (1/5).
  - One participant suggested that the overlay should be viewable independently of the raw terminal output, reducing the perceived dominance of the terminal view (1/5).
  - The automatic expansion of the fix steps was proposed for cases in which multiple errors are reported at once, as a context-dependent default (1/5).
  - Error grouping was suggested for situations in which several reported errors share a common root cause, such as multiple diagnostics for the same line or the same method call (1/5).
  - Follow-up interaction was requested for complex error scenarios that cannot be resolved within a single explanation pass (1/5).
  - Smaller visual refinements, including rounder corners for the error container and additional color usage, were mentioned as improvements (1/5).
]
