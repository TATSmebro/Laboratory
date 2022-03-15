def func(float1, float2):
    return int(h(float1)+i(float2))

def h(x):
    return (f(x)/g(x))

def i(x):
    return(f(x)*g(x))

def f(x):
    return x**3+5**x+1

def g(x):
    return x**5+3**x+1


OTHER_HELPER_FUNCTIONS = ['h', 'i', 'f', 'g']