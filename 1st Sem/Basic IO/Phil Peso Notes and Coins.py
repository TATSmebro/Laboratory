amount = int(input())

#1000
thousand = int(amount/1000)
amount = amount % 1000
#500
five_hun = int(amount/500)
amount = amount % 500
#200
two_hun = int(amount/200)
amount = amount % 200
#100
one_hun = int(amount/100)
amount = amount % 100
#50
fifty = int(amount/50)
amount = amount % 50
#20
twenty = int(amount/20)
amount = amount % 20
#10
ten = int(amount/10)
amount = amount % 10
#5
five = int(amount/5)
amount = amount % 5
#1
one = int(amount/1)

#output
print(thousand, "x 1000")
print(five_hun, "x 500")
print(two_hun, "x 200")
print(one_hun, "x 100")
print(fifty, "x 50")
print(twenty, "x 20")
print(ten, "x 10")
print(five, "x 5")
print(one, "x 1")