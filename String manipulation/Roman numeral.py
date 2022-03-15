def roman(num):
    if 1 <= num <= 3999:
        roman = ""
        #thousands
        roman += "M" * (num // 1000)
        num = num - (num//1000)*1000
        #hundreds
        hundreds = num // 100
        if 1 <= hundreds <= 3:
            roman += "C" * hundreds
        elif hundreds == 4:
            roman += "CD"
        elif hundreds == 5:
            roman += "D"
        elif 5 < hundreds <= 8:
            roman += "D" + "C"*(hundreds-5)
        elif hundreds == 9:
            roman += "CM"
        else:
            pass
        num = num - hundreds*100
        #tens
        tens = num // 10
        if 1 <= tens <= 3:
            roman += "X" * tens
        elif tens == 4:
            roman += "XL"
        elif tens == 5:
            roman += "L"
        elif 5 < tens <= 8:
            roman += "L" + "X"*(tens-5)
        elif tens == 9:
            roman += "XC"
        else:
            pass
        num = num - tens*10
        #ones
        if 1 <= num <= 3:
            roman += "I" * num
        elif num == 4:
            roman += "IV"
        elif num == 5:
            roman += "V"
        elif 5 < num <= 8:
            roman += "V" + "I"*(num-5)
        else:
            roman += "IX"
        return roman
    else:
        return "Invalid Input"


N  = int(input())
alpha = []
if 1 <= N <= 3999:
    for i in range(N):
        alpha.append(int(input()))
    for i in alpha:
        print(roman(i))
else:
    print("Invalid Input")