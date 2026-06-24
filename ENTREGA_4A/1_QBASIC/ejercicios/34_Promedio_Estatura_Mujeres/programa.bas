' 34: PROMEDIO ESTATURA MUJERES - Grupo 4A
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
LOCATE 6, 26: PRINT "34: PROMEDIO ESTATURA MUJERES"
COLOR 15, 1
LOCATE 8, 18
DIM nombre$(100), sexo$(100), edad(100), est(100)
DO: INPUT "Cuantas personas hay en el grupo (1 a 100): ", n: LOOP UNTIL n >= 1 AND n <= 100
FOR i = 1 TO n
    PRINT: LOCATE CSRLIN, 18: PRINT "Persona"; i; " de"; n
    INPUT "Nombre: ", nombre$(i)
    DO: INPUT "Sexo (H/M): ", sexo$(i): sexo$(i) = UCASE$(sexo$(i)): LOOP UNTIL sexo$(i) = "H" OR sexo$(i) = "M"
    DO: INPUT "Edad en anos (>= 0): ", edad(i): LOOP UNTIL edad(i) >= 0
    DO: INPUT "Estatura en metros (> 0): ", est(i): LOOP UNTIL est(i) > 0
NEXT i
LOCATE CSRLIN, 18: PRINT: LOCATE CSRLIN, 18: PRINT "RESULTADOS": LOCATE CSRLIN, 18: PRINT "----------"
suma=0: cont=0: FOR i=1 TO n: IF sexo$(i)="M" THEN suma=suma+est(i): cont=cont+1
NEXT i
IF cont=0 THEN PRINT "No hay mujeres." ELSE PRINT "Promedio de estatura de mujeres:"; suma/cont; " m"

COLOR 13, 1
LOCATE 23, 27: PRINT "Pulse ENTER para terminar...";
LINE INPUT pausa$
COLOR 15, 0
CLS
LOCATE 11, 32: PRINT "+----------------+"
LOCATE 12, 32: PRINT "|    GRACIAS     |"
LOCATE 13, 32: PRINT "+----------------+"
END
