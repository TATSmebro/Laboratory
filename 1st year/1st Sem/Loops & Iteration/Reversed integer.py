num = int(input())

if num<0:
    num *= -1
    num = str(num)
    print("-", end="")
    while num != "":
        print(num[-1], end="")
        num = num[:-1]
else:
    num = str(num)
    while num != "":
        print(num[-1], end="")
        num = num[:-1]