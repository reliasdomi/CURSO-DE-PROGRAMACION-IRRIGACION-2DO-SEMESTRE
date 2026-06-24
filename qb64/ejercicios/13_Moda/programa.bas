' 13: MODA - Grupo 4A
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
LOCATE 6, 37: PRINT "13: MODA"
COLOR 15, 1
LOCATE 8, 18
DIM datos(100)
DO: INPUT "Cuantos datos va a capturar (1 a 100): ", n: LOOP UNTIL n >= 1 AND n <= 100
FOR i = 1 TO n: LOCATE CSRLIN, 18: PRINT "Dato"; i; ": ";: INPUT datos(i): NEXT i
maxfreq = 0: moda = datos(1)
FOR i = 1 TO n: cont = 0: FOR j = 1 TO n: IF datos(j) = datos(i) THEN cont = cont + 1
NEXT j: IF cont > maxfreq THEN maxfreq = cont: moda = datos(i)
NEXT i
LOCATE CSRLIN, 18: PRINT: IF maxfreq = 1 THEN PRINT "No hay moda: todos aparecen una vez." ELSE PRINT "Moda ="; moda: LOCATE CSRLIN, 18: PRINT "Frecuencia ="; maxfreq

COLOR 13, 1
LOCATE 23, 27: PRINT "Pulse ENTER para terminar...";
LINE INPUT pausa$
COLOR 15, 0
CLS
LOCATE 11, 32: PRINT "+----------------+"
LOCATE 12, 32: PRINT "|    GRACIAS     |"
LOCATE 13, 32: PRINT "+----------------+"
END
