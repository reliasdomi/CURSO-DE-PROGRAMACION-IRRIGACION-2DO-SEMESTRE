# Documentos de estudio y exposición — Tres entregas

Curso de Programación · Departamento de Irrigación · UACh · Grupo 4A

Este material es para **estudiar y exponer mejor** las tres entregas del curso: los mismos
42 programas, programados en tres lenguajes distintos.

| # | Entrega | Carpeta | Documento |
|---|---|---|---|
| 1 | QBASIC / QB64 | `qb64/` | [01_QBASIC.md](01_QBASIC.md) |
| 2 | Free Pascal (terminal + gráficos) | `pascal/sistema_profe/` | [02_PASCAL.md](02_PASCAL.md) |
| 3 | Delphi VCL (ventanas) | `delphi/sistema_profe/` | [03_DELPHI.md](03_DELPHI.md) |
| — | Comparativa entre los 3 lenguajes | — | [COMPARATIVA.md](COMPARATIVA.md) |

## Idea central para exponer

> "El **mismo problema** (por ejemplo, dibujar un círculo o calcular una media) se resuelve
> en tres tecnologías que representan tres épocas y estilos de programación:
> **QBASIC** (procedural, gráficos de texto/pantalla), **Free Pascal** (estructurado, modular,
> gráficos BGI en terminal) y **Delphi VCL** (orientado a eventos, ventanas con botones y
> cuadros de texto)."

## Guion sugerido de exposición (15-20 min)

1. **Introducción (2 min).** Presentar el conjunto: 42 programas en 5 categorías
   (Figuras, Estadística, Personas/Poblacionales, Matrices, Misceláneos).
2. **QBASIC (4 min).** Abrir `MENU.BAS`, mostrar el menú y dibujar 2-3 figuras.
   Explicar que aquí se usan los comandos `SCREEN`, `LINE`, `CIRCLE`.
3. **Free Pascal (5 min).** Correr `bin\P_Sistema.exe`. Mostrar que es **terminal** pero
   abre una **ventana gráfica real** (unit `Graph`) para las figuras. Resaltar el estilo
   del profesor: `Val`/`Str`, arreglos `[1..75]`, unidades `Console.pas`/`Librerias.pas`.
4. **Delphi VCL (5 min).** Correr el `.exe` (compilado con F9 en RAD Studio). Mostrar el
   `TMainMenu`, capturar personas en las rejillas, dibujar una figura en el `TPaintBox`.
   Resaltar los prefijos `E_`/`L_`/`B_`/`G_` y los helpers `Cadena_a_real`.
5. **Comparativa y cierre (3 min).** Usar [COMPARATIVA.md](COMPARATIVA.md): mismo programa,
   tres lenguajes. Conclusión: misma lógica, distinta herramienta y paradigma.

## Apoyos visuales

- Diagramas de flujo: carpeta `diagramas_flujo/` (un PNG por ejercicio, `01_Cuadrado.png` … `42_Matriz_Inversa.png`).
- Capturas: tome pantallazos de cada `.exe` corriendo para las diapositivas.
