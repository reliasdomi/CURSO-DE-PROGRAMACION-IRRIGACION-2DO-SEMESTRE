' 41: MATRIZ TRANSPUESTA - Grupo 4A
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
LOCATE 6, 30: PRINT "41: MATRIZ TRANSPUESTA"
COLOR 15, 1
LOCATE 8, 18
DIM a(10, 10), t(10, 10)
DO: INPUT "Filas (1 a 10): ", m: LOOP UNTIL m >= 1 AND m <= 10
DO: INPUT "Columnas (1 a 10): ", n: LOOP UNTIL n >= 1 AND n <= 10
FOR i = 1 TO m: FOR j = 1 TO n: LOCATE CSRLIN, 18: PRINT "A("; i; ","; j; "): ";: INPUT a(i, j): t(j, i) = a(i, j): NEXT j: NEXT i
LOCATE CSRLIN, 18: PRINT: LOCATE CSRLIN, 18: PRINT "Transpuesta": FOR i = 1 TO n: FOR j = 1 TO m: LOCATE CSRLIN, 18: PRINT t(i, j);: NEXT j: LOCATE CSRLIN, 18: PRINT: NEXT i

COLOR 13, 1
LOCATE 23, 27: PRINT "Pulse ENTER para terminar...";
LINE INPUT pausa$
COLOR 15, 0
CLS
LOCATE 11, 32: PRINT "+----------------+"
LOCATE 12, 32: PRINT "|    GRACIAS     |"
LOCATE 13, 32: PRINT "+----------------+"
END
