# Ejemplos del profesor

Programas de muestra vistos en clase, en Pascal.

## Contenido

| Archivo | Que es |
|---|---|
| `archivos.dpr` / `archivos.PAS` | ABM de alumnos en consola: alta/lectura/edicion de **archivos de texto** y **archivos binarios** (`File of Registro_de_alumnos`), con menus de colores y editor de campos. Son dos versiones del mismo programa. |
| `GRAFICOS.PAS` | Demo de graficos BGI (usa `Crt` + `Graph`): pixeles, circulos, barras, pastel, lineas, texto. |
| `Console.pas` | **Reconstruida** (ver nota abajo). UI de consola: `Escribe_texto`, `gotoXY`, `ClrScr`, `Plantilla`, `Cajita`, `Dibuja_cuadro`, `selector_vertical`, `sonido`, `ReadKey`, y los globales `cadena`, `Tecla`, `opcion`, `Texto_de_opcion`, etc. |
| `Librerias.pas` | **Reconstruida**. Helpers de cadena: `existe_punto`, `elima_espacios_derechos_de_cadena`. |
| `MENOR/` | Proyecto del profe (`P_Menor.dpr` + `U_Menor.pas` + `U_Menor.dfm`), extraido de `MENOR.zip`. App VCL de Delphi. |

## Nota: por que se reconstruyeron Console.pas y Librerias.pas

`archivos` hace `uses Console, Librerias`, pero del original **solo quedaron los
`.dcu` compilados de Delphi 7** — sin codigo fuente. Un `.dcu` esta amarrado a la
version exacta del compilador, asi que **no sirve** en Delphi 12 ni en Free Pascal
(copiarlo a otra carpeta tampoco funciona).

Por eso se reconstruyo el **codigo fuente** de ambas unidades, deduciendo su API de
como las llama el ejemplo. Estan implementadas sobre la **API de consola de Windows**
para que compilen igual en **Delphi 12 Athens** y en **Free Pascal 3.2.2**.

## Compilar

Desde esta carpeta:

**Free Pascal 3.2.2** (linea de comandos):

```
fpc -Mdelphi -O2 archivos.dpr
```

**Delphi 12 Athens** (esta instalacion no trae compilador de linea de comandos):
abrir `archivos.dpr` en el IDE y **Build** (Shift+F9), luego **Run** (F9).

> `Console.pas`/`Librerias.pas` deben estar en la misma carpeta que `archivos.dpr`
> (ya lo estan). Los `.dcu`/`.exe` generados NO se versionan (ver `.gitignore`).

## Probar `archivos`

1. Aparece el menu **MANEJO DE ARCHIVOS** con cajas de color.
2. Flechas Arriba/Abajo mueven el resaltado; Enter selecciona.
3. Archivos de texto -> Crear: pide nombre, editor de campos (flechas entre
   campos, **F2** guarda y avanza, **Esc** termina), escribe el archivo.
4. Leer: muestra los registros; cualquier tecla continua.
5. Igual para archivos binarios.
