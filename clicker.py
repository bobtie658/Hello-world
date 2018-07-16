mons = 0
machine = 0
upgrade = 1
loop = 0
tally = 0
mprice = 500
uprice = 100
mupgrade = 10
muprice = 1000

print("welcome to: Definitely not cookie clicker")
print("To make money, press enter in the console, robots will produce 10 money each every 50 turns, upgrades will up your money per click by 1 per upgrade")
print("To buy robots, press r")
print("To buy upgrades, press u")
print("To buy robot upgrades, press ru")
print("To check your money, press m")
print("To stop the game, press s")
print("Use 'y' to confirm a purchase")
print("use stats to see all your purchases")
print("To bring up the instructions again, use 'help'")

while loop == 0:
    order = input("")

    if order == 'm':
        print("you have "+str(mons)+" money")

    elif mons >= uprice and order == "u":
      var = input("do you want to buy 1 upgrade for "+str(uprice)+" money")
      if var == "y":
        upgrade = upgrade + 1
        mons = mons - uprice
        uprice = int(uprice * 1.35)
        print("you have bought 1 upgrade")
        print("you now click for "+str(upgrade)+" each time")

    elif mons >= mprice and order == "r":
      var = input("do you want to buy 1 robot for "+str(mprice)+" money")
      if var == "y":
        print("bought 1 robot")
        machine = machine+1
        mons = mons - mprice
        mprice = int(mprice * 1.15)
        print("you now have "+str(machine)+" robots")

    elif order == "t":
        print("tally = "+str(tally-1))

    elif order == "s":
        exit()

    elif order == "ru" and mons >= muprice:
      var = input("do you want to buy 1 robot upgrade for "+str(muprice)+" money")
      if var == "y":
        mupgrade = mupgrade + 2
        mons = mons - muprice
        muprice = int(muprice * 1.15)
        print("1 robot upgrade bought")
        print("robot clicks for "+str(mupgrade)+" money per click")
        
    elif order == "r" and mons <= mprice:
        print("you do not have enough money, to buy a robot it costs "+str(mprice)+" money")
    
    elif order == "ru" and mons <= muprice:
        print("you do not have enough money, to buy a robot upgrade it costs "+str(muprice)+" money")
        
    elif order == "u" and mons <= uprice:
        print("you do not have enough money, to buy an upgrade, it costs "+str(uprice)+" money")

    elif order == "stats":
      print("you have "+str(machine)+" robots")
      print("you have "+str(mupgrade)+" robot upgrades")
      print("together your robots will produce "+str(machine*mupgrade)+" money every 50 clicks")
      print("you will produce "+str(upgrade)+" money every click")

    elif order == "help":
        print("To make money, press enter in the console, robots will produce 10 money each every 50 turns, upgrades will up your money per click by 1 per upgrade")
        print("To buy robots, press r")
        print("To buy upgrades, press u")
        print("To buy robot upgrades, press ru")
        print("To check your money, press m")
        print("To stop the game, press s")
        print("Use 'y' to confirm a purchase")
        print("use stats to see all your purchases")
        print("To bring up the instructions again, use 'help'")

      
    elif order == "cheats":
        cheat = input("input your cheat code ")
        if cheat == "bring on the money!":
            mons = mons +100000000
            
        elif cheat == "ex machina":
            machine = machine +1000000
            
        elif cheat == "moneymaker":
            upgrade = upgrade+1000000
            
        elif cheat == "machine learning":
            mupgrade = mupgrade+1000000

    else:
        tally = tally+1
        mons = mons + upgrade

    if (tally%10) == 0 and tally >= 0:
        print("you have "+str(mons)+" money")

    if (tally%50) == 0 and machine > 0 and tally >= 0:
        mons = mons + (machine * mupgrade)
        print("robots active")
