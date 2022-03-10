# Variables
In een variable sla je een value op. 

### Keyterms
- Expression
    - Basis soort van programmeer instructies. Bestaat uit values en operators.
- Value
    - Waarde van een bijv. variabele.
- Operator
    - Worden gebruikt om operaties uit te voeren op variabelen en values. 

## Opdracht
Een value sla je op in een variable met een *assignment statement*. Een assignment statement bestaat uit een *variable* naam, een *equal sign* (assignment operator) en een *value*. 

### Gebruikte bronnen
- [Automate the Boring Stuff with Python](https://automatetheboringstuff.com/#toc)
- [W3 Schools Python](https://www.w3schools.com/python/default.asp)


### Exercise 1: 
``` python
 x = 15
 y = 8
 z = x + y
 print(z)
 ``` 

 ### Exercise 2:
 ``` python
 name = "mylene"
 print("Hello, " + name + "!")
 print("Hello,", name, "!")
 ``` 

### Exercise 3: 
Een value kan opnieuw toegwezen worden. Python pakt de waarde van de code die als laatste is toegewezen aan de variable. 

``` python
value1 = "festival"
value2 = "weekend"
print(value1, value2)
value2 = "dag"
print(value1, value2)
``` 