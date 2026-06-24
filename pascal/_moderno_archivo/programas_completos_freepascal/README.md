# Paquete PASCAL completo — 42 programas en modo gráfico (Free Pascal)

Equivalente en **Free Pascal** del paquete BASIC (`qb64/`): los **42 programas**
organizados en **4 submenús bajo un menú principal**, pero con **salida gráfica real**
usando la unit `Graph` (backend `ptcgraph` en Windows) en vez de ASCII en consola.

El menú y la captura de datos viven en la **consola**; cada resultado se muestra en una
**ventana gráfica** (figura a escala, gráfica de barras, dispersión con recta de
regresión, parábola o cuadrícula de matriz). Se pulsa **ENTER en la consola** para
cerrar la ventana y volver al menú.

## Estructura (modular)
- `MenuPrincipal.pas` — programa principal: menú principal + 4 submenús.
- `uComun.pas` — lectura validada, ventana gráfica, panel de texto, gráfica de barras, captura de grupo de personas.
- `uFiguras.pas` — ejercicios 01-06 y 38 (figuras a escala).
- `uEstadistica.pas` — ejercicios 11-15, 36, 37 y estadística de grupo 16-35.
- `uMatrices.pas` — ejercicios 39-42 (resultado en cuadrícula).
- `uMiscelaneos.pas` — ejercicios 07-10 (la cuadrática dibuja la parábola).

## Mapa de los 42 programas
| Submenú | Ejercicios |
|---|---|
| Figuras | 01 Cuadrado, 02 Rectángulo, 03 Triángulo, 04 Círculo, 05 Rombo, 06 Trapecio, 38 Polígono regular |
| Estadística | 11 Media, 12 Mediana, 13 Moda, 14 Orden asc, 15 Orden desc, 36 Regresión, 37 Desv. estándar |
| Estadística → Grupo | 16-35 (conteos, máx/mín y promedios por sexo/edad/estatura) |
| Matrices | 39 Suma, 40 Resta, 41 Transpuesta, 42 Inversa 2x2 |
| Misceláneos | 07 Par/Impar, 08 Cuadrática, 09 Mayor, 10 Menor |

## Requisitos
- **Free Pascal Compiler 3.2.2** (instalado en `C:\FPC\3.2.2`; incluye `ptcgraph`).

## Compilar
```
fpc -O2 -FEbin -FUbin MenuPrincipal.pas
```
Genera `bin\MenuPrincipal.exe`.

## Ejecutar
```
bin\MenuPrincipal.exe
```

> Nota: `unit Graph` es propia de Free Pascal / Turbo Pascal (no existe en QB64 ni en
> Delphi/RAD Studio). La versión QB64 está en `qb64/` y la versión visual en `delphi/`.
