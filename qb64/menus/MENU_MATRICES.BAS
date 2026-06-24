' MENU DE MATRICES - Grupo 4A
' Universidad Autonoma Chapingo - Departamento de Irrigacion
' Archivo independiente para QBasic/QB64
' Autores:
' Bistrain Borraz Angel Gabriel
' Cruz Sibaja Gibran Francisco
' Elias Dominguez Ruben
' Torres Valencia Mario Alberto

DIM datos(100), x(100), y(100)
DIM matA(10, 10), matB(10, 10), matC(10, 10)
DIM nombre$(100), sexo$(100), edad(100), est(100)

GOSUB MenuMatrices
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
COLOR 10, 1: LOCATE 7, 3: PRINT "Integrantes: Elias Dominguez, Bistrain Borraz, Cruz Sibaja, Torres Valencia";
COLOR 14, 1
LOCATE 6, INT((80 - LEN(titulo$)) / 2) + 1: PRINT titulo$
COLOR 15, 1
LOCATE 8, 24
RETURN

CapturaDimMat:
DO
    INPUT "Filas (1 a 10): ", m
LOOP UNTIL m >= 1 AND m <= 10
DO
    INPUT "Columnas (1 a 10): ", n
LOOP UNTIL n >= 1 AND n <= 10
RETURN

MenuMatrices:
DO
    titulo$ = "MATRICES"
    GOSUB Titulo
    LOCATE 8, 24: PRINT "1. Suma de matrices"
    LOCATE 9, 24: PRINT "2. Resta de matrices"
    LOCATE 10, 24: PRINT "3. Transpuesta"
    LOCATE 11, 24: PRINT "4. Inversa 2x2"
    LOCATE 12, 24: PRINT "5. Volver"
    LOCATE 21, 28: INPUT "Seleccione una opcion: ", op
    SELECT CASE op
        CASE 1: GOSUB OpMatSuma
        CASE 2: GOSUB OpMatResta
        CASE 3: GOSUB OpMatTrans
        CASE 4: GOSUB OpMatInv
        CASE 5: RETURN
    END SELECT
LOOP

OpMatSuma:
titulo$ = "39: SUMA DE MATRICES": GOSUB Titulo
GOSUB CapturaDimMat
PRINT "Capture matriz A": FOR i = 1 TO m: FOR j = 1 TO n: PRINT "A("; i; ","; j; "): ";: INPUT matA(i, j): NEXT j: NEXT i
PRINT "Capture matriz B": FOR i = 1 TO m: FOR j = 1 TO n: PRINT "B("; i; ","; j; "): ";: INPUT matB(i, j): matC(i, j) = matA(i, j) + matB(i, j): NEXT j: NEXT i
PRINT "C = A + B": FOR i = 1 TO m: FOR j = 1 TO n: PRINT matC(i, j);: NEXT j: PRINT: NEXT i
GOSUB Pausa: RETURN

OpMatResta:
titulo$ = "40: RESTA DE MATRICES": GOSUB Titulo
GOSUB CapturaDimMat
PRINT "Capture matriz A": FOR i = 1 TO m: FOR j = 1 TO n: PRINT "A("; i; ","; j; "): ";: INPUT matA(i, j): NEXT j: NEXT i
PRINT "Capture matriz B": FOR i = 1 TO m: FOR j = 1 TO n: PRINT "B("; i; ","; j; "): ";: INPUT matB(i, j): matC(i, j) = matA(i, j) - matB(i, j): NEXT j: NEXT i
PRINT "C = A - B": FOR i = 1 TO m: FOR j = 1 TO n: PRINT matC(i, j);: NEXT j: PRINT: NEXT i
GOSUB Pausa: RETURN

OpMatTrans:
titulo$ = "41: MATRIZ TRANSPUESTA": GOSUB Titulo
GOSUB CapturaDimMat
PRINT "Capture matriz A": FOR i = 1 TO m: FOR j = 1 TO n: PRINT "A("; i; ","; j; "): ";: INPUT matA(i, j): matC(j, i) = matA(i, j): NEXT j: NEXT i
PRINT "Transpuesta": FOR i = 1 TO n: FOR j = 1 TO m: PRINT matC(i, j);: NEXT j: PRINT: NEXT i
GOSUB Pausa: RETURN

OpMatInv:
titulo$ = "42: MATRIZ INVERSA 2X2": GOSUB Titulo
PRINT "Capture matriz A de 2x2": FOR i = 1 TO 2: FOR j = 1 TO 2: PRINT "A("; i; ","; j; "): ";: INPUT matA(i, j): NEXT j: NEXT i
det = matA(1, 1) * matA(2, 2) - matA(1, 2) * matA(2, 1)
PRINT "Determinante ="; det
IF det = 0 THEN PRINT "La matriz no tiene inversa." ELSE PRINT matA(2, 2) / det; -matA(1, 2) / det: PRINT -matA(2, 1) / det; matA(1, 1) / det
GOSUB Pausa: RETURN
