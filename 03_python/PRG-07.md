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
print('My list:', a)

for i in range(len(a)):
    if a[i] == a[-1]:  
        print(a[i] + a[0])
    else:
        print(a[i] + a[i+1])
```
