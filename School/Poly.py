# polynomial solver by bobtie

from math import sqrt

print("Welcome to my polynomial solver, input your equation")
print("")
print("aX^2+bX+c=0")
a=""
b=""
c=""

while not a.isdigit():
    a=input("a = ")
    
print("")
a = int(a)

while not b.isdigit():
    b=input("b = ")
    
print("")
b=int(b)

while not c.isdigit():
    c=input("c = ")
    
print("")
c=int(c)

if (b*b)>=(4*a*c):
    
    s = (sqrt((b*b)-(a*c*4)))
    x1 = ((b+s)/(2*a))
    x2 = ((b-s)/(2*a))
    print("X= "+str(x1)+"or X= "+str(x2))
    
else:
    
    s = (sqrt(-(b*b-(a*c*4))))
    x1 = s/(a*2)
    x2 = b/(a*2)
    print("X = "+str(x2)+" + "+str(x1)+"i or X = "+str(x2)+" - "+str(x1)+"i")

input()