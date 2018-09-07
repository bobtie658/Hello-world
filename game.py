# welcome to game v1.0 by bobtie658
# currently functional, will add comments later


print("welcome to game, enjoy your stay")

i1 = input("what is your first item ")

i2 = input("what is your second item ")

import random

i1d = random.randint(1,20)

i2d = random.randint(1,20)

mid = random.randint(1,10)

i3 = ""

i3d = 0

h = 150

if (mid == 1):
    m = "chicken"
    mh = 30
    dm = 1
    dx = 10

if (mid == 2):
    m = "cat"
    mh = 40
    dm = 5
    dx = 10

if (mid == 3):
    m = "fox"
    mh = 50
    dm = 7
    dx = 15

if (mid == 4):
    m = "snake"
    mh = 60
    dm = 9
    dx = 15

if (mid == 5):
    m = "monkey"
    mh = 70
    dm = 10
    dx = 15

if (mid == 6):
    m = "dolphin"
    mh = 80
    dm = 15
    dx = 17

if (mid == 7):
    m = "elephant"
    mh = 90
    dm = 15
    dx = 17

if (mid == 8):
    m = "rhino"
    mh = 100
    dm = 17
    dx = 20

if (mid == 9):
    m = "shark"
    mh = 110
    dm = 15
    dx = 22

if (mid == 10):
    m = "really big shark"
    mh = 120
    dm = 20
    dx = 25
    
mho = mh

print("you will fight a "+m+" with "+str(mh)+" health")
print("to attack the "+m+" type 'a' and to switch items, press 's'")

while not (mh <= 0) or not (h <= 0):
    print("you are currently attacking with a "+i1)
    print("your health: "+str(h))
    print(m+" health: "+str(mh))
    
    i = input()
    
    if i == "a":
        
        c = random.randint(1,10)
        
        if c == 1:
           print("you miss")
        
        elif c == 10:
            print ("critical hit")
            mh = (mh-(2*i1d))
            
        else:
            mh = (mh-i1d)
            
    if i == "s":
        i3 = i1
        i1 = i2
        i2 = i3
        
        i3d = i1d
        i1d = i2d
        i2d = i3d
        
    h = (h-random.randint(dm,dx))
    
    if mh <= 0:
        print("you won!")
        
    elif h <= 0:
        print("you lost")
        
input()
