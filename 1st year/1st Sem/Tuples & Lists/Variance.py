def main():
    raw_inp_scores = input()
    quiz_scores = raw_inp_scores.split()
    list_of_scores = []

    for score in quiz_scores:
        list_of_scores.append(float(score))

    print(variance(list_of_scores))

def ave(scores):
    average = sum(scores)/len(scores)
    return average

def variance(list_of_scores):
    variance = 0
    for score in list_of_scores:
        variance += ((score - ave(list_of_scores))**2)/len(list_of_scores)
    return round(variance, 2)


if __name__ == '__main__':
    main()