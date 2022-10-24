# FOR loops
for i in range(5):
    print(i)

my_lists = [0,2, "geronimo!", 3.0, True, False]
for k in my_lists:
    print(k)

# Variable
total = 0
summands = [0,1,11,111,1111]

for s in summands:
    total = total + s
    print(total)


# Just trying things out
summands = [0,1,11,111,1111]
for s in summands:
    dog = 0
    print(1)
    dog = dog + s
    print(2)
    print(dog)
    print("done!")


# WHILE loop
z = 0

while z < 100:
    z = z +1
    print(z)


# Functions

def foo(x):
    x *= x
    print(x)
    return x

y = foo(2)
y
    
type(y)

def function(x):
    x = 2*x
    print (x)
    #return x

p = function(3) 
p

type(p)