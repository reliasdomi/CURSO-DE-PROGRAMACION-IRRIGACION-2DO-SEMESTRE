# Entrega 2 — Free Pascal (estilo profesor)

Sistema de los **42 programas del curso** en Free Pascal, programado al estilo del profesor:
menús de terminal + **figuras dibujadas con gráficos reales** (unit `Graph`, primitivas
`Line` / `Rectangle` / `Circle`), igual que el `GRAFICOS.PAS` del profe y con paridad 1:1
frente a las figuras de QBASIC.

Universidad Autónoma Chapingo — Departamento de Irrigación. Grupo 4A.

## Estilo del profesor aplicado

- Conversión de cadenas con `Val` / `Str` mediante helpers propios:
  `Cadena_a_real`, `Cadena_a_byte`, `real_a_Cadena`, `Byte_a_Cadena` (en `U_Comun.pas`).
- Arreglos fijos `Array[1..75]`, índice 1-based, variables de módulo (sin records en la GUI).
- Reutiliza las unidades reconstruidas del profe: `Console.pas` y `Librerias.pas`.
- Figuras con la unit `Graph` (BGI): `InitGraph`, `Circle`, `Rectangle`, `Line`, `OutTextXY`.

## Estructura

| Archivo | Contenido | Programas |
|---|---|---|
| `P_Sistema.pas` | Programa principal, menú general + submenús | — |
| `U_Comun.pas` | Helpers `Val`/`Str`, lectura por consola, ventana gráfica | — |
| `U_Figuras.pas` | Figuras geométricas (unit `Graph`) | 1-6, 38 |
| `U_Estadistica.pas` | Mayor, menor, media, mediana, moda, ordenar, regresión, varianza | 9-15, 36-37 |
| `U_Personas.pas` | 20 consultas poblacionales (arreglos paralelos) | 16-35 |
| `U_Matrices.pas` | Suma, resta, transpuesta, inversa 2×2 | 39-42 |
| `U_Miscelaneos.pas` | Par/impar, fórmula cuadrática | 7-8 |
| `Console.pas`, `Librerias.pas` | Unidades del profesor (consola DOS / helpers de cadena) | — |

> Los 42 programas quedan repartidos en 5 categorías; en el menú principal:
> Figuras (7) · Estadística (9) · Personas (20) · Matrices (4) · Misceláneos (2).

## Compilar

Requiere **Free Pascal 3.2.2** (incluye la unit `Graph`).

```
compilar.cmd
```

o manualmente:

```
fpc -O2 -FEbin -FUbin P_Sistema.pas
```

Genera `bin\P_Sistema.exe`.

## Ejecutar

```
bin\P_Sistema.exe
```

Navegue con los números del menú. Al elegir una figura se pide la medida en la consola y
se abre la **ventana gráfica** con el dibujo; pulse ENTER en la consola para volver al menú.

> **Nota:** en algunos equipos con *Device Guard / WDAC* activo, Windows bloquea ejecutables
> recién compilados sin firmar. Si aparece "bloqueado por la directiva de Device Guard",
> ejecute en una sesión normal del equipo o pida al administrador habilitar la ejecución.
