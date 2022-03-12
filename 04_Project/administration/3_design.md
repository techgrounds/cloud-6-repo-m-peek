# Ontwerpdocumentatie
Praktische en technische informatie over de architectuur van het IaC bicep project. 
- Visualisatie van wat, in welke volgoorde het in de cloud.

Opbouw ontwerpdocumentatie:
- Project ontwerp
- Modules
    - Ontwerpbeslissingen per module
- Recomendations 
    - Beschrijving van de recommendations met betrekking op de WAF. 

## Project ontwerp
De verschillende resources in verschillende resourcegroups deployen is best practice. 
Uiteindelijk langere modules geschreven, waardoor onderverdelen in de resourcegroups zoals in eerste instantie gewenst was niet gelukt is. 
- resourcegroup wordt nu aangemaakt in main, vervolgens worden de verschillende resources in die groep geplaatst. 

### Modules
De verschillende resources zijn ingedeeld in verschillende modules die vanuit de main.bicep uitgevoerd worden. 
- Resourcegroup
- Keyvault 
- Admin server 
- Web server
- Network peering
- Storage/deploymentscript
- Backup van de VM's

De outputs die in de main file gebruikt worden voor andere modules, regelt ook in welke volgorde Bicep de infrastructuur deployed. 

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

* Deploymentscript
* Storageaccount
* Blobservice
* Container

#### Backup 
Genereerd recoveryvault, backup policy, en stelt protected items in.

* Recovereryvault
* Backup policy 
* Protected items
