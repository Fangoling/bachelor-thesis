#let appendix_note(body) = {
  block(
    width: 100%,
    inset: 10pt,
    radius: 4pt,
    stroke: luma(180),
    fill: luma(245),
    breakable: true,
  )[
    #body
  ]
}

#let appendix_question(number, prompt, body) = {
  heading(level: 3, numbering: none, outlined: false)[Q#number - #prompt]
  body
}
