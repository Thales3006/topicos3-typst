#import "@preview/suiji:0.4.0": gen-rng, uniform

#let polar(angle, length) = (
  calc.cos(angle) * length,
  calc.sin(angle) * length,
)

#let segment(angle, height, span) = {
  let end = polar(angle, span)
  let bulge = polar(angle + 90deg, height)
  let control = bulge.zip(end).map(((b, e)) => b + e / 2)

  (control, end)
}

#let blob(
  seed,
  fill: black,
  stroke: none,
  scale: 1em,
  angle: (20deg, 60deg),
  height: (0.01, 3),
  span: (0.4, 2),
) = {
  let draw(rng, (low, high)) = uniform(rng, low: low, high: high)
  angle = angle.map(a => a / 1deg)

  let rng = gen-rng(seed)
  let segments = ()
  let turn = 0deg

  while turn <= 360deg {
    let (_, h) = draw(rng, height)
    let (_, s) = draw(rng, span)
    let (next-rng, step) = draw(rng, angle)
    rng = next-rng

    let next-turn = turn + step * 1deg
    if next-turn <= 360deg {
      segments.push(segment(-next-turn, h * 1pt, s * 1pt))
    }
    turn = next-turn
  }

  let factor = scale / 0.5em
  let quads = segments.map(points => curve.quad(
    relative: true,
    ..points.map(p => p.map(c => c * factor)),
  ))

  box(
    width: scale / 1.5,
    height: scale / 1.5,
    place(
      float: true,
      bottom + right,
      curve(fill: fill, stroke: stroke, ..quads, curve.close()),
    ),
  )
}
