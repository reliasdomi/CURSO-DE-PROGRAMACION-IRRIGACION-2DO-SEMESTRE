# Parte A — Figuras geométricas en modo gráfico (Free Pascal)

Reescritura en **Pascal** de las figuras geométricas del curso, pero dibujadas en
**modo gráfico real** (unit `Graph` de Free Pascal, estilo Turbo Pascal / BGI) en vez
de ASCII. El menú vive en la **consola**; al elegir una figura se piden los datos, se
calcula área/perímetro y se **dibuja la figura a escala en una ventana gráfica**.

> Nota: el modo gráfico en terminal (`unit Graph`) **no existe en RAD Studio/Delphi**;
> es propio de Free Pascal / Turbo Pascal. Por eso esta parte usa Free Pascal.
> La versión con interfaz visual de RAD Studio está en `..\parte_b_delphi_vcl`.

## Archivos
- `FiguraMenu.pas` — menú de consola + lectura de datos + orquestación.
- `uFigurasCalc.pas` — cálculos puros de área y perímetro.
- `uFigurasDibujo.pas` — dibujo con la unit `Graph` (InitGraph / escalado / primitivas).

## Figuras incluidas
Cuadrado, Rectángulo, Triángulo, Círculo, Rombo, Trapecio, Polígono regular.

## Requisitos
- **Free Pascal Compiler 3.2.2** (ya instalado en `C:\FPC\3.2.2`; incluye el backend
  `ptcgraph` para `Graph` en Windows).
- Si `fpc` no se reconoce en la terminal, abra una terminal **nueva** (el instalador agrega
  el PATH) o use la ruta completa `C:\FPC\3.2.2\bin\i386-win32\fpc.exe`.

## Compilar
```
fpc -O2 -FEbin FiguraMenu.pas
```
Genera `bin\FiguraMenu.exe`. (Ya verificado: compila y ejecuta correctamente.)

## Ejecutar
```
FiguraMenu.exe
```
1. Aparece el menú en la consola.
2. Elija una figura (1-7) y capture los datos.
3. Se abre una ventana gráfica con la figura dibujada a escala y el área/perímetro.
4. Pulse **ENTER en la consola** para cerrar la figura y volver al menú.
5. Opción `0` para salir.
