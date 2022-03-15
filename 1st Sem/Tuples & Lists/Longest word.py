def main():
    sentence = input()
    list_of_words = sentence.split()
    last_word = '' 
    
    for character in list_of_words[-1]:
        punctuations = ['.', ',', '?', '!']
        if not(character in punctuations):
            last_word += character

    list_of_words.pop()
    list_of_words.append(last_word)

    print(max(list_of_words, key=len))


if __name__ == '__main__':
    main()