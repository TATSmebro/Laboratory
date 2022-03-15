num = int(input())
month = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

if 1 <= num <= 12:
    print(month[num-1])
else:
    print("Invalid input!")