# Beslising log

Alle beslissingen met betrekking tot project: Bicep, Infrastructure as Code.

Opbouw van beslissing log:
- Well-architected framework Azure (WAF)
    - Beschrijving van de pillars van de WAF. En onderdelen van de beslissingen die daarin vallen
- Project vereisten. 
- Resourcegroups
    - Beslissingen met betrekking tot de resourcegroups
- Modules
    - Beslissingen per module
- Recomendations 
    - Beschrijving van de recommendations met betrekking op de WAF. 


## Well-architected framework Azure

* Reliability
    - Recover from failures and continue to function.
* Security
    - Protecting applications and data from threats. 
        - Encrytie van disks
        - Webserver enkel bereikbaar via managementserver
        - Network Security Group Rules
* Cost Optimazation
    - Managing costs to maximize the value deliverd
* Operational Excelence
    - Operations processes that keep a system running in production.
* Preformance Efficiency
    - The ability of a system to adapt on changes in load. 

## Project v1.0

Vereisten:
- Alle VM disks moeten encrypted zijn
- De webserver moet dagelijks gebackupt worden. De backups moeten 7 dagen behouden worden.
- De webserver moet op een geautomatiseerde manier geïnstalleerd worden.
- De admin/management server moet bereikbaar zijn met pubiek IP.
- De admin/management server moet alleen bereikbaar zijn op vertrouwde locaties (office/admin's thuis).
- De volgende IP ranges worden gebruikt: 10.10.10.0/24 & 10.20.20.0/24 .
- Alle subnets moeten beschermd worden door een firewall op subnet niveau. -> Vereiste eruit gehaald ivm kosten.
- SSH of RDP verbinding met de webserver mogen alleen tot stand komen vanuit de admin server. 

Resource ontwerp van de architect:
- Subscription
    - Keyvault
    - Recovery Service Vault
    - Vnet    
        - Vnet app-prd
            - Application subnet NSG
                - Webserver
        - Vnet management-prd
            - Application Subnet NSG
                - Managementserver
        - Peering between VNets
    - Storage account
        - PostDeploymentScrips

### Resourcegroups

De verschillende resources in verschillende resourcegroups deployen is best practice. 
Uiteindelijk langere modules geschreven, waardoor onderverdelen in de resourcegroups zoals in eerste instantie gewenst was niet gelukt is. 
- resourcegroup wordt nu aangemaakt in main, vervolgens worden de verschillende resources in die groep geplaatst. 

### Modules

De verschillende resources zijn ingedeeld in verschillende modules die vanuit de main.bicep uitgevoerd worden. 
- Netwerk module
- Keyvault module
- Management Server 
- Webserver
- Storage

#### Netwerk
De netwerkmodule bestaat uit de volgende resources
- Public IP
    - nodig voor beide VM's
- Network Security Groups
- Virtual Network
- NIC, network Interface
- Peering

#### Keyvault

#### Management Server

#### Webserver

#### Storage

