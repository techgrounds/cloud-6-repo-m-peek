# Functions

## Opdracht

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