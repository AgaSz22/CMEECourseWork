import csv
import sys
import doctest

#Define function
def is_an_oak(name):
    """ Returns True if name starts with 'quercus' and is followed by a space.

    >>> is_an_oak("Fagus sylvatica")
    False

    >>> is_an_oak("Quercuss ilex")
    False

    >>> is_an_oak("Quercus Ilex")
    True

    >>> is_an_oak("QUERCUS ILEX")
    True

    >>> is_an_oak("quercus ilex")    
    True
    """

    return name.lower().startswith('quercus ')

#Checking whether the dataset contains any oak species (species are given in latin)
def main(argv): 
    f = open('../data/TestOaksData.csv','r')
    g = open('../results/JustOaksData.csv','w')
    taxa = csv.reader(f)
    csvwrite = csv.writer(g)
    oaks = set()
    for row in taxa:
        print(row)
        print ("The genus is: ") 
        print(row[0] + '\n')
        if is_an_oak(row[0] + " "):
            print('FOUND AN OAK!\n')
            csvwrite.writerow([row[0], row[1]])    

    return 0
    
if (__name__ == "__main__"):
    status = main(sys.argv)

doctest.testmod() 