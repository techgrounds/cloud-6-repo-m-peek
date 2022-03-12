# Project versie 1.0

Infrastructure as Code project bicep

To deploy the templaye at subscription scope:
`az deployment sub create --location westeurope --template-file main.bicep`

Resourcegroup krijgt de naam rg-<environmentparameter>
De enviromentparameter staat op testv1

SSH publickey moet of handmatig ingevoerd worden of in de main gedefineerd worden. Gebruiker moet zelf keypair aanmaken. 

Adminwachtwoord moeten na deployment command handmatig ingevoerd worden. 
Het adminpassword moet minimaal 8 characters hebben, een cijfer en een speciaal teken bevatten. 

westeurope kan eventueel veranderd worden naar een andere Azure locatie
Wanneer er veranderingen nodig zijn; m.b.t. andere informatie (nameing; tiers; size), aanpassingen moeten nog in de modules zelf gedaan worden, dit moet nog aangepast worden naar parameterfile

De file [usage](../04_Project/administration/5_usage.md) bevat meer informatie over het gebruik van de infrastructuur. 

De informatie over de infrastructuur is terug te vinden in de administatiemap, [desisions](../04_Project/administration/2_decisions.md) en [design](../04_Project/administration/3_design.md)

### Te implementeren verbeteringen 
- parameterfile voor parameters.
- veranderen van toegangsregels, bijv. ssh alleen van windowsserver
    - ssh key moet nu nog zelf aangemaakt worden, moet nog aangepast worden. 
- automatisch aanmaken van wachtwoord voor de adminserver