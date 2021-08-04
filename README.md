# MayeR

## Voraussetzungen

*MayeR* setzt *Python* Version 3 oder grösser voraus.
Im Kern verwendet *BalanceR* die [ccxt](https://github.com/ccxt/ccxt) Bibliothek. Diese gilt es mittels [pip](https://pypi.org/project/pip/) zu installieren:

`python -m pip install -r requirements.txt`

### Mayer Multiple
*mayer.py* ermittelt stündlich den BTC/USD Kurs und aktualisert damit den Tagesdurschnittskurs.
Aufgrund des Durschnittskurses der letzten 200 Tage und dem aktuellen Kurswert können *BalanceR* Instanzen sehr genaue und aktuelle Mayer Multiples berechnen.

Vor dem erstmaligen Start ist die Konfigurationsdatei *mayer.txt* mit dem Namen der gewünschten Börse zu ergänzen.


Der Name der zu verwendenden Konfigurationsdatei kann als Parameter, ohne der Dateierweiterung (*.txt*), übergeben werden:

`./mayer.py mayer`

Fehlt der Parameter, so fragt das Script bei jedem Start nach dem Namen der Konfigurationsdatei. Diesen gilt es ohne Dateierweiterung (*.txt*) einzugeben. Wird dieser Schritt übersprungen, so wird standardmässig die Konfiguration von *mayer.txt* verwendet.

##Betrieb
### Mayer Instanz
Soll die *MayeR* Instanz mit Hilfe des Watchdog-Scrpits *mayer_osiris.sh* überwacht werden, so ist die Installation von [tmux](https://github.com/tmux/tmux/wiki) notwendig.

`apt install tmux`

Im *mayer_osiris.sh* muss der Variable *workingDir* der absolute Pfad zum *mayer.py* Script angegeben werden.

Damit *mayer_osiris.sh* die *Mayer* Instanz kontinuierlich überwachen kann, muss ein entsprechender *Cronjob* eingerichtet werden:

`*/6 *   *   *   *   /home/bot/balancer/mayer_osiris.sh`

Die beiden Dateien *mayer.py* und *mayer_osiris.sh* müssen vor dem ersten Start mittels `chmod +x` ausführbar gemacht werden.