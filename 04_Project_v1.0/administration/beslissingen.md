# Beslising log

Alle beslissingen met betrekking tot project: Bicep, Infrastructure as Code.

Opbouw van beslissing log:
- Project vereisten. 
- Resourcegroups
    - Beslissingen met betrekking tot de resourcegroups
- Modules
    - Beslissingen per module
- Recomendations 
    - Beschrijving van de recommendations met betrekking op de WAF. 


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
- Keyvault 
- Admin server 
- Web server
- Network peering
- Storage/deploymentscript
- Backup van de VM's

In de main module moeten op dit moment nog een aantal dingen gedefined worden. 

#### Keyvault 
Genereerd een keyvault, key, diskencryptionset, user assigned identity en accespolicies.

Keuzes met betrekking tot de resources:
* Keyvault:
    - vrijgeving in premissies
    - public network access is enabled
* Key:
    - keysize: 2048
        - keysize vergroten maakt de key veiliger
    - keytype: RSA
    - key heeft alle permissies
* Diskencryptionset
* User assigned identity
* Accesspolicies
    - accesspolicies keypermissies: get, list, unwrap en wrap; aan user assigned identity en diskencryptieset.

#### Admin server
Genereerd een netwerk security group, public IP, virtual network met subnet, network interface en windows virtual machine

* Netwerk security group
* Public IP
* Virtual network
* Network interface
* Virtual machine

#### Web server
Genereerd een netwerk security group, public IP, virtual network, network interface en windows virtual machine

* Netwerk security group
* Public IP
* Virtual network
* Network interface
* Virtual machine

#### Network peering
Activeerd peering tussen de webserver en de adminserver. 

#### Storage/deploymentscript
Genereerd storageaccount, blobservice, container, activeerd deploymentscript en plaatst deze in container.  

#### Backup 
Genereerd recoveryvault, backup policy, en stelt protected items in.

