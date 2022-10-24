#Learning how debugging works

def buggyfunc(x):
    y = x
    for i in range(x):
        y = y-1
        z = x/y
    return z

buggyfunc(20)

# #### Playinh with some debugging options
# def buggyfunc_2(x):
#     y = x
#     for i in range(x):
#         try:
#             y = y-1
#             z = x/y
#         except:
#             print(f"This didn't work;{x = }; {y = }")
#     return 
    
# ####

# def buggyfunc_3(x):
#     y = x 
#     for i in range(x):
#         try:
#             y = y - 1
#             z = x/y
#         except ZeroDivisionError:
#             print(f"The result of dividing a number by zero is undefined")
#         except:
#             print(f"This didn't work; {x = }; {y = }")
#         else:
#             print(f"OK; {x = }; {y = },{z = };")
#     return z

# buggyfunc_3(20)