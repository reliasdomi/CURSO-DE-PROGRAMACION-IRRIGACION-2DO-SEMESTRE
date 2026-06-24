{ ==================================================================
  INTEGRANTES - Grupo 4A - Irrigacion - U.A. Chapingo:
    - ELIAS DOMINGUEZ RUBEN
    - BISTRAIN BORRAZ ANGEL GABRIEL
    - CRUZ SIBAJA GIBRAN FRANCISCO
    - TORRES VALENCIA MARIO ALBERTO
  ================================================================== }
unit uFigurasCalc;
{ Calculos puros de area y perimetro de las figuras geometricas.
  Portado de 'deplhi figuras geometricas\FigurasGeometricas.dpr'.
  Universidad Autonoma Chapingo - Departamento de Irrigacion. }

{$mode objfpc}{$H+}

interface

type
  TResultado = record
    Area: Double;
    Perimetro: Double;   { en el circulo, Perimetro = circunferencia }
  end;

function CalcCuadrado(Lado: Double): TResultado;
function CalcRectangulo(Base, Altura: Double): TResultado;
function CalcTriangulo(Base, Altura, Lado1, Lado2: Double): TResultado;
function CalcCirculo(Radio: Double): TResultado;
function CalcRombo(DiagMayor, DiagMenor, Lado: Double): TResultado;
function CalcTrapecio(BaseMayor, BaseMenor, Altura, Lado1, Lado2: Double): TResultado;
function CalcPoligono(NumLados: Integer; Lado: Double): TResultado;

implementation

uses Math;

function CalcCuadrado(Lado: Double): TResultado;
begin
  Result.Area := Lado * Lado;
  Result.Perimetro := 4 * Lado;
end;

function CalcRectangulo(Base, Altura: Double): TResultado;
begin
  Result.Area := Base * Altura;
  Result.Perimetro := 2 * (Base + Altura);
end;

function CalcTriangulo(Base, Altura, Lado1, Lado2: Double): TResultado;
begin
  Result.Area := Base * Altura / 2;
  Result.Perimetro := Base + Lado1 + Lado2;
end;

function CalcCirculo(Radio: Double): TResultado;
begin
  Result.Area := Pi * Sqr(Radio);
  Result.Perimetro := 2 * Pi * Radio;
end;

function CalcRombo(DiagMayor, DiagMenor, Lado: Double): TResultado;
begin
  Result.Area := DiagMayor * DiagMenor / 2;
  Result.Perimetro := 4 * Lado;
end;

function CalcTrapecio(BaseMayor, BaseMenor, Altura, Lado1, Lado2: Double): TResultado;
begin
  Result.Area := (BaseMayor + BaseMenor) * Altura / 2;
  Result.Perimetro := BaseMayor + BaseMenor + Lado1 + Lado2;
end;

function CalcPoligono(NumLados: Integer; Lado: Double): TResultado;
var
  Apotema: Double;
begin
  Result.Perimetro := NumLados * Lado;
  Apotema := Lado / (2 * Tan(Pi / NumLados));
  Result.Area := Result.Perimetro * Apotema / 2;
end;

end.
