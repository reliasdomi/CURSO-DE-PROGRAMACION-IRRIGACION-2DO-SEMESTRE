unit U_Comun;

{ ------------------------------------------------------------------
  U_Comun.pas - Utilidades comunes en el ESTILO DEL PROFESOR.

  - Conversion de cadenas con Val/Str (Cadena_a_real, real_a_Cadena, ...)
  - Lectura validada desde consola.
  - Ventana grafica (unit Graph) con encabezado institucional, para
    dibujar las figuras con primitivas reales (Line, Rectangle, Circle).

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

{ ---- conversiones estilo profesor (Val / Str) ---- }
function Cadena_a_byte(cadena: string): byte;
function Cadena_a_entero(cadena: string): integer;
function Cadena_a_real(cadena: string): real;
function Byte_a_Cadena(Numero, campo: byte): string;
function Entero_a_Cadena(Numero: integer; campo: byte): string;
function real_a_Cadena(Numero: real; campo, decimales: byte): string;

{ ---- entrada por consola ---- }
function Lee_real(const Mensaje: string): real;
function Lee_real_positivo(const Mensaje: string): real;
function Lee_entero(const Mensaje: string): integer;
function Lee_entero_rango(const Mensaje: string; Lo, Hi: integer): integer;
function Lee_sexo(const Mensaje: string): char;
procedure Captura_datos(var D: TArregloReal; var N: integer; Lo, Hi: integer);
procedure Pausa;

{ ---- ventana grafica (unit Graph) ---- }
function  Abre_ventana(const Titulo: string): boolean;
procedure Cierra_ventana;
function  CentroX: integer;
function  CentroY: integer;
procedure Pie_de_pagina(const Info: string);
procedure Espera_y_cierra;
function  Escala(unidadesAncho, unidadesAlto: real): real;
procedure Muestra_panel(const Titulo: string; const Lineas: array of string);

implementation

uses Graph, Crt, SysUtils;

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

{ ====================== CONSOLA ====================== }

function Lee_real(const Mensaje: string): real;
var s: string; r: real;
begin
  repeat
    Write(Mensaje);
    ReadLn(s);
    s := StringReplace(Trim(s), ',', '.', [rfReplaceAll]);
    if s <> '' then
    begin
      Val(s, r, Codigo_de_error);
      if Codigo_de_error = 0 then Exit(r);
    end;
    WriteLn('  Entrada invalida. Use numeros (ej. 5 o 5.5).');
  until False;
end;

function Lee_real_positivo(const Mensaje: string): real;
var r: real;
begin
  repeat
    r := Lee_real(Mensaje);
    if r > 0 then Exit(r);
    WriteLn('  El valor debe ser mayor que cero.');
  until False;
end;

function Lee_entero(const Mensaje: string): integer;
var s: string; n: integer;
begin
  repeat
    Write(Mensaje);
    ReadLn(s);
    s := Trim(s);
    if s <> '' then
    begin
      Val(s, n, Codigo_de_error);
      if Codigo_de_error = 0 then Exit(n);
    end;
    WriteLn('  Entrada invalida. Use un numero entero.');
  until False;
end;

function Lee_entero_rango(const Mensaje: string; Lo, Hi: integer): integer;
var n: integer;
begin
  repeat
    n := Lee_entero(Mensaje);
    if (n >= Lo) and (n <= Hi) then Exit(n);
    WriteLn('  El valor debe estar entre ', Lo, ' y ', Hi, '.');
  until False;
end;

function Lee_sexo(const Mensaje: string): char;
var s: string;
begin
  repeat
    Write(Mensaje);
    ReadLn(s);
    s := UpperCase(Trim(s));
    if s = 'H' then Exit('H');
    if s = 'M' then Exit('M');
    WriteLn('  Use H (hombre) o M (mujer).');
  until False;
end;

procedure Captura_datos(var D: TArregloReal; var N: integer; Lo, Hi: integer);
var i: integer;
begin
  N := Lee_entero_rango('Cuantos datos va a capturar (' +
       Entero_a_Cadena(Lo, 1) + ' a ' + Entero_a_Cadena(Hi, 1) + '): ', Lo, Hi);
  for i := 1 to N do
    D[i] := Lee_real('  Dato ' + Entero_a_Cadena(i, 1) + ': ');
end;

procedure Pausa;
var s: string;
begin
  Write('Pulse ENTER para continuar...');
  ReadLn(s);
end;

{ ====================== GRAFICO ====================== }

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

function Abre_ventana(const Titulo: string): boolean;
var gd, gm: smallint;
begin
  if Ventana_abierta then begin CloseGraph; Ventana_abierta := False; end;
  gd := Detect;
  InitGraph(gd, gm, '');
  if GraphResult <> grOk then
  begin
    WriteLn('Error: no se pudo iniciar el modo grafico.');
    Exit(False);
  end;
  Ventana_abierta := True;
  SetBkColor(Black);
  ClearDevice;
  SetColor(LightCyan);
  SetTextStyle(DefaultFont, HorizDir, 1);
  SetTextJustify(CenterText, TopText);
  OutTextXY(ANCHO div 2,  6, 'UNIVERSIDAD AUTONOMA CHAPINGO - IRRIGACION');
  SetColor(Yellow);
  OutTextXY(ANCHO div 2, 22, Titulo);
  SetTextJustify(LeftText, TopText);
  SetColor(White);
  Abre_ventana := True;
end;

procedure Cierra_ventana;
begin
  if Ventana_abierta then begin CloseGraph; Ventana_abierta := False; end;
end;

procedure Pie_de_pagina(const Info: string);
begin
  if Info = '' then Exit;
  SetColor(LightGreen);
  SetTextJustify(CenterText, BottomText);
  OutTextXY(ANCHO div 2, ALTO - 8, Info);
  SetTextJustify(LeftText, TopText);
end;

procedure Espera_y_cierra;
var s: string;
begin
  WriteLn;
  Write('Observe la ventana grafica. Pulse ENTER aqui para volver al menu...');
  ReadLn(s);
  Cierra_ventana;
end;

procedure Muestra_panel(const Titulo: string; const Lineas: array of string);
var i, y: integer;
begin
  if not Abre_ventana(Titulo) then Exit;
  SetColor(White);
  SetTextStyle(DefaultFont, HorizDir, 2);
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

end.
