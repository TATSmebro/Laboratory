def fib(int1):
    from math import sqrt
    ans = (1/sqrt(5))*((((1+sqrt(5))/2)**int1)-(((1-sqrt(5))/2)**int1))
    return round(ans)
