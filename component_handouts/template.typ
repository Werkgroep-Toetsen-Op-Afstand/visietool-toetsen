// ── handout.typ ──────────────────────────────────────────────────────────────
// Typst template for Npuls Dimensie handouts.

// ── Shared palette ─────────────────────────────────────────────────────────
#let accent    = rgb("#E8380D")
#let lightgrey = rgb("#F2F2F2")
#let midgrey   = rgb("#AAAAAA")
#let darkgrey  = rgb("#3C3C3C")

// ── Shared helpers (top-level so raw typst blocks in body can call them) ────
#let checkbox-row() = grid(
  columns: (1fr, 1fr),
  gutter:  8pt,
  ..(("Toekomst", "Huidig")).map(label =>
    rect(
      width: 100%, height: 28pt,
      radius: 3pt, stroke: 0.5pt + midgrey,
      fill: lightgrey, inset: 6pt,
    )[
      #grid(
        columns: (14pt, 1fr), gutter: 6pt,
        rect(width: 12pt, height: 12pt,
             stroke: 0.8pt + darkgrey, radius: 2pt)[],
        align(horizon)[
          #text(size: 8pt, weight: "bold")[#label]
        ]
      )
    ]
  )
)

#let option(number, title, option-body) = {
  block(
    width:  100%,
    inset:  (x: 14pt, top: 12pt, bottom: 12pt),
    radius: 6pt,
    stroke: 1pt + accent,
    fill:   white,
    below:  12pt,
  )[
    #grid(
      columns: (28pt, 1fr),
      gutter:  8pt,
      align(horizon)[
        #circle(radius: 12pt, fill: accent)[
          #align(center + horizon)[
            #text(fill: white, weight: "bold", size: 11pt)[#number]
          ]
        ]
      ],
      align(horizon)[
        #text(weight: "bold", size: 10.5pt)[#title]
      ]
    )
    #v(8pt)
    #set text(size: 9.5pt)
    #set par(leading: 0.6em)
    #option-body
    #v(10pt)
    #checkbox-row()
  ]
}

// ── handout(…) ───────────────────────────────────────────────────────────────
#let handout(
  dimension-number: "?",
  dimension-title:  "",
  component-title:  "",
  instruction:      "Kruis 1 optie die geldt voor de huidige situatie en 1 voor de toekomst. Onderaan is ruimte voor aantekeningen of toelichting.",
  body,
) = {

  // ── Page & text defaults ─────────────────────────────────────────────────
  set page(
    paper:  "a4",
    margin: (top: 2cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm),
  )
  set text(font: "Helvetica Neue", size: 10pt, fill: darkgrey)
  set par(justify: true, leading: 0.65em)

  // ── Heading styles ────────────────────────────────────────────────────────
  show heading.where(level: 1): it => {
    v(6pt)
    text(weight: "bold", size: 11pt)[#it.body]
    v(4pt)
  }
  show heading.where(level: 2): it => {
    v(4pt)
    text(style: "italic", size: 9pt, fill: rgb("#666666"))[#it.body]
    v(2pt)
  }

  // ── Italic paragraphs → example style ────────────────────────────────────
  show emph: it => text(style: "italic", fill: rgb("#555555"))[#it.body]

  // ── PAGE HEADER ──────────────────────────────────────────────────────────
  grid(
    columns: (1fr, auto),
    align(bottom)[
      #text(size: 22pt, weight: "bold", fill: accent)[Dimensie #dimension-number]\
      #text(size: 12pt)[#dimension-title]
    ],
    align(right + bottom)[
      #text(size: 13pt, weight: "bold", fill: accent)[Npuls]
    ]
  )
  line(length: 100%, stroke: 2pt + accent)
  v(10pt)

  // ── Component banner ──────────────────────────────────────────────────────
  block(
    width: 100%, fill: accent,
    inset: (x: 12pt, y: 8pt), radius: 4pt, below: 8pt,
  )[
    #text(fill: white, weight: "bold", size: 11pt)[#component-title]
  ]

  text(size: 9pt)[#instruction]
  v(14pt)

  // ── BODY ─────────────────────────────────────────────────────────────────
  body

  // ── NOTES AREA ───────────────────────────────────────────────────────────
  v(10pt)
  text(size: 9pt, weight: "bold")[Aantekeningen / toelichting:]
  v(4pt)
  rect(
    width: 100%, height: 80pt,
    stroke: 0.5pt + midgrey, radius: 4pt, fill: lightgrey,
  )[]
}
