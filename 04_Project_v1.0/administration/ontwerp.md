# Ontwerp documentatie
Gekozen (N)SG regels; visualisatie van wat en in welke volgoorde de aplicatie gedeployed wordt in de cloud.

## Resources
Resources zijn opgedeeld in verschillende modules
- Network:
    - Virtual Network
    - Virtual Network peering
    - Network Security Rules
- Managementserver
- Webserver
- Keyvault:
    - Customer managed key
- Disk encryption set
- Recovery Service Vault
- Storage Account:
    - Post Deployment Scripts    


### Network
Module die Virtual Network (vNet) en netwerk peering tussen de twee vNets die opgezet worden. 

#### NSG-rules
Regels binnen de Network Security Groups

Webserver:
* alleen bereikbaar met SSH via managementserver (adminserver)

Managementserver:
* bereikbaar via een publiek IP
* alleen bereikbaar vanaf vertrouwde locaties (office/admin's thuis)
* bereikbaar via RDP

### Network Peering
Module die twee Virtual networks met elkaar verbind en deze aan elkaar koppeld.

### Keyvault
Module die keyvault
* Resource KeyVault
    - KeyVault rules
* Resource accessPolicies
* Resource Keys 

### Recoveryservice Vault
Module die recovery

### Storageaccount
Module voor storageaccount maken
- Disk encrypted

### Virtual Machines
De infrastructuur bevat twee VM's 

WebVM:
- Linux Ubuntu server
- Automatische installatie webserver
- Disk encryption

AdminVM:
- Windows VM
- Publiek IP adress
- Disk encryption

### Recomendations
Extra services die aangeraden worden
- firewall op subnet niveau.