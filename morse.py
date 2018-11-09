# welcome to morse v1.1 by bobtie658
# v1.1 log, added more symbols and capital letters

print("welcome to morse code translator, letters -> morse code")
print("only letters and numbers")
print("punctuation supported: ', :, ,, !, ?, ., &, (, ), - and "+'"')

word = input("")
length = len(word)
nword=[""]

time = length

while (time!=0):
    v = length-time
    
    if word[v]=="a" or word[v]=="A":
        nword.append(". -   ")
    elif word[v]=="b" or word[v]=="B":
        nword.append("- . . .   ")
    elif word[v]=="c" or word[v]=="C":
        nword.append("- . - .   ")
    elif word[v]=="d" or word[v]=="D":
        nword.append("- . .   ")
    elif word[v]=="e" or word[v]=="E":
        nword.append(".   ")
    elif word[v]=="f" or word[v]=="F":
        nword.append(". . - .   ")
    elif word[v]=="g" or word[v]=="G":
        nword.append("- - .   ")
    elif word[v]=="h" or word[v]=="H":
        nword.append(". . . .   ")
    elif word[v]=="i" or word[v]=="I":
        nword.append(". .   ")
    elif word[v]=="j" or word[v]=="J":
        nword.append(". - - -   ")
    elif word[v]=="k" or word[v]=="K":
        nword.append("- . -   ")
    elif word[v]=="l" or word[v]=="L":
        nword.append(". - . .   ")
    elif word[v]=="m" or word[v]=="M":
        nword.append("- -   ")
    elif word[v]=="n" or word[v]=="N":
        nword.append("- .   ")
    elif word[v]=="o" or word[v]=="O":
        nword.append("- - -   ")
    elif word[v]=="p" or word[v]=="P":
        nword.append(". - - .   ")
    elif word[v]=="q" or word[v]=="Q":
        nword.append("- - . -   ")
    elif word[v]=="r" or word[v]=="R":
        nword.append(". - .   ")
    elif word[v]=="s" or word[v]=="S":
        nword.append(". . .   ")
    elif word[v]=="t" or word[v]=="T":
        nword.append("-   ")
    elif word[v]=="u" or word[v]=="U":
        nword.append(". . -   ")
    elif word[v]=="v" or word[v]=="V":
        nword.append(". . . -   ")
    elif word[v]=="w" or word[v]=="W":
        nword.append(". - -   ")
    elif word[v]=="x" or word[v]=="X":
        nword.append("- . . -   ")
    elif word[v]=="y" or word[v]=="Y":
        nword.append("- . - -   ")
    elif word[v]=="z" or word[v]=="Z":
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
    elif word[v]=='&':
        nword.append(". - . . .   ")
    elif word[v]=='(':
        nword.append("- . - - .   ")
    elif word[v]==')':
        nword.append("- . - - . -   ")
    elif word[v]=='-':
        nword.append("- . . . . -   ")
    elif word[v]==" ":
        nword.append("    ")
    time=time-1
    
del(nword[0])
print(''.join(nword))
input()
