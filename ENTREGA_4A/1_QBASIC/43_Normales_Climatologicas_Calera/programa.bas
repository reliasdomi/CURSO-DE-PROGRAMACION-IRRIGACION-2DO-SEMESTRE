' 43: NORMALES CLIMATOLOGICAS DE CALERA, ZACATECAS - Grupo 4A
' Universidad Autonoma Chapingo - Departamento de Irrigacion
' Programa para QB64/QBasic: lee un CSV y realiza operaciones estadisticas
' Autores:
' Bistrain Borraz Angel Gabriel
' Cruz Sibaja Gibran Francisco
' Elias Dominguez Ruben
' Torres Valencia Mario Alberto

DIM nombre$(20), mes$(13), datos(20, 13)
DIM archivo$, encabezado$, linea$, resto$, campo$, titulo$
DIM nvar, op, sel, sel1, sel2, i, j, lugar
DIM suma, prom, mayor, menor, dif

archivo$ = "normales_calera.csv"
GOSUB CargarMeses
GOSUB CargarDatos

DO
    titulo$ = "43: NORMALES CLIMATOLOGICAS - CALERA, ZAC."
    GOSUB Titulo
    LOCATE 8, 18: PRINT "Estacion : 32003 Calera"
    LOCATE 9, 18: PRINT "Estado   : Zacatecas"
    LOCATE 10, 18: PRINT "Periodo  : Normal climatologica 1991-2020"
    LOCATE 12, 18: PRINT "1. Ver datos de una variable"
    LOCATE 13, 18: PRINT "2. Calcular promedio mensual"
    LOCATE 14, 18: PRINT "3. Mostrar mes con mayor y menor valor"
    LOCATE 15, 18: PRINT "4. Mostrar valor anual"
    LOCATE 16, 18: PRINT "5. Comparar dos variables por mes"
    LOCATE 17, 18: PRINT "6. Mostrar todos los datos"
    LOCATE 18, 18: PRINT "7. Salir"
    LOCATE 21, 24: INPUT "Seleccione una opcion: ", op

    SELECT CASE op
        CASE 1
            titulo$ = "VER DATOS DE UNA VARIABLE": GOSUB Titulo
            GOSUB ElegirVariable
            GOSUB MostrarVariable
            GOSUB Pausa
        CASE 2
            titulo$ = "PROMEDIO MENSUAL": GOSUB Titulo
            GOSUB ElegirVariable
            GOSUB PromedioMensual
            GOSUB Pausa
        CASE 3
            titulo$ = "MAYOR Y MENOR": GOSUB Titulo
            GOSUB ElegirVariable
            GOSUB MayorMenor
            GOSUB Pausa
        CASE 4
            titulo$ = "VALOR ANUAL": GOSUB Titulo
            GOSUB ElegirVariable
            PRINT
            PRINT "Variable: "; nombre$(sel)
            PRINT "Valor anual reportado: "; datos(sel, 13)
            GOSUB Pausa
        CASE 5
            titulo$ = "COMPARAR VARIABLES": GOSUB Titulo
            PRINT "Primera variable:"
            GOSUB ElegirVariable
            sel1 = sel
            PRINT
            PRINT "Segunda variable:"
            GOSUB ElegirVariable
            sel2 = sel
            GOSUB CompararVariables
            GOSUB Pausa
        CASE 6
            FOR i = 1 TO nvar
                titulo$ = "TODOS LOS DATOS": GOSUB Titulo
                sel = i
                GOSUB MostrarVariable
                IF i < nvar THEN
                    PRINT
                    PRINT "Variable "; i; " de"; nvar; "."
                    GOSUB Pausa
                END IF
            NEXT i
            GOSUB Pausa
        CASE 7
            EXIT DO
    END SELECT
LOOP

COLOR 15, 0
CLS
LOCATE 11, 32: PRINT "+----------------+"
LOCATE 12, 32: PRINT "|    GRACIAS     |"
LOCATE 13, 32: PRINT "+----------------+"
END

CargarMeses:
mes$(1) = "ENE": mes$(2) = "FEB": mes$(3) = "MAR": mes$(4) = "ABR"
mes$(5) = "MAY": mes$(6) = "JUN": mes$(7) = "JUL": mes$(8) = "AGO"
mes$(9) = "SEP": mes$(10) = "OCT": mes$(11) = "NOV": mes$(12) = "DIC"
mes$(13) = "ANUAL"
RETURN

CargarDatos:
ON ERROR GOTO ErrorArchivo
OPEN archivo$ FOR INPUT AS #1
ON ERROR GOTO 0
LINE INPUT #1, encabezado$
nvar = 0
DO WHILE NOT EOF(1)
    LINE INPUT #1, linea$
    linea$ = LTRIM$(RTRIM$(linea$))
    IF LEN(linea$) > 0 THEN
        nvar = nvar + 1
        resto$ = linea$ + ","
        FOR j = 1 TO 14
            lugar = INSTR(resto$, ",")
            campo$ = LEFT$(resto$, lugar - 1)
            resto$ = MID$(resto$, lugar + 1)
            IF j = 1 THEN
                nombre$(nvar) = campo$
            ELSE
                datos(nvar, j - 1) = VAL(campo$)
            END IF
        NEXT j
    END IF
LOOP
CLOSE #1
IF nvar = 0 THEN GOTO ErrorArchivo
RETURN

ErrorArchivo:
COLOR 15, 1
CLS
PRINT "No se pudo leer el archivo: "; archivo$
PRINT
PRINT "Revise que normales_calera.csv este en la misma carpeta que programa.bas"
PRINT "y que conserve el formato indicado en analisis.txt."
PRINT
PRINT "Pulse ENTER para terminar...";
LINE INPUT pausa$
COLOR 15, 0
CLS
END

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
LOCATE 8, 10
RETURN

Pausa:
COLOR 13, 1
LOCATE 23, 25: PRINT "Pulse ENTER para continuar...";
LINE INPUT pausa$
COLOR 15, 1
RETURN

ElegirVariable:
PRINT "Variables disponibles:"
PRINT
FOR i = 1 TO nvar
    PRINT i; ". "; nombre$(i)
NEXT i
PRINT
DO
    INPUT "Seleccione una variable: ", sel
LOOP UNTIL sel >= 1 AND sel <= nvar
RETURN

MostrarVariable:
PRINT "Variable: "; nombre$(sel)
PRINT
PRINT "Mes        Valor"
PRINT "----------------"
FOR j = 1 TO 12
    PRINT mes$(j); "       "; datos(sel, j)
NEXT j
PRINT "ANUAL     "; datos(sel, 13)
RETURN

PromedioMensual:
suma = 0
FOR j = 1 TO 12
    suma = suma + datos(sel, j)
NEXT j
prom = suma / 12
PRINT
PRINT "Variable: "; nombre$(sel)
PRINT "Suma de los 12 meses ="; suma
PRINT "Promedio mensual     ="; prom
PRINT "Valor anual SMN      ="; datos(sel, 13)
RETURN

MayorMenor:
mayor = datos(sel, 1)
menor = datos(sel, 1)
imax = 1
imin = 1
FOR j = 2 TO 12
    IF datos(sel, j) > mayor THEN mayor = datos(sel, j): imax = j
    IF datos(sel, j) < menor THEN menor = datos(sel, j): imin = j
NEXT j
PRINT
PRINT "Variable: "; nombre$(sel)
PRINT "Mayor valor mensual: "; mes$(imax); " = "; mayor
PRINT "Menor valor mensual: "; mes$(imin); " = "; menor
PRINT "Valor anual SMN    : "; datos(sel, 13)
RETURN

CompararVariables:
titulo$ = "COMPARACION MENSUAL": GOSUB Titulo
PRINT nombre$(sel1); " contra "; nombre$(sel2)
PRINT
PRINT "Mes       V1        V2        Diferencia"
PRINT "----------------------------------------"
FOR j = 1 TO 12
    dif = datos(sel1, j) - datos(sel2, j)
    PRINT mes$(j); "      "; datos(sel1, j); "     "; datos(sel2, j); "     "; dif
NEXT j
PRINT
PRINT "Anual    "; datos(sel1, 13); "     "; datos(sel2, 13); "     "; datos(sel1, 13) - datos(sel2, 13)
RETURN
