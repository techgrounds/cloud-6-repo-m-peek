# Gebruik van Project Bicep

Vanuit de main file worden alle verschillende modules aangeroepen die de infrastructuur opzetten. 
Om de main file uit te voeren moet het volgende command in de commentline ingevoerd worden:
`az deployment sub create --location westeurope --template-file ./main.bicep`

Na invoering van het command word er nog gevraagd om een naam voor de resourcegroup, die ook te specificeren is in de mainfile, en om het wachtwoord voor de adminserver. 

Om op de adminserver in te loggen kan verbinding gemaakt worden met rdp. De username van de gebruiker: adminvm<environmentparameter>
Environment staat nu ingesteld op testv1.  

De ssh public key moet aangepast worden op een zelf gegenereerde public key, zodat gebruiker de private key heeft, aanpassing is nog nodig. (Bedoeling is keypair aangemaakt wordt en de private key in de keyvault opgeslagen wordt. Dan kan de toegang voor de webserver op enkel het gegenereerde ip van de windowsserver gezet worden.)