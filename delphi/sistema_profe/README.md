# Entrega 3 — Delphi VCL (estilo profesor)

Sistema de los **42 programas del curso** en Delphi VCL, programado al estilo del profesor:
formulario principal con `TMainMenu` que abre **un formulario por categoría**, con cuadros de
texto, botones y `TStringGrid` (como sus ejemplos `U_System` / `U_personas` / `U_Menor`).
Las **figuras se dibujan con el `Canvas`** de un `TPaintBox` (`Rectangle` / `Ellipse` /
`Polygon` / `LineTo`).

Universidad Autónoma Chapingo — Departamento de Irrigación. Grupo 4A.

## Estilo del profesor aplicado

- Prefijos de componentes: `E_` edit, `L_` label, `B_` button, `G_` grid, `P_` panel.
- Conversión con helpers `Val`/`Str`: `Cadena_a_real`, `Cadena_a_byte`, `real_a_Cadena`,
  `Byte_a_Cadena` (unidad `U_Comun.pas`, equivalente a sus "Librerías").
- Arreglos fijos `Array[1..75]`, índice 1-based.
- `TStringGrid` en columnas paralelas para las personas (i, Nombre, Edad, Estatura, Sexo).
- Menú diseñado en el `.dfm`; cada opción lleva su `Tag` = número de programa.

## Estructura (un formulario por categoría)

| Unidad | Formulario | Programas |
|---|---|---|
| `U_System.pas/.dfm` | Menú principal (`TMainMenu`) | — |
| `U_Figuras.pas/.dfm` | Figuras (entradas + `TPaintBox`) | 1-6, 38 |
| `U_Estadistica.pas/.dfm` | Rejilla de datos + medidas | 9-15, 36-37 |
| `U_Personas.pas/.dfm` | Rejillas paralelas + 20 consultas | 16-35 |
| `U_Matrices.pas/.dfm` | Matrices A/B + resultado | 39-42 |
| `U_Miscelaneos.pas/.dfm` | Par/impar + cuadrática | 7-8 |
| `U_Comun.pas` | Helpers `Val`/`Str` (sin formulario) | — |
| `P_Sistema.dpr` | Proyecto principal | — |

## Compilar y ejecutar (RAD Studio / Delphi 12 Athens)

> **Importante:** la edición de Delphi instalada en este equipo **no permite compilar por línea
> de comandos** (`dcc32`/`dcc64` responden *"This version of the product does not support command
> line compiling"*). Por eso el ejecutable se genera **desde el IDE**:

1. Abrir **RAD Studio** (Delphi 12 Athens).
2. `File → Open Project…` y elegir **`P_Sistema.dpr`** (el IDE crea el `.dproj` automáticamente).
3. Pulsar **F9** (compilar y ejecutar) o **Shift+F9** (solo compilar).
4. El ejecutable queda en la carpeta de salida del proyecto (`Win32\Debug` por defecto).

Al abrir cada formulario en el diseñador, si Delphi pide reconciliar alguna propiedad del `.dfm`,
acepte; el código y el `.dfm` están escritos para Delphi 12.

## Nota sobre los logos

Para mantener los `.dfm` legibles **no se incrustaron** las imágenes (UACh / Irrigación). El
encabezado usa un `TPanel` azul con `TLabel`. Si desea los logos, agregue un `TImage` en
`U_System` y cargue el PNG en tiempo de diseño; hay copias en
`delphi/_moderno_archivo/parte_b_vcl/assets/`.
