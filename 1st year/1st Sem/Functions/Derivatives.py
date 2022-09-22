def der(x, h):
    der = (func(x+h) - func(x))/h
    return round(der, 4)

def func(x):
    return x**2 + x + 131


OTHER_HELPER_FUNCTIONS = ['func']