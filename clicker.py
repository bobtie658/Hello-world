# Clicker game v1.5 by Bobtie


mons = 0    # sets variable for money to 0
machine = 0 # sets variable for robots to 0
upgrade = 1 # instead of having a variable for how much each click is worth and the number of upgrades seperate, i combined them so it would take less space
            # by having upgrade set to 1, each click will be worth 1 mons
loop = 0    # the loop variable is just used to create an infinate loop easily and quickly, there is most definatly a better way of doing it, but its the first thing i thought of
tally = 0   # this is used so every 10 clicks, it will display the money earned and every 50 clicks, the robots will activate
mprice = 500   # these prices are used as a base value for the price of each thing you can buy
uprice = 100
muprice = 1000
mupgrade = 10   # mupgrade is the same as the upgrade, with the same idea to save number of variables, but this is a upgrade for robots

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

    # the instructions set out in the lines above are just a baseline for the game

while loop == 0:        # this while statement uses the loop variable to repeat the game and keep it going
    order = input("")   # This is the input part, where the user inputs the input that they want to input

    if order == 'm':
        print("you have "+str(mons)+" money")   # this if statement is used to help the player to see how much money they have

    elif mons >= uprice and order == "u":   # this makes sure the player can afford the upgrade
      var = input("do you want to buy 1 upgrade for "+str(uprice)+" money") # i put in a checking system to make sure that the player did want to buy the upgrade, not just check the price
      if var == "y":
        upgrade = upgrade + 1       # this increases upgrades value, increasing the money earned per click
        mons = mons - uprice        # this reduces the money the player has by the cost of the upgrade
        uprice = int(uprice * 1.35) # this increases the price of getting an upgrade, thus increasing the difficulty of the game
        print("you have bought 1 upgrade")
        print("you now click for "+str(upgrade)+" each time")

    elif mons >= mprice and order == "r":
      var = input("do you want to buy 1 robot for "+str(mprice)+" money")   # very similar process to upgrade
      if var == "y":
        machine = machine+1
        mons = mons - mprice
        mprice = int(mprice * 1.15) # here the price only increases by 15% compared to a 35% for upgrades, this is to shift the late game focus from upgrades to robots
        print("bought 1 robot")
        print("you now have "+str(machine)+" robots")
        
    elif order == "t":
        print("tally = "+str(tally-1))  # i added this to help with debugging as early on i would get a problem with the tally

    elif order == "s":  # exits the game to prevent any accidental tron-like scenarios
        exit()

    elif order == "ru" and mons >= muprice:
      var = input("do you want to buy 1 robot upgrade for "+str(muprice)+" money")  # another upgrade menu
      if var == "y":
        mupgrade = mupgrade + 2 # here the robot upgrade increases by 2, this is to again, increase late game favour for robots over upgrades
        mons = mons - muprice
        muprice = int(muprice * 1.15)
        print("1 robot upgrade bought")
        print("robot clicks for "+str(mupgrade)+" money per click")
        
    elif order == "r" and mons <= mprice:
        print("you do not have enough money, to buy a robot it costs "+str(mprice)+" money")    # these next few elifs are for if the player doesnt have enough money to buy an upgrade but trys to buy one anyway
    
    elif order == "ru" and mons <= muprice:
        print("you do not have enough money, to buy a robot upgrade it costs "+str(muprice)+" money")
        
    elif order == "u" and mons <= uprice:
        print("you do not have enough money, to buy an upgrade, it costs "+str(uprice)+" money")

    elif order == "stats":      # i added the stats menu because i found while testing the game, it was hard to keep track of how many upgrades there are
      print("you have "+str(machine)+" robots")
      print("you have "+str(mupgrade)+" robot upgrades")
      print("together your robots will produce "+str(machine*mupgrade)+" money every 50 clicks")
      print("you will produce "+str(upgrade)+" money every click")

    elif order == "help":   # just displays the same text as when you open the game
        print("To make money, press enter in the console, robots will produce 10 money each every 50 turns, upgrades will up your money per click by 1 per upgrade")
        print("To buy robots, press r")
        print("To buy upgrades, press u")
        print("To buy robot upgrades, press ru")
        print("To check your money, press m")
        print("To stop the game, press s")
        print("Use 'y' to confirm a purchase")
        print("use stats to see all your purchases")
        print("To bring up the instructions again, use 'help'")

      
    elif order == "cheats": # i added cheats just for fun
        cheat = input("input your cheat code ")
        if cheat == "motherload":
            mons = mons +100000000
            
        elif cheat == "ex machina":
            machine = machine +1000000
            
        elif cheat == "moneymaker":
            upgrade = upgrade+1000000
            
        elif cheat == "machine learning":
            mupgrade = mupgrade+1000000

    else:
        tally = tally+1     # this is where you make money, every time you press enter, you gain money equal to your upgrade variable, it also adds one to the tally marker
        mons = mons + upgrade

    if (tally%10) == 0 and tally >= 0:      # this checks every click and displays the players money every time the tally is a multiple of 10
        print("you have "+str(mons)+" money")

    if (tally%50) == 0 and machine > 0 and tally >= 0:  # this is the same as the code above, but it also makes sure the player has robots
        mons = mons + (machine * mupgrade)
        print("robots active")
