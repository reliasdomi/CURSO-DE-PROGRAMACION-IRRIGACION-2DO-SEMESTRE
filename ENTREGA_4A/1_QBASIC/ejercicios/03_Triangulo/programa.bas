' 03: AREA Y PERIMETRO DEL TRIANGULO - Grupo 4A
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
LOCATE 6, 24: PRINT "03: AREA Y PERIMETRO DEL TRIANGULO"
COLOR 15, 1
LOCATE 8, 18
DO: INPUT "Base (> 0): ", baseTri: LOOP UNTIL baseTri > 0
DO: INPUT "Altura (> 0): ", altura: LOOP UNTIL altura > 0
DO: INPUT "Lado 1 para perimetro (> 0): ", l1: LOOP UNTIL l1 > 0
DO: INPUT "Lado 2 para perimetro (> 0): ", l2: LOOP UNTIL l2 > 0
LOCATE CSRLIN, 18: PRINT: LOCATE CSRLIN, 18: PRINT "Area      ="; baseTri * altura / 2; " unidades cuadradas"
LOCATE CSRLIN, 18: PRINT "Perimetro ="; baseTri + l1 + l2; " unidades"
GOSUB DibujaTriangulo

COLOR 13, 1
LOCATE 23, 27: PRINT "Pulse ENTER para terminar...";
LINE INPUT pausa$
COLOR 15, 0
CLS
LOCATE 11, 32: PRINT "+----------------+"
LOCATE 12, 32: PRINT "|    GRACIAS     |"
LOCATE 13, 32: PRINT "+----------------+"
END

DibujaTriangulo:
LOCATE 14, 36: PRINT "    /\"
LOCATE 15, 36: PRINT "   /  \"
LOCATE 16, 36: PRINT "  /    \"
LOCATE 17, 36: PRINT " /      \"
LOCATE 18, 36: PRINT "/________\"
RETURN
