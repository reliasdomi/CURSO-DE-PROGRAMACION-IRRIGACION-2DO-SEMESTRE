' 44: LECTOR GENERICO DE NORMALES CLIMATOLOGICAS SMN - Grupo 4A
' Universidad Autonoma Chapingo - Departamento de Irrigacion
' Programa para QB64: lee archivos TXT oficiales del SMN/CONAGUA
' Autores:
' Bistrain Borraz Angel Gabriel
' Cruz Sibaja Gibran Francisco
' Elias Dominguez Ruben
' Torres Valencia Mario Alberto

DECLARE SUB LimpiarDatos ()
DECLARE SUB CargarMeses ()
DECLARE SUB CargarArchivo ()
DECLARE SUB LeerNormal (linea$)
DECLARE SUB RevisarMetadatos (linea$)
DECLARE SUB Titulo ()
DECLARE SUB Pausa ()
DECLARE SUB ElegirVariable ()
DECLARE SUB MostrarDatosGenerales ()
DECLARE SUB MostrarVariable ()
DECLARE SUB PromedioMensual ()
DECLARE SUB MayorMenor ()
DECLARE SUB CompararVariables ()
DECLARE SUB MostrarTodasVariables ()
DECLARE FUNCTION Limpia$ (texto$)
DECLARE FUNCTION DespuesDosPuntos$ (texto$)
DECLARE FUNCTION Campo$ (texto$, num)

DIM SHARED nombreVariable$(50), datos(50, 13), mes$(13)
DIM SHARED archivo$, estacion$, nombreEstacion$, estado$, municipio$
DIM SHARED situacion$, latitud$, longitud$, altitud$, periodo$
DIM SHARED tituloPantalla$, errorCarga$, ultimoTitulo$, seccionActual$
DIM SHARED nvar, op, sel, sel1, sel2, i, j, imax, imin
DIM SHARED suma, prom, mayor, menor, dif, cargaCorrecta, pareceSMN

GOSUB Inicio

DO
    IF cargaCorrecta = 0 THEN
        tituloPantalla$ = "44: LECTOR DE NORMALES CLIMATOLOGICAS SMN"
        CALL Titulo
        LOCATE 9, 12: INPUT "Nombre del archivo de normales climatologicas: ", archivo$
        CALL CargarArchivo
        IF cargaCorrecta = 0 THEN
            tituloPantalla$ = "ERROR AL CARGAR ARCHIVO": CALL Titulo
            PRINT errorCarga$
            PRINT
            PRINT "Ejemplos incluidos:"
            PRINT "  calera.txt"
            PRINT "  aguascalientes.txt"
            PRINT "  guadalajara.txt"
            PRINT "  san_luis_potosi.txt"
            PRINT "  oaxaca_de_juarez.txt"
            CALL Pausa
        END IF
    ELSE
        tituloPantalla$ = "44: LECTOR DE NORMALES CLIMATOLOGICAS SMN"
        CALL Titulo
        LOCATE 8, 12: PRINT "Archivo  : "; archivo$
        LOCATE 9, 12: PRINT "Estacion : "; estacion$; " "; nombreEstacion$
        LOCATE 10, 12: PRINT "Estado   : "; estado$
        LOCATE 11, 12: PRINT "Periodo  : "; periodo$
        LOCATE 13, 18: PRINT "1. Mostrar datos generales de la estacion"
        LOCATE 14, 18: PRINT "2. Ver datos mensuales de una variable"
        LOCATE 15, 18: PRINT "3. Calcular promedio mensual"
        LOCATE 16, 18: PRINT "4. Mostrar mes con valor mayor y menor"
        LOCATE 17, 18: PRINT "5. Mostrar valor anual"
        LOCATE 18, 18: PRINT "6. Comparar dos variables"
        LOCATE 19, 18: PRINT "7. Mostrar todas las variables detectadas"
        LOCATE 20, 18: PRINT "8. Cargar otro archivo"
        LOCATE 21, 18: PRINT "9. Salir"
        LOCATE 23, 24: INPUT "Seleccione una opcion: ", op

        SELECT CASE op
            CASE 1
                tituloPantalla$ = "DATOS GENERALES": CALL Titulo
                CALL MostrarDatosGenerales
                CALL Pausa
            CASE 2
                tituloPantalla$ = "DATOS MENSUALES": CALL Titulo
                CALL ElegirVariable
                CALL MostrarVariable
                CALL Pausa
            CASE 3
                tituloPantalla$ = "PROMEDIO MENSUAL": CALL Titulo
                CALL ElegirVariable
                CALL PromedioMensual
                CALL Pausa
            CASE 4
                tituloPantalla$ = "MAYOR Y MENOR": CALL Titulo
                CALL ElegirVariable
                CALL MayorMenor
                CALL Pausa
            CASE 5
                tituloPantalla$ = "VALOR ANUAL": CALL Titulo
                CALL ElegirVariable
                PRINT
                PRINT "Variable: "; nombreVariable$(sel)
                PRINT "Valor anual reportado: "; datos(sel, 13)
                CALL Pausa
            CASE 6
                tituloPantalla$ = "COMPARAR VARIABLES": CALL Titulo
                PRINT "Primera variable:"
                CALL ElegirVariable
                sel1 = sel
                PRINT
                PRINT "Segunda variable:"
                CALL ElegirVariable
                sel2 = sel
                CALL CompararVariables
                CALL Pausa
            CASE 7
                CALL MostrarTodasVariables
                CALL Pausa
            CASE 8
                cargaCorrecta = 0
            CASE 9
                EXIT DO
        END SELECT
    END IF
LOOP

COLOR 15, 0
CLS
LOCATE 11, 32: PRINT "+----------------+"
LOCATE 12, 32: PRINT "|    GRACIAS     |"
LOCATE 13, 32: PRINT "+----------------+"
END

Inicio:
CALL CargarMeses
cargaCorrecta = 0
RETURN

SUB CargarMeses
mes$(1) = "ENE": mes$(2) = "FEB": mes$(3) = "MAR": mes$(4) = "ABR"
mes$(5) = "MAY": mes$(6) = "JUN": mes$(7) = "JUL": mes$(8) = "AGO"
mes$(9) = "SEP": mes$(10) = "OCT": mes$(11) = "NOV": mes$(12) = "DIC"
mes$(13) = "ANUAL"
END SUB

SUB LimpiarDatos
FOR i = 1 TO 50
    nombreVariable$(i) = ""
    FOR j = 1 TO 13
        datos(i, j) = 0
    NEXT j
NEXT i
nvar = 0
estacion$ = "": nombreEstacion$ = "": estado$ = "": municipio$ = ""
situacion$ = "": latitud$ = "": longitud$ = "": altitud$ = ""
periodo$ = "": ultimoTitulo$ = "": seccionActual$ = ""
errorCarga$ = "": pareceSMN = 0
END SUB

SUB CargarArchivo
DIM linea$, lineaLimpia$, mayus$
CALL LimpiarDatos
archivo$ = Limpia$(archivo$)
IF archivo$ = "" THEN
    errorCarga$ = "No escribio ningun nombre de archivo."
    cargaCorrecta = 0
    EXIT SUB
END IF

IF _FILEEXISTS(archivo$) = 0 THEN
    errorCarga$ = "No se pudo abrir el archivo: " + archivo$
    cargaCorrecta = 0
    EXIT SUB
END IF
OPEN archivo$ FOR INPUT AS #1

DO WHILE NOT EOF(1)
    LINE INPUT #1, linea$
    lineaLimpia$ = Limpia$(linea$)
    mayus$ = UCASE$(lineaLimpia$)

    IF INSTR(mayus$, "SERVICIO METEOROLOGICO") > 0 OR INSTR(mayus$, "SERVICIO METEOROL") > 0 THEN pareceSMN = 1
    IF INSTR(mayus$, "NORMAL CLIMAT") > 0 THEN periodo$ = lineaLimpia$: pareceSMN = 1

    CALL RevisarMetadatos(lineaLimpia$)

    IF LEFT$(mayus$, 5) = "MESES" THEN
        seccionActual$ = ultimoTitulo$
    ELSEIF LEFT$(mayus$, 6) = "NORMAL" THEN
        CALL LeerNormal(lineaLimpia$)
    ELSEIF lineaLimpia$ <> "" THEN
        IF INSTR(lineaLimpia$, ":") = 0 AND LEFT$(mayus$, 4) <> "A" + CHR$(165) + "O " THEN
            IF LEFT$(mayus$, 6) <> "MAXIMA" AND LEFT$(mayus$, 6) <> "MINIMA" THEN
                IF LEFT$(mayus$, 5) <> "FECHA" AND LEFT$(mayus$, 6) <> "EMISIO" THEN
                    IF LEFT$(mayus$, 5) <> "DATOS" AND LEFT$(mayus$, 3) <> "CON" THEN
                        IF LEFT$(mayus$, 7) <> "COMISIO" AND LEFT$(mayus$, 6) <> "COORDI" AND LEFT$(mayus$, 4) <> "BASE" THEN
                            ultimoTitulo$ = lineaLimpia$
                        END IF
                    END IF
                END IF
            END IF
        END IF
    END IF
LOOP
CLOSE #1

IF pareceSMN = 0 THEN
    errorCarga$ = "El archivo no parece ser una normal climatologica del SMN/CONAGUA."
    cargaCorrecta = 0
    EXIT SUB
END IF
IF nvar = 0 THEN
    errorCarga$ = "No se encontro ninguna fila NORMAL con 13 valores numericos."
    cargaCorrecta = 0
    EXIT SUB
END IF
cargaCorrecta = 1
EXIT SUB
END SUB

SUB RevisarMetadatos (linea$)
DIM mayus$
mayus$ = UCASE$(linea$)
IF INSTR(mayus$, "ESTACI") > 0 AND INSTR(linea$, ":") > 0 THEN estacion$ = DespuesDosPuntos$(linea$)
IF INSTR(mayus$, "NOMBRE") > 0 AND INSTR(linea$, ":") > 0 THEN nombreEstacion$ = DespuesDosPuntos$(linea$)
IF INSTR(mayus$, "ESTADO") > 0 AND INSTR(linea$, ":") > 0 THEN estado$ = DespuesDosPuntos$(linea$)
IF INSTR(mayus$, "MUNICIPIO") > 0 AND INSTR(linea$, ":") > 0 THEN municipio$ = DespuesDosPuntos$(linea$)
IF INSTR(mayus$, "SITUACI") > 0 AND INSTR(linea$, ":") > 0 THEN situacion$ = DespuesDosPuntos$(linea$)
IF INSTR(mayus$, "LATITUD") > 0 AND INSTR(linea$, ":") > 0 THEN latitud$ = DespuesDosPuntos$(linea$)
IF INSTR(mayus$, "LONGITUD") > 0 AND INSTR(linea$, ":") > 0 THEN longitud$ = DespuesDosPuntos$(linea$)
IF INSTR(mayus$, "ALTITUD") > 0 AND INSTR(linea$, ":") > 0 THEN altitud$ = DespuesDosPuntos$(linea$)
END SUB

SUB LeerNormal (linea$)
DIM k, valor$
IF seccionActual$ = "" THEN EXIT SUB
IF nvar >= 50 THEN EXIT SUB
IF Campo$(linea$, 14) = "" THEN EXIT SUB
nvar = nvar + 1
nombreVariable$(nvar) = seccionActual$
FOR k = 1 TO 13
    valor$ = Campo$(linea$, k + 1)
    datos(nvar, k) = VAL(valor$)
NEXT k
END SUB

SUB MostrarDatosGenerales
PRINT "Archivo   : "; archivo$
PRINT "Periodo   : "; periodo$
PRINT "Estacion  : "; estacion$
PRINT "Nombre    : "; nombreEstacion$
PRINT "Estado    : "; estado$
PRINT "Municipio : "; municipio$
PRINT "Situacion : "; situacion$
PRINT "Latitud   : "; latitud$
PRINT "Longitud  : "; longitud$
PRINT "Altitud   : "; altitud$
PRINT
PRINT "Variables detectadas:"; nvar
END SUB

SUB ElegirVariable
PRINT "Variables disponibles:"
PRINT
FOR i = 1 TO nvar
    PRINT i; ". "; nombreVariable$(i)
NEXT i
PRINT
DO
    INPUT "Seleccione una variable: ", sel
LOOP UNTIL sel >= 1 AND sel <= nvar
END SUB

SUB MostrarVariable
PRINT
PRINT "Variable: "; nombreVariable$(sel)
PRINT
PRINT "Mes        Valor"
PRINT "----------------"
FOR j = 1 TO 12
    PRINT mes$(j); "       "; datos(sel, j)
NEXT j
PRINT "ANUAL     "; datos(sel, 13)
END SUB

SUB PromedioMensual
suma = 0
FOR j = 1 TO 12
    suma = suma + datos(sel, j)
NEXT j
prom = suma / 12
PRINT
PRINT "Variable: "; nombreVariable$(sel)
PRINT "Suma de los 12 meses ="; suma
PRINT "Promedio mensual     ="; prom
PRINT "Valor anual SMN      ="; datos(sel, 13)
END SUB

SUB MayorMenor
mayor = datos(sel, 1)
menor = datos(sel, 1)
imax = 1
imin = 1
FOR j = 2 TO 12
    IF datos(sel, j) > mayor THEN mayor = datos(sel, j): imax = j
    IF datos(sel, j) < menor THEN menor = datos(sel, j): imin = j
NEXT j
PRINT
PRINT "Variable: "; nombreVariable$(sel)
PRINT "Mayor valor mensual: "; mes$(imax); " = "; mayor
PRINT "Menor valor mensual: "; mes$(imin); " = "; menor
PRINT "Valor anual SMN    : "; datos(sel, 13)
END SUB

SUB CompararVariables
tituloPantalla$ = "COMPARACION MENSUAL": CALL Titulo
PRINT nombreVariable$(sel1); " contra "; nombreVariable$(sel2)
PRINT
PRINT "Mes       V1        V2        Diferencia"
PRINT "----------------------------------------"
FOR j = 1 TO 12
    dif = datos(sel1, j) - datos(sel2, j)
    PRINT mes$(j); "      "; datos(sel1, j); "     "; datos(sel2, j); "     "; dif
NEXT j
PRINT
PRINT "Anual    "; datos(sel1, 13); "     "; datos(sel2, 13); "     "; datos(sel1, 13) - datos(sel2, 13)
END SUB

SUB MostrarTodasVariables
FOR i = 1 TO nvar
    tituloPantalla$ = "VARIABLES DETECTADAS": CALL Titulo
    sel = i
    CALL MostrarVariable
    IF i < nvar THEN
        PRINT
        PRINT "Variable "; i; " de"; nvar; "."
        CALL Pausa
    END IF
NEXT i
END SUB

SUB Titulo
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
LOCATE 6, INT((80 - LEN(tituloPantalla$)) / 2) + 1: PRINT tituloPantalla$
COLOR 15, 1
LOCATE 8, 10
END SUB

SUB Pausa
COLOR 13, 1
LOCATE 23, 25: PRINT "Pulse ENTER para continuar...";
LINE INPUT espera$
COLOR 15, 1
END SUB

FUNCTION Limpia$ (texto$)
DIM t$
t$ = texto$
DO WHILE INSTR(t$, CHR$(9)) > 0
    MID$(t$, INSTR(t$, CHR$(9)), 1) = " "
LOOP
Limpia$ = LTRIM$(RTRIM$(t$))
END FUNCTION

FUNCTION DespuesDosPuntos$ (texto$)
DIM p
p = INSTR(texto$, ":")
IF p > 0 THEN
    DespuesDosPuntos$ = Limpia$(MID$(texto$, p + 1))
ELSE
    DespuesDosPuntos$ = ""
END IF
END FUNCTION

FUNCTION Campo$ (texto$, num)
DIM t$, c$, p, cuenta
t$ = Limpia$(texto$)
cuenta = 0
DO WHILE t$ <> ""
    t$ = LTRIM$(t$)
    p = INSTR(t$, " ")
    IF p = 0 THEN
        c$ = t$
        t$ = ""
    ELSE
        c$ = LEFT$(t$, p - 1)
        t$ = MID$(t$, p + 1)
    END IF
    IF c$ <> "" THEN
        cuenta = cuenta + 1
        IF cuenta = num THEN
            Campo$ = c$
            EXIT FUNCTION
        END IF
    END IF
LOOP
Campo$ = ""
END FUNCTION
