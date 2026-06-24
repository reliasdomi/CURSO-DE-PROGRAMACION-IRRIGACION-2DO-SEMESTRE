# Entrega 1 — QBASIC / QB64

Los **42 programas del curso** (más 2 extra de normales climatológicas) en BASIC,
ejecutables con **QB64**. Incluye el menú principal y los menús por categoría.

Universidad Autónoma Chapingo — Departamento de Irrigación. Grupo 4A.

## Cómo abrir y ejecutar

1. Instalar QB64 (ver `INSTALAR_QB64.md`).
2. Abrir QB64 y cargar `menus\MENU.BAS`.
3. Pulsar **F5** para ejecutar. El menú principal lleva a los submenús.
4. Para generar un `.exe`: pulsar **F11** (compila a ejecutable en la misma carpeta).

## Menús

| Archivo | Categoría |
|---|---|
| `menus\MENU.BAS` | Menú principal |
| `menus\MENU_FIGURAS.BAS` | Figuras geométricas |
| `menus\MENU_ESTADISTICA.BAS` | Estadística |
| `menus\MENU_MATRICES.BAS` | Matrices |
| `menus\MENU_MISCELANEOS.BAS` | Misceláneos |

> Los dibujos de figuras usan los comandos gráficos de QBASIC (`SCREEN`, `LINE`,
> `CIRCLE`, `PSET`). Esta entrega es la referencia para las pistas de Pascal y Delphi.

## Los 42 programas (carpeta `ejercicios\`)

**Figuras (1-6, 38)**
1. Cuadrado · 2. Rectángulo · 3. Triángulo · 4. Círculo · 5. Rombo · 6. Trapecio ·
38. Polígono regular

**Misceláneos (7-8)**
7. Par o impar · 8. Fórmula cuadrática

**Estadística (9-15, 36-37)**
9. Número mayor · 10. Número menor · 11. Media · 12. Mediana · 13. Moda ·
14. Ordenar menor→mayor · 15. Ordenar mayor→menor · 36. Regresión lineal ·
37. Varianza y desviación estándar

**Personas / Poblacionales (16-35)**
16. Hombres del grupo · 17. Mujeres del grupo · 18. Edad mayor/menor grupo ·
19. Estatura mayor/menor grupo · 20. Edad may/men mujeres · 21. Edad may/men hombres ·
22. Mayores de edad · 23. Menores de edad · 24. Mujeres mayores · 25. Mujeres menores ·
26. Hombres mayores · 27. Hombres menores · 28. Estatura may/men mujeres ·
29. Estatura may/men hombres · 30. Promedio edad grupo · 31. Promedio estatura grupo ·
32. Promedio edad mujeres · 33. Promedio edad hombres · 34. Promedio estatura mujeres ·
35. Promedio estatura hombres

**Matrices (39-42)**
39. Suma · 40. Resta · 41. Transpuesta · 42. Inversa 2×2

**Extra**
43. Normales climatológicas (Calera) · 44. Lector de normales

## Relación con las otras entregas

El mismo conjunto de 42 programas está reimplementado en:
- `pascal/sistema_profe/` — Free Pascal, terminal + gráficos reales (unit `Graph`).
- `delphi/sistema_profe/` — Delphi VCL, ventanas con botones/grids y figuras en `Canvas`.

Ver `docs_entregas/` para la comparativa entre los tres lenguajes.
