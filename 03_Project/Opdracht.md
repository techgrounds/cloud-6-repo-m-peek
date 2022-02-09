# Infrastructure as Code

### Planning

| Onderwerp | Datum | 
| ------ | ------ |
| Start Python, start Project (v1.0) | 07 feb '22 |
| Introductie Project v1.1 | 14 maart '22 | 
| Oplevering- / eindpresentatie | 08 apr '22 |

## Opdracht
* Een werkende Bicep app van het MVP
* Ontwerp documentatie
* Beslissing documentatie
* Tijd logs
* Eindpresentatie

Bedrijf helpen bij transitie naar de cloud:

- VM disks moeten encrypted zijn.
- Webservers dagelijks geupdate; backups moeten 7 dagen behouden worden.
- Webserver moet op een geautomatiseerde manier geïnstalleerd worden. 
- admin/management server moet bereikbaar zijn met public IP.
- admin/management server moet alleen bereikbaar zijn vanaf vertrouwde locaties (office/admin;s thuis).
- IP range die worden gebruikt: 10,10,10,0/24 & 10.20.20.0/24
- Alle subnets moeten beschermd worden door een firewall op subnet niveau.
- SSH of RDP verbindingen met de webserver mogen alleen tot stand komen vanuit de admin server. 
- Wees niet bang om verbeteringen in de architectuur voor te stellen of te implementeren, maar maak wel harde keuzes, zodat je de deadline kan halen. 

Epic:
- Duidelijk eisen van de aplicatie
    - Puntsgewijze omschrijving van alle eisen
- Duidelijk overzicht van aannames
    - Puntsgewijze omschrijving van alle aannames
- Duidelijk overzicht van Cloud infrastructuur
    - Overzicht van alle diensten die gebruikt gaan worden.
- Werkende applicatie waarmee veilig netwerk gedeployd kan worden.
    - IaC-code voor en webserver en alle benodigdheden.
- Werkende aplicatie waarmee een werkende management server gedeployd kan worden. 
    - IaC-code voor een management server met alle benodigdheden
-  Een opslagoplossingn waarin bootstrap/post-deployment script opgeslagen kunnen worden
    - IaC-code voor een opslagoplossing voor scripts
- Data in de infrastructuur is versleuteld
    - IaC-code voor versleuteling voorzieningen.
- Iedere dag een backup hebben dat 7 dagen behouden wordt.
    - IaC-code voor backup voorzieningen.
- Weten hoe ik de applicatie kan gebruiken.
    - Documentatie voor het gebruik van de applicatie
- Een MVP kunnen deployen om te testen
    - Configuratie voor een MVP deployment