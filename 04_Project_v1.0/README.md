# Project versie 1.0

Infrastructure as Code project bicep

To deploy the templaye at subscription scope:
`az deployment sub create --location westeurope --template-file main.bicep`

westeurope kan eventueel veranderd worden naar een andere Azure locatie
Wanneer er veranderingen nodig zijn; m.b.t. andere informatie (locatie; name; tiers), aanpassingen in de main file doen. 
