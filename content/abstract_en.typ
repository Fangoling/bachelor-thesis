The terminal is a central tool in the workflow of developers, yet it often presents challenges due to its steep learning curve and overwhelming output.
To address these issues, this work proposes an AI-assisted system to enhance terminal usability.
We implement the system within the Theia IDE, which features an integrated terminal. 

The proposed system leverages a large language model (LLM) to process outputs, such as those generated during a Java build, to summarize key information and explain errors with remediation hints.
By providing context-aware guidance and transparent explanation, the system reduces the need to consult external documentation. 
Shell integration extends the capabilites of the terminal to capture structured command execution data and construct a commmand history, which enhances the context available for AI analysis. 

To evaluate the system's effectiveness, we conduct a qualitative user study with computer science students, gathering feedback on usability and pedagogical value.
While the primary focus lies on supporting students in educational settings, the concepts explored in this thesis also point towards benefits for professional developers' workflows.
