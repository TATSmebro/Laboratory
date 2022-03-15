def main():
    test_cases = int(input())
    space = input()
    
    directions = (
        'up', 
        'up_right', 
        'right', 
        'down_right', 
        'down', 
        'down_left', 
        'left', 
        'up_left'
    )
    grids = []
    word_batches = []

    for i in range(test_cases):
        if i == test_cases - 1:
            grid_size = [int(i) for i in input().split()]
            grids.append(get_grid(grid_size))
            
            k = int(input())
            word_batches.append(get_words_to_find(k))
        else:
            grid_size = [int(i) for i in input().split()]
            grids.append(get_grid(grid_size))
            
            k = int(input())
            word_batches.append(get_words_to_find(k))
            case_separator = input()

    for batch, grid in zip(word_batches, grids):
        for word in batch:
            checked_words = []
            for row in range(len(grid)):
                for col in range(len(grid[0])):
                    for direction in directions:
                        if find_word(word, row, col, direction, grid) and not(word in checked_words):
                            print(f'{row+1} {col+1}')
                            checked_words.append(word)
                            break
        print()

def get_grid(grid_size):
    grid = []
    for i in range(grid_size[0]):
        row = input()
        grid.append(row.lower())
    return grid

def get_words_to_find(k):
    words_to_find = []
    for i in range(k):
        word = input()
        words_to_find.append(word.lower())
    return words_to_find

def find_word(word, row, col, direction, grid):
    m = len(grid)
    n = len(grid[0])

    directions = {
        'up': (-1, 0),
        'up_right': (-1, 1),
        'right': (0, 1),
        'down_right': (1, 1),
        'down': (1, 0),
        'down_left': (1, -1),
        'left': (0, -1),
        'up_left': (-1, -1)
    }

    i = 0
    while i < len(word) and 0 <= row < m and 0 <= col < n:
        if grid[row][col] != word[i]:
            return False
        row += directions[direction][0]
        col += directions[direction][1]
        i += 1

    return i == len(word)


if __name__ == '__main__':
    main()
