# welcome to game v2.1 by bobtie658
# currently functional, will add comments later
# 3.0   log: added shop
# 2.12  log: minor bug fixes
# 2.0   log: added multiple rounds, potions and prevented the same animal from coming up across different rounds


print("welcome to game, enjoy your stay")

i1=""
i2=""

while (i1==i2):

    i1 = input("what is your first weapon ")
    i2 = input("what is your second weapon ")
    print("")

print("")

import random

du=False
ca=False
fo=False
sn=False
hw=False
ele=False
rh=False
ho=False
sh=False
rsh=False

m = random.randint(10,20)

i3 = ""
i3d = 0
h = 150
p = 5
r = 5
rn = 1
x = 0

i1d = random.randint(1,20)
i2d = random.randint(1,20)

while not (h<=0) or not (r==0):

    while not x == rn:

        mid = random.randint(1,10)

        if (mid == 1) and not du == True:
            m = "duck"
            mh = 30
            dm = 1
            dx = 10
            x=x+1
            du = True
            pm = 1
            px = 10

        elif (mid == 2) and not ca == True:
            m = "cat"
            mh = 40
            dm = 5
            dx = 10
            x=x+1
            ca = True
            pm = 3
            px = 13

        elif (mid == 3) and not fo == True:
            m = "fox"
            mh = 50
            dm = 7
            dx = 15
            x=x+1
            fo = True
            pm = 6
            px = 16

        elif (mid == 4) and not sn == True:
            m = "snake"
            mh = 60
            dm = 9
            dx = 15
            x=x+1
            sn = True
            pm = 7
            px = 17

        elif (mid == 5) and not hw == True:
            m = "hawk"
            mh = 70
            dm = 10
            dx = 15
            x=x+1
            hw = True
            pm = 9
            px = 19

        elif (mid == 6) and not ele == True:
            m = "elephant"
            mh = 80
            dm = 15
            dx = 17
            x=x+1
            ele = True
            pm = 11
            px = 21

        elif (mid == 7) and not rh == True:
            m = "rhino"
            mh = 90
            dm = 15
            dx = 17
            x=x+1
            rh = True
            pm = 12
            px = 22

        elif (mid == 8) and not ho == True:
            m = "hippo"
            mh = 100
            dm = 17
            dx = 20
            x=x+1
            ho = True
            pm = 15
            px = 25

        elif (mid == 9) and not sh == True:
            m = "shark"
            mh = 110
            dm = 15
            dx = 22
            x=x+1
            sh = True
            pm = 17
            px = 27

        elif (mid == 10) and not rsh == True:
            m = "really big shark"
            mh = 120
            dm = 20
            dx = 25
            x=x+1
            rsh = True
            pm = 20
            px = 30
    
    print("round "+str(rn))
    print("you will fight a "+m+" with "+str(mh)+" health")
    print("to attack the "+m+" type 'a', to switch items, press 's' and to use a potion, press 'p'")

    while not (mh <= 0) or not (h <= 0):
        print("")
        print("")
        print("you are currently attacking with a "+i1)
        print("your health: "+str(h))
        print(m+" health: "+str(mh))
        print("you have "+str(p)+" potions remaining")
    
        i = input()
        print("")
    
        if i == "a":
        
            c = random.randint(1,10)
        
            if c == 1:
               print("you miss")
        
            elif c == 10:
                print ("critical hit")
                mho = mh
                mh = (mh-(2*i1d))
                print("you did "+str(mho-mh)+" damage")
            
            else:
                mho = mh
                mh = (mh-i1d)
                print("you did "+str(mho-mh)+" damage")
            
        if i == "s":
            i3 = i1
            i1 = i2
            i2 = i3
        
            i3d = i1d
            i1d = i2d
            i2d = i3d
        
        if i == "p" and p>0 and h<150:
            oh = h
            h = h+75
            p = p-1
            
            if h>150:
                h = 150
            print("you used a potion and restored "+str(h-oh)+" health")
        
        h = (h-random.randint(dm,dx))
    
        if mh <= 0:
            print("you won the fight")
            mo = m
            m = m+random.randint(pm,px)
            print("you won "+str(m-mo)+" money")
            print("")
            break
        
        elif h <= 0:
            print("you lost")
            break
    
    if h<=0:
        break
    
    if h>0 and r>0:
        r = r-1
        rn = rn+1

        
        print("welcome to the shop, you can buy potions and weapon upgrades here")
        while not ch == leave:
            print("1 potion costs 10 money and one weapon costs 15 money")
            print("to buy a potion, type 'potion', to buy an upgrade, type 'upgrade' and to leave, type 'leave'")
            print("you have "+str(m)+" money")
            print("What yould you like to buy?")
            ch = input("")
            print("")

            if ch = "potion" and m >=10:
                p = p+1
                m = m-10
                print("you bought 1 potion")

            if ch = "potion" and m <10:
                print("you dont have enough money to buy a potion")

            if ch = "upgrade" and m>=15:
                i1d = i1d+5
                i2d = i2d+5
                m = m-15
                print("your weapon damage increased by 5")

            if ch = "upgrade" and m<15:
                print("you dont have enough money to buy an upgrade")

            if ch = "leave":
                print("you left the shop")
                break
        
        
        print("")
        print("you have "+str(h)+" health remaining and "+str(p)+" potions remaining, how many would you like to use?")
        up = "a"
        while not up.isdigit():
            up = input("")
        
        up = int(up)
        oh = h
        if (up<p):
            h = (h+(75*up))
            p=p-up
        else:
            h = h+(75*p)
            p=0
    
        if h>150:
            h = 150
    
        print("you restored "+str(h-oh)+" health")
    
if r==0:
    print("")
    print("congratulations, you won!")
input()
