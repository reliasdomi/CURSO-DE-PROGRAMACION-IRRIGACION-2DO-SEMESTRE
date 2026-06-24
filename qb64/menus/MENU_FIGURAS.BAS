' MENU DE FIGURAS GEOMETRICAS - Grupo 4A
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

GOSUB MenuFiguras
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

MenuFiguras:
DO
    titulo$ = "FIGURAS GEOMETRICAS"
    GOSUB Titulo
    LOCATE 8, 24: PRINT "1. Cuadrado"
    LOCATE 9, 24: PRINT "2. Rectangulo"
    LOCATE 10, 24: PRINT "3. Triangulo"
    LOCATE 11, 24: PRINT "4. Circulo"
    LOCATE 12, 24: PRINT "5. Rombo"
    LOCATE 13, 24: PRINT "6. Trapecio"
    LOCATE 14, 24: PRINT "7. Poligono regular"
    LOCATE 15, 24: PRINT "8. Volver"
    LOCATE 21, 28: INPUT "Seleccione una opcion: ", op
    SELECT CASE op
        CASE 1: GOSUB OpCuadrado
        CASE 2: GOSUB OpRectangulo
        CASE 3: GOSUB OpTriangulo
        CASE 4: GOSUB OpCirculo
        CASE 5: GOSUB OpRombo
        CASE 6: GOSUB OpTrapecio
        CASE 7: GOSUB OpPoligono
        CASE 8: RETURN
    END SELECT
LOOP

OpCuadrado:
titulo$ = "01: AREA Y PERIMETRO DEL CUADRADO": GOSUB Titulo
DO: INPUT "Lado del cuadrado (> 0): ", lado: LOOP UNTIL lado > 0
PRINT "Area      ="; lado * lado; " unidades cuadradas"
PRINT "Perimetro ="; 4 * lado; " unidades"
GOSUB DibujaCuadrado
GOSUB Pausa: RETURN

OpRectangulo:
titulo$ = "02: AREA Y PERIMETRO DEL RECTANGULO": GOSUB Titulo
DO: INPUT "Base (> 0): ", baseRect: LOOP UNTIL baseRect > 0
DO: INPUT "Altura (> 0): ", altura: LOOP UNTIL altura > 0
PRINT "Area      ="; baseRect * altura; " unidades cuadradas"
PRINT "Perimetro ="; 2 * (baseRect + altura); " unidades"
GOSUB DibujaRectangulo
GOSUB Pausa: RETURN

OpTriangulo:
titulo$ = "03: AREA Y PERIMETRO DEL TRIANGULO": GOSUB Titulo
DO: INPUT "Base (> 0): ", baseTri: LOOP UNTIL baseTri > 0
DO: INPUT "Altura (> 0): ", altura: LOOP UNTIL altura > 0
DO: INPUT "Lado 1 para perimetro (> 0): ", l1: LOOP UNTIL l1 > 0
DO: INPUT "Lado 2 para perimetro (> 0): ", l2: LOOP UNTIL l2 > 0
PRINT "Area      ="; baseTri * altura / 2; " unidades cuadradas"
PRINT "Perimetro ="; baseTri + l1 + l2; " unidades"
GOSUB DibujaTriangulo
GOSUB Pausa: RETURN

OpCirculo:
titulo$ = "04: AREA Y CIRCUNFERENCIA DEL CIRCULO": GOSUB Titulo
pi = 4 * ATN(1)
DO: INPUT "Radio (> 0): ", radio: LOOP UNTIL radio > 0
PRINT "Area           ="; pi * radio * radio; " unidades cuadradas"
PRINT "Circunferencia ="; 2 * pi * radio; " unidades"
GOSUB DibujaCirculo
GOSUB Pausa: RETURN

OpRombo:
titulo$ = "05: AREA Y PERIMETRO DEL ROMBO": GOSUB Titulo
DO: INPUT "Diagonal mayor (> 0): ", dmayor: LOOP UNTIL dmayor > 0
DO: INPUT "Diagonal menor (> 0): ", dmenor: LOOP UNTIL dmenor > 0
DO: INPUT "Lado del rombo (> 0): ", lado: LOOP UNTIL lado > 0
PRINT "Area      ="; dmayor * dmenor / 2; " unidades cuadradas"
PRINT "Perimetro ="; 4 * lado; " unidades"
GOSUB DibujaRombo
GOSUB Pausa: RETURN

OpTrapecio:
titulo$ = "06: AREA Y PERIMETRO DEL TRAPECIO": GOSUB Titulo
DO: INPUT "Base mayor (> 0): ", bmayor: LOOP UNTIL bmayor > 0
DO: INPUT "Base menor (> 0): ", bmenor: LOOP UNTIL bmenor > 0
DO: INPUT "Altura (> 0): ", altura: LOOP UNTIL altura > 0
DO: INPUT "Lado no paralelo 1 (> 0): ", l1: LOOP UNTIL l1 > 0
DO: INPUT "Lado no paralelo 2 (> 0): ", l2: LOOP UNTIL l2 > 0
PRINT "Area      ="; (bmayor + bmenor) * altura / 2; " unidades cuadradas"
PRINT "Perimetro ="; bmayor + bmenor + l1 + l2; " unidades"
GOSUB DibujaTrapecio
GOSUB Pausa: RETURN

OpPoligono:
titulo$ = "38: AREA DEL POLIGONO REGULAR": GOSUB Titulo
pi = 4 * ATN(1)
DO: INPUT "Numero de lados (>= 3): ", n: LOOP UNTIL n >= 3
DO: INPUT "Longitud de cada lado (> 0): ", lado: LOOP UNTIL lado > 0
perimetro = n * lado
apotema = lado / (2 * TAN(pi / n))
PRINT "Perimetro ="; perimetro; " unidades"
PRINT "Apotema   ="; apotema; " unidades"
PRINT "Area      ="; perimetro * apotema / 2; " unidades cuadradas"
GOSUB DibujaPoligono
GOSUB Pausa: RETURN

DibujaCuadrado:
LOCATE 15, 32: PRINT "+----------+"
LOCATE 16, 32: PRINT "|          |"
LOCATE 17, 32: PRINT "|          |"
LOCATE 18, 32: PRINT "+----------+"
RETURN

DibujaRectangulo:
LOCATE 15, 29: PRINT "+----------------+"
LOCATE 16, 29: PRINT "|                |"
LOCATE 17, 29: PRINT "+----------------+"
RETURN

DibujaTriangulo:
LOCATE 14, 36: PRINT "    /\"
LOCATE 15, 36: PRINT "   /  \"
LOCATE 16, 36: PRINT "  /    \"
LOCATE 17, 36: PRINT " /      \"
LOCATE 18, 36: PRINT "/________\"
RETURN

DibujaCirculo:
LOCATE 14, 34: PRINT "   ****"
LOCATE 15, 34: PRINT " *      *"
LOCATE 16, 34: PRINT "*        *"
LOCATE 17, 34: PRINT " *      *"
LOCATE 18, 34: PRINT "   ****"
RETURN

DibujaRombo:
LOCATE 14, 38: PRINT "   /\"
LOCATE 15, 38: PRINT "  /  \"
LOCATE 16, 38: PRINT " /    \"
LOCATE 17, 38: PRINT " \    /"
LOCATE 18, 38: PRINT "  \  /"
LOCATE 19, 38: PRINT "   \/"
RETURN

DibujaTrapecio:
LOCATE 15, 33: PRINT "   ______"
LOCATE 16, 33: PRINT "  /      \"
LOCATE 17, 33: PRINT " /        \"
LOCATE 18, 33: PRINT "/__________\"
RETURN

DibujaPoligono:
LOCATE 14, 35: PRINT "  ______"
LOCATE 15, 35: PRINT " /      \"
LOCATE 16, 35: PRINT "/        \"
LOCATE 17, 35: PRINT "\        /"
LOCATE 18, 35: PRINT " \______/"
RETURN
