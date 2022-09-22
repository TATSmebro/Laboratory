in1 = int(input())
in2 = int(input())
sum = 0

for i in range(min(in1, in2), max(in1, in2)+1):
    if i%2 == 0:
        sum += i

print(sum)