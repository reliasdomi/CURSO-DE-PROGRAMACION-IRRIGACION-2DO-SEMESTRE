unit U_Estadistica;

{ Estadistica (programas 9-15, 36, 37) en un solo formulario, al estilo del
  U_Menor del profesor: una rejilla de datos y botones que calculan varias
  medidas a la vez. Columna X para una variable; columna Y para la regresion. }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, U_Comun;

type
  TF_Estadistica = class(TForm)
    P_Cabecera: TPanel;
    L_Programa: TLabel;
    L_NDatos: TLabel;
    E_N: TEdit;
    B_Generar: TButton;
    G_Datos: TStringGrid;
    B_Calcular: TButton;
    B_Ordenar: TButton;
    B_Regresion: TButton;
    B_Limpiar: TButton;
    B_Salir: TButton;
    L_Mayor: TLabel;
    L_Menor: TLabel;
    L_Media: TLabel;
    L_Mediana: TLabel;
    L_Moda: TLabel;
    L_Varianza: TLabel;
    L_Desv: TLabel;
    M_Resultado: TMemo;
    procedure B_GenerarClick(Sender: TObject);
    procedure B_CalcularClick(Sender: TObject);
    procedure B_OrdenarClick(Sender: TObject);
    procedure B_RegresionClick(Sender: TObject);
    procedure B_LimpiarClick(Sender: TObject);
    procedure B_SalirClick(Sender: TObject);
    procedure E_NKeyPress(Sender: TObject; var Key: Char);
  private
    N: integer;
    X, Y: TArregloReal;
    procedure Genera_filas;
    procedure Lee_columna_X;
    procedure Ordena(var D: TArregloReal; Asc: boolean);
    procedure Limpia_resultados;
  public
    procedure Preparar(k: integer);
  end;

var
  F_Estadistica: TF_Estadistica;

implementation

{$R *.dfm}

procedure TF_Estadistica.E_NKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', #8]) then Key := #0;
end;

procedure TF_Estadistica.Genera_filas;
var i: integer;
begin
  N := Cadena_a_entero(E_N.Text);
  if N < 1 then N := 1;
  if N > MAXP then N := MAXP;
  G_Datos.RowCount := N + 1;
  G_Datos.Cells[0, 0] := '  i';
  G_Datos.Cells[1, 0] := '    X';
  G_Datos.Cells[2, 0] := '    Y';
  for i := 1 to N do G_Datos.Cells[0, i] := Entero_a_Cadena(i, 3);
end;

procedure TF_Estadistica.B_GenerarClick(Sender: TObject);
begin
  Genera_filas;
end;

procedure TF_Estadistica.Lee_columna_X;
var i: integer;
begin
  for i := 1 to N do X[i] := Cadena_a_real(G_Datos.Cells[1, i]);
end;

procedure TF_Estadistica.Ordena(var D: TArregloReal; Asc: boolean);
var i, j: integer; t: real; cambia: boolean;
begin
  for i := 1 to N - 1 do
    for j := 1 to N - i do
    begin
      if Asc then cambia := D[j] > D[j + 1] else cambia := D[j] < D[j + 1];
      if cambia then begin t := D[j]; D[j] := D[j + 1]; D[j + 1] := t; end;
    end;
end;

procedure TF_Estadistica.B_CalcularClick(Sender: TObject);
var
  i, j, conteo, mejor: integer;
  suma, media, mayor, menor, moda, sumcuad, varp, desvp: real;
  Z: TArregloReal;
begin
  if E_N.Text <> '' then N := Cadena_a_entero(E_N.Text);
  if N < 1 then Exit;
  Lee_columna_X;
  mayor := X[1]; menor := X[1]; suma := 0;
  for i := 1 to N do
  begin
    if X[i] > mayor then mayor := X[i];
    if X[i] < menor then menor := X[i];
    suma := suma + X[i];
  end;
  media := suma / N;
  { mediana sobre copia ordenada }
  for i := 1 to N do Z[i] := X[i];
  { orden ascendente simple }
  for i := 1 to N - 1 do
    for j := 1 to N - i do
      if Z[j] > Z[j + 1] then
      begin suma := Z[j]; Z[j] := Z[j + 1]; Z[j + 1] := suma; end;
  { moda }
  moda := X[1]; mejor := 0;
  for i := 1 to N do
  begin
    conteo := 0;
    for j := 1 to N do if X[j] = X[i] then Inc(conteo);
    if conteo > mejor then begin mejor := conteo; moda := X[i]; end;
  end;
  { varianza y desviacion (poblacional) }
  sumcuad := 0;
  for i := 1 to N do sumcuad := sumcuad + Sqr(X[i] - media);
  varp := sumcuad / N;
  desvp := Sqrt(varp);

  L_Mayor.Caption := 'Mayor: ' + real_a_Cadena(mayor, 1, 2);
  L_Menor.Caption := 'Menor: ' + real_a_Cadena(menor, 1, 2);
  L_Media.Caption := 'Media: ' + real_a_Cadena(media, 1, 4);
  if N mod 2 = 1 then
    L_Mediana.Caption := 'Mediana: ' + real_a_Cadena(Z[(N + 1) div 2], 1, 4)
  else
    L_Mediana.Caption := 'Mediana: ' +
      real_a_Cadena((Z[N div 2] + Z[N div 2 + 1]) / 2, 1, 4);
  L_Moda.Caption := 'Moda: ' + real_a_Cadena(moda, 1, 2) +
                    ' (x' + Entero_a_Cadena(mejor, 1) + ')';
  L_Varianza.Caption := 'Varianza: ' + real_a_Cadena(varp, 1, 4);
  L_Desv.Caption := 'Desv. estandar: ' + real_a_Cadena(desvp, 1, 4);
end;

procedure TF_Estadistica.B_OrdenarClick(Sender: TObject);
var i: integer; D: TArregloReal; linea: string;
begin
  if E_N.Text <> '' then N := Cadena_a_entero(E_N.Text);
  if N < 1 then Exit;
  Lee_columna_X;
  M_Resultado.Clear;
  for i := 1 to N do D[i] := X[i];
  Ordena(D, True);
  linea := '';
  for i := 1 to N do linea := linea + real_a_Cadena(D[i], 1, 2) + '  ';
  M_Resultado.Lines.Add('Menor a mayor:');
  M_Resultado.Lines.Add(linea);
  for i := 1 to N do D[i] := X[i];
  Ordena(D, False);
  linea := '';
  for i := 1 to N do linea := linea + real_a_Cadena(D[i], 1, 2) + '  ';
  M_Resultado.Lines.Add('Mayor a menor:');
  M_Resultado.Lines.Add(linea);
end;

procedure TF_Estadistica.B_RegresionClick(Sender: TObject);
var
  i: integer;
  sx, sy, sxy, sxx, a, b: real;
begin
  if E_N.Text <> '' then N := Cadena_a_entero(E_N.Text);
  if N < 2 then begin M_Resultado.Lines.Add('Se necesitan 2 o mas pares.'); Exit; end;
  for i := 1 to N do
  begin
    X[i] := Cadena_a_real(G_Datos.Cells[1, i]);
    Y[i] := Cadena_a_real(G_Datos.Cells[2, i]);
  end;
  sx := 0; sy := 0; sxy := 0; sxx := 0;
  for i := 1 to N do
  begin
    sx := sx + X[i]; sy := sy + Y[i];
    sxy := sxy + X[i] * Y[i]; sxx := sxx + X[i] * X[i];
  end;
  b := (N * sxy - sx * sy) / (N * sxx - sx * sx);
  a := (sy - b * sx) / N;
  M_Resultado.Clear;
  M_Resultado.Lines.Add('Regresion lineal Y = a + b X');
  M_Resultado.Lines.Add('a = ' + real_a_Cadena(a, 1, 4));
  M_Resultado.Lines.Add('b = ' + real_a_Cadena(b, 1, 4));
  M_Resultado.Lines.Add('Y = ' + real_a_Cadena(a, 1, 4) + ' + ' +
                        real_a_Cadena(b, 1, 4) + ' X');
end;

procedure TF_Estadistica.Limpia_resultados;
begin
  L_Mayor.Caption := 'Mayor:';
  L_Menor.Caption := 'Menor:';
  L_Media.Caption := 'Media:';
  L_Mediana.Caption := 'Mediana:';
  L_Moda.Caption := 'Moda:';
  L_Varianza.Caption := 'Varianza:';
  L_Desv.Caption := 'Desv. estandar:';
  M_Resultado.Clear;
end;

procedure TF_Estadistica.B_LimpiarClick(Sender: TObject);
var i: integer;
begin
  for i := 1 to G_Datos.RowCount - 1 do
  begin
    G_Datos.Cells[1, i] := '';
    G_Datos.Cells[2, i] := '';
  end;
  Limpia_resultados;
end;

procedure TF_Estadistica.B_SalirClick(Sender: TObject);
begin
  Close;
end;

procedure TF_Estadistica.Preparar(k: integer);
begin
  case k of
     9: L_Programa.Caption := '9. NUMERO MAYOR';
    10: L_Programa.Caption := '10. NUMERO MENOR';
    11: L_Programa.Caption := '11. MEDIA ARITMETICA';
    12: L_Programa.Caption := '12. MEDIANA';
    13: L_Programa.Caption := '13. MODA';
    14: L_Programa.Caption := '14. ORDENAR DE MENOR A MAYOR';
    15: L_Programa.Caption := '15. ORDENAR DE MAYOR A MENOR';
    36: L_Programa.Caption := '36. REGRESION LINEAL (use columna Y)';
    37: L_Programa.Caption := '37. VARIANZA Y DESVIACION ESTANDAR';
  else
    L_Programa.Caption := 'ESTADISTICA';
  end;
  if E_N.Text = '' then E_N.Text := '5';
  Genera_filas;
  Limpia_resultados;
end;

end.
