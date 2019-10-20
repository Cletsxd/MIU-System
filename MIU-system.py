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
        
        

word = input('Enter the word: ')

wr1, check1 = rule1(word)
wr2, check2 = rule2(word)
wr3, check3 = rule3(word)
wr4, check4 = rule4(word)