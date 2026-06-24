' 36: REGRESION LINEAL SIMPLE - Grupo 4A
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
LOCATE 6, 27: PRINT "36: REGRESION LINEAL SIMPLE"
COLOR 15, 1
LOCATE 8, 18
DIM x(100), y(100)
DO: INPUT "Cuantos pares de datos (2 a 100): ", n: LOOP UNTIL n >= 2 AND n <= 100
sx = 0: sy = 0: sxy = 0: sx2 = 0
FOR i = 1 TO n: LOCATE CSRLIN, 18: PRINT "X("; i; "): ";: INPUT x(i): LOCATE CSRLIN, 18: PRINT "Y("; i; "): ";: INPUT y(i): sx = sx + x(i): sy = sy + y(i): sxy = sxy + x(i) * y(i): sx2 = sx2 + x(i) * x(i): NEXT i
den = n * sx2 - sx * sx
LOCATE CSRLIN, 18: PRINT: IF den = 0 THEN PRINT "No se puede calcular: X no varia." ELSE b = (n * sxy - sx * sy) / den: a = (sy - b * sx) / n: LOCATE CSRLIN, 18: PRINT "Y = a + bX": LOCATE CSRLIN, 18: PRINT "a ="; a: LOCATE CSRLIN, 18: PRINT "b ="; b

COLOR 13, 1
LOCATE 23, 27: PRINT "Pulse ENTER para terminar...";
LINE INPUT pausa$
COLOR 15, 0
CLS
LOCATE 11, 32: PRINT "+----------------+"
LOCATE 12, 32: PRINT "|    GRACIAS     |"
LOCATE 13, 32: PRINT "+----------------+"
END
