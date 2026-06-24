# Entrega 1 — QBASIC / QB64 (guía de estudio y exposición)

Carpeta: `qb64/` · Cómo instalar el intérprete: `qb64/INSTALAR_QB64.md`

## Qué es

Los 42 programas del curso en BASIC clásico, con menú principal y submenús. Es la
**entrega base**: las de Pascal y Delphi replican estos mismos programas.

## Cómo correrla en clase

1. Abrir QB64 → `File → Open` → `qb64\menus\MENU.BAS`.
2. **F5** para ejecutar. Navegar el menú con el teclado.
3. (Opcional) **F11** para generar `MENU.exe`.

## Arquitectura

- `menus\MENU.BAS` = menú principal con `GOSUB` a cada submenú.
- Submenús: figuras, estadística, matrices, misceláneos.
- Cada ejercicio en `ejercicios\NN_Nombre\` como `.bas` independiente.
- Datos en arreglos globales (`datos()`, `edad()`, `sexo$()`, ...).

## Puntos para explicar

- **Gráficos:** QBASIC dibuja con `SCREEN` (modo gráfico) y `LINE`, `CIRCLE`, `PSET`.
  Es la forma "original" de dibujar figuras, antes de las ventanas.
- **Estructura procedural:** todo se organiza con `GOSUB`/`RETURN` y `SELECT CASE`.
- **Entrada/salida:** `INPUT` para leer, `PRINT`/`LOCATE` para escribir en pantalla.

## Posibles preguntas de la clase

- *¿Por qué la pantalla se ve de baja resolución?* → Los modos `SCREEN` de QBASIC son de
  baja resolución por diseño (compatibilidad histórica).
- *¿Se puede hacer un `.exe`?* → Sí, con QB64 (F11); QBasic original solo interpretaba.

## Relación con las otras entregas

Comparar el dibujo del círculo y el cálculo de la media con Pascal y Delphi:
ver [COMPARATIVA.md](COMPARATIVA.md).
