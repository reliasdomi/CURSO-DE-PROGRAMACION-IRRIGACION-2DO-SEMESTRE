unit uMatrices;
{ Operaciones con matrices (ejercicios 39-42).
  Captura por consola y muestra el resultado como una cuadricula en la
  ventana grafica de uComun.
  Universidad Autonoma Chapingo - Departamento de Irrigacion. Grupo 4A. }

{$mode objfpc}{$H+}

interface

procedure OpSuma;
procedure OpResta;
procedure OpTranspuesta;
procedure OpInversa;

implementation

uses Graph, SysUtils, Math, uComun;

const
  MAXM = 10;

type
  TMat = array[1..MAXM, 1..MAXM] of Double;

procedure LeerMatriz(var A: TMat; filas, cols: Integer; const nombre: string);
var i, j: Integer;
begin
  WriteLn('Capture la matriz ', nombre, ' (', filas, 'x', cols, '):');
  for i := 1 to filas do
    for j := 1 to cols do
      A[i, j] := LeerReal('  ' + nombre + '[' + IntToStr(i) + ',' +
                          IntToStr(j) + '] = ');
end;

procedure ImprimirConsola(const A: TMat; filas, cols: Integer);
var i, j: Integer; s: string;
begin
  for i := 1 to filas do
  begin
    s := '';
    for j := 1 to cols do
      s := s + Fmt(A[i, j]) + #9;
    WriteLn('  ', s);
  end;
end;

{ Dibuja una matriz como cuadricula centrada en la ventana grafica. }
procedure DibujarMatriz(const Titulo: string; const A: TMat;
                        filas, cols: Integer);
var
  i, j, celW, celH, x0, y0, gx, gy: Integer;
begin
  if not AbrirVentana(Titulo) then Exit;
  celW := Min(90, (ANCHO - 2 * MARGEN) div cols);
  celH := Min(50, (ALTO - 140) div filas);
  x0 := (ANCHO - celW * cols) div 2;
  y0 := 70;
  SetColor(White);
  SetTextStyle(DefaultFont, HorizDir, 1);
  SetTextJustify(CenterText, CenterText);
  for i := 1 to filas do
    for j := 1 to cols do
    begin
      gx := x0 + (j - 1) * celW;
      gy := y0 + (i - 1) * celH;
      Rectangle(gx, gy, gx + celW, gy + celH);
      SetColor(LightGreen);
      OutTextXY(gx + celW div 2, gy + celH div 2, Fmt(A[i, j]));
      SetColor(White);
    end;
  SetTextJustify(LeftText, TopText);
  PiePagina('Matriz resultado ' + IntToStr(filas) + 'x' + IntToStr(cols));
  EsperarYCerrar;
end;

procedure OpSuma;
var A, B, C: TMat; m, n, i, j: Integer;
begin
  WriteLn; WriteLn('-- 39: SUMA DE MATRICES --');
  m := LeerEnteroRango('Filas (1 a 10): ', 1, MAXM);
  n := LeerEnteroRango('Columnas (1 a 10): ', 1, MAXM);
  LeerMatriz(A, m, n, 'A');
  LeerMatriz(B, m, n, 'B');
  for i := 1 to m do for j := 1 to n do C[i, j] := A[i, j] + B[i, j];
  WriteLn('Resultado A + B:'); ImprimirConsola(C, m, n);
  DibujarMatriz('39: SUMA A+B', C, m, n);
end;

procedure OpResta;
var A, B, C: TMat; m, n, i, j: Integer;
begin
  WriteLn; WriteLn('-- 40: RESTA DE MATRICES --');
  m := LeerEnteroRango('Filas (1 a 10): ', 1, MAXM);
  n := LeerEnteroRango('Columnas (1 a 10): ', 1, MAXM);
  LeerMatriz(A, m, n, 'A');
  LeerMatriz(B, m, n, 'B');
  for i := 1 to m do for j := 1 to n do C[i, j] := A[i, j] - B[i, j];
  WriteLn('Resultado A - B:'); ImprimirConsola(C, m, n);
  DibujarMatriz('40: RESTA A-B', C, m, n);
end;

procedure OpTranspuesta;
var A, T: TMat; m, n, i, j: Integer;
begin
  WriteLn; WriteLn('-- 41: MATRIZ TRANSPUESTA --');
  m := LeerEnteroRango('Filas (1 a 10): ', 1, MAXM);
  n := LeerEnteroRango('Columnas (1 a 10): ', 1, MAXM);
  LeerMatriz(A, m, n, 'A');
  for i := 1 to m do for j := 1 to n do T[j, i] := A[i, j];
  WriteLn('Transpuesta (', n, 'x', m, '):'); ImprimirConsola(T, n, m);
  DibujarMatriz('41: TRANSPUESTA', T, n, m);
end;

procedure OpInversa;
var A, Inv: TMat; det: Double;
begin
  WriteLn; WriteLn('-- 42: MATRIZ INVERSA 2x2 --');
  LeerMatriz(A, 2, 2, 'A');
  det := A[1, 1] * A[2, 2] - A[1, 2] * A[2, 1];
  WriteLn('Determinante = ', Fmt(det));
  if Abs(det) < 1E-12 then
  begin
    WriteLn('La matriz no tiene inversa (determinante = 0).');
    MostrarPanel('42: MATRIZ INVERSA 2x2',
      ['Determinante = ' + Fmt(det), '', 'La matriz NO tiene inversa.']);
    Exit;
  end;
  Inv[1, 1] :=  A[2, 2] / det;
  Inv[1, 2] := -A[1, 2] / det;
  Inv[2, 1] := -A[2, 1] / det;
  Inv[2, 2] :=  A[1, 1] / det;
  WriteLn('Inversa:'); ImprimirConsola(Inv, 2, 2);
  DibujarMatriz('42: INVERSA (det=' + Fmt(det) + ')', Inv, 2, 2);
end;

end.
