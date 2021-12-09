# Processes
Uitzoeken hoeveel geheugen een process gebruikt en deze uitzetten. 

## Keyterms
Process - Het uitvoeren van code <br/>
Deamons - Draait op de achtergrond en is niet interactief. <br/>
Services - Reageert op vraag van programma's kan interactief zijn<br/>
Programs - Wordt gedraaid door de gebruiker. <br/>
Ssh - Secure shell. <br/>
PID - Bestand met het proces indentificatie nummer. 

## Opdracht
- Start ssh daemon.
- Vind de PID van de ssh daemon.
- Zoek uit hoeveel memory de sshd aan het gebruiken is.
- Stop of kill het sshd proces. 

### Gebruikte bronnen


### Ervaren problemen


### Resultaat
sshd - open SSH daemon.
cat /var/run/sshd/pd - find pid 
vmstat - check stats vm

