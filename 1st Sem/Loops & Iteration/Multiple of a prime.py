n = int(input())
main_check = False

def is_prime(x):
    for i in range(2, x):
        if x%i==0:
            return False
    return True

for i in range(100, n+1):
    if (is_prime(i)) and (n%i==0):
        main_check = True
        break

print(main_check)