birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
         )

#(1) Write three separate list comprehensions that create three different
# lists containing the latin names, common names and mean body masses for
# each species in birds, respectively. 

# (2) Now do the same using conventional loops (you can choose to do this 
# before 1 !). 

# A nice example out out is:
# Step #1:
# Latin names:
# ['Passerculus sandwichensis', 'Delichon urbica', 'Junco phaeonotus', 'Junco hyemalis', 'Tachycineata bicolor']
# ... etc.

###1 using list comprehensions to print three lists containing latin names, common names and respective body masses
print("Latin names:")
body_mass_lc = [(birds[x][0]) for x in range(len(birds))]
print(body_mass_lc)

print("Common names:")
common_names_lc = [(birds[x][1]) for x in range(len(birds))]
print(common_names_lc)

print("Body mass:")
body_mass_lc = [(birds[x][2]) for x in range(len(birds))]
print(body_mass_lc)
 
###2
### using loops to print three lists containing latin names, common names and respective body masses
print("Latin names:")
Latin_names = []
for x in range(len(birds)):
    Latin_names.append(birds[x][0])
print(Latin_names)

print("Common names:")
Common_names = []
for x in range(len(birds)):
    Common_names.append(birds[x][1])
print(Common_names)

print("Body mass:")
Body_mass = []
for x in range(len(birds)):
    Body_mass.append(birds[x][2])
print(Body_mass)






