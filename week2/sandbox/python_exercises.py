a = (5,6,6,7,7,8)
b = (6,7,8,8,9)


c = set(a)
d = set(b)
d.difference(c)

d.issubset(c)

r = (3,4,4,5)
s = (4,5,6,7)

x=set(r)
y=set(s)

x.intersection(y)
y.intersection(x)

x.union(y)

GenomeSize = {'Homo sapiens': 3200.0, 'Escherichia coli': 4.6, 'Arabidopsis thaliana': 157.0}
GenomeSize

GenomeSize["Arabidopsis thaliana"]
GenomeSize['Escherichia coli']

a = [1,2,3]
b = a[:]
b

a.append(4)
print(a)
print(b)

c=[[1,2],[3,4]]
d=c[:]
#print(c)
#print(d)

c[0][1]=22
print(c)
print(d)

import copy

a = [[1,2], [3,4]]
b = copy.deepcopy(a)
a[0][1]=22
print(a)
print(b)


for i in range(x):
    if i > 3: #4 spaces or 2 tabs in this case
        print(i)



for n in range(2,10,2):
    print(n)
        
my_iterable = [1,2,3]

type(my_iterable)

my_iterable = iter(my_iterable)
type(my_iterable)



my_iterator = iter(my_iterable)

type(my_iterator)

next(my_iterator) # same as my_iterator.__next__()

next(my_iterator)

next(my_iterator)

#CONDITIONALS

x = 0; y = 2
if x < y:
   print("yes")
if x:
    print("yes")
if x ==0 :
    print("yes")
if y:
    print("yes")
if y == 2:
    print("yes")
x = True
if x:
    print("yes")
if x == True:
    print("yes")

