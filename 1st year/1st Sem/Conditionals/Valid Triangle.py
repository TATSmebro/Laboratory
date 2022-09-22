a = float(input())
b = float(input())
c = float(input())

if a + b < c or a + c < b or b + c < a:
    print("INVALID")
else:
    if a == b == c:
        print("EQUILATERAL TRIANGLE")
    elif a == b or a == c or b == c:
        print("ISOSCELES TRIANGLE")
    else:
        print("SCALENE TRIANGLE")