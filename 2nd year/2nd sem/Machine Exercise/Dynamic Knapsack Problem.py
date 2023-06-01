def knapsack(n, wt, val, W):
    # Create a table to store the maximum values for each subproblem
    table = [[0 for _ in range(W + 1)] for _ in range(n + 1)]

    # Build the table in a bottom-up manner
    for i in range(n + 1):
        for w in range(W + 1):
            if i == 0 or w == 0:
                table[i][w] = 0
            elif wt[i - 1] <= w:
                table[i][w] = max(val[i - 1] + table[i - 1][w - wt[i - 1]], table[i - 1][w])
            else:
                table[i][w] = table[i - 1][w]

    # Find the maximum value
    max_value = table[n][W]

    # Find the items included in the knapsack
    included_items = []
    i = n
    j = W
    while i > 0 and j > 0:
        if table[i][j] != table[i - 1][j]:
            included_items.append(i - 1)
            j -= wt[i - 1]
        i -= 1

    return max_value, included_items[::-1]


# Reading input from the user
W = int(input())
n = int(input())

wt = []
val = []
ids = []

# Reading n lines of input
for i in range(n):
    record = input().split()
    ids.append(int(record[0]))
    wt.append(int(record[1]))
    val.append(int(record[2]))

# Calling the knapsack function
max_value, selected_items = knapsack(n, wt, val, W)

# Printing the maximum value and the IDs of selected items in decreasing order of their IDs
print(max_value)
for item in reversed(selected_items):
    print(ids[item])
