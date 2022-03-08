# Project IaC

Log van project Infrastructure as Code Bicep. 
- Versie 1.0 
    14 februari tot 11 maart 2022
- Versie 1.1
    14 maart tot 8 april 2022

# Versie 1.0

## Log [14-02-22]

### Dagverslag (1 zin):
- Opdracht project v1.0 doorlezen, vereisten vinden voor IaC
- Architectuur bespreken in groep.
- Storymapping
### Opstakels:
Services die nog toegevoegd moeten worden die niet in de architecturele tekening staan, maar wel nodig zijn voor de MVP.
### Oplossingen:
[Guide to Story Mapping](https://www.digite.com/agile/story-mapping/)
### Learnings:
Ontdekken van prioriteiten en onderdelen van het project. 

--- 
## Log [15-02-22]

### Dagverslag (1 zin):
- Bicep learning path. 
- P.O meet
### Opstakels:
Architecturele verbeteringen die niet nodig zijn voor MVP. 
Enkel focus op MVP.
### Oplossingen:
Focus op MVP; niet op verbeteringen. 
### Learnings:
IaC opbouwen vanuit kleinere onderdelen. Kijken of geschreven code werkt  en deze dan uitbreiden. 
Specificaties voor MVP; Managementserver is Windows; Webserver eigen keus, keuze beargumenteren in ontwerp documentatie. 

--- 
## Log [16-02-22]

### Dagverslag (1 zin):
- IaC workshop
- Bicep learning path/Bicep documentation
### Opstakels:
Focus op MVP, niet op verbeteringen
### Oplossingen:
IaC opbouwen vanuit kleinere onderdelen. Focus op de resources.
### Learnings:
Focus op MVP, niet op verbeteringen

--- 
## Log [17-02-22]

### Dagverslag (1 zin):
- Deploy resourcegroup in Bicep.
- Modules ontwerpen voor verschillende resources. 
### Opstakels:
Afhankelijkheden van modules; outputs die doorgegeven moeten worden aan volgende service
### Oplossingen:
IaC opbouwen vanuit kleinere onderdelen. Focus op de resources.
### Learnings:
Deployen van Bicep scripts via VScode

--- 
## Log [18-02-22]

### Dagverslag (1 zin):
- P.O. Meet
- Werken met modules
### Opstakels:
Resources in verschillende resourcegroupen deployen; geen antwoord op gestelde vragen hierover, werken aan MVP.
### Oplossingen:
Gebruik van 1 resourcegroup voor MVP. IaC opbouwen vanuit kleinere onderdelen. Focus op de resources.
### Learnings:
Bicepscripts opbouwen. In main een module aanroepen. 

--- 
## Log [21-02-22]

### Dagverslag (1 zin):
- Documentatie aanmaken. 
### Opstakels:
Vereisten voor documentatie, ontwerpdocumentatie en beslissingsdocumentatie vereisten.
### Oplossingen:
Google; andere projecten bekijken op github.
### Learnings:
Documentatievereisten.

--- 
## Log [22-02-22]

### Dagverslag (1 zin):
- Onderzoeken of losse modules werken.
- Welke resources samen in een module gaan. 
### Opstakels:
Sommige resources moeten door verschillende andere resources geimplementeerd worden.
### Oplossingen:
Verschillende oplossingen om dependencies vast te leggen. 
### Learnings:
Afhankelijk van de resource moet de dependency vastgelegd worden. Verschillende soorten dependencies. Kan met parent/child; depends on en gebruik van outputs. 

--- 
## Log [23-02-22]

### Dagverslag (1 zin):
- Netwerkmodule ontwerpen en deployen
- Peering van Vnets
### Opstakels:
Wens was eigenlijk om modules kleiner te maken en twee keer aan te roepen.
### Oplossingen:
Minder modules; mogelijkheid om later modules op te breken en in kleinere onderdelen te verdelen.
### Learnings:
Reusable modules.

--- 
## Log [24-02-22]

### Dagverslag (1 zin):
- Keyvault ontwerpen en deployen
- Meeting met andere Azure groepen voor vragen m.b.t. project
### Opstakels:
Regels van de keyvault
### Oplossingen:
Eerst regels weggecomment, resource gedeployed en verder gewerkt aan regels toevoegen.
### Learnings:
A small step, can be a big leap.

--- 
## Log [25-02-22]

### Dagverslag (1 zin):
- Voorbereiden op tussentijdse presentatie. 
### Opstakels:
Niet tevreden met het punt waar ik nu ben door ziekte wat achterstand opgelopen.
### Oplossingen:
Rust nemen en overzicht creëeren. 
### Learnings:
Verschillende manieren waarop opleidingsgenoten hun code hebben geschreven. 

--- 
## Log [28-02-22]

### Dagverslag (1 zin):
- Storage account deployen met blob container.
### Opstakels:
Encryptie werkt niet. 
### Oplossingen:
Encryptie vereisten uit elkaar halen en opdelen in kleinere onderdelen. 
### Learnings:
Verschillende soorten encryptie en beveiligingsmanieren. 

--- 
## Log [01-03-22]

### Dagverslag (1 zin):
- Module voor webserver en managementserver gemaakt.
### Opstakels:
Dependencies van bepaalde resources. Werken met outputs en resource id's van verschillende resources.
### Oplossingen:
Logische indeling is van belang
### Learnings:
Verschillende manieren van outputs, refereren naar parent e.d.

--- 
## Log [02-03-22]

### Dagverslag (1 zin):
- Modules omgegooid, anders ingedeeld
- Een file aangemaakt voor testing perposes
### Opstakels:
Dependencies van resources voor testen.
### Oplossingen:
Een testfile aangemaakt waarin alle resources samengevoegd worden. 
### Learnings:
Soms is in een file werken makkelijker. 

--- 
## Log [03-03-22]

## Dagverslag (1 zin):
- Module indeling vastgelegd in mainfile, waardoor die onbruikbaar is
- Vastgelegd welke resources in modules moeten, resources aangeroepen
    - ! Finetuning nodig
### Opstakels:
Key in keyvault
### Oplossingen:
Soms zit het in een andere resource als je denkt 
### Learnings:
Belang van troubleshooten; manieren van troubleshooten. 

--- 
## Log [04-03-22]

### Dagverslag (1 zin):
- Werkende keyvault, key, diskencryptionset, nsg, public ip, vnet, nic.
### Opstakels:
Juiste configuratie vinden
### Oplossingen:
Documentatie lezen
### Learnings:
Lezen en vergelijken. 

--- 
## Log [07-03-22]

### Dagverslag (1 zin):
- Werkede adminvm, werkende linuxvm met ssh
    - Netwerkinstellingen moeten nog aangepast
    - deploymentscript voor webvm moet nog aangemaakt worden
### Opstakels:
Instellingen juist krijgen
### Oplossingen:
Troubleshooten
### Learnings: 
Stap voor stap komen we er wel

--- 
## Log [08-03-22]

### Dagverslag (1 zin):
- Backup van vm's
    - moet in andere resourcegroup (best practice.)
- Storageaccount
- Deploymentscript
- Modules
### Opstakels:

### Oplossingen:

### Learnings:

--- 
## Log [09-03-22]

### Dagverslag (1 zin):
- documentatie
- parameterfile
- secretfile
### Opstakels:

### Oplossingen:

### Learnings:

--- 
## Log [10-03-22]

### Dagverslag (1 zin):
- 
### Opstakels:

### Oplossingen:

### Learnings:

--- 
## Log [11-03-22]
- presentatie versie 1.0
### Dagverslag (1 zin):
- 
### Opstakels:

## Oplossingen:

## Learnings:

---
# Versie 1.1 
---
## Log [14-03-22]

### Dagverslag (1 zin):
- Vereisten versie 1.1 doornemen
- Uitzoeken welke resources er nodig zijn. 
### Opstakels:

### Oplossingen:

### Learnings:

--- 
## Log [15-03-22]

### Dagverslag (1 zin):
- 
### Opstakels:

### Oplossingen:

### Learnings:

--- 
## Log [16-03-22]

### Dagverslag (1 zin):
- 
### Opstakels:

### Oplossingen:

### Learnings:

--- 
## Log [17-03-22]

### Dagverslag (1 zin):
- 
### Opstakels:

### Oplossingen:

### Learnings:

--- 
## Log [18-03-22]

### Dagverslag (1 zin):
- 
### Opstakels:

### Oplossingen:

### Learnings:

--- 
## Log [21-03-22]

### Dagverslag (1 zin):
- 
### Opstakels:

### Oplossingen:

### Learnings:

--- 
## Log [22-03-22]

### Dagverslag (1 zin):
- 
### Opstakels:

### Oplossingen:

### Learnings:

--- 
## Log [23-03-22]

### Dagverslag (1 zin):
- 
### Opstakels:

### Oplossingen:

### Learnings:

--- 
## Log [24-03-22]

### Dagverslag (1 zin):
- 
### Opstakels:

### Oplossingen:

### Learnings:

--- 
## Log [25-03-22]

### Dagverslag (1 zin):
- 
### Opstakels:

### Oplossingen:

### Learnings:

--- 