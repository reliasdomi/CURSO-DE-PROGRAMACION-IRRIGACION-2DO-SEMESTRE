# Instalar QB64 (para correr la entrega de QBASIC)

QB64 es un compilador moderno y gratuito de BASIC, compatible con QBasic/QuickBASIC,
que corre en Windows actual y permite generar `.exe`. **No requiere instalación** (es
portátil: se descomprime y se usa).

## Pasos

1. Entrar a **https://qb64phoenix.com** (QB64 Phoenix Edition, la versión mantenida).
2. En *Downloads* descargar el ZIP de **Windows** (64-bit).
3. Descomprimir el ZIP en una carpeta sencilla, por ejemplo `C:\qb64`.
   - No usar "Archivos de programa": QB64 funciona mejor en una ruta sin espacios.
4. Abrir `qb64pe.exe` (el IDE de QB64).

## Cómo correr esta entrega

1. En QB64: `File → Open…` y elegir
   `...\qb64\menus\MENU.BAS` de este repositorio.
2. **F5** = ejecutar.
3. **F11** = compilar a `.exe` (queda junto al `.bas`).

## Notas

- Si Windows SmartScreen o un antivirus advierte al abrir `qb64pe.exe`, es por ser un
  ejecutable sin firma; permita la ejecución (es seguro, es código abierto).
- Si la pantalla gráfica de las figuras se ve pequeña, está bien: QBASIC usa modos
  `SCREEN` de baja resolución. Es el comportamiento esperado.
- Una vez instalado QB64, se puede generar `bin\MENU.exe` con F11 para llevar la
  demo a clase sin abrir el IDE.
