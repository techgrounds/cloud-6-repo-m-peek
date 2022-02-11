# Key-value pairs

## Opdracht

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