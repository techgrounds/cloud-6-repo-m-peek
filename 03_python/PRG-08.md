# Key-value pairs
Dictionaries in Pyton maken gebruik van key-value pairs.

## Opdracht
Schrijf een aantal scripts met een key en een value toegewezen. 

### Gebruikte bronnen
- [Automate the Boring Stuff with Python](https://automatetheboringstuff.com/#toc)
- [W3 Schools Python](https://www.w3schools.com/python/default.asp)

### Exercise 1:
``` python
LC = {
    'first name': 'Coen', 
    'Last name': 'Meulenkamp', 
    'Job title':'Learning coach', 
    'Company': 'Techgrounds'
}
for key, value in LC.items():
    print(key, ':', value)

```
### Exercise 2: 
``` python

import csv 

LC = {
    'First name': 'Coen', 
    'Last name': 'Meulenkamp', 
    'Job title':'Learning coach', 
    'Company': 'Techgrounds'
}
LC['First name'] = input("firstname:")
LC['Last name'] = input("Lastname:")
LC['Job title' ] = input("jobtitle:" )
LC['Company' ] = input("company:" )

for key, value in LC.items():
    print(key, ':', value)
```