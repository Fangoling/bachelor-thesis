#import "/utils/todo.typ": TODO

= Related Work
This work builds on prior research and tooling in three areas: terminal usability within IDEs, AI-assisted programming support, and educational scaffolding for error remediation. The following sections summarize the most relevant directions and clarify how the proposed system differs.

== Terminal Usability in IDEs
Modern IDEs integrate terminals to keep command-line workflows close to source code, debugging, and build tools. Prior work and tooling typically focus on improving discoverability (e.g., command palettes, snippets) and on bridging terminal output with editor navigation (e.g., clickable stack traces). These approaches reduce context switching, but they largely leave interpretation of noisy build output and error remediation to the user. This thesis extends terminal integration by adding an AI layer that summarizes output and structures errors with actionable hints while keeping the terminal as the primary interaction surface.

== AI Assistants for Programming
LLM-based assistants can explain code, generate snippets, and answer programming questions. Most widely deployed systems operate either as chat interfaces detached from the terminal or as editor-centric copilots focused on code completion. In contrast, this work targets the command-line workflow itself, taking raw terminal output as the primary input. The contribution is not generic code generation but context-aware output processing: summarization, classification of errors, and hint generation directly grounded in command execution results.

== Automated Error Diagnosis and Remediation
Research on error diagnosis often uses static analysis, build logs, or test failures to suggest fixes. These systems tend to optimize for correctness of the fix rather than for a learning-oriented explanation. The proposed system emphasizes structured, minimal hints and retains user control over applying fixes. It aims to reduce the time to understand errors without removing the learning opportunity, which is particularly relevant for student settings.

== Natural Language to Command Support
There is a body of work on mapping natural language to shell commands, but most solutions either require curated datasets or operate as standalone command generators. This thesis integrates natural language intent parsing into the IDE terminal flow and complements it with explanations and safe execution steps. The focus is on interaction design and trust: users can review, copy, or execute suggested commands rather than relying on opaque automation.

== Summary of Contributions
Compared to existing approaches, the core contribution is an integrated terminal assistant within Theia that combines output summarization, structured error explanations, configurable assistance levels, and natural-language command suggestions. The system balances automation with transparency, aiming to improve terminal usability while preserving educational value.
