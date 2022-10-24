from pprint import pprint

taxa = [ ('Myotis lucifugus','Chiroptera'),
         ('Gerbillus henleyi','Rodentia',),
         ('Peromyscus crinitus', 'Rodentia'),
         ('Mus domesticus', 'Rodentia'),
         ('Cleithrionomys rutilus', 'Rodentia'),
         ('Microgale dobsoni', 'Afrosoricida'),
         ('Microgale talazaci', 'Afrosoricida'),
         ('Lyacon pictus', 'Carnivora'),
         ('Arctocephalus gazella', 'Carnivora'),
         ('Canis lupus', 'Carnivora'),
        ]

# Write a python script to populate a dictionary called taxa_dic derived from
# taxa so that it maps order names to sets of taxa and prints it to screen.
# 
# An example output is:
#  
# 'Chiroptera' : set(['Myotis lucifugus']) ... etc. OR, 'Chiroptera': {'Myotis
#  lucifugus'} ... etc

taxa_dic = {"Chiroptera": [],"Rodentia": [], "Afrosoricida": [], "Carnivora": []} #creating a dictionary with four orders to populate
for x in range(len(taxa)):
    if taxa[x][1] == "Chiroptera":
        taxa_dic["Chiroptera"].append(taxa[x][0])  #appending all species from the Chiroptera order
    if taxa[x][1] == "Rodentia":
        taxa_dic["Rodentia"].append(taxa[x][0]) 
    if taxa[x][1] == "Afrosoricida":
        taxa_dic["Afrosoricida"].append(taxa[x][0]) 
    if taxa[x][1] == "Carnivora":
        taxa_dic["Carnivora"].append(taxa[x][0])   
pprint(taxa_dic)


# Now write a list comprehension that does the same (including the printing after the dictionary has been created)  

order_set = set([x[1] for x in taxa])  #creating a set of orders present in taxa
taxa_dic = dict()     #creating an empty dictionary

for order in order_set:    #adding species to each order set within a dictionary if the species name matches the genus name
    taxa_dic[order] = set()
    taxa_dic[order] = [(species[0]) for species in taxa if species[1] == order]
pprint(taxa_dic)




