a = [6, 15, 29, 31, 38]
print('My list:', a)

for i in range(len(a)):
    if a[i] == a[-1]:  
        print(a[i] + a[0])
    else:
        print(a[i] + a[i+1])
