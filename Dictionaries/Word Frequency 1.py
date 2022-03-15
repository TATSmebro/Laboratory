def  main():

    inp = input()
    list_of_words = string_to_list_of_words(inp)

    word_frequency = {}

    for word in list_of_words:
        if not(word in word_frequency):
            word_frequency[word] = 1
        else:
            word_frequency[word] += 1
    
    for key, val in word_frequency.items():
        print(f'{key} {val}')


def string_to_list_of_words(sentence):
    
    list_with_punc = sentence.split()
    list_with_no_punc = []
    punctuations = '!()-[]{;}:"\,<>./?@#$%^&*_~'
    for word in list_with_punc:
        new_character = ''
        for character in word:
            # if 65 <= ord(character) <= 90 or 97 <= ord(character) <= 122:
            if character not in punctuations:
                new_character += character
        list_with_no_punc.append(new_character)

    final_list = [i.lower() for i in list_with_no_punc]

    return final_list


if __name__ == '__main__':
    main()