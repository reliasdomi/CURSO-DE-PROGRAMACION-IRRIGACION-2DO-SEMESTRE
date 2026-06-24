' 42: MATRIZ INVERSA 2X2 - Grupo 4A
' Universidad Autonoma Chapingo - Departamento de Irrigacion
' Programa corregido para QBasic/QB64
' Autores:
' Bistrain Borraz Angel Gabriel
' Cruz Sibaja Gibran Francisco
' Elias Dominguez Ruben
' Ortiz Ugarte Jonatan
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
COLOR 14, 1
LOCATE 6, 30: PRINT "42: MATRIZ INVERSA 2X2"
COLOR 15, 1
LOCATE 8, 18
DIM a(2, 2)
FOR i = 1 TO 2: FOR j = 1 TO 2: LOCATE CSRLIN, 18: PRINT "A("; i; ","; j; "): ";: INPUT a(i, j): NEXT j: NEXT i
det = a(1, 1) * a(2, 2) - a(1, 2) * a(2, 1)
LOCATE CSRLIN, 18: PRINT: LOCATE CSRLIN, 18: PRINT "Determinante ="; det
IF det = 0 THEN PRINT "La matriz no tiene inversa." ELSE PRINT "Inversa:": LOCATE CSRLIN, 18: PRINT a(2, 2) / det; -a(1, 2) / det: LOCATE CSRLIN, 18: PRINT -a(2, 1) / det; a(1, 1) / det

COLOR 13, 1
LOCATE 23, 27: PRINT "Pulse ENTER para terminar...";
LINE INPUT pausa$
COLOR 15, 0
CLS
LOCATE 11, 32: PRINT "+----------------+"
LOCATE 12, 32: PRINT "|    GRACIAS     |"
LOCATE 13, 32: PRINT "+----------------+"
END
