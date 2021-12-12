# Protocols
Om te zorgen dat de verschillende lagen van het internet met elkaar kunnen samenwerken zijn er protocollen opgezet. 

## Keywterms
Modellen:
* OSI-model - Open System Interconnection
* TCP/IP - Transmission Control Protocol 
    * Ontworpen om hogere beschikbaarheid en end-to-end byte stroom over een onbetrouwbaar netwerk aan te bieden. 
Protocollen:
* HTTP - HyperText Transfer Protocol
* UDP - User Datagram Protocol
* BGP - Border Gateway Protocol 
    * Meganisme om routing informatie tussen autonomous systems (AS) uit te wisselen. 
* ASN - Autonomous System Number

* CRLF - Carriage Return Line Feed - beweegt de cursor naar de lijn beneden en naar het begin van de lijn.
* RFC - Request for Comments

## Opdracht
Er zijn een aantal veelvuldig gebruikte internet protocollen. Deze zorgen ervoor dat de verschillende apparaten die met het internet verbonden zijn elkaar kunnen vinden. 

### Gebruikte bronnen
- https://www.webnots.com/what-is-http/
- https://www.guru99.com/difference-tcp-ip-vs-osi-model.html
- https://www.imperva.com/learn/application-security/osi-model/
- https://osi-model.com/physical-layer/
- https://blog.cloudflare.com/october-2021-facebook-outage/

### Ervaren problemen
Geen problemen ervaren. 

### Resultaat
Structuur HTTPS: 
| Request | Response |
| --------- | ------------ |
| Request line | HTTP Status Code |
| Heeaders | Headers |
| Empty line | Empty line |
| Message body[^1] | Message body[^1] |
[^1]: Optional

Structuur TCP/IP en OSI model: 
| TCP/IP-pakket | OSI-model | Protocols |
| ----------- | ---------- | --------- |
| Application | Application | HTTP, DNS, SSH |
| ^ | Presentation |AFP, LPP, NCP, NDR, XDR |
| ^ | Session | RPC, SOCKS |
| Transport | Transport |TCP, UDP |
| Network | Network |IPv4, IPv6, DDP |
| Network interface | Data Link | ARP, Ethernet, Spanning Tree Protocol |
| ^ | Physical | USB, Ethernet physical layer |

Hoe een protocol veranderd/geimplementeerd wordt is afhankelijk in welke laag je wat wil aanpassen. Na het veranderen/maken van een nieuw protocol moet je deze online plaatsen met een RFC. De RFC is een formeel document dat specificaties van een bepaalde technologie beschrijft. Het moet vervolgens aan anderen gepitcht worden, aangezien je in de internetcommunity moet komen om het door andere te laten gebruiken.

Internet is een netwerk van netwerken en samengebracht door BGP. Een AS is een individueel netwerk met een verenigd intern routing policy. Elk ASN moet zijn prefix routs aan het internet aankondigen door middel van BGP, anders zal niemand weten hoe te verbinden/vinden. 

---

* Facebook (FB) storing:

Prefix routes waren teruggetroken, FB's DNS servers gingen ofline en een minuut later begonnen de problen. Het falen van DNS was het eerste symptoom. Het probleem ontstond toen FB voor de storing een piek in routing changes had. BGP UPDATE informeerd een router over de veranderingen in de prefix of trekt de prefix terug. FB stopte met aankondigen van DNS prefix routes aan BGP, waardoor er niet met de nameservers verbonden kon worden. Als de url invoerd wordt in de browser gaat de DNS reslover de domeinnaam vertalen in IP adressen om te verbinden. Als de nameservers onbereikbaar zijn of niet reageren komt er een SERVFAIL terug geeft de browser een error aan. 

* Effect van downtime FB: 

Doordat FB onbereikbaar was, kwamen er wereldwijd meer DNS problemen voor. Apps accepteren vaak geen errors en blijven dan opnieuw proberen en daarnaast omdat de eindgebruiker ook geen error accepteerd en de pagina herlaat. Dit zorgde ervoor dat er 30x meer DNS waren en dat voor vertraging op andere pagina's zorgde.