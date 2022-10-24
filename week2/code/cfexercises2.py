#Playing with a couple of functions and list comprehensions
#Checking whether x can be divided by 3 without the remainder

def hello_1(x):
    for j in range(x):
        if j % 3 ==0:
            print("hello")
    print ("")

hello_1(12)

#Checking whether x can be divided by 5 & 4 without the remainder

def hello_2(x):
    for j in range(x):
        if j % 5 == 3:
            print("hello")
        elif j % 4 == 3:
            print("hello")
    print("")

hello_2(12)     

#
def hello_3(x,y):
    for i in range(x,y):
        print("hello")
    print("")

hello_3(3,17)

#
def hello_4(x):
    while x != 15:
        print("hello")
        x = x + 3
    print("")

hello_4(0)

#
def hello_5(x):
    while x < 100:
        if x == 31:
            for k in range(7):
                print("hello")
        elif x == 18:
            print("hello")
        x = x+1
    print("")

hello_5(19)

#WHILE loop with BREAK
def hello_6(x,y):
    while x: #while x is True
        print("hello! " + str(y))
        y += 1
        if y == 6:
            break
    print("")

hello_6 (True,0)

#Comprehensions

x = [i for i in range(10)]
print(x)

#
x  = []
for i in range(10):
    x.append(i)
print(x)

#
x = ["LIST","COMPREHENSIONS","ARE","COOL"]
for i in range(len(x)): #explicit loop
    x[i] = x[i].lower()
    print(x)

#
x = [i.lower() for i in ["LIST","COMPREHENSIONS","ARE","COOL"]]
print(x)

#
x = ["LIST","COMPREHENSIONS","ARE","COOL"]
x_new = []
for i in x: #implict
    x_new.append(i.lower())
print(x_new)

#
matrix = [[1,2,3],[4,5,6],[7,8,9]]
flattened_matrix = []
for row in matrix:
    for n in row:
        flattened_matrix.append(n)
print(flattened_matrix)

#
matrix = [[1,2,3],[4,5,6],[7,8,9]]
flattened_matrix = [n for row in matrix for n in row]

#
words = (["These","are","some","words"])
first_letters = set()
for w in words:
    first_letters.add(w[0])

print(first_letters)

# 
words = (["These","are", "some","words"])
first_letters = {w[0] for w in words}

print(first_letters)
