number = abs(int(input()))
num = str(number)

result = int(num.replace(num[0], "", 1) + num[0])

print(result)