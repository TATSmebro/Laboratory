def main():
    size_matrix_A = [int(i) for i in input().split(',')]
    matrix_A = get_matrix(size_matrix_A)

    size_matrix_X = [int(i) for i in input().split(',')]
    matrix_X = get_matrix(size_matrix_X)

    size_matrix_B = [int(i) for i in input().split(',')]
    matrix_B = get_matrix(size_matrix_B)

    prod_AX = mult_matrix(matrix_A, matrix_X, size_matrix_X)
    Z = sum_matrix(prod_AX, matrix_B)
    
    for i in Z:
        for j in i:
            print(j, end=' ')
        print()

def get_matrix(size):
    matrix = []
    
    for row in range(size[0]):
        curr_row = input()
        curr_row = curr_row.split()
        curr_row = [float(i) for i in curr_row]
        matrix.append(curr_row)
    
    return matrix

def mult_matrix(matrix_1, matrix_2, size_2): #matrix_1 * matrix_2
    product = []
    for row in matrix_1:
        curr_row = []
        for col2 in range(size_2[1]):
            sum = 0
            for row2, col in zip(range(size_2[0]), row):
                element = col*matrix_2[row2][col2]
                sum += element
            curr_row.append(sum)
        product.append(curr_row)
    return product

def sum_matrix(matrix_1, matrix_2):
    sum = []
    for row1, row2 in zip(matrix_1, matrix_2):
        curr_row = []
        for col1, col2 in zip(row1, row2):
            curr_row.append(round(col1+col2, 1))
        sum.append(curr_row)
    return sum


if __name__ == '__main__':
    main()