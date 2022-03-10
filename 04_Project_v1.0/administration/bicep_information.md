# Bicep language

Bicep is een declarative language, dat betekend dat de elementen in elke order kunnen worden gezet. De order van elementen heeft geen effect op hoe de deployment is processed.

Bicep is pushed based; vergelijkbaar met Ansible, Terraform, JSON.

Voordelen van bicep:
- Parameters maakt de template reusable 
- Variables en expressions maken het makkelijker om teplate te schrijven en uit te voeren.
- Modules helpen bij het structureren van templates in meerdere files. 
- Outputs versturen data van de template en modules terug naar wie of wat de infrastructuur aan het deployen is.

## Keyterms
- symbolic name > Referes to resource, but don't show in Azure
- variable > laat je belangrijke informatie opslaan in een plaats en kan naar gerefereerd worden door de gehele file heen.
- String interpolation
   - combine strings
- `?` ternary operator > if/then statement 
    - `:` value after the colon is used when the statement evaluates to false
- modularized
    - Opgedeeld in individuele bicep code voor verschillende onderdelen in de deployment.
- parameters
    - you can provide information to a Bicep template at deployment time. You can make a Bicep template flexible and reusable by declaring parameters within your template.
- decorators
    - a way to attach constraints and metadata to a parameter, which helps anyone using your templates to understand what information they need to provide

### Targetscope

Er zijn vier toegestane values, de scope geeft ook aan waarvoor de depoyments gebruikt worden. 
* resourceGroup
    - Default setting
* subscription
* managementGroup
* tenant

### Parameters

Parameters worden gebruikt voor values die verschillend moeten zijn voor verschillende deployments.
- Namen van resources die uniek moeten zijn
- Locaties om de resources in te plaatsen
- Settings die de prijs van resouces beïnvloeden (SKU, pricing tiers, intance counts).
- Credentials en informatie die nodig is om andere systemen te bereiken die niet gedefineerd zijn in de template. 

`param` > defining a parameter > `name_of_param` > `string` > type of parameter; string for text, int for numbers, bool for boolean values; more complex param `array` `object` types.

Wanneer er string parameters zijn, is er een limiet aan de lengte van een string. Met `@minLength` en `@maxLength` kan dit limiet in de parameter worden vastgesteld. 

Met `@description()` kan je in het document doelen van parameters in een human-readable manier decoreren. -> string. 

Decorator `@secure` kan toegepast worden  die mogelijk een secret value heeft. De parameter values worden niet in de deployment logs.

De `@allowed()` functie kan aangeven welke values er in de parameter mogen.


### Variablen
- Goede optie wanneer je de zelfde values voor elke deployment wil, maar je wil de value reusable maken binnne het template of je wil expressions gebruiken om een complexe value te maken. 
- Bruikbaar voor namen van resources die geen unieke namen hoeven te hebben. 

- gebruik `var` keyword om bicep te vertellen dat je een variable benoemd.
- variable hebben een value nodig
- variablen hoeven geen types te zijn. bicep kan type herkennen op basis van de value die je set. 

### functions

`uniqueString()` > seed value nodig, moet verschillend zijn bij verschillende deployments maar 


### Modules
- Reusability
- Encapsulation
- Composability
- Functionality

Om een module aan te roepen moet de volgende code geimplementeerd worden `module <symbolicname> <modulepath>`. Ook moet de naam en parameters toegevoegd worden.  

* Nest modules: Enkele modules maken die kleine sets resources deployen en deze vervolgens samenstellen in grotere modules die complexe topologies van resources definiëren. Een template combineert deze onderdelen in een deployable artefact.

- Module parameters
    - default parameters in parent zetten en niet in de module
- Conditions
- Outputs

Outputs van een module kunnen verkregen worden door `outputs` property in het module object te verwerken.  



### Output
Syntax voor het definiëren van output waarde:
`output <name> <data-type> = <value>`

Output kan de zelfde naam hebben als een parameter, variable, module of resource. Elke output moet in de datatypes passen. 

### Child parent resources
Child resources bestaan alleen in de context van een andere resource. Elke parent resource accepteerd alleen bepaalde resources als child.
`parent: <parentresource>`; `child: <childresource>`

De childresources kunnen op verschillende manieren aan de parent gekoppeld worden. Ook wanneer er twee of meerdere child resources zijn. 
- naam en type patroon:
    - `<parent-resourcename>/<child-resourcename>`
    - `<parent-resourcename>/<child1-resourcename>/<child2-resourcename>`
- binnen in de parent resource
- buiten de parent resource
- volledige resoucename buiten de parent

### Dependencies
Tijdens het deployen moet je zeker weten dat de ene resource voor de andere resource wordt gedeployed. Dit kan op twee manieren:
- Implicit dependency
    - Wanneer een resource declaration refereeerd aan een andere resource in dezelfde deployment
- Explicit dependency
    - `dependsOn: []`
    - de dependsOn property accepteerd een array van resource identifiers, zodat er meer dan een dependency gespecificeerd kan worden. 

### Conditions
Gebruik het `if` conditie om te specificeren of de resource of module is gedeployed. Het if statement wordt aan een Boolean gekoppeld die de uitkomst true of false geeft.
- Deployment condition
- New of existing resource
- Runtime functions

### Loops
Loops kunnen declared worden door:
- gebruik van een integer index
- gebruik van items in een array
- gebruik van items in een dictionary object
- gebruik van een integer index en items in een array
- een conditional deployment toevoegen

Limitaties:
- Kan niet boven de 8000 iterations.
- Kan niet een resource loopen met nested child resources
- Kan niet loopen op meerdere levels van properties
