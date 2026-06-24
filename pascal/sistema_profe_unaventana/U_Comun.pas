unit U_Comun;

{ ------------------------------------------------------------------
  U_Comun.pas - VARIANTE "UNA SOLA VENTANA" (modo grafico total).

  Misma interfaz publica que la version de dos ventanas, pero TODO
  ocurre dentro de la ventana grafica:
    - Menus dibujados con OutTextXY.
    - Entrada de datos leyendo el teclado con ptccrt.ReadKey y
      mostrando lo tecleado en una zona de entrada de la ventana.
    - Resultados en paneles graficos y figuras con Line/Rectangle/Circle.

  La ventana grafica se abre UNA vez (Inicia_grafico) y permanece
  abierta hasta Termina_grafico. No hay consola visible.

  Requiere Free Pascal con ptcgraph + ptccrt (incluidos en FPC Windows).

  Universidad Autonoma Chapingo - Departamento de Irrigacion. Grupo 4A.
  ------------------------------------------------------------------ }

{$mode objfpc}{$H+}

interface

const
  MAXP   = 75;          { tope de datos, estilo profe Array[1..75] }
  ANCHO  = 640;
  ALTO   = 480;
  MARGEN = 70;

type
  TArregloReal = array[1..MAXP] of real;
  TArregloByte = array[1..MAXP] of byte;
  TStringArray = array of string;

var
  Codigo_de_error : integer;

{ ---- ciclo de vida de la ventana unica ---- }
procedure Inicia_grafico;
procedure Termina_grafico;

{ ---- conversiones estilo profesor (Val / Str) ---- }
function Cadena_a_byte(cadena: string): byte;
function Cadena_a_entero(cadena: string): integer;
function Cadena_a_real(cadena: string): real;
function Byte_a_Cadena(Numero, campo: byte): string;
function Entero_a_Cadena(Numero: integer; campo: byte): string;
function real_a_Cadena(Numero: real; campo, decimales: byte): string;

{ ---- entrada DENTRO de la ventana grafica ---- }
function Lee_cadena(const Mensaje: string): string;
function Lee_real(const Mensaje: string): real;
function Lee_real_positivo(const Mensaje: string): real;
function Lee_entero(const Mensaje: string): integer;
function Lee_entero_rango(const Mensaje: string; Lo, Hi: integer): integer;
function Lee_sexo(const Mensaje: string): char;
procedure Captura_datos(var D: TArregloReal; var N: integer; Lo, Hi: integer);
procedure Pausa;
procedure Aviso(const s: string);

{ ---- ventana / panel / figuras ---- }
function  Abre_ventana(const Titulo: string): boolean;
procedure Cierra_ventana;                 { en esta variante NO cierra; limpia }
function  CentroX: integer;
function  CentroY: integer;
procedure Pie_de_pagina(const Info: string);
procedure Espera_y_cierra;                { espera tecla, mantiene la ventana }
function  Escala(unidadesAncho, unidadesAlto: real): real;
procedure Muestra_panel(const Titulo: string; const Lineas: array of string);

{ ---- menu dibujado en la ventana ---- }
function Pantalla_menu(const Titulo: string; const Lineas: array of string;
                       Lo, Hi: integer): integer;

implementation

uses Graph, ptccrt, SysUtils;

const
  ZONA_Y = ALTO - 52;     { renglon de la zona de entrada }

var
  Ventana_abierta : boolean = False;
  cadena_aux      : string;

{ ====================== CONVERSIONES ====================== }

function Cadena_a_byte(cadena: string): byte;
var n: byte;
begin
  if cadena <> '' then Val(cadena, n, Codigo_de_error) else n := 0;
  if Codigo_de_error <> 0 then n := 0;
  Cadena_a_byte := n;
end;

function Cadena_a_entero(cadena: string): integer;
var n: integer;
begin
  if cadena <> '' then Val(cadena, n, Codigo_de_error) else n := 0;
  if Codigo_de_error <> 0 then n := 0;
  Cadena_a_entero := n;
end;

function Cadena_a_real(cadena: string): real;
var r: real;
begin
  if cadena <> '' then Val(cadena, r, Codigo_de_error) else r := 0;
  if Codigo_de_error <> 0 then r := 0;
  Cadena_a_real := r;
end;

function Byte_a_Cadena(Numero, campo: byte): string;
begin
  Str(Numero:campo, cadena_aux);
  Byte_a_Cadena := cadena_aux;
end;

function Entero_a_Cadena(Numero: integer; campo: byte): string;
begin
  Str(Numero:campo, cadena_aux);
  Entero_a_Cadena := cadena_aux;
end;

function real_a_Cadena(Numero: real; campo, decimales: byte): string;
begin
  Str(Numero:campo:decimales, cadena_aux);
  real_a_Cadena := cadena_aux;
end;

{ ====================== VENTANA UNICA ====================== }

procedure Dibuja_encabezado(const Titulo: string);
begin
  SetColor(LightCyan);
  SetTextStyle(DefaultFont, HorizDir, 1);
  SetTextJustify(CenterText, TopText);
  OutTextXY(ANCHO div 2,  6, 'UNIVERSIDAD AUTONOMA CHAPINGO - IRRIGACION');
  SetColor(Yellow);
  OutTextXY(ANCHO div 2, 22, Titulo);
  SetTextJustify(LeftText, TopText);
  SetColor(White);
end;

procedure Inicia_grafico;
var gd, gm: smallint;
begin
  gd := Detect;
  InitGraph(gd, gm, '');
  if GraphResult <> grOk then Halt(1);
  Ventana_abierta := True;
  SetBkColor(Black);
  ClearDevice;
end;

procedure Termina_grafico;
begin
  if Ventana_abierta then begin CloseGraph; Ventana_abierta := False; end;
end;

function Abre_ventana(const Titulo: string): boolean;
begin
  if not Ventana_abierta then Inicia_grafico;
  SetBkColor(Black);
  ClearDevice;
  Dibuja_encabezado(Titulo);
  Abre_ventana := True;
end;

procedure Cierra_ventana;
begin
  { en la variante de una ventana no se cierra el modo grafico }
end;

function CentroX: integer; begin CentroX := ANCHO div 2; end;
function CentroY: integer; begin CentroY := (ALTO div 2) + 10; end;

function Escala(unidadesAncho, unidadesAlto: real): real;
var sx, sy: real;
begin
  if unidadesAncho <= 0 then unidadesAncho := 1;
  if unidadesAlto  <= 0 then unidadesAlto  := 1;
  sx := (ANCHO - 2 * MARGEN) / unidadesAncho;
  sy := (ALTO  - 2 * MARGEN) / unidadesAlto;
  if sx < sy then Escala := sx else Escala := sy;
end;

procedure Pie_de_pagina(const Info: string);
begin
  if Info = '' then Exit;
  SetColor(LightGreen);
  SetTextStyle(DefaultFont, HorizDir, 1);
  SetTextJustify(CenterText, BottomText);
  OutTextXY(ANCHO div 2, ALTO - 8, Info);
  SetTextJustify(LeftText, TopText);
  SetColor(White);
end;

{ borra la zona de entrada/mensajes (parte baja de la ventana) }
procedure Limpia_zona;
begin
  SetFillStyle(SolidFill, Black);
  Bar(0, ZONA_Y - 6, ANCHO - 1, ZONA_Y + 26);
end;

procedure Espera_y_cierra;
begin
  Limpia_zona;
  SetColor(LightGray);
  SetTextStyle(DefaultFont, HorizDir, 1);
  SetTextJustify(LeftText, TopText);
  OutTextXY(MARGEN, ZONA_Y, 'Pulse una tecla para volver al menu...');
  ReadKey;
end;

procedure Aviso(const s: string);
begin
  Limpia_zona;
  SetColor(LightRed);
  SetTextStyle(DefaultFont, HorizDir, 1);
  SetTextJustify(LeftText, TopText);
  OutTextXY(MARGEN, ZONA_Y, s);
  Delay(1300);
  Limpia_zona;
end;

procedure Muestra_panel(const Titulo: string; const Lineas: array of string);
var i, y: integer;
begin
  Abre_ventana(Titulo);
  SetColor(White);
  SetTextStyle(DefaultFont, HorizDir, 2);
  SetTextJustify(LeftText, TopText);
  y := 70;
  for i := Low(Lineas) to High(Lineas) do
  begin
    OutTextXY(MARGEN, y, Lineas[i]);
    Inc(y, 28);
  end;
  SetTextStyle(DefaultFont, HorizDir, 1);
  Pie_de_pagina('Grupo 4A - Irrigacion');
  Espera_y_cierra;
end;

{ ====================== ENTRADA EN VENTANA ====================== }

{ Lee una linea de texto mostrando lo tecleado en la zona de entrada. }
function Lee_cadena(const Mensaje: string): string;
var s: string; ch: char;
begin
  s := '';
  repeat
    Limpia_zona;
    SetColor(Yellow);
    SetTextStyle(DefaultFont, HorizDir, 1);
    SetTextJustify(LeftText, TopText);
    OutTextXY(MARGEN, ZONA_Y, Mensaje + s + '_');
    ch := ReadKey;
    if ch = #0 then
      ReadKey                              { descarta tecla extendida }
    else if (ch = #13) then
      Break
    else if (ch = #8) then
    begin
      if Length(s) > 0 then SetLength(s, Length(s) - 1);
    end
    else if ch >= ' ' then
      s := s + ch;
  until False;
  Limpia_zona;
  SetColor(LightGreen);
  OutTextXY(MARGEN, ZONA_Y, Mensaje + s);
  SetColor(White);
  Lee_cadena := s;
end;

function Lee_real(const Mensaje: string): real;
var s: string; r: real;
begin
  repeat
    s := Lee_cadena(Mensaje);
    s := StringReplace(Trim(s), ',', '.', [rfReplaceAll]);
    if s <> '' then
    begin
      Val(s, r, Codigo_de_error);
      if Codigo_de_error = 0 then Exit(r);
    end;
    Aviso('Entrada invalida. Use numeros (ej. 5 o 5.5).');
  until False;
end;

function Lee_real_positivo(const Mensaje: string): real;
var r: real;
begin
  repeat
    r := Lee_real(Mensaje);
    if r > 0 then Exit(r);
    Aviso('El valor debe ser mayor que cero.');
  until False;
end;

function Lee_entero(const Mensaje: string): integer;
var s: string; n: integer;
begin
  repeat
    s := Trim(Lee_cadena(Mensaje));
    if s <> '' then
    begin
      Val(s, n, Codigo_de_error);
      if Codigo_de_error = 0 then Exit(n);
    end;
    Aviso('Entrada invalida. Use un numero entero.');
  until False;
end;

function Lee_entero_rango(const Mensaje: string; Lo, Hi: integer): integer;
var n: integer;
begin
  repeat
    n := Lee_entero(Mensaje);
    if (n >= Lo) and (n <= Hi) then Exit(n);
    Aviso('El valor debe estar entre ' + Entero_a_Cadena(Lo, 1) +
          ' y ' + Entero_a_Cadena(Hi, 1) + '.');
  until False;
end;

function Lee_sexo(const Mensaje: string): char;
var s: string;
begin
  repeat
    s := UpperCase(Trim(Lee_cadena(Mensaje)));
    if s = 'H' then Exit('H');
    if s = 'M' then Exit('M');
    Aviso('Use H (hombre) o M (mujer).');
  until False;
end;

procedure Captura_datos(var D: TArregloReal; var N: integer; Lo, Hi: integer);
var i: integer;
begin
  Abre_ventana('CAPTURA DE DATOS');
  N := Lee_entero_rango('Cuantos datos va a capturar (' +
       Entero_a_Cadena(Lo, 1) + ' a ' + Entero_a_Cadena(Hi, 1) + '): ', Lo, Hi);
  for i := 1 to N do
    D[i] := Lee_real('Dato ' + Entero_a_Cadena(i, 1) + ' de ' +
            Entero_a_Cadena(N, 1) + ': ');
end;

procedure Pausa;
begin
  Limpia_zona;
  SetColor(LightGray);
  SetTextStyle(DefaultFont, HorizDir, 1);
  OutTextXY(MARGEN, ZONA_Y, 'Pulse una tecla para continuar...');
  ReadKey;
  Limpia_zona;
end;

{ ====================== MENU EN VENTANA ====================== }

function Pantalla_menu(const Titulo: string; const Lineas: array of string;
                       Lo, Hi: integer): integer;
var i, y: integer;
begin
  Abre_ventana(Titulo);
  SetColor(White);
  SetTextStyle(DefaultFont, HorizDir, 1);
  SetTextJustify(LeftText, TopText);
  y := 60;
  for i := Low(Lineas) to High(Lineas) do
  begin
    OutTextXY(MARGEN, y, Lineas[i]);
    Inc(y, 18);
  end;
  Pie_de_pagina('Grupo 4A - Irrigacion');
  Pantalla_menu := Lee_entero_rango('Opcion: ', Lo, Hi);
end;

end.
