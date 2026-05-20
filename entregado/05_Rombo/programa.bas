' 05: AREA Y PERIMETRO DEL ROMBO - Grupo 4A
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
LOCATE 6, 26: PRINT "05: AREA Y PERIMETRO DEL ROMBO"
COLOR 15, 1
LOCATE 8, 18
DO: INPUT "Diagonal mayor (> 0): ", dmayor: LOOP UNTIL dmayor > 0
DO: INPUT "Diagonal menor (> 0): ", dmenor: LOOP UNTIL dmenor > 0
DO: INPUT "Lado del rombo (> 0): ", lado: LOOP UNTIL lado > 0
LOCATE CSRLIN, 18: PRINT: LOCATE CSRLIN, 18: PRINT "Area      ="; dmayor * dmenor / 2; " unidades cuadradas"
LOCATE CSRLIN, 18: PRINT "Perimetro ="; 4 * lado; " unidades"
GOSUB DibujaRombo

COLOR 13, 1
LOCATE 23, 27: PRINT "Pulse ENTER para terminar...";
LINE INPUT pausa$
COLOR 15, 0
CLS
LOCATE 11, 32: PRINT "+----------------+"
LOCATE 12, 32: PRINT "|    GRACIAS     |"
LOCATE 13, 32: PRINT "+----------------+"
END

DibujaRombo:
LOCATE 14, 38: PRINT "   /\"
LOCATE 15, 38: PRINT "  /  \"
LOCATE 16, 38: PRINT " /    \"
LOCATE 17, 38: PRINT " \    /"
LOCATE 18, 38: PRINT "  \  /"
LOCATE 19, 38: PRINT "   \/"
RETURN
