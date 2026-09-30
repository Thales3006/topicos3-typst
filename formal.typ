#let template(title: none, body) = {
  let accent = rgb("#9e1b1b")
  let bar = 1.2cm

  let side-bar = place(right, block(
    width: bar,
    height: 100%,
    inset: (y: 2.5cm),
    fill: accent,
    {
      set align(center)
      set text(size: 9pt, tracking: 0.2em, fill: white)
      rotate(90deg, reflow: true, upper(title))
      v(1fr)
      context counter(page).display()
    },
  ))

  set text(font: "New Computer Modern", size: 11pt)
  set page(
    paper: "a4",
    margin: (left: 2.5cm, right: 2.5cm + bar, y: 2.5cm),
    background: side-bar,
  )
  set par(justify: true)

  set heading(numbering: "1.")
  show heading: it => block(above: 1.8em, below: 1em, sticky: true, {
    text(fill: accent, counter(heading).display(it.numbering))
    h(0.6em)
    it.body
  })

  set list(marker: box(square(size: 0.35em, fill: accent)))
  set enum(numbering: n => text(weight: "bold", fill: accent)[#n.])

  set table(
    stroke: none,
    inset: 0.6em,
    align: center + horizon,
    fill: (_, y) => {
      if y == 0 { accent }
      else if calc.even(y) { luma(240) }
    },
  )
  show table.cell.where(y: 0): set text(weight: "bold", fill: white)

  show figure.caption: set text(size: 0.9em, fill: luma(80))

  show raw.where(block: true): block.with(
    width: 100%,
    inset: 0.8em,
    fill: luma(245),
    stroke: (left: 2pt + accent),
  )

  block(below: 2em, stack(
    spacing: 0.8em,
    text(size: 24pt, weight: "bold", title),
    line(length: 4cm, stroke: 3pt + accent),
  ))

  body
}
