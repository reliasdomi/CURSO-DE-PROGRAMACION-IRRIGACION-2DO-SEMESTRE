unit U_Matrices;

{ Matrices (programas 39-42). Dos rejillas de entrada (A y B) y una de
  resultado. Suma, resta, transpuesta e inversa 2x2. }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids;

const
  MAXM = 10;

type
  TMatriz = array[1..MAXM, 1..MAXM] of real;

  TF_Matrices = class(TForm)
    P_Cabecera: TPanel;
    L_Programa: TLabel;
    L_Filas: TLabel;
    L_Cols: TLabel;
    E_Filas: TEdit;
    E_Cols: TEdit;
    B_Generar: TButton;
    L_A: TLabel;
    L_B: TLabel;
    L_R: TLabel;
    G_A: TStringGrid;
    G_B: TStringGrid;
    G_R: TStringGrid;
    B_Suma: TButton;
    B_Resta: TButton;
    B_Transpuesta: TButton;
    B_Inversa: TButton;
    B_Salir: TButton;
    L_Mensaje: TLabel;
    procedure B_GenerarClick(Sender: TObject);
    procedure B_SumaClick(Sender: TObject);
    procedure B_RestaClick(Sender: TObject);
    procedure B_TranspuestaClick(Sender: TObject);
    procedure B_InversaClick(Sender: TObject);
    procedure B_SalirClick(Sender: TObject);
  private
    F, C: integer;
    procedure Dimensiona(G: TStringGrid; filas, cols: integer);
    procedure Genera_grids;
    procedure Lee_matriz(G: TStringGrid; var M: TMatriz; filas, cols: integer);
    procedure Muestra_matriz(var M: TMatriz; filas, cols: integer);
  public
    procedure Preparar(k: integer);
  end;

var
  F_Matrices: TF_Matrices;

implementation

uses
  U_Comun;

{$R *.dfm}

procedure TF_Matrices.Dimensiona(G: TStringGrid; filas, cols: integer);
begin
  G.ColCount := cols;
  G.RowCount := filas;
end;

procedure TF_Matrices.Genera_grids;
begin
  F := Cadena_a_entero(E_Filas.Text);
  C := Cadena_a_entero(E_Cols.Text);
  if F < 1 then F := 1; if F > MAXM then F := MAXM;
  if C < 1 then C := 1; if C > MAXM then C := MAXM;
  Dimensiona(G_A, F, C);
  Dimensiona(G_B, F, C);
  Dimensiona(G_R, F, C);
  L_Mensaje.Caption := '';
end;

procedure TF_Matrices.B_GenerarClick(Sender: TObject);
begin
  Genera_grids;
end;

procedure TF_Matrices.Lee_matriz(G: TStringGrid; var M: TMatriz; filas, cols: integer);
var i, j: integer;
begin
  for i := 1 to filas do
    for j := 1 to cols do
      M[i, j] := Cadena_a_real(G.Cells[j - 1, i - 1]);
end;

procedure TF_Matrices.Muestra_matriz(var M: TMatriz; filas, cols: integer);
var i, j: integer;
begin
  G_R.ColCount := cols;
  G_R.RowCount := filas;
  for i := 1 to filas do
    for j := 1 to cols do
      G_R.Cells[j - 1, i - 1] := real_a_Cadena(M[i, j], 1, 2);
end;

procedure TF_Matrices.B_SumaClick(Sender: TObject);
var A, B, R: TMatriz; i, j: integer;
begin
  if E_Filas.Text <> '' then F := Cadena_a_entero(E_Filas.Text);
  if E_Cols.Text <> '' then C := Cadena_a_entero(E_Cols.Text);
  Lee_matriz(G_A, A, F, C);
  Lee_matriz(G_B, B, F, C);
  for i := 1 to F do for j := 1 to C do R[i, j] := A[i, j] + B[i, j];
  Muestra_matriz(R, F, C);
  L_Mensaje.Caption := 'C = A + B';
end;

procedure TF_Matrices.B_RestaClick(Sender: TObject);
var A, B, R: TMatriz; i, j: integer;
begin
  if E_Filas.Text <> '' then F := Cadena_a_entero(E_Filas.Text);
  if E_Cols.Text <> '' then C := Cadena_a_entero(E_Cols.Text);
  Lee_matriz(G_A, A, F, C);
  Lee_matriz(G_B, B, F, C);
  for i := 1 to F do for j := 1 to C do R[i, j] := A[i, j] - B[i, j];
  Muestra_matriz(R, F, C);
  L_Mensaje.Caption := 'C = A - B';
end;

procedure TF_Matrices.B_TranspuestaClick(Sender: TObject);
var A, T: TMatriz; i, j: integer;
begin
  if E_Filas.Text <> '' then F := Cadena_a_entero(E_Filas.Text);
  if E_Cols.Text <> '' then C := Cadena_a_entero(E_Cols.Text);
  Lee_matriz(G_A, A, F, C);
  for i := 1 to F do for j := 1 to C do T[j, i] := A[i, j];
  Muestra_matriz(T, C, F);
  L_Mensaje.Caption := 'T = A transpuesta (de A)';
end;

procedure TF_Matrices.B_InversaClick(Sender: TObject);
var A, Inv: TMatriz; det: real;
begin
  F := 2; C := 2;
  E_Filas.Text := '2'; E_Cols.Text := '2';
  Lee_matriz(G_A, A, 2, 2);
  det := A[1, 1] * A[2, 2] - A[1, 2] * A[2, 1];
  if det = 0 then
  begin
    L_Mensaje.Caption := 'Determinante = 0: la matriz A no tiene inversa.';
    Exit;
  end;
  Inv[1, 1] :=  A[2, 2] / det;
  Inv[1, 2] := -A[1, 2] / det;
  Inv[2, 1] := -A[2, 1] / det;
  Inv[2, 2] :=  A[1, 1] / det;
  Muestra_matriz(Inv, 2, 2);
  L_Mensaje.Caption := 'Inversa de A (det = ' + real_a_Cadena(det, 1, 2) + ')';
end;

procedure TF_Matrices.B_SalirClick(Sender: TObject);
begin
  Close;
end;

procedure TF_Matrices.Preparar(k: integer);
begin
  case k of
    39: L_Programa.Caption := '39. SUMA DE MATRICES';
    40: L_Programa.Caption := '40. RESTA DE MATRICES';
    41: L_Programa.Caption := '41. MATRIZ TRANSPUESTA';
    42: L_Programa.Caption := '42. MATRIZ INVERSA 2x2';
  else
    L_Programa.Caption := 'MATRICES';
  end;
  if k = 42 then
  begin
    E_Filas.Text := '2';
    E_Cols.Text := '2';
  end
  else
  begin
    if E_Filas.Text = '' then E_Filas.Text := '2';
    if E_Cols.Text = '' then E_Cols.Text := '2';
  end;
  Genera_grids;
end;

end.
