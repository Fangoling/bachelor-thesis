#import "/utils/todo.typ": TODO


= Introduction
#TODO[ // Remove this block
  *Introduction*
  - Introduce the reader to the general setting (No Problem description yet)
  - What is the environment?
  - What are the tools in use?
  - (Not more than 1/2 a page)
]
At the Technical University of Munich, students of the subject Computer Science, Information Technology, and Games Engineering are introduced to the Java programming language, which teaches students the fundamentals of object-oriented programming.
During these exercises, students are expected to use both Integrated Development Environments (IDEs) and terminals, creating a dual environment.
In this environment, many students rely on modern IDEs, which provide powerful features such as graphical interfaces, intelligent code completion, and integrated debugging, to support the development of complex software systems.

However, despite these advancements, the command-line terminal remains essential to the development workflow #footnote[The State of the CLI 2023 Edition #link("https://www.warp.dev/state-of-the-cli-2023")].
It complements the IDE, enabling either unavailable or less efficient operations in graphical tools by providing powerful and flexible capabilities for tasks ranging from build automation to deployment, version control, and system configuration.

Among modern IDEs, Theia stands out as an IDE for both cloud and desktop.
It features a terminal that is integrated into the IDE, as shown in @theia below.
Theia itself is built on the Theia Platform, an open source framework managed by Eclipse Source #footnote[Theia IDE - AI-Native Open-Source Cloud and Desktop IDE #link("https://theia-ide.org")] for building custom, tailored cloud & desktop IDEs.

#figure(
  image("../../figures/theia.png"),
  caption: [Interface of the terminal integrated within the Theia IDE.]
) <theia>


