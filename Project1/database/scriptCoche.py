import random
l = ["usado", "nuevo", "reparacion"]
c = ["verde", "azul", "morado", "amarillo", "gris", "negro", "blanco", "café"]
def sriptCoche(amount):
    for i in range(amount):
        a = random.randint(0, 2)
        es = l[a]
        k = 0
        if es != "nuevo":
            k = random.randint(1, 400)
        print("CALL AgregarCoche(" + str(random.randint(100000, 999999))+ ", " + str(random.randint(1, 20)) + ", " + "\"" + c[random.randint(0, 7)] + "\"" + ", " + "\"" + es + "\"" + ", " + str(k) + ", " + str(random.randint(1, 2))  + ");")
#sqlScript(50)


def scriptRxM(amount):
    a = int(amount/2);
    for i in range (a):
        b = random.randint(2, 4)
        for j in range (b): #Varios mecanicos
            print("CALL AgregarReparacionXMecanico(" + str(i+1) + ", " + str((b+random.randint(0, 5))%5 + 1) +", " + str(random.randint(1, 10)) + ");")
    for i in range (a, amount):
        b = random.randint(2, 4)
        for j in range (b): #Varios mecanicos
            print("CALL AgregarReparacionXMecanico(" + str(i+1) + ", " + str((b+random.randint(0, 5))%5 + 6) +", " + str(random.randint(1, 10)) + ");")
                  
scriptRxM(50)
