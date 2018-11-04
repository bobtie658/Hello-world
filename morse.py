print("welcome to morse v1")
print("only lower case letters and numbers")
print("punctuation supported: ', :, ,, !, ?, . and "+'"')

word = input("")
length = len(word)
nword=[""]

time = length

while (time!=0):
    v = length-time
    
    if word[v]=="a":
        nword.append(". -   ")
    elif word[v]=="b":
        nword.append("- . . .   ")
    elif word[v]=="c":
        nword.append("- . - .   ")
    elif word[v]=="d":
        nword.append("- . .   ")
    elif word[v]=="e":
        nword.append(".   ")
    elif word[v]=="f":
        nword.append(". . - .   ")
    elif word[v]=="g":
        nword.append("- - .   ")
    elif word[v]=="h":
        nword.append(". . . .   ")
    elif word[v]=="i":
        nword.append(". .   ")
    elif word[v]=="j":
        nword.append(". - - -   ")
    elif word[v]=="k":
        nword.append("- . -   ")
    elif word[v]=="l":
        nword.append(". - . .   ")
    elif word[v]=="m":
        nword.append("- -   ")
    elif word[v]=="n":
        nword.append("- .   ")
    elif word[v]=="o":
        nword.append("- - -   ")
    elif word[v]=="p":
        nword.append(". - - .   ")
    elif word[v]=="q":
        nword.append("- - . -   ")
    elif word[v]=="r":
        nword.append(". - .   ")
    elif word[v]=="s":
        nword.append(". . .   ")
    elif word[v]=="t":
        nword.append("-   ")
    elif word[v]=="u":
        nword.append(". . -   ")
    elif word[v]=="v":
        nword.append(". . . -   ")
    elif word[v]=="w":
        nword.append(". - -   ")
    elif word[v]=="x":
        nword.append("- . . -   ")
    elif word[v]=="y":
        nword.append("- . - -   ")
    elif word[v]=="z":
        nword.append("- - . .   ")
    elif word[v]=="1":
        nword.append(". - - - -   ")
    elif word[v]=="2":
        nword.append(". . - - -   ")
    elif word[v]=="3":
        nword.append(". . . - -   ")
    elif word[v]=="4":
        nword.append(". . . . -   ")
    elif word[v]=="5":
        nword.append(". . . . .   ")
    elif word[v]=="6":
        nword.append("- . . . .   ")
    elif word[v]=="7":
        nword.append("- - . . .   ")
    elif word[v]=="8":
        nword.append("- - - . .   ")
    elif word[v]=="9":
        nword.append("- - - - .   ")
    elif word[v]=="0":
        nword.append("- - - - -   ")
    elif word[v]=="'":
        nword.append(". - - - - .   ")
    elif word[v]==":":
        nword.append("- - - . . .   ")
    elif word[v]==",":
        nword.append("- - . . - -   ")
    elif word[v]=="!":
        nword.append("- . - . - -   ")
    elif word[v]=="?":
        nword.append(". . - - . .   ")
    elif word[v]==".":
        nword.append(". - . - . -   ")
    elif word[v]=='"':
        nword.append(". - . . - .   ")
    elif word[v]==" ":
        nword.append("    ")
    time=time-1
    
del(nword[0])
print(''.join(nword))
input()