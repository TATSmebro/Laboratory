s1 = input()
s2 = input()

for i in range(0,len(s2)):
    s1 = s1[:(i*2)+1] + s2[i] + s1[(i*2)+1:]

print(s1)