' 38: AREA DEL POLIGONO REGULAR - Grupo 4A
' Universidad Autonoma Chapingo - Departamento de Irrigacion
' Programa corregido para QBasic/QB64
' Autores:
' Bistrain Borraz Angel Gabriel
' Cruz Sibaja Gibran Francisco
' Elias Dominguez Ruben
' Torres Valencia Mario Alberto

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
LOCATE 6, 26: PRINT "38: AREA DEL POLIGONO REGULAR"
COLOR 15, 1
LOCATE 8, 18
pi = 4 * ATN(1)
DO: INPUT "Numero de lados (>= 3): ", n: LOOP UNTIL n >= 3
DO: INPUT "Longitud de cada lado (> 0): ", lado: LOOP UNTIL lado > 0
perimetro = n * lado: apotema = lado / (2 * TAN(pi / n))
LOCATE CSRLIN, 18: PRINT: LOCATE CSRLIN, 18: PRINT "Perimetro ="; perimetro; " unidades": LOCATE CSRLIN, 18: PRINT "Apotema ="; apotema; " unidades": LOCATE CSRLIN, 18: PRINT "Area ="; perimetro * apotema / 2; " unidades cuadradas"
GOSUB DibujaPoligono

COLOR 13, 1
LOCATE 23, 27: PRINT "Pulse ENTER para terminar...";
LINE INPUT pausa$
COLOR 15, 0
CLS
LOCATE 11, 32: PRINT "+----------------+"
LOCATE 12, 32: PRINT "|    GRACIAS     |"
LOCATE 13, 32: PRINT "+----------------+"
END

DibujaPoligono:
LOCATE 14, 35: PRINT "  ______"
LOCATE 15, 35: PRINT " /      \"
LOCATE 16, 35: PRINT "/        \"
LOCATE 17, 35: PRINT "\        /"
LOCATE 18, 35: PRINT " \______/"
RETURN
