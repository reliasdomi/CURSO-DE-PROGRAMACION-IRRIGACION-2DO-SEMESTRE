{ ==================================================================
  INTEGRANTES - Grupo 4A - Irrigacion - U.A. Chapingo:
    - ELIAS DOMINGUEZ RUBEN
    - BISTRAIN BORRAZ ANGEL GABRIEL
    - CRUZ SIBAJA GIBRAN FRANCISCO
    - TORRES VALENCIA MARIO ALBERTO
  ================================================================== }
unit uComun;
{ Utilidades compartidas del paquete PASCAL (modo grafico real).
  - Lectura validada desde consola.
  - Ventana grafica (unit Graph / backend ptcgraph) con banner institucional.
  - Panel de resultados y grafica de barras reutilizables.
  - Captura de un GRUPO de personas (nombre, sexo, edad, estatura).

  Universidad Autonoma Chapingo - Departamento de Irrigacion.
  Grupo 4A. }

{$mode objfpc}{$H+}

interface

const
  MAXP   = 100;
  ANCHO  = 640;
  ALTO   = 480;
  MARGEN = 80;

type
  TDatos = array[1..MAXP] of Double;
  TGrupo = record
    n: Integer;
    nombre: array[1..MAXP] of string;
    sexo:   array[1..MAXP] of Char;     { 'H' = hombre, 'M' = mujer }
    edad:   array[1..MAXP] of Integer;
    est:    array[1..MAXP] of Double;
  end;

{ ---- Consola ---- }
function  LeerReal(const Msg: string): Double;
function  LeerRealPos(const Msg: string): Double;
function  LeerEntero(const Msg: string): Integer;
function  LeerEnteroRango(const Msg: string; Lo, Hi: Integer): Integer;
function  LeerCuantos(const Msg: string; Lo, Hi: Integer): Integer;
function  Fmt(X: Double): string;
procedure CapturarDatos(var D: TDatos; var N: Integer; Lo, Hi: Integer);
procedure CapturarGrupo(var G: TGrupo);

{ ---- Ventana grafica ---- }
function  AbrirVentana(const Titulo: string): Boolean;
procedure CerrarVentana;
procedure PiePagina(const Info: string);
procedure EsperarYCerrar;
function  CentroX: Integer;
function  CentroY: Integer;
procedure MostrarPanel(const Titulo: string; const Lineas: array of string);
procedure GraficarBarras(const Titulo: string; const D: TDatos; N: Integer;
                         const Lineas: array of string);

implementation

uses Graph, Math, SysUtils;

var
  Abierto: Boolean = False;

{ ====================== CONSOLA ====================== }

function LeerReal(const Msg: string): Double;
var s: string; v: Double;
begin
  repeat
    Write(Msg);
    ReadLn(s);
    if TryStrToFloat(Trim(s), v) then Exit(v);
    WriteLn('  Entrada invalida. Use numeros (ej: 5 o 5.5).');
  until False;
end;

function LeerRealPos(const Msg: string): Double;
var v: Double;
begin
  repeat
    v := LeerReal(Msg);
    if v > 0 then Exit(v);
    WriteLn('  El valor debe ser mayor que cero.');
  until False;
end;

function LeerEntero(const Msg: string): Integer;
var s: string; v: Integer;
begin
  repeat
    Write(Msg);
    ReadLn(s);
    if TryStrToInt(Trim(s), v) then Exit(v);
    WriteLn('  Entrada invalida. Use un numero entero.');
  until False;
end;

function LeerEnteroRango(const Msg: string; Lo, Hi: Integer): Integer;
var v: Integer;
begin
  repeat
    v := LeerEntero(Msg);
    if (v >= Lo) and (v <= Hi) then Exit(v);
    WriteLn('  El valor debe estar entre ', Lo, ' y ', Hi, '.');
  until False;
end;

function LeerCuantos(const Msg: string; Lo, Hi: Integer): Integer;
begin
  Result := LeerEnteroRango(Msg, Lo, Hi);
end;

{ Formato compacto: hasta 4 decimales, sin ceros sobrantes. }
function Fmt(X: Double): string;
begin
  Result := FormatFloat('0.####', X);
end;

procedure CapturarDatos(var D: TDatos; var N: Integer; Lo, Hi: Integer);
var i: Integer;
begin
  N := LeerCuantos('Cuantos datos va a capturar (' + IntToStr(Lo) + ' a ' +
                   IntToStr(Hi) + '): ', Lo, Hi);
  for i := 1 to N do
    D[i] := LeerReal('Dato ' + IntToStr(i) + ': ');
end;

function LeerSexo(const Msg: string): Char;
var s: string;
begin
  repeat
    Write(Msg);
    ReadLn(s);
    s := UpperCase(Trim(s));
    if s = 'H' then Exit('H');
    if s = 'M' then Exit('M');
    WriteLn('  Use H (hombre) o M (mujer).');
  until False;
end;

procedure CapturarGrupo(var G: TGrupo);
var i: Integer;
begin
  G.n := LeerCuantos('Cuantas personas (1 a 100): ', 1, MAXP);
  for i := 1 to G.n do
  begin
    WriteLn('--- Persona ', i, ' ---');
    Write('  Nombre: '); ReadLn(G.nombre[i]);
    G.sexo[i] := LeerSexo('  Sexo (H/M): ');
    G.edad[i] := LeerEnteroRango('  Edad (0 a 130): ', 0, 130);
    G.est[i]  := LeerRealPos('  Estatura en metros (> 0): ');
  end;
end;

{ ====================== GRAFICO ====================== }

function CentroX: Integer; begin Result := ANCHO div 2; end;
function CentroY: Integer; begin Result := (ALTO div 2) + 10; end;

function AbrirVentana(const Titulo: string): Boolean;
var gd, gm: SmallInt;
begin
  if Abierto then begin CloseGraph; Abierto := False; end;
  gd := Detect;
  InitGraph(gd, gm, '');
  if GraphResult <> grOk then
  begin
    WriteLn('Error: no se pudo iniciar el modo grafico.');
    Exit(False);
  end;
  Abierto := True;
  SetBkColor(Black);
  ClearDevice;
  SetColor(LightCyan);
  SetTextStyle(DefaultFont, HorizDir, 1);
  SetTextJustify(CenterText, TopText);
  OutTextXY(ANCHO div 2, 6,  'UNIVERSIDAD AUTONOMA CHAPINGO - IRRIGACION');
  SetColor(Yellow);
  OutTextXY(ANCHO div 2, 22, Titulo);
  SetTextJustify(LeftText, TopText);
  Result := True;
end;

procedure CerrarVentana;
begin
  if Abierto then begin CloseGraph; Abierto := False; end;
end;

procedure PiePagina(const Info: string);
begin
  if Info = '' then Exit;
  SetColor(LightGreen);
  SetTextJustify(CenterText, BottomText);
  OutTextXY(ANCHO div 2, ALTO - 8, Info);
  SetTextJustify(LeftText, TopText);
end;

procedure EsperarYCerrar;
begin
  WriteLn;
  Write('Observe la ventana grafica. Pulse ENTER aqui para volver al menu...');
  ReadLn;
  CerrarVentana;
end;

{ Ventana con titulo y lista de lineas de texto centradas a la izquierda. }
procedure MostrarPanel(const Titulo: string; const Lineas: array of string);
var i, y: Integer;
begin
  if not AbrirVentana(Titulo) then Exit;
  SetColor(White);
  SetTextStyle(DefaultFont, HorizDir, 2);
  y := 70;
  for i := Low(Lineas) to High(Lineas) do
  begin
    OutTextXY(MARGEN, y, Lineas[i]);
    Inc(y, 28);
  end;
  SetTextStyle(DefaultFont, HorizDir, 1);
  PiePagina('Grupo 4A - Irrigacion');
  EsperarYCerrar;
end;

{ Grafica de barras de un conjunto de datos + lineas de texto al pie. }
procedure GraficarBarras(const Titulo: string; const D: TDatos; N: Integer;
                         const Lineas: array of string);
var
  i, x0, anchoBarra, hBarra, baseY, topArea: Integer;
  vmin, vmax, rango: Double;
begin
  if not AbrirVentana(Titulo) then Exit;
  if N < 1 then begin EsperarYCerrar; Exit; end;

  vmin := D[1]; vmax := D[1];
  for i := 2 to N do
  begin
    if D[i] < vmin then vmin := D[i];
    if D[i] > vmax then vmax := D[i];
  end;
  if vmin > 0 then vmin := 0;          { incluir el cero como base }
  rango := vmax - vmin;
  if rango <= 0 then rango := 1;

  topArea := 50;
  baseY   := ALTO - 120;               { deja espacio para las lineas de texto }
  anchoBarra := Max(4, (ANCHO - 2 * MARGEN) div N);

  SetColor(DarkGray);
  Line(MARGEN, baseY, ANCHO - MARGEN, baseY);

  for i := 1 to N do
  begin
    x0 := MARGEN + (i - 1) * anchoBarra;
    hBarra := Round((D[i] - vmin) / rango * (baseY - topArea));
    SetColor(LightBlue);
    SetFillStyle(SolidFill, Blue);
    Bar(x0 + 1, baseY - hBarra, x0 + anchoBarra - 2, baseY);
    SetColor(White);
    Rectangle(x0 + 1, baseY - hBarra, x0 + anchoBarra - 2, baseY);
  end;

  SetColor(Yellow);
  SetTextStyle(DefaultFont, HorizDir, 1);
  for i := Low(Lineas) to High(Lineas) do
    OutTextXY(MARGEN, baseY + 16 + (i - Low(Lineas)) * 14, Lineas[i]);
  EsperarYCerrar;
end;

end.
