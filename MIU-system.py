#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Oct 20 11:18:18 2019

@author: gustavo
"""

def rule1(word) :
    if word[-1] == 'I' :
        wr1 = word + 'U'
        
        return wr1, 1
    else :
        return word, 0

def rule2(word) :
    if word[0] == 'M' :
        rest = []
        wr2 = word
        for i in range(1, len(word)) :
            wr2 = wr2 + word[i]
        return wr2, 1
    
    else :
        return word, 0

def rule3(word) :
    wr3 = ''
    for i in range(len(word) - 2) :
        if word[i] == 'I' and word[i + 1] == 'I' and word[i + 2] == 'I' :
          for j in range(i) :
              wr3 = wr3 + word[j]
          wr3 = wr3 + 'U'
          for j in range(i + 3, len(word)) :
              wr3 = wr3 + word[j]
          
          return wr3, 1
      
    return word, 0   

def rule4(word) :
    wr4 = '' 
    for i in range(len(word) - 1) :
        if word[i] == 'U' and word[i + 1] == 'U' :
          for j in range(i) :
              wr4 = wr4 + word[j]
          #wr4 = wr4 + 'U'
          for j in range(i + 2, len(word)) :
              wr4 = wr4 + word[j]
          
          return wr4, 1
      
    return word, 0

def search_rules(words):
    ret = []

    if len(words) < 2:
        wr1, check1 = rule1(words[0][0])
        wr2, check2 = rule2(wr1)
        wr3, check3 = rule3(wr2)
        wrfinal, check4 = rule4(wr3)

        if check1 == 1 and wr1 != "M":
            ret.append([wr1, 1])

        if check2 == 1 and wr2 != "M":
            ret.append([wr2, 2])

        if check3 == 1 and wr3 != "M":
            ret.append([wr3, 3])

        if check4 == 1 and wrfinal != "M":
            ret.append([wrfinal, 4])

    else:
        for word in words:
            wr1, check1 = rule1(word[0])
            wr2, check2 = rule2(wr1)
            wr3, check3 = rule3(wr2)
            wrfinal, check4 = rule4(wr3)

            if check1 == 1 and wr1 != "M":
                ret.append([wr1, 1])

            if check2 == 1 and wr2 != "M":
                ret.append([wr2, 2])

            if check3 == 1 and wr3 != "M":
                ret.append([wr3, 3])

            if check4 == 1 and wrfinal != "M":
                ret.append([wrfinal, 4])

    if len(words) < 2:
        wr1, check1 = rule1(words[0][0])
        wr2, check2 = rule2(words[0][0])
        wr3, check3 = rule3(words[0][0])
        wr4, check4 = rule4(words[0][0])

        if check1 == 1 and wr1 != "M":
            ret.append([wr1, 1])

        if check2 == 1 and wr2 != "M":
            ret.append([wr2, 2])

        if check3 == 1 and wr3 != "M":
            ret.append([wr3, 3])

        if check4 == 1 and wr4 != "M":
            ret.append([wr4, 4])
    else:
        for word in words:
            wr1, check1 = rule1(word[0])
            wr2, check2 = rule2(word[0])
            wr3, check3 = rule3(word[0])
            wr4, check4 = rule4(word[0])

            if check1 == 1 and wr1 != "M":
                ret.append([wr1, 1])

            if check2 == 1 and wr2 != "M":
                ret.append([wr2, 2])

            if check3 == 1 and wr3 != "M":
                ret.append([wr3, 3])

            if check4 == 1 and wr4 != "M":
                ret.append([wr4, 4])

    return ret

def check_mu(words):
    for word in words:
        if word[0] == "MU":
            return word[0], word[1], True

    return 0, 0, False

if __name__ == '__main__':
    word = input('Enter the word: ')

    first_attp = []
    first_attp.append([word, 0])

    list_words = []
    list_words = search_rules(first_attp)
    print("Iter 1")

    wrd = ""
    rule = 0
    bit = False

    iters = 1
    wrd, rule, bit = check_mu(list_words)

    while not bit:
        list_words = search_rules(list_words)
        iters += 1
        print("Iter", iters)
        wrd, rule, bit = check_mu(list_words)
        if iters == 10 :
            print('MU was not found in the 10th depth')
            break

    print("-> Word:", wrd, "Rule:", rule, "Depth:", iters)