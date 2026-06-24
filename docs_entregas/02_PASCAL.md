# Entrega 2 — Free Pascal (guía de estudio y exposición)

Carpeta: `pascal/sistema_profe/` · Cómo compilar: `compilar.cmd` (requiere FPC 3.2.2)

## Qué es

Los 42 programas en Free Pascal, **estilo del profesor**: programa de terminal con menús
numerados, pero las figuras se dibujan en una **ventana gráfica real** con la unit `Graph`
(las mismas primitivas que el `GRAFICOS.PAS` del profe).

## Cómo correrla en clase

1. Ejecutar `pascal\sistema_profe\bin\P_Sistema.exe`
   (o doble clic; si falta, correr `compilar.cmd`).
2. Navegar el menú con números.
3. Al elegir una figura: se piden las medidas en la consola y se abre la **ventana gráfica**
   con el dibujo; pulsar ENTER en la consola para volver al menú.

> Si Windows bloquea el `.exe` por *Device Guard*, ejecútelo en una sesión normal del equipo.

## Arquitectura (modular, con `unit`)

| Unidad | Contenido |
|---|---|
| `P_Sistema.pas` | Programa principal: menú general + submenús |
| `U_Comun.pas` | Helpers `Val`/`Str`, lectura por consola, ventana `Graph` |
| `U_Figuras.pas` | Figuras 1-6, 38 (dibujo con `Line`/`Rectangle`/`Circle`) |
| `U_Estadistica.pas` | Programas 9-15, 36-37 |
| `U_Personas.pas` | 20 consultas poblacionales (16-35), arreglos paralelos |
| `U_Matrices.pas` | 39-42 |
| `U_Miscelaneos.pas` | 7-8 |
| `Console.pas`, `Librerias.pas` | Unidades del profesor |

## Puntos para explicar

- **Estilo del profesor:** `Cadena_a_real`/`real_a_Cadena` (con `Val`/`Str`), arreglos
  `Array[1..75]`, variables globales, índice 1-based.
- **Gráficos reales en terminal:** la unit `Graph` abre una ventana y dibuja con primitivas
  BGI (`Circle`, `Rectangle`, `Line`), no con caracteres ASCII.
- **Modularidad:** cada categoría es una `unit` que se incluye con `uses`.

## Posibles preguntas de la clase

- *¿Por qué se abre una ventana aparte para la figura?* → La unit `Graph` usa un modo gráfico
  separado de la consola de texto; es lo más cercano al `SCREEN` de QBASIC.
- *¿Qué diferencia hay con el QBASIC?* → Mismo resultado, pero Pascal es **estructurado y
  modular** (unidades, tipos, funciones), y valida mejor la entrada.

## Cómo se compila

`fpc -O2 -FEbin -FUbin P_Sistema.pas` → genera `bin\P_Sistema.exe`.
