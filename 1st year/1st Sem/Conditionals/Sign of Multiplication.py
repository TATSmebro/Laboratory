A = int(input())
B = int(input())

if A != 0 and B != 0:
    if (A > 0 and B > 0) or (A < 0 and B < 0):
        print("+")    
    else:
        print("-")
else:
    print("")