= Evaluation

To assess the usability and pedagogical effectiveness of the proposed AI terminal assistant, we conduct a think-aloud user testing session. This evaluation does not aim to serve as a controlled experiment with statistical claims, but rather seeks to gather qualitative feedback from students interacting with the system.

== Design 

We conduct the user testing session with five computer science students from the Technical University of Munich. All participants are regular terminal users with prior exposure to command-line build workflows. We structure the session around a think-aloud protocol. Each participant is shown the running tool applied to a representative build failure in a typical programming exercise. We ask the participants to verbalize their thoughts while interacting with the user interface.

Following the practical interaction, we conduct a structured interview with each participant. The questions cover the comprehension of the error, the quality of the provided explanation, the perceived utility of the suggested fix steps, the ease of navigation, and layout preferences. Because all participants are experienced terminal users, we interpret the findings as feedback from the upper end of the target audience, noting that first-semester students with no prior terminal experience are not represented in this sample.

== Objectives

The primary objective of this evaluation is to identify points of usability friction within the terminal assistant interface. We also assess whether the AI-generated error explanations are comprehensible to a student audience. In addition, we evaluate whether the educational design choices, specifically the use of plain-language explanations and hidden-by-default fix steps, match the expectations and needs of students.

== Results

During the testing sessions, we observed specific patterns in how participants interacted with the user interface. Regarding the visual hierarchy, the red error accent of the error line consistently drew attention first, guiding participants toward the explanation text. Consequently, all participants oriented to the content of the error explanation before reading the technical error type label.

When evaluating the explanation quality, participants broadly received the content as appropriate for a beginner audience. However, more experienced participants flagged redundancy between explanation steps that restated the same point. Participants criticized the bullet-point format as visually overwhelming, noting they would likely skim the text rather than read it thoroughly. This suggests that the presentation format needs adjustment to encourage deeper reading.

Regarding the provided fix steps, participants found them directionally useful but too generic. The steps did not reference the actual code of the student and therefore could not guide toward a concrete change. Despite this limitation, the participants unanimously approved the hidden-by-default disclosure toggle for the fix steps, confirming its appropriateness for an educational setting.

For the open-file-in-editor navigation feature, participants who discovered it received it positively. In contrast, several participants did not find or notice the "Open in Editor" button without prompting from the researcher. This lack of discoverability highlights a significant usability gap in the initial design.

Regarding the layout, participants considered the vertical layout unintuitive and generally preferred a horizontal arrangement. Nevertheless, they criticized the horizontal layout for generating excessive whitespace and noted that the buffer widget was not resizable. Participants confirmed they would use the tool as a beginner encountering a build failure for the first time, but experienced participants stated they would not use the AI assistant regularly, aligning with the target audience assumptions.

== Findings

The observations from the testing sessions reveal several insights into the system's effectiveness. The visual hierarchy successfully directs users to the most critical information first, although the error type label is less prominent than intended. The explanation quality is suitable for the target audience, but the visual density of bullet points discourages deep reading. This indicates that presenting text without clear structure leads to skimming rather than comprehensive analysis.

The feedback validates the core educational design decisions. The approval of the hidden fix steps and the positive reception of the plain-language explanations demonstrate that these choices match participant expectations for a tool targeting students without prior domain knowledge. These validations confirm that the system provides appropriate pedagogical scaffolding.

However, the discoverability gap for the editor navigation suggests that affordances relying on a hover-to-reveal mechanism are insufficient. Because the assistant component is primarily consumed through passive reading rather than active interaction, new users may not know where to look for hidden actions. This insight motivated a direct revision of the interaction design.

== Discussion

To address the identified usability friction and improve the pedagogical value of the system, we implemented several revisions based on the evaluation findings. To improve the explanation quality and reduce visual density, we replaced plain bullet points with a structured label-and-body format, making each point easier to scan. To align with the visual hierarchy participants established naturally, we also accented the error type label in red alongside the explanation text. These changes guide the reader's attention more effectively.

To eliminate the discovery gap observed during the sessions, we changed the action buttons so they remain visible rather than appearing only on hover. We also introduced a responsive layout in which the assistant view adapts to the available panel width, reduces unused whitespace, and addresses the layout concerns raised by the participants. These revisions make the interface easier to discover and use.

While these revisions address the immediate usability issues, the generic nature of the fix steps remains a disadvantage. Because the system currently does not incorporate the student's local workspace context beyond the terminal output, it cannot provide code-specific remediation guidance. This limits the assistant's ability to offer highly targeted help, pointing toward an area for future enhancement.

== Limitations

The evaluation methodology carries several limitations that affect the validity of the results. First, the sample size of five participants does not support statistical claims; therefore, the findings are qualitative and indicative only. Second, there is a selection bias regarding the participants' experience levels. All participants were experienced terminal users, which skewed the feedback towards finding the explanations too verbose. Because first-semester students with no terminal background were not represented, the results may not fully reflect the needs of the primary target audience.

Additionally, the think-aloud protocol and the presence of a researcher may have introduced observer bias. Participants may have been more thorough in their reading and interaction than a student working alone in a natural environment. The evaluation also covered a single fixed scenario involving one specific build failure. Consequently, the findings may not generalize to different types of errors, longer development sessions, or repeated use of the tool over time.
