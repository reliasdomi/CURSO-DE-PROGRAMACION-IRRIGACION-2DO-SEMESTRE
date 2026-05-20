' MENU PRINCIPAL - Grupo 4A
' Universidad Autonoma Chapingo - Departamento de Irrigacion
' Programas corregidos para QBasic/QB64
' Autores:
' Bistrain Borraz Angel Gabriel
' Cruz Sibaja Gibran Francisco
' Elias Dominguez Ruben
' Ortiz Ugarte Jonatan
' Torres Valencia Mario Alberto

DIM datos(100), x(100), y(100)
DIM matA(10, 10), matB(10, 10), matC(10, 10)
DIM nombre$(100), sexo$(100), edad(100), est(100)

DO
    titulo$ = "MENU PRINCIPAL - PROGRAMAS 4A"
    GOSUB Titulo
    LOCATE CSRLIN, 24: PRINT "1. Figuras geometricas"
    LOCATE CSRLIN, 24: PRINT "2. Estadistica"
    LOCATE CSRLIN, 24: PRINT "3. Matrices"
    LOCATE CSRLIN, 24: PRINT "4. Miscelaneos"
    LOCATE CSRLIN, 24: PRINT "5. Salir"
    PRINT
    LOCATE 21, 28: INPUT "Seleccione una opcion: ", op
    SELECT CASE op
        CASE 1: GOSUB MenuFiguras
        CASE 2: GOSUB MenuEstadistica
        CASE 3: GOSUB MenuMatrices
        CASE 4: GOSUB MenuMiscelaneos
        CASE 5: END
    END SELECT
LOOP

Pausa:
COLOR 13, 1
LOCATE 23, 26: PRINT "Pulse ENTER para continuar...";
LINE INPUT pausa$
RETURN

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
COLOR 14, 1
LOCATE 6, INT((80 - LEN(titulo$)) / 2) + 1: PRINT titulo$
COLOR 15, 1
LOCATE 8, 24
RETURN

LeerDatos:
DO
    INPUT "Cuantos datos va a capturar (1 a 100): ", n
LOOP UNTIL n >= 1 AND n <= 100
FOR i = 1 TO n
    PRINT "Dato"; i; ": ";
    INPUT datos(i)
NEXT i
RETURN

OrdenarAsc:
FOR i = 1 TO n - 1
    FOR j = 1 TO n - i
        IF datos(j) > datos(j + 1) THEN
            temp = datos(j)
            datos(j) = datos(j + 1)
            datos(j + 1) = temp
        END IF
    NEXT j
NEXT i
RETURN

CapturaGrupo:
DO
    INPUT "Cuantas personas hay en el grupo (1 a 100): ", n
LOOP UNTIL n >= 1 AND n <= 100
FOR i = 1 TO n
    PRINT
    PRINT "Persona"; i; " de"; n
    INPUT "Nombre: ", nombre$(i)
    DO
        INPUT "Sexo (H/M): ", sexo$(i)
        sexo$(i) = UCASE$(sexo$(i))
    LOOP UNTIL sexo$(i) = "H" OR sexo$(i) = "M"
    DO
        INPUT "Edad en anos (>= 0): ", edad(i)
    LOOP UNTIL edad(i) >= 0
    DO
        INPUT "Estatura en metros (> 0): ", est(i)
    LOOP UNTIL est(i) > 0
NEXT i
PRINT
PRINT "RESULTADOS"
PRINT "----------"
RETURN

CapturaDimMat:
DO
    INPUT "Filas (1 a 10): ", m
LOOP UNTIL m >= 1 AND m <= 10
DO
    INPUT "Columnas (1 a 10): ", n
LOOP UNTIL n >= 1 AND n <= 10
RETURN

MenuFiguras:
DO
    titulo$ = "FIGURAS GEOMETRICAS"
    GOSUB Titulo
    LOCATE 8, 24: PRINT "1. Cuadrado"
    LOCATE 9, 24: PRINT "2. Rectangulo"
    LOCATE 10, 24: PRINT "3. Triangulo"
    LOCATE 11, 24: PRINT "4. Circulo"
    LOCATE 12, 24: PRINT "5. Rombo"
    LOCATE 13, 24: PRINT "6. Trapecio"
    LOCATE 14, 24: PRINT "7. Poligono regular"
    LOCATE 15, 24: PRINT "8. Volver"
    LOCATE 21, 28: INPUT "Seleccione una opcion: ", op
    SELECT CASE op
        CASE 1: GOSUB OpCuadrado
        CASE 2: GOSUB OpRectangulo
        CASE 3: GOSUB OpTriangulo
        CASE 4: GOSUB OpCirculo
        CASE 5: GOSUB OpRombo
        CASE 6: GOSUB OpTrapecio
        CASE 7: GOSUB OpPoligono
        CASE 8: RETURN
    END SELECT
LOOP

MenuEstadistica:
DO
    titulo$ = "ESTADISTICA"
    GOSUB Titulo
    LOCATE 8, 24: PRINT "1. Media"
    LOCATE 9, 24: PRINT "2. Mediana"
    LOCATE 10, 24: PRINT "3. Moda"
    LOCATE 11, 24: PRINT "4. Ordenar menor a mayor"
    LOCATE 12, 24: PRINT "5. Ordenar mayor a menor"
    LOCATE 13, 24: PRINT "6. Estadistica de grupo"
    LOCATE 14, 24: PRINT "7. Regresion lineal"
    LOCATE 15, 24: PRINT "8. Varianza y desviacion estandar"
    LOCATE 16, 24: PRINT "9. Volver"
    LOCATE 21, 28: INPUT "Seleccione una opcion: ", op
    SELECT CASE op
        CASE 1: GOSUB OpMedia
        CASE 2: GOSUB OpMediana
        CASE 3: GOSUB OpModa
        CASE 4: GOSUB OpOrdenAsc
        CASE 5: GOSUB OpOrdenDesc
        CASE 6: GOSUB MenuGrupo
        CASE 7: GOSUB OpRegresion
        CASE 8: GOSUB OpDesviacion
        CASE 9: RETURN
    END SELECT
LOOP

MenuGrupo:
DO
    titulo$ = "ESTADISTICA DE GRUPO"
    GOSUB Titulo
    LOCATE 8, 6: PRINT "1. Hombres en el grupo"
    LOCATE 9, 6: PRINT "2. Mujeres en el grupo"
    LOCATE 10, 6: PRINT "3. Edad mayor y menor"
    LOCATE 11, 6: PRINT "4. Estatura mayor y menor"
    LOCATE 12, 6: PRINT "5. Edad mayor mujeres"
    LOCATE 13, 6: PRINT "6. Edad mayor hombres"
    LOCATE 14, 6: PRINT "7. Mayores de edad"
    LOCATE 15, 6: PRINT "8. Menores de edad"
    LOCATE 16, 6: PRINT "9. Mujeres mayores"
    LOCATE 17, 6: PRINT "10. Mujeres menores"
    LOCATE 18, 6: PRINT "11. Hombres mayores"
    LOCATE 8, 43: PRINT "12. Hombres menores"
    LOCATE 9, 43: PRINT "13. Estatura mujeres"
    LOCATE 10, 43: PRINT "14. Estatura hombres"
    LOCATE 11, 43: PRINT "15. Promedio edad grupo"
    LOCATE 12, 43: PRINT "16. Promedio estatura grupo"
    LOCATE 13, 43: PRINT "17. Promedio edad mujeres"
    LOCATE 14, 43: PRINT "18. Promedio edad hombres"
    LOCATE 15, 43: PRINT "19. Prom. estatura mujeres"
    LOCATE 16, 43: PRINT "20. Prom. estatura hombres"
    LOCATE 17, 43: PRINT "21. Volver"
    LOCATE 22, 28: INPUT "Seleccione una opcion: ", op
    SELECT CASE op
        CASE 1: GOSUB OpGrupo16
        CASE 2: GOSUB OpGrupo17
        CASE 3: GOSUB OpGrupo18
        CASE 4: GOSUB OpGrupo19
        CASE 5: GOSUB OpGrupo20
        CASE 6: GOSUB OpGrupo21
        CASE 7: GOSUB OpGrupo22
        CASE 8: GOSUB OpGrupo23
        CASE 9: GOSUB OpGrupo24
        CASE 10: GOSUB OpGrupo25
        CASE 11: GOSUB OpGrupo26
        CASE 12: GOSUB OpGrupo27
        CASE 13: GOSUB OpGrupo28
        CASE 14: GOSUB OpGrupo29
        CASE 15: GOSUB OpGrupo30
        CASE 16: GOSUB OpGrupo31
        CASE 17: GOSUB OpGrupo32
        CASE 18: GOSUB OpGrupo33
        CASE 19: GOSUB OpGrupo34
        CASE 20: GOSUB OpGrupo35
        CASE 21: RETURN
    END SELECT
LOOP

MenuMatrices:
DO
    titulo$ = "MATRICES"
    GOSUB Titulo
    LOCATE 8, 24: PRINT "1. Suma de matrices"
    LOCATE 9, 24: PRINT "2. Resta de matrices"
    LOCATE 10, 24: PRINT "3. Transpuesta"
    LOCATE 11, 24: PRINT "4. Inversa 2x2"
    LOCATE 12, 24: PRINT "5. Volver"
    LOCATE 21, 28: INPUT "Seleccione una opcion: ", op
    SELECT CASE op
        CASE 1: GOSUB OpMatSuma
        CASE 2: GOSUB OpMatResta
        CASE 3: GOSUB OpMatTrans
        CASE 4: GOSUB OpMatInv
        CASE 5: RETURN
    END SELECT
LOOP

MenuMiscelaneos:
DO
    titulo$ = "MISCELANEOS"
    GOSUB Titulo
    LOCATE 8, 24: PRINT "1. Par o impar"
    LOCATE 9, 24: PRINT "2. Formula cuadratica"
    LOCATE 10, 24: PRINT "3. Numero mayor"
    LOCATE 11, 24: PRINT "4. Numero menor"
    LOCATE 12, 24: PRINT "5. Volver"
    LOCATE 21, 28: INPUT "Seleccione una opcion: ", op
    SELECT CASE op
        CASE 1: GOSUB OpPar
        CASE 2: GOSUB OpCuadratica
        CASE 3: GOSUB OpMayor
        CASE 4: GOSUB OpMenor
        CASE 5: RETURN
    END SELECT
LOOP

OpCuadrado:
titulo$ = "01: AREA Y PERIMETRO DEL CUADRADO": GOSUB Titulo
DO: INPUT "Lado del cuadrado (> 0): ", lado: LOOP UNTIL lado > 0
PRINT "Area      ="; lado * lado; " unidades cuadradas"
PRINT "Perimetro ="; 4 * lado; " unidades"
GOSUB DibujaCuadrado
GOSUB Pausa: RETURN

OpRectangulo:
titulo$ = "02: AREA Y PERIMETRO DEL RECTANGULO": GOSUB Titulo
DO: INPUT "Base (> 0): ", baseRect: LOOP UNTIL baseRect > 0
DO: INPUT "Altura (> 0): ", altura: LOOP UNTIL altura > 0
PRINT "Area      ="; baseRect * altura; " unidades cuadradas"
PRINT "Perimetro ="; 2 * (baseRect + altura); " unidades"
GOSUB DibujaRectangulo
GOSUB Pausa: RETURN

OpTriangulo:
titulo$ = "03: AREA Y PERIMETRO DEL TRIANGULO": GOSUB Titulo
DO: INPUT "Base (> 0): ", baseTri: LOOP UNTIL baseTri > 0
DO: INPUT "Altura (> 0): ", altura: LOOP UNTIL altura > 0
DO: INPUT "Lado 1 para perimetro (> 0): ", l1: LOOP UNTIL l1 > 0
DO: INPUT "Lado 2 para perimetro (> 0): ", l2: LOOP UNTIL l2 > 0
PRINT "Area      ="; baseTri * altura / 2; " unidades cuadradas"
PRINT "Perimetro ="; baseTri + l1 + l2; " unidades"
GOSUB DibujaTriangulo
GOSUB Pausa: RETURN

OpCirculo:
titulo$ = "04: AREA Y CIRCUNFERENCIA DEL CIRCULO": GOSUB Titulo
pi = 4 * ATN(1)
DO: INPUT "Radio (> 0): ", radio: LOOP UNTIL radio > 0
PRINT "Area           ="; pi * radio * radio; " unidades cuadradas"
PRINT "Circunferencia ="; 2 * pi * radio; " unidades"
GOSUB DibujaCirculo
GOSUB Pausa: RETURN

OpRombo:
titulo$ = "05: AREA Y PERIMETRO DEL ROMBO": GOSUB Titulo
DO: INPUT "Diagonal mayor (> 0): ", dmayor: LOOP UNTIL dmayor > 0
DO: INPUT "Diagonal menor (> 0): ", dmenor: LOOP UNTIL dmenor > 0
DO: INPUT "Lado del rombo (> 0): ", lado: LOOP UNTIL lado > 0
PRINT "Area      ="; dmayor * dmenor / 2; " unidades cuadradas"
PRINT "Perimetro ="; 4 * lado; " unidades"
GOSUB DibujaRombo
GOSUB Pausa: RETURN

OpTrapecio:
titulo$ = "06: AREA Y PERIMETRO DEL TRAPECIO": GOSUB Titulo
DO: INPUT "Base mayor (> 0): ", bmayor: LOOP UNTIL bmayor > 0
DO: INPUT "Base menor (> 0): ", bmenor: LOOP UNTIL bmenor > 0
DO: INPUT "Altura (> 0): ", altura: LOOP UNTIL altura > 0
DO: INPUT "Lado no paralelo 1 (> 0): ", l1: LOOP UNTIL l1 > 0
DO: INPUT "Lado no paralelo 2 (> 0): ", l2: LOOP UNTIL l2 > 0
PRINT "Area      ="; (bmayor + bmenor) * altura / 2; " unidades cuadradas"
PRINT "Perimetro ="; bmayor + bmenor + l1 + l2; " unidades"
GOSUB DibujaTrapecio
GOSUB Pausa: RETURN

OpPoligono:
titulo$ = "38: AREA DEL POLIGONO REGULAR": GOSUB Titulo
pi = 4 * ATN(1)
DO: INPUT "Numero de lados (>= 3): ", n: LOOP UNTIL n >= 3
DO: INPUT "Longitud de cada lado (> 0): ", lado: LOOP UNTIL lado > 0
perimetro = n * lado
apotema = lado / (2 * TAN(pi / n))
PRINT "Perimetro ="; perimetro; " unidades"
PRINT "Apotema   ="; apotema; " unidades"
PRINT "Area      ="; perimetro * apotema / 2; " unidades cuadradas"
GOSUB DibujaPoligono
GOSUB Pausa: RETURN

OpMedia:
titulo$ = "11: MEDIA ARITMETICA": GOSUB Titulo
GOSUB LeerDatos
suma = 0: menor = datos(1): mayor = datos(1)
FOR i = 1 TO n
    suma = suma + datos(i)
    IF datos(i) < menor THEN menor = datos(i)
    IF datos(i) > mayor THEN mayor = datos(i)
NEXT i
PRINT "Suma ="; suma
PRINT "Media ="; suma / n
PRINT "Minimo ="; menor
PRINT "Maximo ="; mayor
GOSUB Pausa: RETURN

OpMediana:
titulo$ = "12: MEDIANA": GOSUB Titulo
GOSUB LeerDatos: GOSUB OrdenarAsc
IF n MOD 2 = 1 THEN mediana = datos((n + 1) / 2) ELSE mediana = (datos(n / 2) + datos(n / 2 + 1)) / 2
PRINT "Datos ordenados:"
FOR i = 1 TO n: PRINT datos(i);: NEXT i: PRINT
PRINT "Mediana ="; mediana
GOSUB Pausa: RETURN

OpModa:
titulo$ = "13: MODA": GOSUB Titulo
GOSUB LeerDatos
maxfreq = 0: moda = datos(1)
FOR i = 1 TO n
    cont = 0
    FOR j = 1 TO n
        IF datos(j) = datos(i) THEN cont = cont + 1
    NEXT j
    IF cont > maxfreq THEN maxfreq = cont: moda = datos(i)
NEXT i
IF maxfreq = 1 THEN PRINT "No hay moda: todos los datos aparecen una vez." ELSE PRINT "Moda ="; moda: PRINT "Frecuencia ="; maxfreq
GOSUB Pausa: RETURN

OpOrdenAsc:
titulo$ = "14: ORDENAR DE MENOR A MAYOR": GOSUB Titulo
GOSUB LeerDatos: GOSUB OrdenarAsc
FOR i = 1 TO n: PRINT datos(i);: NEXT i: PRINT
GOSUB Pausa: RETURN

OpOrdenDesc:
titulo$ = "15: ORDENAR DE MAYOR A MENOR": GOSUB Titulo
GOSUB LeerDatos
FOR i = 1 TO n - 1
    FOR j = 1 TO n - i
        IF datos(j) < datos(j + 1) THEN temp = datos(j): datos(j) = datos(j + 1): datos(j + 1) = temp
    NEXT j
NEXT i
FOR i = 1 TO n: PRINT datos(i);: NEXT i: PRINT
GOSUB Pausa: RETURN

OpRegresion:
titulo$ = "36: REGRESION LINEAL SIMPLE": GOSUB Titulo
DO: INPUT "Cuantos pares de datos (2 a 100): ", n: LOOP UNTIL n >= 2 AND n <= 100
sx = 0: sy = 0: sxy = 0: sx2 = 0
FOR i = 1 TO n
    PRINT "X("; i; "): ";: INPUT x(i)
    PRINT "Y("; i; "): ";: INPUT y(i)
    sx = sx + x(i): sy = sy + y(i): sxy = sxy + x(i) * y(i): sx2 = sx2 + x(i) * x(i)
NEXT i
den = n * sx2 - sx * sx
IF den = 0 THEN PRINT "No se puede calcular: todos los valores de X son iguales." ELSE b = (n * sxy - sx * sy) / den: a = (sy - b * sx) / n: PRINT "Y = a + bX": PRINT "a ="; a: PRINT "b ="; b
GOSUB Pausa: RETURN

OpDesviacion:
titulo$ = "37: VARIANZA Y DESVIACION ESTANDAR": GOSUB Titulo
GOSUB LeerDatos
suma = 0: menor = datos(1): mayor = datos(1)
FOR i = 1 TO n
    suma = suma + datos(i)
    IF datos(i) < menor THEN menor = datos(i)
    IF datos(i) > mayor THEN mayor = datos(i)
NEXT i
media = suma / n: sumdif = 0
FOR i = 1 TO n: sumdif = sumdif + (datos(i) - media) * (datos(i) - media): NEXT i
PRINT "Suma ="; suma: PRINT "Media ="; media: PRINT "Minimo ="; menor: PRINT "Maximo ="; mayor
PRINT "Varianza poblacional ="; sumdif / n
PRINT "Desv. estandar poblacional ="; SQR(sumdif / n)
IF n > 1 THEN PRINT "Varianza muestral ="; sumdif / (n - 1): PRINT "Desv. estandar muestral ="; SQR(sumdif / (n - 1)) ELSE PRINT "Muestral: requiere n > 1"
GOSUB Pausa: RETURN

OpPar:
titulo$ = "07: NUMERO PAR O IMPAR": GOSUB Titulo
INPUT "Escriba un numero entero: ", n
IF n MOD 2 = 0 THEN PRINT n; " es PAR" ELSE PRINT n; " es IMPAR"
GOSUB Pausa: RETURN

OpCuadratica:
titulo$ = "08: FORMULA CUADRATICA": GOSUB Titulo
DO: INPUT "Coeficiente A (A <> 0): ", a: LOOP UNTIL a <> 0
INPUT "Coeficiente B: ", b: INPUT "Coeficiente C: ", c
disc = b * b - 4 * a * c
PRINT "Discriminante ="; disc
IF disc < 0 THEN
    PRINT "No hay raices reales."
ELSEIF disc = 0 THEN
    PRINT "Una raiz real: X ="; -b / (2 * a)
ELSE
    PRINT "X1 ="; (-b + SQR(disc)) / (2 * a)
    PRINT "X2 ="; (-b - SQR(disc)) / (2 * a)
END IF
GOSUB Pausa: RETURN

OpMayor:
titulo$ = "09: NUMERO MAYOR": GOSUB Titulo
GOSUB LeerDatos
mayor = datos(1)
FOR i = 2 TO n: IF datos(i) > mayor THEN mayor = datos(i)
NEXT i
PRINT "El numero mayor es:"; mayor
GOSUB Pausa: RETURN

OpMenor:
titulo$ = "10: NUMERO MENOR": GOSUB Titulo
GOSUB LeerDatos
menor = datos(1)
FOR i = 2 TO n: IF datos(i) < menor THEN menor = datos(i)
NEXT i
PRINT "El numero menor es:"; menor
GOSUB Pausa: RETURN

OpGrupo16:
titulo$ = "ESTADISTICA DE GRUPO": GOSUB Titulo
GOSUB CapturaGrupo
cont = 0
FOR i = 1 TO n
    IF sexo$(i) = "H" THEN cont = cont + 1
NEXT i
PRINT "Numero de hombres:"; cont
GOSUB Pausa: RETURN

OpGrupo17:
titulo$ = "ESTADISTICA DE GRUPO": GOSUB Titulo
GOSUB CapturaGrupo
cont = 0
FOR i = 1 TO n
    IF sexo$(i) = "M" THEN cont = cont + 1
NEXT i
PRINT "Numero de mujeres:"; cont
GOSUB Pausa: RETURN

OpGrupo18:
titulo$ = "ESTADISTICA DE GRUPO": GOSUB Titulo
GOSUB CapturaGrupo
mayor = edad(1): menor = edad(1)
FOR i = 2 TO n
    IF edad(i) > mayor THEN mayor = edad(i)
    IF edad(i) < menor THEN menor = edad(i)
NEXT i
PRINT "Edad mayor:"; mayor
PRINT "Edad menor:"; menor
GOSUB Pausa: RETURN

OpGrupo19:
titulo$ = "ESTADISTICA DE GRUPO": GOSUB Titulo
GOSUB CapturaGrupo
mayor = est(1): menor = est(1)
FOR i = 2 TO n
    IF est(i) > mayor THEN mayor = est(i)
    IF est(i) < menor THEN menor = est(i)
NEXT i
PRINT "Estatura mayor:"; mayor; " m"
PRINT "Estatura menor:"; menor; " m"
GOSUB Pausa: RETURN

OpGrupo20:
titulo$ = "ESTADISTICA DE GRUPO": GOSUB Titulo
GOSUB CapturaGrupo
cont = 0
FOR i = 1 TO n
    IF sexo$(i) = "M" THEN
        IF cont = 0 THEN mayor = edad(i): menor = edad(i)
        IF edad(i) > mayor THEN mayor = edad(i)
        IF edad(i) < menor THEN menor = edad(i)
        cont = cont + 1
    END IF
NEXT i
IF cont = 0 THEN PRINT "No hay mujeres en el grupo." ELSE PRINT "Edad mayor mujeres:"; mayor: PRINT "Edad menor mujeres:"; menor
GOSUB Pausa: RETURN

OpGrupo21:
titulo$ = "ESTADISTICA DE GRUPO": GOSUB Titulo
GOSUB CapturaGrupo
cont = 0
FOR i = 1 TO n
    IF sexo$(i) = "H" THEN
        IF cont = 0 THEN mayor = edad(i): menor = edad(i)
        IF edad(i) > mayor THEN mayor = edad(i)
        IF edad(i) < menor THEN menor = edad(i)
        cont = cont + 1
    END IF
NEXT i
IF cont = 0 THEN PRINT "No hay hombres en el grupo." ELSE PRINT "Edad mayor hombres:"; mayor: PRINT "Edad menor hombres:"; menor
GOSUB Pausa: RETURN

OpGrupo22:
titulo$ = "ESTADISTICA DE GRUPO": GOSUB Titulo
GOSUB CapturaGrupo
cont = 0
FOR i = 1 TO n
    IF edad(i) >= 18 THEN cont = cont + 1
NEXT i
PRINT "Personas con 18 anos o mas:"; cont
GOSUB Pausa: RETURN

OpGrupo23:
titulo$ = "ESTADISTICA DE GRUPO": GOSUB Titulo
GOSUB CapturaGrupo
cont = 0
FOR i = 1 TO n
    IF edad(i) < 18 THEN cont = cont + 1
NEXT i
PRINT "Personas menores de 18 anos:"; cont
GOSUB Pausa: RETURN

OpGrupo24:
titulo$ = "ESTADISTICA DE GRUPO": GOSUB Titulo
GOSUB CapturaGrupo
cont = 0
FOR i = 1 TO n
    IF sexo$(i) = "M" AND edad(i) >= 18 THEN cont = cont + 1
NEXT i
PRINT "Mujeres con 18 anos o mas:"; cont
GOSUB Pausa: RETURN

OpGrupo25:
titulo$ = "ESTADISTICA DE GRUPO": GOSUB Titulo
GOSUB CapturaGrupo
cont = 0
FOR i = 1 TO n
    IF sexo$(i) = "M" AND edad(i) < 18 THEN cont = cont + 1
NEXT i
PRINT "Mujeres menores de edad:"; cont
GOSUB Pausa: RETURN

OpGrupo26:
titulo$ = "ESTADISTICA DE GRUPO": GOSUB Titulo
GOSUB CapturaGrupo
cont = 0
FOR i = 1 TO n
    IF sexo$(i) = "H" AND edad(i) >= 18 THEN cont = cont + 1
NEXT i
PRINT "Hombres con 18 anos o mas:"; cont
GOSUB Pausa: RETURN

OpGrupo27:
titulo$ = "ESTADISTICA DE GRUPO": GOSUB Titulo
GOSUB CapturaGrupo
cont = 0
FOR i = 1 TO n
    IF sexo$(i) = "H" AND edad(i) < 18 THEN cont = cont + 1
NEXT i
PRINT "Hombres menores de edad:"; cont
GOSUB Pausa: RETURN

OpGrupo28:
titulo$ = "ESTADISTICA DE GRUPO": GOSUB Titulo
GOSUB CapturaGrupo
cont = 0
FOR i = 1 TO n
    IF sexo$(i) = "M" THEN
        IF cont = 0 THEN mayor = est(i): menor = est(i)
        IF est(i) > mayor THEN mayor = est(i)
        IF est(i) < menor THEN menor = est(i)
        cont = cont + 1
    END IF
NEXT i
IF cont = 0 THEN PRINT "No hay mujeres en el grupo." ELSE PRINT "Estatura mayor mujeres:"; mayor; " m": PRINT "Estatura menor mujeres:"; menor; " m"
GOSUB Pausa: RETURN

OpGrupo29:
titulo$ = "ESTADISTICA DE GRUPO": GOSUB Titulo
GOSUB CapturaGrupo
cont = 0
FOR i = 1 TO n
    IF sexo$(i) = "H" THEN
        IF cont = 0 THEN mayor = est(i): menor = est(i)
        IF est(i) > mayor THEN mayor = est(i)
        IF est(i) < menor THEN menor = est(i)
        cont = cont + 1
    END IF
NEXT i
IF cont = 0 THEN PRINT "No hay hombres en el grupo." ELSE PRINT "Estatura mayor hombres:"; mayor; " m": PRINT "Estatura menor hombres:"; menor; " m"
GOSUB Pausa: RETURN

OpGrupo30:
titulo$ = "ESTADISTICA DE GRUPO": GOSUB Titulo
GOSUB CapturaGrupo
suma = 0
FOR i = 1 TO n
    suma = suma + edad(i)
NEXT i
PRINT "Promedio de edad del grupo:"; suma / n; " anos"
GOSUB Pausa: RETURN

OpGrupo31:
titulo$ = "ESTADISTICA DE GRUPO": GOSUB Titulo
GOSUB CapturaGrupo
suma = 0
FOR i = 1 TO n
    suma = suma + est(i)
NEXT i
PRINT "Promedio de estatura del grupo:"; suma / n; " m"
GOSUB Pausa: RETURN

OpGrupo32:
titulo$ = "ESTADISTICA DE GRUPO": GOSUB Titulo
GOSUB CapturaGrupo
suma = 0: cont = 0
FOR i = 1 TO n
    IF sexo$(i) = "M" THEN suma = suma + edad(i): cont = cont + 1
NEXT i
IF cont = 0 THEN PRINT "No hay mujeres en el grupo." ELSE PRINT "Promedio de edad de mujeres:"; suma / cont; " anos"
GOSUB Pausa: RETURN

OpGrupo33:
titulo$ = "ESTADISTICA DE GRUPO": GOSUB Titulo
GOSUB CapturaGrupo
suma = 0: cont = 0
FOR i = 1 TO n
    IF sexo$(i) = "H" THEN suma = suma + edad(i): cont = cont + 1
NEXT i
IF cont = 0 THEN PRINT "No hay hombres en el grupo." ELSE PRINT "Promedio de edad de hombres:"; suma / cont; " anos"
GOSUB Pausa: RETURN

OpGrupo34:
titulo$ = "ESTADISTICA DE GRUPO": GOSUB Titulo
GOSUB CapturaGrupo
suma = 0: cont = 0
FOR i = 1 TO n
    IF sexo$(i) = "M" THEN suma = suma + est(i): cont = cont + 1
NEXT i
IF cont = 0 THEN PRINT "No hay mujeres en el grupo." ELSE PRINT "Promedio de estatura de mujeres:"; suma / cont; " m"
GOSUB Pausa: RETURN

OpGrupo35:
titulo$ = "ESTADISTICA DE GRUPO": GOSUB Titulo
GOSUB CapturaGrupo
suma = 0: cont = 0
FOR i = 1 TO n
    IF sexo$(i) = "H" THEN suma = suma + est(i): cont = cont + 1
NEXT i
IF cont = 0 THEN PRINT "No hay hombres en el grupo." ELSE PRINT "Promedio de estatura de hombres:"; suma / cont; " m"
GOSUB Pausa: RETURN


OpMatSuma:
titulo$ = "39: SUMA DE MATRICES": GOSUB Titulo
GOSUB CapturaDimMat
PRINT "Capture matriz A": FOR i = 1 TO m: FOR j = 1 TO n: PRINT "A("; i; ","; j; "): ";: INPUT matA(i, j): NEXT j: NEXT i
PRINT "Capture matriz B": FOR i = 1 TO m: FOR j = 1 TO n: PRINT "B("; i; ","; j; "): ";: INPUT matB(i, j): matC(i, j) = matA(i, j) + matB(i, j): NEXT j: NEXT i
PRINT "C = A + B": FOR i = 1 TO m: FOR j = 1 TO n: PRINT matC(i, j);: NEXT j: PRINT: NEXT i
GOSUB Pausa: RETURN

OpMatResta:
titulo$ = "40: RESTA DE MATRICES": GOSUB Titulo
GOSUB CapturaDimMat
PRINT "Capture matriz A": FOR i = 1 TO m: FOR j = 1 TO n: PRINT "A("; i; ","; j; "): ";: INPUT matA(i, j): NEXT j: NEXT i
PRINT "Capture matriz B": FOR i = 1 TO m: FOR j = 1 TO n: PRINT "B("; i; ","; j; "): ";: INPUT matB(i, j): matC(i, j) = matA(i, j) - matB(i, j): NEXT j: NEXT i
PRINT "C = A - B": FOR i = 1 TO m: FOR j = 1 TO n: PRINT matC(i, j);: NEXT j: PRINT: NEXT i
GOSUB Pausa: RETURN

OpMatTrans:
titulo$ = "41: MATRIZ TRANSPUESTA": GOSUB Titulo
GOSUB CapturaDimMat
PRINT "Capture matriz A": FOR i = 1 TO m: FOR j = 1 TO n: PRINT "A("; i; ","; j; "): ";: INPUT matA(i, j): matC(j, i) = matA(i, j): NEXT j: NEXT i
PRINT "Transpuesta": FOR i = 1 TO n: FOR j = 1 TO m: PRINT matC(i, j);: NEXT j: PRINT: NEXT i
GOSUB Pausa: RETURN

OpMatInv:
titulo$ = "42: MATRIZ INVERSA 2X2": GOSUB Titulo
PRINT "Capture matriz A de 2x2": FOR i = 1 TO 2: FOR j = 1 TO 2: PRINT "A("; i; ","; j; "): ";: INPUT matA(i, j): NEXT j: NEXT i
det = matA(1, 1) * matA(2, 2) - matA(1, 2) * matA(2, 1)
PRINT "Determinante ="; det
IF det = 0 THEN PRINT "La matriz no tiene inversa." ELSE PRINT matA(2, 2) / det; -matA(1, 2) / det: PRINT -matA(2, 1) / det; matA(1, 1) / det
GOSUB Pausa: RETURN

DibujaCuadrado:
LOCATE 15, 32: PRINT "+----------+"
LOCATE 16, 32: PRINT "|          |"
LOCATE 17, 32: PRINT "|          |"
LOCATE 18, 32: PRINT "+----------+"
RETURN

DibujaRectangulo:
LOCATE 15, 29: PRINT "+----------------+"
LOCATE 16, 29: PRINT "|                |"
LOCATE 17, 29: PRINT "+----------------+"
RETURN

DibujaTriangulo:
LOCATE 14, 36: PRINT "    /\"
LOCATE 15, 36: PRINT "   /  \"
LOCATE 16, 36: PRINT "  /    \"
LOCATE 17, 36: PRINT " /      \"
LOCATE 18, 36: PRINT "/________\"
RETURN

DibujaCirculo:
LOCATE 14, 34: PRINT "   ****"
LOCATE 15, 34: PRINT " *      *"
LOCATE 16, 34: PRINT "*        *"
LOCATE 17, 34: PRINT " *      *"
LOCATE 18, 34: PRINT "   ****"
RETURN

DibujaRombo:
LOCATE 14, 38: PRINT "   /\"
LOCATE 15, 38: PRINT "  /  \"
LOCATE 16, 38: PRINT " /    \"
LOCATE 17, 38: PRINT " \    /"
LOCATE 18, 38: PRINT "  \  /"
LOCATE 19, 38: PRINT "   \/"
RETURN

DibujaTrapecio:
LOCATE 15, 33: PRINT "   ______"
LOCATE 16, 33: PRINT "  /      \"
LOCATE 17, 33: PRINT " /        \"
LOCATE 18, 33: PRINT "/__________\"
RETURN

DibujaPoligono:
LOCATE 14, 35: PRINT "  ______"
LOCATE 15, 35: PRINT " /      \"
LOCATE 16, 35: PRINT "/        \"
LOCATE 17, 35: PRINT "\        /"
LOCATE 18, 35: PRINT " \______/"
RETURN
