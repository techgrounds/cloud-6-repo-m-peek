# Users and groups
Linux maakt gebruik van verschillende gebruikers. De gebruikers zijn in groepen in te delen. 

## Keyterms
Root - Root user mag alles doen.  <br/>
Sudo - command om tijdelijke root permissons te krijgen. 

## Opdracht
Maak een nieuwe user aan in je VM
- User moet onderdeel zijn van admin groep.
- User moet een wachtwoord hebben.
- User moet sudo command kunnen gebruiken. 
Localiseer de bestanden die users, wachtwoorden, en groepen bijhouden. Kijk of daar een of je je nieuwe user kan vinden. 

### Gebruikte bronnen
https://www.howtogeek.com/50787/add-a-user-to-a-group-or-second-group-on-linux/

### Ervaren problemen


### Resultaat
useradd (user)
groupadd (group)
usermod -g (group)(user)
/etc/passwd 
