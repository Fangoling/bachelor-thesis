#import "/utils/todo.typ": TODO

= Related Work

This chapter builds on prior research and tooling in three main areas: the evolution of shell integration, the application of artificial intelligence in command-line environments, and the use of language models for pedagogical error explanation. It examines how existing systems approach these domains, identifies their limitations regarding open educational environments, and outlines the specific contributions of this thesis.

== Shell Integration in Terminal Emulators

The iTerm2 terminal pioneered shell-level metadata integration through custom escape sequences for tracking information such as working directories and user marks #footnote[https://iterm2.com/]. Building on this concept, Visual Studio Code standardizes the use of Virtual Terminal (VT) sequence extensions #footnote[https://www.xfree86.org/current/ctlseqs.html], specifically OSC 133, to track command history, exit codes, and semantic boundaries within a mainstream IDE #footnote[https://code.visualstudio.com/docs/terminal/shell-integration]. The Warp terminal extends this concept from invisible background tracking to visual block models that isolate individual inputs and outputs entirely #footnote[https://docs.warp.dev/terminal/blocks]. 

These implementations show that OSC sequences and visual block models can establish semantic terminal state effectively. However, the Eclipse Theia framework currently lacks this foundational integration, leaving its terminal output as an unstructured textual stream. In contrast, this thesis implements the missing OSC shell integration layer for Theia to enable advanced structural features and support subsequent intelligent interactions.

== AI-Assisted Terminal and Command-Line Tools

Building upon structured terminal data, the industry increasingly integrates LLMs into professional development tooling. Tools like Warp AI offer native terminal integration that explains errors isolated within specific execution blocks #footnote[https://warp.dev/terminal/blocks]. Similarly, GitHub Copilot #footnote[https://github.com/features/copilot] and Cursor #footnote[https://cursor.com/] provide deep IDE integration, allowing their underlying LLMs to read terminal buffers and suggest automated fixes for failed executions. 

While these systems demonstrate the utility of AI in the terminal, they operate as proprietary platforms rather than open, extensible frameworks. These tools also optimize for rapid professional development, which prioritizes the immediate correctness of a fix over a learning-oriented explanation. In contrast, this thesis targets an open IDE framework and prioritizes pedagogical assistance that helps users understand the problem by offering hints rather than direct solutions.

== AI Error Explanation for Learners

Within the domain of computer science education, researchers actively explore the pedagogical application of LLMs. Education platforms such as Artemis utilize LLMs to perform consistency checks and assist with grading programming exercises @kruscheArTEMiSAutomaticAssessment2018.
Other approaches, like the AI virtual tutor Iris, introduce student-facing chatbots that operate alongside the primary development environment to assist students in their studies @bassnerIrisAIDrivenVirtual2024. 

Although these tools provide valuable educational assistance, they typically rely on static artifacts, such as post-mortem log analysis, or require the student to context-switch to an external web portal. By operating outside the immediate execution loop, these systems disrupt the natural development workflow. We address this limitation by offering live, in-terminal intervention that integrates explanations directly alongside the execution output.

== Secondary Rationale for Advanced Terminal Interactions

The design of structured terminal interactions is further supported by software engineering literature concerning developer interruptions, context reconstruction, and fragmented information. Frequent context switching forces developers to repeatedly reconstruct their mental models of the system state, which degrades productivity and increases the risk of errors @abadTaskInterruptionSoftware2018. Presenting terminal output as a continuous, unstructured stream exacerbates this fragmented information problem, as users must manually filter noise to find relevant execution results. 

While minimizing context switches is not the primary evaluated focus of this thesis, this literature still motivates structured command interactions indirectly. By isolating terminal output into discrete blocks and providing inline AI summaries, the proposed system may reduce the cognitive overhead associated with interpreting complex command-line output.

== Research Gap and Thesis Contribution

Existing research and industry practices demonstrate the technical viability of OSC-driven terminal integration, the professional utility of AI-assisted command-line tools, and the pedagogical need for automated error explanations. However, a significant gap remains at the intersection of these domains. Most widely deployed systems operate either as proprietary tools optimized for professionals or as detached pedagogical aids that interrupt the developer workflow. There is currently no open-source, extensible implementation that brings the professional standards of OSC-driven AI assistance directly into a pedagogical IDE workflow for learners.

To address this gap, we bridge the missing technical layers within the Eclipse Theia ecosystem. Compared to existing approaches, the core contribution is an integrated terminal assistant within Theia that combines output summarization for task-based executions, structured error explanations, and configurable assistance levels as a thesis objective. By establishing structured terminal history for Theia as an enabling infrastructure, the thesis shows how a tightly integrated AI assistant can support students directly within their command-line workflow.
