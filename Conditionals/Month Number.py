in1 = input()
month = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

if in1 in month:
    if month.index(in1) < 3:
        if in1 == "January":
            print("1st")
        elif in1 == "February":
            print("2nd")
        else:
            print("3rd")
    else:
        print(str(month.index(in1) + 1) + "th")
else:
    print("Invalid input!")
    