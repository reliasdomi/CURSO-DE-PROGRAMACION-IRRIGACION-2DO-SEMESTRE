# Comparativa entre los tres lenguajes

El **mismo programa** en QBASIC, Free Pascal y Delphi VCL. Útil para explicar en clase
que la **lógica es la misma**; cambia la herramienta y el paradigma.

---

## 1) Dibujar un CÍRCULO (programa 4)

**QBASIC** — comandos gráficos de pantalla:
```basic
SCREEN 12
CIRCLE (320, 240), r
```

**Free Pascal** — unit `Graph` (BGI), ventana gráfica real:
```pascal
uses Graph;
InitGraph(gd, gm, '');
Circle(CentroX, CentroY, pr);   { pr = radio escalado a pixeles }
```

**Delphi VCL** — `Canvas` de un `TPaintBox`:
```pascal
cv := PB_Dibujo.Canvas;
cv.Ellipse(cx - pr, cy - pr, cx + pr, cy + pr);
```

> Las tres dibujan el mismo círculo; QBASIC y Pascal usan primitivas de "círculo",
> Delphi usa una elipse inscrita en un cuadrado.

---

## 2) Calcular la MEDIA (programa 11)

La fórmula es idéntica (`suma / n`); cambia cómo se leen los datos.

**QBASIC** — `INPUT` en consola:
```basic
suma = 0
FOR i = 1 TO n
  INPUT "Dato: ", d
  suma = suma + d
NEXT i
media = suma / n
```

**Free Pascal** — captura por consola con `Val`:
```pascal
for i := 1 to N do D[i] := Lee_real('Dato: ');
media := Suma_de(D, N) / N;
```

**Delphi VCL** — datos en una `TStringGrid`:
```pascal
for i := 1 to N do X[i] := Cadena_a_real(G_Datos.Cells[1, i]);
media := suma / N;
L_Media.Caption := 'Media: ' + real_a_Cadena(media, 1, 4);
```

---

## 3) PAR o IMPAR (programa 7)

Misma decisión (`n mod 2`); cambia la salida.

**QBASIC**
```basic
IF n MOD 2 = 0 THEN PRINT "PAR" ELSE PRINT "IMPAR"
```

**Free Pascal**
```pascal
if n mod 2 = 0 then texto := 'PAR' else texto := 'IMPAR';
Muestra_panel('PAR O IMPAR', [texto]);
```

**Delphi VCL**
```pascal
if n mod 2 = 0 then L_ResPar.Caption := '... es PAR'
               else L_ResPar.Caption := '... es IMPAR';
```

---

## Convenciones del profesor (presentes en Pascal y Delphi)

| Convención | Por qué / cómo | Ejemplo |
|---|---|---|
| `Val` / `Str` para convertir | Estilo Turbo Pascal, sin `StrToFloat`/`Format` | `Val(cadena, r, Codigo_de_error)` |
| Helpers de conversión | "Librerías" reutilizables | `Cadena_a_real`, `real_a_Cadena` |
| Arreglos fijos `[1..75]` | Tope de datos, índice 1-based | `Edad: array[1..75] of byte` |
| Prefijos de componentes (Delphi) | Identificar tipo por el nombre | `E_` edit, `L_` label, `B_` botón, `G_` grid |
| Rejillas paralelas (Delphi) | Una columna por campo de la persona | `G_Nombre`, `G_Edad`, `G_Estatura`, `G_Sexo` |
| Variables globales de módulo | Estado compartido entre procedimientos | `N`, `Codigo_de_error` |

## Tres paradigmas, un mismo problema

| | QBASIC | Free Pascal | Delphi VCL |
|---|---|---|---|
| Paradigma | Procedural | Estructurado / modular | Orientado a eventos |
| Interfaz | Consola + `SCREEN` | Terminal + ventana `Graph` | Ventanas (formularios) |
| Entrada | `INPUT` | `ReadLn` / `Val` | `TEdit` / `TStringGrid` |
| Dibujo | `LINE`, `CIRCLE` | `Line`, `Circle` (BGI) | `Canvas.Ellipse`, `Polygon` |
| Organización | `GOSUB` / subrutinas | `unit` + `uses` | `unit` por formulario |
