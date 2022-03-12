# Project vereisten

## Versie 1.0
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

## Versie 1.1
Vereisten:
- De webserver moet via een load balancer bereikbaar zijn
    - De server moet geen eigen publiek IP adress meer hebben
- HTTP moet geupgrade naar HTTPS
    - Verbinding moet beveiligd zijn met minimaal TLS 1.2
- Webserver moet een health check ondergaan
    - Als de health check faalt moet de server automatisch hersteld moeten worden
- Scaleset gebruiken voor de webserver om aanhoudende belasting aan te kunnen, max 3.