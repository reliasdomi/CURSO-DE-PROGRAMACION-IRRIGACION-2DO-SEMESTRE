# Entrega Final 4A — Sistema de los 42 programas

Universidad Autónoma Chapingo — Departamento de Irrigación. Grupo 4A.

Esta carpeta reúne **la misma colección de programas del curso resuelta en tres
lenguajes**. Lista para comprimir en `.zip` y ejecutarse en otra PC.

```
ENTREGA_4A/
  1_QBASIC/   -> 42 ejercicios + menús (BASIC, se corre con QB64)
  2_PASCAL/   -> Sistema en Free Pascal, UNA sola ventana gráfica (.exe incluido)
  3_DELPHI/   -> Sistema en Delphi VCL (se abre y corre desde el IDE)
```

---

## 1_QBASIC  (BASIC / QB64)

Programas `.bas` interpretados. **No llevan .exe**: se ejecutan con **QB64**.

**Cómo correr en otra PC:**
1. Instalar QB64 (ver `1_QBASIC/INSTALAR_QB64.md`). Descarga: https://qb64phoenix.com
2. Abrir QB64, menú `File > Open`, elegir el `.bas` deseado, p. ej.
   `1_QBASIC/menus/MENU.BAS` (menú general) o cualquier
   `1_QBASIC/ejercicios/NN_.../programa.bas`.
3. Pulsar **F5** para ejecutar.

Incluye: `ejercicios/` (1-42 con `algoritmo.txt` y `analisis.txt`),
`menus/` (menú general + por categoría), los extras 43-44 (normales
climatológicas) y `diagramas_flujo/` (PNG de cada algoritmo).

---

## 2_PASCAL  (Free Pascal — UNA sola ventana)

Todo (menús, captura, resultados y figuras) ocurre dentro de **una ventana
gráfica**. **.exe ya compilado** en `2_PASCAL/bin/P_Sistema.exe`.

**Cómo correr en otra PC:**
- **Rápido:** doble clic en `2_PASCAL/bin/P_Sistema.exe`.
- **Recompilar** (si hace falta): instalar Free Pascal 3.2.2
  (https://www.freepascal.org) y ejecutar `2_PASCAL/compilar.cmd`.

> Si Windows bloquea el .exe por *Device Guard / WDAC*, recompílelo en esa PC
> con `compilar.cmd` o ejecútelo en una sesión normal del equipo.

---

## 3_DELPHI  (Delphi VCL)

Aplicación de ventanas VCL. Delphi **se compila desde su propio IDE**.

**Cómo correr en otra PC:**
1. Abrir Delphi (RAD Studio / Delphi Community).
2. `File > Open Project`, elegir `3_DELPHI/P_Sistema.dpr`.
3. Pulsar **F9** (Run) para compilar y ejecutar.

Formularios: `U_System` (principal), `U_Figuras`, `U_Estadistica`,
`U_Personas`, `U_Matrices`, `U_Miscelaneos`.

---

## Resumen de ejecución

| Entrega | Herramienta | Cómo correr |
|---|---|---|
| 1_QBASIC | QB64 | Abrir `.bas` y F5 |
| 2_PASCAL | (ninguna) | Doble clic en `bin/P_Sistema.exe` |
| 3_DELPHI | Delphi IDE | Abrir `.dpr` y F9 |
