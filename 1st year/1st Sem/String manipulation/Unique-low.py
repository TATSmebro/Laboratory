def clean(word):
    no_space = word.replace(" ", "")
    clean = no_space.lower()
    return clean

def arrange(clean):
    arranged = ""
    for i in range(32, 256):
        if clean.find(chr(i)) != -1:
            arranged += chr(i)
    return arranged


test_cases = int(input())
inp = []

for i in range(test_cases):
    inp.append(clean(input()))
for i in inp:
    print(arrange(i))