# Lists

## Opdracht

### Exercise 1:
``` python
ls = ['Mylene', 'Jerry', 'Steph', 'Sergio', 'Daniel']
print(*ls, sep= "\n")
```

### Exercise 2:
``` python
a = [6, 15, 29, 31, 38]

for i in range(len(a)):
    if a[i] == a[len(a)-1]:
        print('My list:', a)
    else:
        print(a[i] + a[i+1])
```
