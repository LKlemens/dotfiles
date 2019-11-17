#!/usr/bin/python3.7

import math
import time


def count_time():
    sec = time.time()
    min = sec // 60
    hours = min // 60
    days = hours // 24
    print(days)


def draw(t, length, n):
    if n == 0:
        return
    angle = 50
    t.fd(length * n)
    t.lt(angle)
    draw(t, length, n - 1)
    t.rt(2 * angle)
    draw(t, length, n - 1)


def factorial(n):
    if n == 0:
        return 1
    else:
        return factorial(n - 1) + n


def is_palindrome(word1, word2):
    if word1 != word2[::-1]:
        return False
    else:
        return True


def not_e_letter(word):
    if 'e' in word:
        return False
    else:
        return True


def uses_only(word, patt):
    for letter in patt:
        if letter not in word:
            return False
    return True


# def uses_only(word, patt):
#     for char in word:
#         i = 0
#         for char2 in patt:
#             if char != char2:
#                 i = i + 1
#         if i == len(patt):
#             return False
#         else:
#             i = 0

#     return True


def read_words():
    fin = open('/home/klemens/Downloads/words.txt')
    i = 0
    for line in fin:
        word = line.strip()
        if uses_only(word, 'aeiouy'):
            i = i + 1
            print(word)
    print(i)


def nested_sum(t):
    s = 0
    for l in t:
        s += sum(l)
    return s


def cum_sum(t):
    li = []
    for i in range(len(t)):
        li.append(t[i] + sum(t[:i]))
    return li


def histogram(s):
    d = dict()
    for l in s:
        d[l] = d.get(l, 0) + 1
    return d


def fib1(n):
    if n == 0:
        return 1
    elif n == 1:
        return 1
    return fib1(n - 1) + fib1(n - 2)


known = {0: 1, 1: 1}


def fib2(n):
    if n in known:
        return known[n]
    else:
        known[n] = fib2(n - 1) + fib2(n - 2)
        return known[n]


def sumall(*args):
    sum = 0
    for i in args:
        sum += i
    return sum


t = (1, 2, 3, 4, 5)
print sumall(*t)

# draw(turtle.Turtle(), 10, 10)
