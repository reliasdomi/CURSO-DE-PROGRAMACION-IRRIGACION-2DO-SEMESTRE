unit uFigurasDibujo;
{ Dibujo de las figuras geometricas en MODO GRAFICO real usando la unit Graph
  de Free Pascal (backend ptcgraph en Windows -> abre una ventana grafica BGI).
  Cada figura se escala para encajar centrada en la ventana de 640x480.
  Universidad Autonoma Chapingo - Departamento de Irrigacion. }

{$mode objfpc}{$H+}

interface

procedure DibCuadrado(Lado: Double; const Info: string);
procedure DibRectangulo(Base, Altura: Double; const Info: string);
procedure DibTriangulo(Base, Altura: Double; const Info: string);
procedure DibCirculo(Radio: Double; const Info: string);
procedure DibRombo(DiagMayor, DiagMenor: Double; const Info: string);
procedure DibTrapecio(BaseMayor, BaseMenor, Altura: Double; const Info: string);
procedure DibPoligono(NumLados: Integer; Lado: Double; const Info: string);
procedure CerrarGrafico;

implementation

uses Graph, Math, SysUtils;

const
  ANCHO  = 640;
  ALTO   = 480;
  MARGEN = 80;   { espacio reservado para titulo/textos }

var
  Abierto: Boolean = False;

{ Inicia la ventana grafica. Devuelve True si quedo lista. }
function Abrir(const Titulo: string): Boolean;
var
  gd, gm: SmallInt;
begin
  if Abierto then
  begin
    CloseGraph;
    Abierto := False;
  end;
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

  { Banner institucional }
  SetColor(LightCyan);
  SetTextStyle(DefaultFont, HorizDir, 1);
  SetTextJustify(CenterText, TopText);
  OutTextXY(ANCHO div 2, 6,  'UNIVERSIDAD AUTONOMA CHAPINGO - IRRIGACION');
  SetColor(Yellow);
  OutTextXY(ANCHO div 2, 22, Titulo);
  SetTextJustify(LeftText, TopText);
  Result := True;
end;

procedure CerrarGrafico;
begin
  if Abierto then
  begin
    CloseGraph;
    Abierto := False;
  end;
end;

{ Factor de escala para que un objeto de Ancho x Alto unidades quepa en el area util. }
function Escala(AnchoU, AltoU: Double): Double;
begin
  if AnchoU <= 0 then AnchoU := 1;
  if AltoU  <= 0 then AltoU  := 1;
  Result := Min((ANCHO - 2 * MARGEN) / AnchoU, (ALTO - 2 * MARGEN) / AltoU);
end;

{ Pie con area / perimetro. }
procedure PiePagina(const Info: string);
begin
  SetColor(LightGreen);
  SetTextJustify(CenterText, BottomText);
  OutTextXY(ANCHO div 2, ALTO - 8, Info);
  SetTextJustify(LeftText, TopText);
end;

function Cx: Integer; begin Result := ANCHO div 2; end;
function Cy: Integer; begin Result := (ALTO div 2) + 10; end;

procedure DibCuadrado(Lado: Double; const Info: string);
var s: Double; m: Integer;
begin
  if not Abrir('CUADRADO') then Exit;
  s := Escala(Lado, Lado);
  m := Round(Lado * s) div 2;
  SetColor(White);
  Rectangle(Cx - m, Cy - m, Cx + m, Cy + m);
  PiePagina(Info);
end;

procedure DibRectangulo(Base, Altura: Double; const Info: string);
var s: Double; bw, bh: Integer;
begin
  if not Abrir('RECTANGULO') then Exit;
  s := Escala(Base, Altura);
  bw := Round(Base * s) div 2;
  bh := Round(Altura * s) div 2;
  SetColor(White);
  Rectangle(Cx - bw, Cy - bh, Cx + bw, Cy + bh);
  PiePagina(Info);
end;

procedure DibTriangulo(Base, Altura: Double; const Info: string);
var s: Double; bw, bh: Integer;
begin
  if not Abrir('TRIANGULO') then Exit;
  s := Escala(Base, Altura);
  bw := Round(Base * s) div 2;
  bh := Round(Altura * s) div 2;
  SetColor(White);
  Line(Cx, Cy - bh, Cx - bw, Cy + bh);   { izquierda }
  Line(Cx - bw, Cy + bh, Cx + bw, Cy + bh); { base }
  Line(Cx + bw, Cy + bh, Cx, Cy - bh);   { derecha }
  PiePagina(Info);
end;

procedure DibCirculo(Radio: Double; const Info: string);
var s: Double; pr: Integer;
begin
  if not Abrir('CIRCULO') then Exit;
  s := Escala(2 * Radio, 2 * Radio);
  pr := Round(Radio * s);
  SetColor(White);
  Circle(Cx, Cy, pr);
  PiePagina(Info);
end;

procedure DibRombo(DiagMayor, DiagMenor: Double; const Info: string);
var s: Double; hw, hh: Integer;
begin
  if not Abrir('ROMBO') then Exit;
  s := Escala(DiagMayor, DiagMenor);
  hw := Round(DiagMayor * s) div 2;
  hh := Round(DiagMenor * s) div 2;
  SetColor(White);
  Line(Cx, Cy - hh, Cx + hw, Cy);
  Line(Cx + hw, Cy, Cx, Cy + hh);
  Line(Cx, Cy + hh, Cx - hw, Cy);
  Line(Cx - hw, Cy, Cx, Cy - hh);
  PiePagina(Info);
end;

procedure DibTrapecio(BaseMayor, BaseMenor, Altura: Double; const Info: string);
var s, anchoU: Double; bM, bm2, h2, topY, botY: Integer;
begin
  if not Abrir('TRAPECIO') then Exit;
  anchoU := Max(BaseMayor, BaseMenor);
  s := Escala(anchoU, Altura);
  bM  := Round(BaseMayor * s) div 2;
  bm2 := Round(BaseMenor * s) div 2;
  h2  := Round(Altura * s) div 2;
  topY := Cy - h2;
  botY := Cy + h2;
  SetColor(White);
  Line(Cx - bm2, topY, Cx + bm2, topY);   { base menor (arriba) }
  Line(Cx + bm2, topY, Cx + bM, botY);    { lado derecho }
  Line(Cx + bM, botY, Cx - bM, botY);     { base mayor (abajo) }
  Line(Cx - bM, botY, Cx - bm2, topY);    { lado izquierdo }
  PiePagina(Info);
end;

procedure DibPoligono(NumLados: Integer; Lado: Double; const Info: string);
var
  R, s, ang: Double;
  pr, i, x0, y0, x1, y1, xIni, yIni: Integer;
begin
  if not Abrir('POLIGONO REGULAR') then Exit;
  { circunradio del poligono regular }
  R := Lado / (2 * Sin(Pi / NumLados));
  s := Escala(2 * R, 2 * R);
  pr := Round(R * s);
  SetColor(White);
  xIni := Cx + Round(pr * Cos(-Pi / 2));
  yIni := Cy + Round(pr * Sin(-Pi / 2));
  x0 := xIni; y0 := yIni;
  for i := 1 to NumLados do
  begin
    ang := -Pi / 2 + 2 * Pi * i / NumLados;
    x1 := Cx + Round(pr * Cos(ang));
    y1 := Cy + Round(pr * Sin(ang));
    Line(x0, y0, x1, y1);
    x0 := x1; y0 := y1;
  end;
  PiePagina(Info);
end;

end.
