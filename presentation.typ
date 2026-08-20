#import "@preview/typslides:1.3.4": *
#show: typslides.with(
  ratio: "16-9",
  theme: "reddy",
  font: "Fira Sans",
  font-size: 20pt,
  link-style: "color",
  show-progress: false,
)

#front-slide(
  title: "L Systems",
  subtitle: "Implementazione in raylib e c++",
  authors: "B. Rodolfo, H.Kirollos",
  info: [#link("https://github.com/alonzo-bazaar/lsystems")],
)

#table-of-contents()

#focus-slide[
  L Systems

  (scusa rod se sto facendo il prototipo in italiano)
]

#slide(title:"Anatomia di un L-System")[

Per disegnare un albero tramite L-system serve avere
- Un alfabeto di *simboli* da interpretare come istruzioni per disegnare l'albero
  #linebreak()
  questi simboli possono essere
  - *non parametrici*: una "lettera e basta"
  - *parametrici* una "lettera" accompagnata da un vettore di parametri ($in bb(R)^n$ per un qualche $bb(N)$)
- Regole di *riscrittura* per stringhe fatte di questi simboli #linebreak()
  queste regole possono essere
  - *deterministiche* o *stocastiche*
  - *context free* (cosiddetti _0L-systems_) o context dependant(quale ad esempio un _2L-system_)
- Un sistema di *turtle graphics* a cui passare una stringa di questi simboli/istruzioni dopo che è passata tot volte per le regole di riscrittura
]


#slide(title:"Cosa si è fatto noi?")[
Noi si è realizzato uno *stochastic parametric OL System*
- *OL System*: Le regole di riscrittura (o _produzioni_, in gergo informatica teorica) sono _context free_, sarebbe a dire, determiniamo come sostituire un simbolo guardando solo quel simbolo, ignorando eventuali simboli che questo possa avere a destra o a sinistra all'interno della stringa
- *Stochastic*: Durante una riscrittura, la produzione che andiamo ad applicare al simbolo può essere fissa o può venire campionata da una qualche distribuzione di produzioni.
- *Parametric*: I simboli su cui vanno ad agire queste produzioni sono coppie lettera - vettore di parametri
]

#focus-slide[
  Turtle Graphics
]

#slide(title:"Turtle Graphics Tradizionale")[
Per parlare della parte di riscrittura serve parlare dei simboli che compongono le stringhe di istruzioni, e per parlare di quei simboli bisogna contestualizzare su cosa vanno ad agire questi simboli.

Turtle graphics tradizionalmente composto da
- una posizione in $bb(R)^2$ e un angolo
- una "penna" che si può alzare o abbassare per iniziare/smettere di disegnare
Un tale sistema prevende un set relativamente ridotto di istruzioni, solitamente
- vai avanti/dietro una certa lunghezza 
- gira a destra/sinistra di un certo angolo
- abbassa o alzall la "penna" dal "foglio"
]

#slide(title:"Istruzioni Nostra Tartaruga")[
Il sistema presentato nel libro prevede però ulteriori istruzioni, quali
- spostarsi in 3d e girare pitch, yaw, e roll
- salva stato precedente/ripristina un stato precedente salvato
- assottiglia/inspessisci il tratto (avanza l'indice in una tabella di spessori) (tronco spesso, rametti sottili)
- passa a un colore più scuro/più chiaro (avanza l'indice in una tabella di colori) (tronco marrone scuro, rametti verde chiaro)
- non è presente il concetto di una penna alzata/abbassata, andare avanti con o senza il "tracciare una riga" sono due istruzioni diverse
- `{` e `}` rinchiudono un contesto, tipo un `with` di python
  - `{` qua inizia un poligiono, fino alla fine del poligono segnati tutti i punti da cui passi
  - `}` prendi tutti i punti che ti sei segnato e facci un poligono
]  
#slide(title:"Struttura Nostra Tartaruga")[
Per implementare un sistema che potesse eseguire queste istruzioni la nostra tartaruga ha
- posizione $in bb(R)^3$, angolo rappresentato come matrice $3 times 3$ HLU (colonne formano vettori Heading, Left, Right)
- una tabella di spessori e un indice in questa tabella
- tabella di colori, sempre con indice, realizzata però come tabella di texture coordinate
  - facilita la fase di texturing il lavoro con lo shader (non bisogna gestire vertex color)
  - comportamento "color table" simulato con texture coordinate crescenti e una texture gradiente
- uno stack di stati precedentemente salvati, salvare fa push ripristinare fa pop
  - lo stato include anche gli indici nelle tabelle di spessore e texcoord
]
#slide(title:"Struttura Nostra Tartaruga")[
- flag per vedere se siamo in un "blocco" `{` ... `}` e un buffer di vertici dove ci segnamo il poligono corrente
  - buffer dove vengono salvati i vertici del poligono percorso durante il blocco `{` ... `}`

Inoltre per motivi di efficienza invece di disegnare l'albero la turtle crea un modello di albero, che poi passiamo subito alla gpu e non dobbiamo rieseguire la tartaruga a ogni frame in cui si vede l'albero, per creare il modello utilizziamo
- un buffer (espandibile) di vertex coordinate
- un buffer (espandibile) di texture coordinate

(qui parti con pippone sul pattern builder)
(quando incontri un'istruzione di disengare roba aggiungi la roba al buffer, poi alla fine fai get e hai tutta la roba che hai aggiunto nelle varie chiamate)
]

#slide(title:"Simboli")[
- un simbolo è una coppia carattere + vettore di numeri che rappresenta un'istruzione per il sistema di turtle graphics descritto sopra, l'alfabeto di simboli accettato dalla nostra turtle, ripreso dal libro, è
- `F|f` + `stride`: avanza di una lunghezza pari a `stride` lungoo l'angolo di heading, lasciando (`F`) o non lasciando (`f`) dietro una traccia di questo avanzamento
- `&|.|.|.|.|.` + `angolo`: ruota di +(`sdd`) o -(`sss`) angolo lungo l'asse H(`...`), L(`...`), o U(`...`)
- `'!` (senza parametri): incrementa indice in...
- `[|]` (senza parametri) : salva lo stato corrente `[` o ripristina lo stato precedentemente salvato `]`
- `{|}` (senza parametri) : inizia `{` a diesgnare un poligono, o finisci di disengare un poligono `}`
]

#slide(title:"Riscritture")[
  roba
]

#slide(title:"Inoltre Json")[
  roba
]

#focus-slide[
  Terrain
]

#slide(title: "Terrain")[
  - Procedural terrain generation
  - Based on Fractal Perlin Noise chunks
    - using non precalculated vectors
  - Amplitude, frequency, lacunarity are some of the attribute that models the shape
]
#slide(title: "Terrain Management")[
 - A function in the Terrain class take care of the chunks generation
    - Using a value of Render Distance
      - When the player move and a rendered chunk became outside the RD
      - The Management Function delete the chunk and deallocate memory
      
- Every chunk generated comes with a mesh and a bounding box
    - the bbox is used for Frustum Culling

]
#slide(title: "Terrain Drawing")[
  - Only the chunks inside the Render Distance are drawn
    - Since they are the only still existing
  - Applied Frustum Culling
  - Terrain texture has diffrent textures depending on the height
]

#focus-slide[
  Texture e Shader
]

#slide(title: "Texturing")[
  - Readapted a PBR shaders to use textures and lighting
  - An MRA image is created using Roughness and Ambient Occlusion
    - From the loaded textures
    - Metalness is set to 0
  - Then is used by the shaders togheter with a una Normal map
]
#slide(title: "Shader")[
  - PBR shader used for lightning interaction with textures
  - A shader is used for the trees another for the terrain
    - Separation is needed since terrain use two textures
  - Light class has been made for create directional light
    - Rapresenting the sun
    - Can manage more light by the shaders
]

#focus-slide[
  Player
]

#slide(title: "Player")[
  - Class that manage the camera and player controls
  - Use a semi-realistic phisics with differen parameter s.a.
    - Gravity
    - Air drag
    - Ground drag
    - Bobbing
  - Has the attribute of the Frustum Planes
    - Needed for frustum culling
]
