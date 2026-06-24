' MENU DE MISCELANEOS - Grupo 4A
' Universidad Autonoma Chapingo - Departamento de Irrigacion
' Archivo independiente para QBasic/QB64
' Autores:
' Bistrain Borraz Angel Gabriel
' Cruz Sibaja Gibran Francisco
' Elias Dominguez Ruben
' Ortiz Ugarte Jonatan
' Torres Valencia Mario Alberto

DIM datos(100), x(100), y(100)
DIM matA(10, 10), matB(10, 10), matC(10, 10)
DIM nombre$(100), sexo$(100), edad(100), est(100)

GOSUB MenuMiscelaneos
END

Pausa:
COLOR 13, 1
LOCATE 23, 26: PRINT "Pulse ENTER para continuar...";
LINE INPUT pausa$
RETURN

Titulo:
COLOR 15, 1
CLS
FOR fila = 1 TO 24
    LOCATE fila, 1
    IF fila = 1 OR fila = 5 OR fila = 24 THEN
        PRINT "+------------------------------------------------------------------------------+";
    ELSE
        PRINT "|                                                                              |";
    END IF
NEXT fila
COLOR 11, 1
LOCATE 2, 26: PRINT "UNIVERSIDAD AUTONOMA CHAPINGO"
LOCATE 3, 28: PRINT "DEPARTAMENTO DE IRRIGACION"
COLOR 15, 1
LOCATE 4, 29: PRINT "P R O G R A M A C I O N"
COLOR 14, 1
LOCATE 6, INT((80 - LEN(titulo$)) / 2) + 1: PRINT titulo$
COLOR 15, 1
LOCATE 8, 24
RETURN

LeerDatos:
DO
    INPUT "Cuantos datos va a capturar (1 a 100): ", n
LOOP UNTIL n >= 1 AND n <= 100
FOR i = 1 TO n
    PRINT "Dato"; i; ": ";
    INPUT datos(i)
NEXT i
RETURN

OrdenarAsc:
FOR i = 1 TO n - 1
    FOR j = 1 TO n - i
        IF datos(j) > datos(j + 1) THEN
            temp = datos(j)
            datos(j) = datos(j + 1)
            datos(j + 1) = temp
        END IF
    NEXT j
NEXT i
RETURN

MenuMiscelaneos:
DO
    titulo$ = "MISCELANEOS"
    GOSUB Titulo
    LOCATE 8, 24: PRINT "1. Par o impar"
    LOCATE 9, 24: PRINT "2. Formula cuadratica"
    LOCATE 10, 24: PRINT "3. Numero mayor"
    LOCATE 11, 24: PRINT "4. Numero menor"
    LOCATE 12, 24: PRINT "5. Volver"
    LOCATE 21, 28: INPUT "Seleccione una opcion: ", op
    SELECT CASE op
        CASE 1: GOSUB OpPar
        CASE 2: GOSUB OpCuadratica
        CASE 3: GOSUB OpMayor
        CASE 4: GOSUB OpMenor
        CASE 5: RETURN
    END SELECT
LOOP

OpPar:
titulo$ = "07: NUMERO PAR O IMPAR": GOSUB Titulo
INPUT "Escriba un numero entero: ", n
IF n MOD 2 = 0 THEN PRINT n; " es PAR" ELSE PRINT n; " es IMPAR"
GOSUB Pausa: RETURN

OpCuadratica:
titulo$ = "08: FORMULA CUADRATICA": GOSUB Titulo
DO: INPUT "Coeficiente A (A <> 0): ", a: LOOP UNTIL a <> 0
INPUT "Coeficiente B: ", b: INPUT "Coeficiente C: ", c
disc = b * b - 4 * a * c
PRINT "Discriminante ="; disc
IF disc < 0 THEN
    PRINT "No hay raices reales."
ELSEIF disc = 0 THEN
    PRINT "Una raiz real: X ="; -b / (2 * a)
ELSE
    PRINT "X1 ="; (-b + SQR(disc)) / (2 * a)
    PRINT "X2 ="; (-b - SQR(disc)) / (2 * a)
END IF
GOSUB Pausa: RETURN

OpMayor:
titulo$ = "09: NUMERO MAYOR": GOSUB Titulo
GOSUB LeerDatos
mayor = datos(1)
FOR i = 2 TO n: IF datos(i) > mayor THEN mayor = datos(i)
NEXT i
PRINT "El numero mayor es:"; mayor
GOSUB Pausa: RETURN

OpMenor:
titulo$ = "10: NUMERO MENOR": GOSUB Titulo
GOSUB LeerDatos
menor = datos(1)
FOR i = 2 TO n: IF datos(i) < menor THEN menor = datos(i)
NEXT i
PRINT "El numero menor es:"; menor
GOSUB Pausa: RETURN

