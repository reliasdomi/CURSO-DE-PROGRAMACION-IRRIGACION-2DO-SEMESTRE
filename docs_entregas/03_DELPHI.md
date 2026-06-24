# Entrega 3 — Delphi VCL (guía de estudio y exposición)

Carpeta: `delphi/sistema_profe/` · Proyecto: `P_Sistema.dpr`

## Qué es

Los 42 programas en Delphi VCL, **estilo del profesor**: un formulario principal con
`TMainMenu` que abre **un formulario por categoría**, con cuadros de texto, botones y
`TStringGrid`. Las figuras se dibujan con el `Canvas` de un `TPaintBox`.

## Cómo compilar y correr en clase

> La edición de Delphi instalada **no compila por línea de comandos**, así que el `.exe`
> se genera en el IDE:

1. Abrir **RAD Studio** (Delphi 12 Athens).
2. `File → Open Project…` → `delphi\sistema_profe\P_Sistema.dpr`.
3. **F9** = compilar y ejecutar.
4. Para llevar a clase: el `.exe` queda en la carpeta de salida (`Win32\Debug`).

> Recomendación: compilar **antes** de la exposición y exponer con el `.exe` ya generado.

## Arquitectura (un formulario por categoría)

| Unidad | Formulario | Programas |
|---|---|---|
| `U_System` | Menú principal `TMainMenu` | — |
| `U_Figuras` | Entradas + `TPaintBox` (dibujo) | 1-6, 38 |
| `U_Estadistica` | Rejilla de datos + medidas | 9-15, 36-37 |
| `U_Personas` | Rejillas paralelas + 20 consultas | 16-35 |
| `U_Matrices` | Matrices A/B + resultado | 39-42 |
| `U_Miscelaneos` | Par/impar + cuadrática | 7-8 |
| `U_Comun` | Helpers `Val`/`Str` | — |

## Puntos para explicar

- **Estilo del profesor:** prefijos `E_` (edit), `L_` (label), `B_` (button), `G_` (grid);
  helpers `Cadena_a_real`/`real_a_Cadena`; rejillas paralelas para personas
  (`G_Nombre`, `G_Edad`, `G_Estatura`, `G_Sexo`) en arreglos `[1..75]`.
- **Orientado a eventos:** cada botón tiene su manejador `B_XxxClick`. El menú usa un solo
  manejador `ItemClick` que lee el `Tag` del ítem (= número de programa).
- **Dibujo en ventana:** las figuras se pintan en `PB_Dibujo.Canvas`
  (`Rectangle`, `Ellipse`, `Polygon`, `LineTo`) — gráficos de verdad, no texto.

## Posibles preguntas de la clase

- *¿Por qué un formulario por categoría y no uno por programa?* → Es el patrón del propio
  profesor: su `U_Menor` calcula varias medidas en un solo formulario y `U_personas` resuelve
  todas las consultas demográficas en otro. Agrupar por categoría es fiel a su estilo.
- *¿Dónde está la lógica?* → En `U_Comun` (conversiones) y en cada formulario (cálculos).

## Nota técnica

Los `.dfm` se escribieron sin imágenes incrustadas para mantenerlos legibles; el encabezado
es un `TPanel` azul con `TLabel`. Si el diseñador pide reconciliar alguna propiedad al abrir
un formulario, acepte (el código está hecho para Delphi 12).
