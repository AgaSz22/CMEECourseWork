
def buggyfunc(x):
    y = x
    print(f"I am outside {y}")
   
    aa = []


    for i in range(x):
        y = y-1
        print(f"I am inside y = {y}")
        z = x/(y+1)
        aa.append(z)

    return aa


bb = buggyfunc(20)