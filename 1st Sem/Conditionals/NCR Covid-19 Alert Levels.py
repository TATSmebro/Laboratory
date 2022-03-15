# 1	- low, low
# 2	- low, increasing
# 3	- high, increasing
# 4	- high, high
# 5	- alarming, critical
# INVALID - none of the above applies

case = input()
beds = input()

if case == "low" and beds == "low":
    print("1")
elif case == "low" and beds == "increasing":
    print("2")
elif case == "high" and beds == "increasing":
    print("3")
elif case == "high" and beds == "high":
    print("4")
elif case == "alarming" and beds == "critical":
    print("5")
else:
    print("INVALID")