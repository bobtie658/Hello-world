# word shifter v1.0 by piers


debug = input("enable debug mode? ") 

# debug mode is identical to normal mode, however it displays all of the variables whenever they are changed

# in debug mode, there will be lines of code which look like [print("{variable name}: "+{variable name})]
# these lines of code are not in the normal mode and are just to help find errors

if debug == "yes":      # checking if the user wants to enable debug mode
        word = input("input your word: ") # recording the initial value for "word"

        print("word: "+word) # first example of a debug line of code, there are quite a few of these

        while len(word) <= 1 or word == " ":    # loop checking if the user inputs a valid word
                repeat1 = ["please input an actual word ","this time, try putting in a word ", "for the last time, use a god damn word! ","right, thats it, im shutting off the program "]
                for y in repeat1: # repeat1 is the variable storing the different resposes
                        word = input(y) # changes the request each time the user doesn't input a valid word
                        
                        print("word: "+word)

                        if y == "right, thats it, im shutting off the program ":
                                exit()  # exits the program if the user takes too long

                        if not len(word) <= 1 or not word ==" ":
                                break # breaks the loop if the user inputs a valid word

        number = input("input the first number ") # asks for the first number
        
        print("number: "+number)

        while not number.isdigit(): # same idea as before, keeps asking for a valid number if the user does not supply a valid one
                repeat = ["please input a valid integer ","this time, try using a valid integer ", "for the last time, try to use whatever living brain cells you have left, to input a valid integer ","right, thats it, im shutting off the program "]
                for x in repeat:
                        number = input(x)
                        
                        print("number: "+number)

                        if x == "right, thats it, im shutting off the program ":
                                exit()

                        if number.isdigit(): # This is checking that the number inputted is acutally a number and then breaking the loop if it is
                                break


        number2 = input("input the Second number ") # asks for second number
        
        print("number2: "+number2)

        while not number2.isdigit(): # yet another while loop, same story
                repeat = ["please input a valid integer ","this time, try using a valid integer ", "for the last time, try to use whatever living brain cells you have left, to input a valid integer ","right, thats it, im shutting off the program "]
                for x in repeat:
                        number2 = input(x)
                        
                        print("number2: "+number2)
                
                        if x == "right, thats it, im shutting off the program ":
                                exit()
        
                        if number2.isdigit():
                                break

        number = int(number) # convers the numbers given into integers, insted of strings
        number2 = int(number2)

        new_number = number*number2 # calculates a new number which is the number of times the word will be shifted
        

        while new_number > 1000000: # this while loop just repeats the whole number input loops if the new number calculated is larger than 1 million, this time i got bored of the for loops, so its just a while one with no different requests
                print("sorry the numbers you inputed were too big, try again") # all this code is exactly the same except the first three lines of code which are just for debug
                
                print("new_number:"+str(new_number))
                
                number = input("input the first number ")
                
                print("number: "+number)
                
                while not number.isdigit():
                        repeat = ["please input a valid integer ","this time, try using a valid integer ", "for the last time, try to use whatever living brain cells you have left, to input a valid integer ","right, thats it, im shutting off the program "]
                        for x in repeat:
                                number = input(x)
                                
                                print("number: "+number)
                                
                                if x == "right, thats it, im shutting off the program ":
                                        exit()

                                if number.isdigit():
                                        break


                number2 = input("input the Second number ")
                
                print("number2: "+number2)
                
                while not number2.isdigit():
                        repeat = ["please input a valid integer ","this time, try using a valid integer ", "for the last time, try to use whatever living brain cells you have left, to input a valid integer ","right, thats it, im shutting off the program "]
                        for x in repeat:
                                number2 = input(x)
                                
                                print("number2: "+number2)
                                
                                if x == "right, thats it, im shutting off the program ":
                                        exit()

                                if number2.isdigit():
                                        break

                number = int(number)
                number2 = int(number2) # This part is calculating new_number, which will determine whether or not the while loop will repeat or not

                new_number = number*number2

        print("new_number: "+str(new_number))
        
        if not new_number == 1: # this if function here is just changing grammar a bit if the number is 1
                print("your word, '"+word+"' will be shifted "+str(new_number)+" times")

        else:
                print("your word, '"+word+"' will be shifted "+str(new_number)+" time") # these print the word and the number of times shifted for the ueser

        new_number = int(new_number) # converts the number back into an integer in order to be used in the final part
        

        wleng = len(word)
        
        if ((new_number/wleng)-int(new_number/wleng)) == 0: # if the number of times a word is shifted is able to be divided directly by the length of the word, the word will not change, this just helps to shorten the whole thing down
                word2 = word
                
        else:
                word = word.lower()
                
                upper = word[0] # upper is recording the value of the first letter in the word for later
                print("upper: "+upper)

                debug2 = input("display steps? ") # sometimes in debug mode you dont want to see the steps when testing large numbers as it may take a long time, this variable is just to give the option to disable it
                        
                tally = 0 # tally is a part of debug which is very useful, it helps display the number of times the word has been shifted in order to find whether the word has been shifted the right number of times as keeping track of new_number was a bit confusing

                if debug2 == "yes":
                        
                        while new_number > 0:
                                swap = word[-1]
                
                                print("swap: "+swap)
                
                                word = swap+word[0:-1]
                                new_number = new_number-1
                
                                tally = tally+1
                                print("word: "+word)
                                print("swap number "+str(tally)+" complete")
                                print("new_number: "+str(new_number))
                else:
                        while new_number > 0:
                                swap = word[-1]
                                word = swap+word[0:-1]
                                new_number = new_number-1
        
                first = word[0] # records the first letter after the shifting
                if upper.isupper(): # changes the fist letter to a capital if the first letter was originally capital
                         word2 = first.upper()+word[1:] # replacing the first letter of the word with an uppercase version of itself
                else:
                         word2 = word

        print(word2) # finally this prints the final word after being shifted

        # I decided to make word2 its own integer instead of just replacing word with itself because i dont like the way it looks as this way, i know that word2 is the final variable and there should be nothing after it in the console

        input("press enter to exit") # This input is to make it so that the console doesnt just close after it finishes

else: # this is the code where the user selects to not enable debug mode, it is the same as the rest of the code, but without printing the variables all the time
        word = input("input your word ")

        while len(word) <= 1 or word == " ":
                repeat1 = ["please input an actual word ","this time, try putting in a word ", "for the last time, use a god damn word! ","right, thats it, im shutting off the program "]
                for y in repeat1:
                        word = input(y)

                        if y == "right, thats it, im shutting off the program ":
                                exit()

                        if not len(word) <= 1 or not word ==" ":
                                break

        number = input("input the first number ")

        while not number.isdigit():
                repeat = ["please input a valid integer ","this time, try using a valid integer ", "for the last time, try to use whatever living brain cells you have left, to input a valid integer ","right, thats it, im shutting off the program "]
                for x in repeat:
                        number = input(x)

                        if x == "right, thats it, im shutting off the program ":
                                exit()

                        if number.isdigit():
                                break


        number2 = input("input the Second number ")

        while not number2.isdigit():
                repeat = ["please input a valid integer ","this time, try using a valid integer ", "for the last time, try to use whatever living brain cells you have left, to input a valid integer ","right, thats it, im shutting off the program "]
                for x in repeat:
                        number2 = input(x)
                
                        if x == "right, thats it, im shutting off the program ":
                                exit()
        
                        if number2.isdigit():
                                break

        number = int(number)
        number2 = int(number2)

        new_number = number*number2

        while new_number > 1000000:
                print("sorry the numbers you inputed were too big, try again")
                number = input("input the first number ")

                while not number.isdigit():
                        repeat = ["please input a valid integer ","this time, try using a valid integer ", "for the last time, try to use whatever living brain cells you have left, to input a valid integer ","right, thats it, im shutting off the program "]
                        for x in repeat:
                                number = input(x)

                                if x == "right, thats it, im shutting off the program ":
                                        exit()

                                if number.isdigit():
                                        break


                number2 = input("input the Second number ")
        
                while not number2.isdigit():
                        repeat = ["please input a valid integer ","this time, try using a valid integer ", "for the last time, try to use whatever living brain cells you have left, to input a valid integer ","right, thats it, im shutting off the program "]
                        for x in repeat:
                                number2 = input(x)
                
                                if x == "right, thats it, im shutting off the program ":
                                        exit()

                                if number2.isdigit():
                                        break

                number = int(number)
                number2 = int(number2)

                new_number = number*number2

        new_number = int(new_number)
        
        if not new_number == 1:
                print("your word, '"+word+"' will be shifted "+str(new_number)+" times")

        else:
                print("your word, '"+word+"' will be shifted "+str(new_number)+" time")

        wleng = len(word)
                
        if ((new_number/wleng)-int(new_number/wleng)) == 0:
                word2 = word

        else:
                
                upper = word[0]

                while new_number > 0:
                        swap = word[-1]
                        word = swap+word[0:-1]
                        new_number = new_number-1
        
        
                first = word[0]
                if upper.isupper():
                         word2 = first.upper()+word[1:]
                else:
                         word2 = word

        print(word2)

        input("press enter to exit")