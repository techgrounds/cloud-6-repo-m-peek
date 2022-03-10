# Project versie 1.0

Infrastructure as Code project bicep

To deploy the templaye at subscription scope:
`az deployment sub create --location westeurope --template-file main.bicep`

De resourcegroup en adminwachtwoord moeten na deployment command handmatig ingevoerd worden. 

Het adminpassword moet minimaal 8 characters hebben, een cijfer en een speciaal teken bevatten. 

westeurope kan eventueel veranderd worden naar een andere Azure locatie
Wanneer er veranderingen nodig zijn; m.b.t. andere informatie (nameing; tiers; size), aanpassingen moeten nog in de modules zelf gedaan worden, dit moet nog aangepast worden naar parameterfile

De file [usage](../04_Project_v1.0/administration/5_usage.md) bevat meer informatie over het gebruik van de infrastructuur. 

De informatie over de infrastructuur is terug te vinden in de administatiemap, [desisions](../04_Project_v1.0/administration/2_decisions.md) en [design](../04_Project_v1.0/administration/3_design.md)

### Te implementeren verbeteringen 
- parameterfile waarin ook de resourcegroupnaam automatisch aangemaakt wordt. 
- veranderen van toegangsregels, bijv. ssh alleen van windowsserver
    - ssh key moet nu nog zelf aangemaakt worden, moet nog aangepast worden. 
- aanpassing op hoe webserver geinstalleerd wordt. 
- automatisch aanmaken van wachtwoord voor de adminserver