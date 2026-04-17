#pagebreak()
= Evaluation <evaluation>

To assess the usability and pedagogical effectiveness of the proposed AI Terminal Assistant, we conduct a think-aloud user testing session. This evaluation does not aim to serve as a controlled experiment with statistical claims, but rather seeks to gather qualitative feedback from students interacting with the system.

== Objectives

The primary objective of this evaluation is to identify points of usability friction within the terminal assistant interface. We also assess whether the AI-generated error explanations are comprehensible to a student audience. In addition, we evaluate whether the educational design choices, specifically the use of plain-language explanations and hidden-by-default remediation steps, match the expectations and needs of students.

== Design 
We conducted guided think-aloud sessions with five computer science students who regularly use terminal-based workflows. All participants interacted with the same prototype version of the AI Terminal Assistant, based on a fixed implementation snapshot, and completed the session on the same representative build-failure scenario from a typical programming exercise. The prototype was run in Theia 1.70 in a consistent editor environment so that all participants saw the same interface behavior.

During the session, participants were asked to verbalize their observations while responding to a structured interview guide covering first impression, explanation quality, remediation usefulness, navigation, and layout preferences. The full question set is provided in @appendix-user-study. The user test reproduction package, which includes the programming exercise and the implementation snapshot of the AI Terminal Assistant is available online. #footnote[https://github.com/Fangoling/bachelor-thesis-enhancing-terminal-usability-replication/releases/tag/ba]

== Results

During the testing sessions, we observed specific patterns in how participants interacted with the user interface. Most participants immediately understood the tool's purpose as an interface for explaining a build error together with its location and context. Regarding the visual hierarchy, the red error accent of the error line was the dominant first visual anchor for most participants, usually guiding attention toward the summary and explanation text. However, this pattern was not universal, as one participant reported focusing first on the inline code snippet.

When evaluating the explanation quality, participants broadly received the content as appropriate for a beginner audience. However, more experienced participants flagged redundancy between explanation steps and between the error name and its explanation. Participants criticized the bullet-point format as visually overwhelming, noting they would likely skim the text rather than read it thoroughly. This suggests that the presentation format needs adjustment to encourage deeper reading.

Regarding the provided remediation steps, participants found them directionally useful but too generic. The steps did not reference the actual code of the student and therefore could not guide toward a concrete change. Despite this limitation, the participants unanimously approved the hidden-by-default disclosure toggle for the remediation steps, confirming its appropriateness for an educational setting.

For the open-file-in-editor navigation feature, participants who discovered it received it positively. In contrast, several participants did not find or notice the "Open in Editor" button without prompting from the researcher. This lack of discoverability highlights a significant usability gap in the initial design.

Regarding the layout, participants considered the initial bottom-docked vertical arrangement unintuitive and generally preferred a side-oriented presentation. They also criticized the use of space, noting excessive whitespace and that the buffer widget was not resizable. Participants confirmed they would use the tool as a beginner encountering a build failure for the first time, but experienced participants stated they would not use the AI assistant regularly, aligning with the target audience assumptions.

== Discussion

The observations from the testing sessions reveal several insights into the system's effectiveness. The visual hierarchy usually directs users to the most critical information first, although the error type label is less prominent than intended. The explanation quality was perceived as suitable for beginners, but the visual density of bullet points discourages deep reading. This indicates that presenting text without clear structure leads to skimming rather than comprehensive analysis.

The feedback is consistent with the core educational design decisions. The approval of the hidden remediation steps and the positive reception of the plain-language explanations indicate that experienced terminal users considered these choices appropriate for a tool targeting less experienced students. This supports the intended pedagogical scaffolding, but it should not be read as a direct validation by beginner students themselves.

However, the discoverability gap for the editor navigation suggests that affordances relying on a hover-to-reveal mechanism are insufficient. Because the assistant component is primarily consumed through passive reading rather than active interaction, new users may not know where to look for hidden actions. This insight motivated a revision of the interaction design.

== Limitations 

The evaluation methodology carries several limitations that affect the validity of the results. First, the sample size of five participants does not support statistical claims; therefore, the findings are qualitative and indicative only. Second, there is a selection bias regarding the participants' experience levels. All participants were experienced terminal users, which skewed the feedback towards finding the explanations too verbose. Because first-semester students with no terminal background were not represented, the results may not fully reflect the needs of the primary target audience.

Additionally, the think-aloud protocol and the presence of a researcher may have introduced observer bias. Participants may have been more thorough in their reading and interaction than a student working alone in a natural environment. The evaluation also covered a single fixed scenario involving one specific build failure. Consequently, the findings may not generalize to different types of errors, longer development sessions, or repeated use of the tool over time.
