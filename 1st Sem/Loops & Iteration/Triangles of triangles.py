h = int(input())

for outer_row in range(h):

    for row in range(h):

        for col in range((2*h-1)*(h-outer_row-1)):
            print(end = " ")

        for i in range(2*outer_row+1):
            for col in range(h-row-1):
                print(end = " ")
            for col in range(2*row+1):
                print("*", end="")
            for col in range(h-row-1):
                print(end = " ")
        print()