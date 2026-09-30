#import "@preview/droplet:0.3.1": dropcap

#let template(title: none, body) = {
  let blue = rgb("#1d4f91")
  let red = rgb("#a11d21")
  let margin = (x: 1.4cm, top: 2cm, bottom: 1.6cm)

  let ornament = grid(
    columns: (1fr, auto, 1fr),
    column-gutter: 0.6em,
    align: horizon,
    line(length: 100%, stroke: 0.5pt + blue),
    rotate(45deg, square(size: 4pt, fill: blue)),
    line(length: 100%, stroke: 0.5pt + blue),
  )

  let header = context block(
    width: 100%,
    inset: (bottom: 0.4em),
    stroke: (bottom: 0.5pt + blue),
    {
      set text(size: 8pt, fill: blue)
      if here().page() > 1 {
        smallcaps(title)
      }
      h(1fr)
      text(weight: "bold", counter(page).display())
    },
  )

  let column-rule = context {
    let start = if here().page() == 1 {
      locate(<bible-start>).position().y
    } else {
      margin.top
    }

    place(
      top + center,
      dy: start,
      line(
        angle: 90deg,
        length: page.height - start - margin.bottom,
        stroke: 0.4pt + blue.lighten(60%),
      ),
    )
  }

  set text(font: "Libertinus Serif", size: 9.5pt)
  set page(
    paper: "a5",
    fill: rgb("#fffdf6"),
    columns: 2,
    margin: margin,
    header: header,
    background: column-rule,
  )
  set columns(gutter: 1.2em)
  set par(justify: true, leading: 0.5em, spacing: 0.5em)

  show strong: set text(fill: red)

  show heading: it => {
    if it.level == 1 {
      block(
        above: 1.4em,
        below: 0.8em,
        sticky: true,
        smallcaps(text(size: 1.2em, tracking: 0.04em, fill: blue, it.body)),
      )
    } else {
      block(sticky: true, emph(it.body))
    }
  }

  set list(marker: text(fill: blue)[•])
  set enum(numbering: n => text(size: 0.8em, weight: "bold", fill: blue)[#n])

  set table(
    stroke: (_, y) => if y == 0 { (bottom: 0.5pt + blue) },
    inset: 0.5em,
    align: center + horizon,
  )
  show table: block.with(stroke: (y: 0.8pt + blue))
  show table.cell.where(y: 0): set text(weight: "bold", fill: blue)

  show figure.caption: set text(size: 0.85em, style: "italic")

  show raw.where(block: true): block.with(
    width: 100%,
    inset: 0.6em,
    radius: 2pt,
    fill: blue.lighten(92%),
  )

  place(top + center, scope: "parent", float: true, {
    set align(center)
    text(size: 26pt, tracking: 0.12em, fill: blue, upper(title))
    ornament
  })
  [#metadata(none)<bible-start>]

  let space = [ ].func()
  let inline-funcs = (
    text, space, linebreak, smartquote, strong, emph, box, link, footnote,
    super, sub, highlight, underline, strike, h, ref, cite,
  )
  let is-inline(it) = {
    it.func() in inline-funcs or (it.func() in (raw, math.equation) and not it.block)
  }

  let runs = ()
  for child in body.at("children", default: (body,)) {
    if not is-inline(child) {
      runs.push(child)
    } else if type(runs.at(-1, default: none)) == array {
      runs.at(-1).push(child)
    } else {
      runs.push((child,))
    }
  }

  let chapter = 0
  let verse = 0
  for run in runs {
    if type(run) != array {
      if run.func() == heading and run.at("depth", default: 1) == 1 {
        chapter += 1
        verse = 0
      }
      run
    } else if run.all(it => it.func() == space) {
      run.join()
    } else {
      verse += 1
      let words = run.slice(run.position(it => it.func() != space)).join()

      if verse == 1 and chapter > 0 {
        dropcap(
          height: 2,
          gap: 0.3em,
          weight: "bold",
          fill: blue,
          str(chapter),
          words,
        )
      } else {
        text(size: 0.65em, weight: "bold", fill: blue, baseline: -0.35em, str(verse))
        h(0.2em)
        words
      }
    }
  }
}
