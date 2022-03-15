n = int(input())

for row in range(n):
    for col in range(n):
        print((row+1)*(col+1), end = "\t")
    print()