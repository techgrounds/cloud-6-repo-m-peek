# Functions
Een functie is een blok code die alleen gedraaid wordt wanneer die geroepen wordt.

## Opdracht
Creëer meerdere scripts waarbij gebruik wordt gemaakt van functies. 

### Gebruikte bronnen
- [Automate the Boring Stuff with Python](https://automatetheboringstuff.com/#toc)
- [W3 Schools Python](https://www.w3schools.com/python/default.asp)

### Exersice 1:
``` python
import random

i = random.randint
for i in range (5):
    print(random.randint(0, 100))
```

### Exersice 2:
``` python
def myfunction():
    print("Hello", x)

x = "world!"
myfunction()

x = input("your name:")
myfunction()
```

### Exersice 3:
``` python
def avg(b,c):
    return (b + c) / 2
    
x = 128
y = 255
z = avg(x,y)
print("The average of", x,"and", y, "is", z)
```