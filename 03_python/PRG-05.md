# Conditions
Condities kunnen op verschillende manieren gebruikt worden, meestal in 'if' statements en loops.

### Keyterms
- Equals: a == b
- Not Equals: a != b
- Less than: a < b
- Less than or equal to: a <= b
- Greater than: a > b
- Greater than or equal to: a >= b

## Opdracht
Maak een aantal scripts waarbij er gebruik wordt gemaakt van scripts.

### Gebruikte bronnen
- [Automate the Boring Stuff with Python](https://automatetheboringstuff.com/#toc)
- [W3 Schools Python](https://www.w3schools.com/python/default.asp)

### Exercise 1:
``` python
name = input("Please input your name:")
if name == 'Mylene':
    print("Hello! Welcome Mylene")
else:
    print("You are", name, "you're not welcome")
```

### Exercise 2:
``` python
x = 0 
while x != 100:
    x = int(input('Please put in a number: ')) 
    if x == 100:
        print(x, 'is the best number')
    elif x < 100:
        print(x, 'that\'s a nice number')
    else:
        print('wow,', x, 'is a big number!')
``` 
    