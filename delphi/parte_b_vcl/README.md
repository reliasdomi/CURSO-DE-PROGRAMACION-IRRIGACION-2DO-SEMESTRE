# Parte B — App visual VCL con los 42 programas (RAD Studio / Delphi 12)

Aplicación **visual estilo Visual Studio** (VCL, RAD Studio 23.0 / Delphi 12 Athens) que
reúne **los 42 programas** del Grupo 4A en un solo programa, con **menú principal nativo**
(`TMainMenu`) y controles nativos (`TStringGrid`, `TEdit`, `TMemo`, `TPaintBox`).

Equivalente "moderno" del menú general en BASIC: en vez de modo texto/ASCII, todo es una
interfaz de ventanas. Las figuras se dibujan con `TCanvas` sobre un `TPaintBox`.

## Archivos
- `ProgramasChapingo.dpr` / `.dproj` — proyecto Delphi (abrir en RAD Studio).
- `uPrincipal.pas` / `.dfm` — formulario principal: banner + menú + área de contenido.
  Toda la UI se construye en código (el `.dfm` es mínimo a propósito).
- `uLogica.pas` — capa de **cálculo pura** (sin VCL) de los 42 programas.
- `assets/` — logos institucionales del banner (ver sección **Assets**).

## Assets (logos del banner)
El banner azul superior espera dos PNG en la carpeta `assets/` junto al proyecto:

| Archivo                  | Contenido                                                |
|--------------------------|----------------------------------------------------------|
| `assets/chapingo.png`    | Escudo de la UACH (trigo + leyenda "Enseñar la explotación de la tierra…"). |
| `assets/irrigacion.png`  | Sello redondo del Departamento de Irrigación (hombre + torre). |

Si alguno de los dos archivos no existe, la app **abre igual** — solo se ve la banda
azul con el título centrado, sin esa imagen. El código busca también los logos en
`..\assets\`, `..\..\assets\` y `..\..\..\assets\` para que funcione tanto al correr
desde el IDE (con el `.exe` en `Win32\Debug\`) como al copiar el `.exe` aparte.

## Organización del menú
- **Figuras**: Cuadrado, Rectángulo, Triángulo, Círculo, Rombo, Trapecio, Polígono (dibujo).
- **Misc**: Par/Impar, Ecuación cuadrática.
- **Estadística**: Mayor, Menor, Media, Mediana, Moda, Ordenar (asc/desc), Regresión, Varianza/Desv.
- **Demografía**: 20 programas de grupo (conteos, mín/máx, promedios por sexo/edad/estatura).
- **Matrices**: Suma, Resta, Transpuesta, Inversa 2x2.

## Cómo se usa cada tipo
- **Figuras / Misc**: capture los valores en las cajas y pulse **Calcular**.
- **Estadística**: escriba la cantidad de datos, **Aplicar**, llene la tabla, **Calcular**.
- **Demografía**: cantidad de personas, **Aplicar**, llene Nombre/Sexo(H/M)/Edad/Estatura, **Calcular**.
- **Matrices**: indique filas/columnas, **Aplicar**, llene A (y B), **Calcular**.

> Acepta punto o coma decimal.

## Compilar (IMPORTANTE)
Este RAD Studio instalado **no tiene el compilador de línea de comandos** (`dcc32.exe`),
así que se compila **desde el IDE**:
1. Abrir `ProgramasChapingo.dproj` en RAD Studio (doble clic o File → Open Project).
2. Pulsar **F9** (Run) o **Shift+F11 / Ctrl+F9** (Build).

El IDE normaliza el `.dproj` al primer guardado (es normal). Las bibliotecas VCL/RTL ya
están instaladas, así que compilará sin dependencias extra.
