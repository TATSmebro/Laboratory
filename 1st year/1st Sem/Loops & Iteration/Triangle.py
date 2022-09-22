h = int(input())

if h<=0:
    print("Invalid height!")
else:
    for row in range(h):
        for i in range(h-row-1):
            print(end = " ")
        for i in range(2*row+1):
            print("*", end="")
        print()