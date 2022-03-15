def main():
    #Initialize Dictionary
    name_color = {}

    #Ask for name
    name = input('Name: ')
    
    #returns the empty dictionary if input is 'show'
    if name == 'show':
        return name_color

    #asks for fave color otherwise
    fave_color = input('Fave Color: ')

    #Loops prompt for name and fave color
    while True:
        name_color[name] = fave_color #Adds another key-value pair into the dictionary
        name = input('Name: ')
        if name == 'show': #Checks if name input is 'show' and breaks if True
            break
        fave_color = input('Fave Color: ')
        if fave_color == 'show': #Checks if color input is 'show' and breaks if True
            break

    #Iterates over key-value pairs and prints with the given format
    for key, val in name_color.items(): 
        print(f'{key} - {val}')


if __name__ == '__main__':
    main()