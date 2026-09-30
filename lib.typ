#import "form.typ": blob

#let template(title: none, body) = {
  let main-color = rgb(121, 59, 184)
  let accent = rgb(250, 180, 180)
  let orchid = rgb(240, 180, 253)
  let fancy = text.with(font: "Atma", weight: 700, fill: main-color)

  let edge(side, ..cells) = place(
    side + horizon,
    grid(
      rows: 1fr,
      columns: 10em,
      align: side,
      ..cells,
    ),
  )

  let background = {
    edge(
      left,
      [
        #pad(
          x: -20%,
          top: -610%,
          blob(43, fill: rgb(160, 220, 250), scale: 27em),
        )
        #place(pad(
          x: -20%,
          top: -10000%,
          blob(4223, fill: none, stroke: rgb(200, 140, 200) + 0.3em, scale: 27em),
        ))
      ],
      [],
      pad(
        x: -150%,
        bottom: -50%,
        blob(3234, fill: rgb(220, 240, 200), scale: 30em),
      ),
      pad(
        x: 20%,
        bottom: -110%,
        blob(24, fill: orchid, scale: 15em),
      ),
    )

    edge(
      right,
      [
        #pad(
          x: -20%,
          top: -300%,
          blob(7123, fill: orchid, scale: 25em),
        )
        #place(pad(
          x: 80%,
          top: -10000%,
          blob(1223323322382, fill: rgb(234, 70, 140), scale: 20em),
        ))
      ],
      [],
      [],
      pad(
        x: -30%,
        bottom: -130%,
        blob(9220, fill: orchid, scale: 20em),
      ),
    )
  }

  set page(columns: 2, background: background)
  set par(justify: true)
  set text(size: 12pt, font: "TeX Gyre Adventor")

  show heading: it => {
    fancy(size: 30pt, it.body)
    v(-0.7em)
    line(
      length: 100%,
      stroke: (
        paint: rgb(187, 217, 254),
        thickness: 0.3em,
        dash: (0.7em, 0.5em, 0.1em, 0.5em),
        cap: "round",
      ),
    )
  }

  set list(marker: box(circle(radius: 0.3em, fill: accent)))
  set enum(numbering: n => text(font: "Atma", weight: 900, fill: accent)[#n.])

  set table(
    stroke: none,
    gutter: 0.4em,
    inset: 0.7em,
    align: center + horizon,
    fill: (x, y) => {
      if y == 0 { rgb(175, 80, 240) }
      else if x == 0 { rgb(195, 180, 240) }
      else { rgb(225, 210, 250) }
    },
  )
  show table.cell: set text(
    font: "OpenDyslexic",
    size: 10pt,
    weight: 700,
    fill: rgb(50, 50, 50),
  )

  show figure.caption: set text(size: 0.7em)

  show raw: set text(size: 1.2em)
  show raw.where(block: true): block.with(
    width: 100%,
    inset: 0.5em,
    radius: 0.5em,
    fill: rgb(240, 230, 253),
    stroke: main-color + 0.2em,
  )

  place(top + center, scope: "parent", float: true)[
    #fancy(size: 50pt, title)
    #v(3em)
  ]

  body
}
