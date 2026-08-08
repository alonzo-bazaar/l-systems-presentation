# presentazione l-systems
presentazione l-systems

# contenuti di questa repo
ho scaricato più o meno la qualsiasi qua dentro, è tipo un docker dei poveri ma per compilare un pdf, la cartella contiene
- file della presentazione (`presentation.typ`)
- script `run` che fa il setup di tutto (se serve) poi runna typst
- cartella asset con
  - il template usato per fare la presentazione (`assets > templates > typslides`)
  - tutti i font utilizzati per la presentazione (`assets > fonts`), in particolare
    - fira sans (quello default del template `typslides`)
    - jetbrains mono (per stile)
    - comic sans (per ridere)
  - il file eseguibile per runnare `typst` (`assets > tools > typst` (per linux), `assets > tools > typst.exe` (per windows))  
    gli eseguibili di typst dal github sono tutti compilati staticamente quindi l'eseguibile da solo basta e avanza.
  - il file eseguibile dell'interpreter per runnare lo script di setup/lancio
- license di qualsiasi cosa

# per editare il documento
penso vscode sappia gestire i file `.typ` abbastanza tranquillamente
se non out of the box sicuro c'è un plugin che puoi scaricarti per farlo funzionare

# come compilare il documento
per compilare sto documento se usa [typst](https://typst.app/), non si fa niente di troppo strano probabilmente puoi anche  prenderlo e schiaffarlo sulla web app, ma per come si è impostato qua abbiamo uno script `run` per gestirla un po' più tranquillamente

## da webapp
non so usare programmi web, vedi te se vuoi fare dalla webapp

## da script `run`
lo script `run` è diviso in due parti

- una prima scarica tutti gli asset che possono servire, purtroppo per come l'ho scritta questa parte dello script per ora funziona solo da posix (linux o mac), può funzionare (in parte) da windows se ti installi [la versione windows delle coreutil posix](https://github.com/microsoft/coreutils) ma per ora non l'ho testata, per evitare troppe beghe al momento lasciato nella repo tutta la roba che si è scaricato lo script così quando lo rirunni quella parte viene saltata e l'interpreter non si ammazza in medias res per "manca il comando `ls`"

- una seconda parta runna l'eseguibile `typst` (vendorizzato all'interno della repo insieme a tutto il resto, faceva più comodo) e gli passa il file della presentazione, questa parte ti produce in output il pdf abbastanza in fretta 

### per runnare lo script
- da posix (linux o mac), puoi fare
```sh
./assets/tools/shsl ./run
```
o anche semplicemente
```sh
./run
```

- da windows, puoi fare
```sh
.\assets\tools\shsl.exe .\run
```
o anche solo 
```sh
run
```
se girare `run` e basta non funziona ho aggiunto per sicurezza un file `.bat` che esegue `.\assets\tools\shsl.exe .\run`, per runnare il file `.bat` basta fa
```sh
run.bat
```
> i comandi per runnare lo script vanno eseguiti nella cartella dove sta lo script, altrimenti la shell non lo trova
