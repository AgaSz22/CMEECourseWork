#Variable scope
i = 1
x = 0
for i in range(10):
    x +=1
print(x)
print(i)


#
i = 5 
x = 0
for i in range(10):
    x += 1
    print(x)
    print(i)
print("Done")


#
x = 0
for i in range(1,10):
    x += 1
print(x)
print(i)

#
i = 1
x = 0
def a_function(y):
    x = 0
    for i in range(y):
        x += 1
    return x
x = a_function(10)
print(x)
print(i)