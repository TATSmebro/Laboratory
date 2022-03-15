mother = int(input())
child = int(input())
years = 0

if mother/child == 2:
    print(years)
else:
    while mother/child != 2:
        mother += 1
        child += 1
        years += 1
    print(years)
