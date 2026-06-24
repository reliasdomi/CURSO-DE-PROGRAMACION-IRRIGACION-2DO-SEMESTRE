{ ==================================================================
  INTEGRANTES - Grupo 4A - Irrigacion - U.A. Chapingo:
    - ELIAS DOMINGUEZ RUBEN
    - BISTRAIN BORRAZ ANGEL GABRIEL
    - CRUZ SIBAJA GIBRAN FRANCISCO
    - TORRES VALENCIA MARIO ALBERTO
  ================================================================== }
unit uLogica;
{ Capa de calculo PURA (sin interfaz) de los 42 programas del Grupo 4A.
  No usa VCL: compila con Delphi y tambien con Free Pascal (-Mdelphi) para
  smoke-test de la logica. Portado de los programas QBasic de 'entregado\'.
  Universidad Autonoma Chapingo - Departamento de Irrigacion. }

{$IFDEF FPC}{$MODE DELPHI}{$ENDIF}

interface

type
  TVector = array of Double;
  TMatriz = array of array of Double;

  TPersona = record
    Nombre: string;
    Sexo: Char;        { 'H' o 'M' }
    Edad: Double;
    Estatura: Double;
  end;
  TGrupo = array of TPersona;

  TSexoFiltro = (sfTodos, sfHombres, sfMujeres);
  TCampo = (cpEdad, cpEstatura);
  TMetrica = (mtMinimo, mtMaximo, mtPromedio);

  TResFigura = record
    Area: Double;
    Perimetro: Double;
  end;

{ ---- Figuras (01-06, 38) ---- }
function FigCuadrado(Lado: Double): TResFigura;
function FigRectangulo(Base, Altura: Double): TResFigura;
function FigTriangulo(Base, Altura, Lado1, Lado2: Double): TResFigura;
function FigCirculo(Radio: Double): TResFigura;
function FigRombo(DiagMayor, DiagMenor, Lado: Double): TResFigura;
function FigTrapecio(BaseMayor, BaseMenor, Altura, Lado1, Lado2: Double): TResFigura;
function FigPoligono(NumLados: Integer; Lado: Double): TResFigura;

{ ---- Misc escalares (07, 08) ---- }
function EsPar(N: Int64): Boolean;
{ Devuelve cantidad de raices reales (0,1,2); las raices validas en X1,X2. }
function Cuadratica(A, B, C: Double; out Disc, X1, X2: Double): Integer;

{ ---- Datos N (09-15, 36, 37) ---- }
function VecMaximo(const D: TVector): Double;
function VecMinimo(const D: TVector): Double;
function VecMedia(const D: TVector): Double;
function VecMediana(const D: TVector): Double;
function VecModa(const D: TVector; out Frecuencia: Integer): Double;  { Frecuencia=1 => sin moda }
function VecOrdenado(const D: TVector; Ascendente: Boolean): TVector;
{ Regresion lineal Y = a + bX. Result=False si X no varia. }
function Regresion(const X, Y: TVector; out A, B: Double): Boolean;
{ Varianza / desviacion. HayMuestral=False si n<=1. }
procedure VarianzaDesviacion(const D: TVector;
  out Media, Minimo, Maximo, VarPob, DesvPob, VarMue, DesvMue: Double;
  out HayMuestral: Boolean);

{ ---- Demografia de grupo (16-35) ---- }
function ContarSexo(const G: TGrupo; Filtro: TSexoFiltro): Integer;
{ Cuenta por mayoria de edad (>=18). EsMayor=True cuenta mayores; False menores. }
function ContarEdad(const G: TGrupo; Filtro: TSexoFiltro; EsMayor: Boolean): Integer;
{ Min/Max/Promedio de un campo con filtro de sexo. OK=False si no hay elementos. }
function AgregaCampo(const G: TGrupo; Filtro: TSexoFiltro; Campo: TCampo;
  Metrica: TMetrica; out Valor: Double): Boolean;

{ ---- Matrices (39-42) ---- }
function MatSuma(const A, B: TMatriz): TMatriz;
function MatResta(const A, B: TMatriz): TMatriz;
function MatTranspuesta(const A: TMatriz): TMatriz;
{ Inversa 2x2. Result=False si determinante=0. Det devuelve el determinante. }
function MatInversa2x2(const A: TMatriz; out Inv: TMatriz; out Det: Double): Boolean;

implementation

uses SysUtils, Math;

{ ===== Figuras ===== }

function FigCuadrado(Lado: Double): TResFigura;
begin
  Result.Area := Lado * Lado;
  Result.Perimetro := 4 * Lado;
end;

function FigRectangulo(Base, Altura: Double): TResFigura;
begin
  Result.Area := Base * Altura;
  Result.Perimetro := 2 * (Base + Altura);
end;

function FigTriangulo(Base, Altura, Lado1, Lado2: Double): TResFigura;
begin
  Result.Area := Base * Altura / 2;
  Result.Perimetro := Base + Lado1 + Lado2;
end;

function FigCirculo(Radio: Double): TResFigura;
begin
  Result.Area := Pi * Sqr(Radio);
  Result.Perimetro := 2 * Pi * Radio;
end;

function FigRombo(DiagMayor, DiagMenor, Lado: Double): TResFigura;
begin
  Result.Area := DiagMayor * DiagMenor / 2;
  Result.Perimetro := 4 * Lado;
end;

function FigTrapecio(BaseMayor, BaseMenor, Altura, Lado1, Lado2: Double): TResFigura;
begin
  Result.Area := (BaseMayor + BaseMenor) * Altura / 2;
  Result.Perimetro := BaseMayor + BaseMenor + Lado1 + Lado2;
end;

function FigPoligono(NumLados: Integer; Lado: Double): TResFigura;
var Apotema: Double;
begin
  Result.Perimetro := NumLados * Lado;
  Apotema := Lado / (2 * Tan(Pi / NumLados));
  Result.Area := Result.Perimetro * Apotema / 2;
end;

{ ===== Misc escalares ===== }

function EsPar(N: Int64): Boolean;
begin
  Result := (N mod 2) = 0;
end;

function Cuadratica(A, B, C: Double; out Disc, X1, X2: Double): Integer;
begin
  Disc := B * B - 4 * A * C;
  X1 := 0; X2 := 0;
  if Disc < 0 then
    Result := 0
  else if Disc = 0 then
  begin
    X1 := -B / (2 * A);
    X2 := X1;
    Result := 1;
  end
  else
  begin
    X1 := (-B + Sqrt(Disc)) / (2 * A);
    X2 := (-B - Sqrt(Disc)) / (2 * A);
    Result := 2;
  end;
end;

{ ===== Datos N ===== }

function VecMaximo(const D: TVector): Double;
var i: Integer;
begin
  Result := D[0];
  for i := 1 to High(D) do
    if D[i] > Result then Result := D[i];
end;

function VecMinimo(const D: TVector): Double;
var i: Integer;
begin
  Result := D[0];
  for i := 1 to High(D) do
    if D[i] < Result then Result := D[i];
end;

function VecMedia(const D: TVector): Double;
var i: Integer; s: Double;
begin
  s := 0;
  for i := 0 to High(D) do s := s + D[i];
  Result := s / Length(D);
end;

function CopiarOrdenado(const D: TVector): TVector;
var i, j: Integer; t: Double;
begin
  Result := Copy(D, 0, Length(D));
  for i := 0 to High(Result) - 1 do
    for j := 0 to High(Result) - 1 - i do
      if Result[j] > Result[j + 1] then
      begin
        t := Result[j]; Result[j] := Result[j + 1]; Result[j + 1] := t;
      end;
end;

function VecMediana(const D: TVector): Double;
var s: TVector; n: Integer;
begin
  s := CopiarOrdenado(D);
  n := Length(s);
  if (n mod 2) = 1 then
    Result := s[n div 2]
  else
    Result := (s[n div 2 - 1] + s[n div 2]) / 2;
end;

function VecModa(const D: TVector; out Frecuencia: Integer): Double;
var i, j, cont, maxfreq: Integer;
begin
  maxfreq := 0;
  Result := D[0];
  for i := 0 to High(D) do
  begin
    cont := 0;
    for j := 0 to High(D) do
      if D[j] = D[i] then Inc(cont);
    if cont > maxfreq then
    begin
      maxfreq := cont;
      Result := D[i];
    end;
  end;
  Frecuencia := maxfreq;
end;

function VecOrdenado(const D: TVector; Ascendente: Boolean): TVector;
var s: TVector; i, n: Integer; t: Double;
begin
  s := CopiarOrdenado(D);
  if not Ascendente then
  begin
    n := Length(s);
    for i := 0 to (n div 2) - 1 do
    begin
      t := s[i]; s[i] := s[n - 1 - i]; s[n - 1 - i] := t;
    end;
  end;
  Result := s;
end;

function Regresion(const X, Y: TVector; out A, B: Double): Boolean;
var i, n: Integer; sx, sy, sxy, sx2, den: Double;
begin
  n := Length(X);
  sx := 0; sy := 0; sxy := 0; sx2 := 0;
  for i := 0 to n - 1 do
  begin
    sx := sx + X[i];
    sy := sy + Y[i];
    sxy := sxy + X[i] * Y[i];
    sx2 := sx2 + X[i] * X[i];
  end;
  den := n * sx2 - sx * sx;
  if den = 0 then
  begin
    A := 0; B := 0;
    Exit(False);
  end;
  B := (n * sxy - sx * sy) / den;
  A := (sy - B * sx) / n;
  Result := True;
end;

procedure VarianzaDesviacion(const D: TVector;
  out Media, Minimo, Maximo, VarPob, DesvPob, VarMue, DesvMue: Double;
  out HayMuestral: Boolean);
var i, n: Integer; suma, sumdif: Double;
begin
  n := Length(D);
  suma := 0;
  for i := 0 to n - 1 do suma := suma + D[i];
  Media := suma / n;
  sumdif := 0;
  Minimo := D[0]; Maximo := D[0];
  for i := 0 to n - 1 do
  begin
    sumdif := sumdif + Sqr(D[i] - Media);
    if D[i] < Minimo then Minimo := D[i];
    if D[i] > Maximo then Maximo := D[i];
  end;
  VarPob := sumdif / n;
  DesvPob := Sqrt(VarPob);
  if n > 1 then
  begin
    VarMue := sumdif / (n - 1);
    DesvMue := Sqrt(VarMue);
    HayMuestral := True;
  end
  else
  begin
    VarMue := 0; DesvMue := 0;
    HayMuestral := False;
  end;
end;

{ ===== Demografia ===== }

function Coincide(const P: TPersona; Filtro: TSexoFiltro): Boolean;
begin
  case Filtro of
    sfHombres: Result := P.Sexo = 'H';
    sfMujeres: Result := P.Sexo = 'M';
  else
    Result := True;
  end;
end;

function ContarSexo(const G: TGrupo; Filtro: TSexoFiltro): Integer;
var i: Integer;
begin
  Result := 0;
  for i := 0 to High(G) do
    if Coincide(G[i], Filtro) then Inc(Result);
end;

function ContarEdad(const G: TGrupo; Filtro: TSexoFiltro; EsMayor: Boolean): Integer;
var i: Integer; mayor: Boolean;
begin
  Result := 0;
  for i := 0 to High(G) do
    if Coincide(G[i], Filtro) then
    begin
      mayor := G[i].Edad >= 18;
      if mayor = EsMayor then Inc(Result);
    end;
end;

function AgregaCampo(const G: TGrupo; Filtro: TSexoFiltro; Campo: TCampo;
  Metrica: TMetrica; out Valor: Double): Boolean;
var i, cont: Integer; v, suma, minv, maxv: Double; primero: Boolean;
begin
  cont := 0; suma := 0; minv := 0; maxv := 0; primero := True;
  for i := 0 to High(G) do
    if Coincide(G[i], Filtro) then
    begin
      if Campo = cpEdad then v := G[i].Edad else v := G[i].Estatura;
      Inc(cont);
      suma := suma + v;
      if primero then
      begin
        minv := v; maxv := v; primero := False;
      end
      else
      begin
        if v < minv then minv := v;
        if v > maxv then maxv := v;
      end;
    end;
  if cont = 0 then
  begin
    Valor := 0;
    Exit(False);
  end;
  case Metrica of
    mtMinimo:   Valor := minv;
    mtMaximo:   Valor := maxv;
    mtPromedio: Valor := suma / cont;
  end;
  Result := True;
end;

{ ===== Matrices ===== }

function MatSuma(const A, B: TMatriz): TMatriz;
var i, j, f, c: Integer;
begin
  f := Length(A); c := Length(A[0]);
  SetLength(Result, f, c);
  for i := 0 to f - 1 do
    for j := 0 to c - 1 do
      Result[i, j] := A[i, j] + B[i, j];
end;

function MatResta(const A, B: TMatriz): TMatriz;
var i, j, f, c: Integer;
begin
  f := Length(A); c := Length(A[0]);
  SetLength(Result, f, c);
  for i := 0 to f - 1 do
    for j := 0 to c - 1 do
      Result[i, j] := A[i, j] - B[i, j];
end;

function MatTranspuesta(const A: TMatriz): TMatriz;
var i, j, f, c: Integer;
begin
  f := Length(A); c := Length(A[0]);
  SetLength(Result, c, f);
  for i := 0 to f - 1 do
    for j := 0 to c - 1 do
      Result[j, i] := A[i, j];
end;

function MatInversa2x2(const A: TMatriz; out Inv: TMatriz; out Det: Double): Boolean;
begin
  Det := A[0, 0] * A[1, 1] - A[0, 1] * A[1, 0];
  if Det = 0 then
  begin
    SetLength(Inv, 0);
    Exit(False);
  end;
  SetLength(Inv, 2, 2);
  Inv[0, 0] :=  A[1, 1] / Det;
  Inv[0, 1] := -A[0, 1] / Det;
  Inv[1, 0] := -A[1, 0] / Det;
  Inv[1, 1] :=  A[0, 0] / Det;
  Result := True;
end;

end.
