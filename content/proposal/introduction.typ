#import "/utils/todo.typ": TODO


= Introduction
#TODO[ // Remove this block
  *Introduction*
  - Introduce the reader to the general setting (No Problem description yet)
  - What is the environment?
  - What are the tools in use?
  - (Not more than 1/2 a page)
]
The Technical University of Munich introduces students in Computer Science, Information Technology, and Games Engineering to the Java programming language, which teaches the fundamentals of object-oriented programming.
During these exercises, students work within an Integrated Development Environment (IDE) that displays Java build output in its build output window.

While modern IDEs simplify software development through graphical interfaces, intelligent code completion, and integrated debugging, the terminal remains essential in the development workflow #footnote[The State of the CLI 2023 Edition #link("https://www.warp.dev/state-of-the-cli-2023")]. 
The terminal complements the IDE, enabling operations that are either unavailable or less efficient in graphical tools by providing capabilities for tasks ranging from build automation to deployment, version control, and system configuration.
Although students typically view the build results through the IDE's build output window, these results originate from processes executed in a terminal environment by the IDE in the background.

To integrate terminal functionality seamlessly, modern IDEs incorporate a terminal directly within their interfaces. An example is the Theia IDE, a unified cloud and desktop IDE maintained by Eclipse Source #footnote[Theia IDE - AI-Native Open-Source Cloud and Desktop IDE #link("https://theia-ide.org")].
Theia IDE follows a modular architecture and consists of Theia extensions #footnote[https://theia-ide.org/docs/extensions/]. Among them, the Terminal Extension shown in @theia-terminal embeds a terminal in the workbench, allowing developers to run commands without leaving the IDE.
@theia-architecture illustrates the architecture overview of Theia IDE with the Theia Terminal Extension.

#figure(
  image("../../figures/theia2.png"),
  caption: [Theia IDE with an embedded terminal.]
) <theia-terminal>

#figure(
  image("../../figures/TheiaIdeAom.drawio.svg"),
  caption: [Overview of the modular architecture of Theia IDE with the Theia Terminal Extension.]
) <theia-architecture>
