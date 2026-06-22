#import "/layout/feedbacklog_template.typ": *
#import "/metadata.typ": *
#import "/utils/feedback.typ": *

#set document(title: titleEnglish, author: author)

#show: feedbacklog.with(
  titleEnglish: titleEnglish,
  examiner: examiner,
  supervisors: supervisors,
  author: author,
  presentationDate: presentationDate,
  feedbacklogSubmissionDate: feedbacklogSubmissionDate,
)

#feedback(
  feedback: "Stephan Krusche: Use case “View Raw Build output” has a strange white overlay in the presentation",
  response: "This has been fixed in the updated Keynote source file."
)

#feedback(
  feedback: "Stephan Krusche: “Struggle” Detection is not covered well in the written theses as there are not enough citations. Patrick Bassner also has conducted research in this direction and it is good that you have cited their first paper, but you can give it more scientific “meat” by citing more of their work. (e.g. their second paper).",
  response: "As the thesis had already been officially submitted prior to the presentation, further citations could no longer be incorporated into the text."
)

#feedback(
  feedback: "Stephan Krusche: You define distinct objectives for the Beginner and Professional, but combine them both in the status. How is the status mapped to the Objectives? You have 3 Objectives for each Beginner and Professional vs 2 status points - Not consistent with the beginning.",
  response: "This has been corrected. The AI Terminal Assistant on the status slide has been replaced with the three individual Objectives mentioned in the initial Objectives slide."
)

#feedback(
  feedback: "Stephan Krusche: You have a lot of extended relations in your use case diagram. Extended relations are optional but usually indicate that only 10% of the cases require them. If you have an extended relation hidden behind another hidden relation, the case is modelled as very unlikely. For your target group - beginner students - this is not optional in most cases. So maybe rephrase this to be a top level citizen in the use case diagram and connect it to the beginner student directly.",
  response: "This has been updated in the Keynote source and PDF files. The thesis diagram itself was not altered, as the presentation took place after the official submission."
)

#feedback(
  feedback: "Stephan Krusche: Can we integrate Iris in EduIDE as terminal assistant, Liam Berger is currently working on an extension which uses IRIS within EduIDE. Talk to him and tell us if it works.",
  response: "I evaluated the integration of IRIS for external tool capabilities beyond standard chatbot usage. Following discussion, it was determined that utilizing IRIS for this specific use case would not be viable."
)

#feedback(
  feedback: "Sandro Speth: You are currently storing the terminal history items in chunks. What about scripts with transitive commands? Do dependent tasks get their own terminal history items?",
  response: "If commands are chained together (e.g., `npm run build && npm run browser`), both commands are captured and stored within a single command block/chunk."
)

#feedback(
  feedback: "Maximilian Anzinger: Can your system select more than one item from the terminal history to summarize? For complex tasks it would be interesting to have more context. Your system is also able to tell the user if the output was successful or not, so it would be interesting to know if the user is currently on the right path to the solution, given the history of events.",
  response: "The system is currently limited to selecting a single item from the terminal history, though multi-item contextual analysis is a compelling avenue for future work. However, this history-spanning analysis might fall outside the scope of this specific tool, whose primary goal is to translate immediate error messages for beginner students. Expanding the implementation to evaluate historical trends would require a significant overhaul of the current, highly constrained prompt design."
)