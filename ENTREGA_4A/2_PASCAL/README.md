# Entrega 2 — Free Pascal · VARIANTE "UNA SOLA VENTANA"

Mismo sistema de los **42 programas del curso**, pero **todo dentro de una
única ventana gráfica**: menús, captura de datos, resultados y figuras. No
aparece ninguna ventana de consola.

> Es una **alternativa** a la versión `../sistema_profe` (que usa dos ventanas:
> consola para el menú + ventana gráfica para las figuras, igual que el
> `GRAFICOS.PAS` del profesor). Aquí se conserva la versión de dos ventanas
> intacta para comparar.

Universidad Autónoma Chapingo — Departamento de Irrigación. Grupo 4A.

## Diferencia clave frente a `sistema_profe`

| Aspecto | `sistema_profe` (2 ventanas) | `sistema_profe_unaventana` (1 ventana) |
|---|---|---|
| Menús | Consola (`WriteLn`/`ReadLn`) | Dibujados en la ventana (`OutTextXY`) |
| Captura de datos | Consola | Teclado leído en la ventana (`ptccrt.ReadKey`) |
| Figuras / resultados | Ventana gráfica | Misma ventana gráfica |
| Ventana de consola | Sí (aparece) | No (subsistema GUI) |
| Estilo profesor | Igual al `GRAFICOS.PAS` | Variante moderna de una ventana |

La **lógica matemática es idéntica**: las unidades reusan los mismos cálculos.
Solo cambió la **capa de entrada/salida** (`U_Comun.pas`), que ahora hace toda
la interacción dentro de la ventana.

## Cómo funciona la ventana única

`U_Comun.pas`:

- `Inicia_grafico` abre la ventana **una vez**; permanece abierta hasta salir.
- `Lee_cadena` / `Lee_real` / `Lee_entero` … muestran el *prompt* en la zona de
  entrada (parte baja de la ventana) y leen el teclado con `ptccrt.ReadKey`,
  mostrando en pantalla lo que se teclea (con borrado `Backspace` y `Enter`).
- `Pantalla_menu` dibuja el menú y lee la opción dentro de la ventana.
- `Muestra_panel` y `Abre_ventana` limpian y redibujan el encabezado
  institucional sin cerrar el modo gráfico.

## Estructura

| Archivo | Contenido |
|---|---|
| `P_Sistema.pas` | Programa principal (`{$APPTYPE GUI}`) + menús en ventana |
| `U_Comun.pas` | Capa gráfica: conversiones, entrada en ventana, paneles, menú |
| `U_Figuras.pas` | Figuras 1-6, 38 (unit `Graph`) |
| `U_Estadistica.pas` | Programas 9-15, 36-37 |
| `U_Personas.pas` | 20 consultas poblacionales (16-35) |
| `U_Matrices.pas` | Suma, resta, transpuesta, inversa 2×2 (39-42) |
| `U_Miscelaneos.pas` | Par/impar, fórmula cuadrática (7-8) |

## Compilar

Requiere **Free Pascal 3.2.2** con `ptcgraph` + `ptccrt` (incluidos en FPC Windows).

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

Se abre **una sola ventana**. Navegue tecleando el número de la opción y
`Enter`. Al pedir datos, escriba directamente en la ventana. En cada resultado
o figura, pulse una tecla para volver al menú.

> **Nota:** en equipos con *Device Guard / WDAC* activo, Windows puede bloquear
> el `.exe` recién compilado sin firmar. Si aparece "bloqueado por la directiva
> de Device Guard", ejecútelo en una sesión normal del equipo o pida al
> administrador habilitar la ejecución.
