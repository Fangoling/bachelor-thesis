#import "/utils/todo.typ": TODO

= Background <background>

This chapter introduces the foundational concepts and technologies upon which this work builds. It describes the architecture of the Theia IDE, the technical mechanics of terminal emulation and shell integration, and the application of large language models in development tools.

== Theia IDE

Eclipse Theia is an extensible, open-source framework for building web-based Integrated Development Environments (IDEs). The framework supports execution both as a desktop application and in a browser, which facilitates its use in cloud-based development environments that require consistent, preconfigured workflows across different client machines.

Theia's architecture employs a strict separation between client-side and server-side processes, which communicate via a JSON-RPC protocol. It utilizes an extension-based model centered on InversifyJS for dependency injection, enabling the decoupling of components and allowing for deep customization of the IDE's behavior. In this architecture, extensions serve as the fundamental building blocks that constitute the IDE itself. #footnote[https://theia-ide.org/docs/architecture/]

For build and runtime workflows, Theia provides task and debug infrastructure that coordinates these actions and routes their input and output through the integrated terminal.

To support intelligent features, Theia provides the Theia AI framework that introduces abstractions for integrating Large Language Models (LLMs) into the development environment. It provides mechanisms for defining tool functions and agents, which serve as integration points for features like code completion, chat interfaces, and context-aware suggestions. #footnote[https://theia-ide.org/docs/theia_ai/] These abstractions allow developers to decouple the UI-level assistance from the underlying providers and the specific logic of AI-driven tools

== Terminal Emulation and Shell Integration

Terminal emulation involves the simulation of physical video terminals through software. Modern architectures achieve this using a Pseudoterminal (PTY), a kernel-level abstraction that provides a bidirectional communication channel between a terminal-oriented program, such as a shell, and a terminal emulator. In the Theia IDE, the `xterm.js` library #footnote[https://xtermjs.org/] serves as the terminal emulator, responsible for parsing the byte stream and rendering it within the browser. 

Communication via the PTY delivers prompts, command echo, and program output to the terminal emulator as a continuous bytestream.
This stream includes both standard output and standard error and may contain ANSI escape sequences for visual formatting or cursor control. A characteristic of this model is the absence of semantic boundaries within the stream, as the emulator does not natively distinguish between the start and end of a command execution.

To reconstruct this missing structure, terminal environments utilize shell integration. This technique involves injecting specialized scripts into the shell's configuration (e.g., `.bashrc` or `.zshrc`) to emit non-printing Operating System Command (OSC) escape sequences. These sequences, such as those defined in the OSC 133 protocol, act as markers for significant events: the start of a prompt, the start of command execution, and the completion of a command. #footnote[https://www.iterm2.com/documentation-escape-codes.html (iTerm2 OSC 133)] By interpreting these markers, the IDE can transform a raw byte stream into a structured history of discrete command-output pairs.

== Large Language Models in Development Tools

LLMs are probabilistic systems trained to generate and transform natural language and code. In software engineering environments, they are used to provide context-sensitive assistance, including explanation of code, summarization of diagnostic output, and support during debugging @mohamedImpactLLMAssistantsSoftware2026. For this thesis, their relevance lies in their ability to interpret complex build and runtime output and translate it into explanations that are easier for novice users to understand.

To integrate LLMs reliably into interactive development environments, their outputs must be transformed into machine-usable structures rather than remaining purely free-form text. Many systems therefore constrain responses through predefined output schemas and validation steps @gengGeneratingStructuredOutputs2025. This enables downstream components to consume model results deterministically, for example by separating an overall execution summary from individual error entries, source locations, and suggested remediation steps.

In educational applications, pedagogical design constraints govern the deployment of LLMs. Unlike professional assistants that focus primarily on immediate task completion, educational tools prioritize scaffolding—guidance that supports the learning process by offering actionable hints and explanations while encouraging independent problem-solving. Consequently, prompt engineering and rigorous output validation ensure that the assistance remains both technically accurate and pedagogically effective.
