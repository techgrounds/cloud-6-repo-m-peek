# Lists
In Python kan een lijst van values in een enkele variabele verdelen.

## Opdracht
Schrijf een aantal scripts waarbij gebruit wordt gemaakt van een lijst. 

### Gebruikte bronnen
- [Automate the Boring Stuff with Python](https://automatetheboringstuff.com/#toc)
- [W3 Schools Python](https://www.w3schools.com/python/default.asp)

### Exercise 1:
``` python
ls = ['Mylene', 'Jerry', 'Steph', 'Sergio', 'Daniel']
print(*ls, sep= "\n")
```

### Exercise 2:
``` python
a = [6, 15, 29, 31, 38]
print('My list:', a)

for i in range(len(a)):
    if a[i] == a[-1]:  
        print(a[i] + a[0])
    else:
        print(a[i] + a[i+1])
```
