import random
l = ["usado", "nuevo", "reparacion"]
c = ["verde", "azul", "morado", "amarillo", "gris", "negro", "blanco", "café"]
def sqlScript(amount):
    for i in range(amount):
        a = random.randint(0, 2)
        es = l[a]
        k = 0
        if es != "nuevo":
            k = random.randint(1, 400)
        print("CALL AgregarCoche(" + str(random.randint(100000, 999999))+ ", " + str(random.randint(1, 20)) + ", " + "\"" + c[random.randint(0, 7)] + "\"" + ", " + "\"" + es + "\"" + ", " + str(k) + ", " + str(random.randint(1, 2))  + ");")
sqlScript(50)
