unit U_Matrices;

{ ------------------------------------------------------------------
  U_Matrices.pas - Matrices (programas 39-42).
    39 Suma            41 Transpuesta
    40 Resta           42 Inversa 2x2
  Captura por consola y muestra la matriz resultante en el panel grafico.
  ------------------------------------------------------------------ }

{$mode objfpc}{$H+}

interface

procedure Op_suma;
procedure Op_resta;
procedure Op_transpuesta;
procedure Op_inversa;

implementation

uses U_Comun;

const
  MAXM = 10;

type
  TMatriz = array[1..MAXM, 1..MAXM] of real;

procedure Captura_matriz(var M: TMatriz; F, C: integer; const Nombre: string);
var i, j: integer;
begin
  WriteLn('Capture la matriz ', Nombre, ' (', F, 'x', C, '):');
  for i := 1 to F do
    for j := 1 to C do
      M[i, j] := Lee_real('  ' + Nombre + '[' + Entero_a_Cadena(i, 1) + ',' +
                 Entero_a_Cadena(j, 1) + ']: ');
end;

function Lineas_matriz(const M: TMatriz; F, C: integer): TStringArray;
var i, j: integer; linea: string; res: TStringArray;
begin
  SetLength(res, F);
  for i := 1 to F do
  begin
    linea := '';
    for j := 1 to C do
      linea := linea + real_a_Cadena(M[i, j], 8, 2);
    res[i - 1] := linea;
  end;
  Lineas_matriz := res;
end;

procedure Op_suma;
var A, B, R: TMatriz; f, c, i, j: integer;
begin
  WriteLn; WriteLn('=== SUMA DE MATRICES ===');
  f := Lee_entero_rango('Filas (1 a 10): ', 1, MAXM);
  c := Lee_entero_rango('Columnas (1 a 10): ', 1, MAXM);
  Captura_matriz(A, f, c, 'A');
  Captura_matriz(B, f, c, 'B');
  for i := 1 to f do for j := 1 to c do R[i, j] := A[i, j] + B[i, j];
  Muestra_panel('SUMA  C = A + B', Lineas_matriz(R, f, c));
end;

procedure Op_resta;
var A, B, R: TMatriz; f, c, i, j: integer;
begin
  WriteLn; WriteLn('=== RESTA DE MATRICES ===');
  f := Lee_entero_rango('Filas (1 a 10): ', 1, MAXM);
  c := Lee_entero_rango('Columnas (1 a 10): ', 1, MAXM);
  Captura_matriz(A, f, c, 'A');
  Captura_matriz(B, f, c, 'B');
  for i := 1 to f do for j := 1 to c do R[i, j] := A[i, j] - B[i, j];
  Muestra_panel('RESTA  C = A - B', Lineas_matriz(R, f, c));
end;

procedure Op_transpuesta;
var A, T: TMatriz; f, c, i, j: integer;
begin
  WriteLn; WriteLn('=== MATRIZ TRANSPUESTA ===');
  f := Lee_entero_rango('Filas (1 a 10): ', 1, MAXM);
  c := Lee_entero_rango('Columnas (1 a 10): ', 1, MAXM);
  Captura_matriz(A, f, c, 'A');
  for i := 1 to f do for j := 1 to c do T[j, i] := A[i, j];
  Muestra_panel('TRANSPUESTA  T = A^t', Lineas_matriz(T, c, f));
end;

procedure Op_inversa;
var A, Inv: TMatriz; det: real;
begin
  WriteLn; WriteLn('=== MATRIZ INVERSA 2x2 ===');
  Captura_matriz(A, 2, 2, 'A');
  det := A[1, 1] * A[2, 2] - A[1, 2] * A[2, 1];
  if det = 0 then
  begin
    Muestra_panel('INVERSA 2x2',
      ['Determinante = 0', 'La matriz NO tiene inversa (es singular).']);
    Exit;
  end;
  Inv[1, 1] :=  A[2, 2] / det;
  Inv[1, 2] := -A[1, 2] / det;
  Inv[2, 1] := -A[2, 1] / det;
  Inv[2, 2] :=  A[1, 1] / det;
  Muestra_panel('INVERSA 2x2  (det = ' + real_a_Cadena(det, 1, 2) + ')',
                Lineas_matriz(Inv, 2, 2));
end;

end.
