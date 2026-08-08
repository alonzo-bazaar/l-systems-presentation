#import "./assets/templates/typslides/template/main.typ": *

#show: typslides.with(
  ratio: "16-9",
  theme: "reddy",
  font: "Jetbrains Mono",
  font-size: 20pt,
  link-style: "color",
  show-progress: false,
)

#front-slide(
  title: "abbiamo fatto degli alberi",
  subtitle: [con raylib e degli l-system],
  authors: "B. Rodolfo, H.Kirollos",
  info: [#link("https://github.com/alonzo-bazaar/lsystems")],
)

#table-of-contents()

#slide[
  - un `lsystem` è fatto da
  - ci sono stringhe #stress("simobli")
  - ci stanno delle #stress("riscritture")
  - e poi le stringhe se passano a una #stress("tartaruga")

  #framed(title: "nota")[noi s'è fatto un l-system stocastico e parametrico, la stocasticità influisce su come si sono fatte le `riscritture`, mentre la parametricità ha inluito su tutto]
]

#focus-slide[
  e come s'è fatto?
]

#slide(title: "Outlined slide", outlined: true)[
  - Outline slides with `outlined: true`.

  #grayed([This is a `#grayed` text. Useful for equations.])
  #grayed($ P_t = alpha - 1 / (sqrt(x) + f(y)) $)
]

#slide(title: "Columns")[
  #cols(columns: (2fr, 1fr, 2fr), gutter: 2em)[
    #grayed[Columns can be included using `#cols[...][...]`]
  ][#grayed[And this is]
  ][#grayed[mannaggia kitemmuort]
  ]

  - Custom spacing: `#cols(columns: (2fr, 1fr, 2fr), gutter: 2em)[...]`

  - Sample references: @typst, @typslides.
    - Add a #stress[bibliography slide]...
    1. `#let bib = bibliography("you_bibliography_file.bib")`
    2. `#bibliography-slide(bib)`
]

#let bib = bibliography("bibliography.bib")
#bibliography-slide(bib)
