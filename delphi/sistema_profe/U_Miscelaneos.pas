{ ==================================================================
  INTEGRANTES - Grupo 4A - Irrigacion - U.A. Chapingo:
    - ELIAS DOMINGUEZ RUBEN
    - BISTRAIN BORRAZ ANGEL GABRIEL
    - CRUZ SIBAJA GIBRAN FRANCISCO
    - TORRES VALENCIA MARIO ALBERTO
  ================================================================== }
unit U_Miscelaneos;

{ Miscelaneos (programas 7 y 8): numero par o impar y formula cuadratica. }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TF_Miscelaneos = class(TForm)
    P_Cabecera: TPanel;
    L_Programa: TLabel;
    L_ParImpar: TLabel;
    L_Numero: TLabel;
    E_Numero: TEdit;
    B_ParImpar: TButton;
    L_ResPar: TLabel;
    L_Cuadratica: TLabel;
    L_A: TLabel;
    L_B: TLabel;
    L_C: TLabel;
    E_A: TEdit;
    E_B: TEdit;
    E_C: TEdit;
    B_Cuadratica: TButton;
    M_ResCuad: TMemo;
    B_Salir: TButton;
    procedure B_ParImparClick(Sender: TObject);
    procedure B_CuadraticaClick(Sender: TObject);
    procedure B_SalirClick(Sender: TObject);
  public
    procedure Preparar(k: integer);
  end;

var
  F_Miscelaneos: TF_Miscelaneos;

implementation

uses
  U_Comun;

{$R *.dfm}

procedure TF_Miscelaneos.B_ParImparClick(Sender: TObject);
var n: integer;
begin
  n := Cadena_a_entero(E_Numero.Text);
  if n mod 2 = 0 then
    L_ResPar.Caption := 'El numero ' + Entero_a_Cadena(n, 1) + ' es PAR'
  else
    L_ResPar.Caption := 'El numero ' + Entero_a_Cadena(n, 1) + ' es IMPAR';
end;

procedure TF_Miscelaneos.B_CuadraticaClick(Sender: TObject);
var a, b, c, disc, x1, x2, re, im: real;
begin
  a := Cadena_a_real(E_A.Text);
  b := Cadena_a_real(E_B.Text);
  c := Cadena_a_real(E_C.Text);
  M_ResCuad.Clear;
  if a = 0 then
  begin
    M_ResCuad.Lines.Add('El coeficiente a no puede ser 0.');
    Exit;
  end;
  disc := b * b - 4 * a * c;
  M_ResCuad.Lines.Add('Discriminante = ' + real_a_Cadena(disc, 1, 2));
  if disc > 0 then
  begin
    x1 := (-b + Sqrt(disc)) / (2 * a);
    x2 := (-b - Sqrt(disc)) / (2 * a);
    M_ResCuad.Lines.Add('Dos raices reales:');
    M_ResCuad.Lines.Add('x1 = ' + real_a_Cadena(x1, 1, 4));
    M_ResCuad.Lines.Add('x2 = ' + real_a_Cadena(x2, 1, 4));
  end
  else if disc = 0 then
  begin
    x1 := -b / (2 * a);
    M_ResCuad.Lines.Add('Raiz doble:');
    M_ResCuad.Lines.Add('x1 = x2 = ' + real_a_Cadena(x1, 1, 4));
  end
  else
  begin
    re := -b / (2 * a);
    im := Sqrt(-disc) / (2 * a);
    M_ResCuad.Lines.Add('Raices complejas:');
    M_ResCuad.Lines.Add('x1 = ' + real_a_Cadena(re, 1, 4) + ' + ' + real_a_Cadena(im, 1, 4) + 'i');
    M_ResCuad.Lines.Add('x2 = ' + real_a_Cadena(re, 1, 4) + ' - ' + real_a_Cadena(im, 1, 4) + 'i');
  end;
end;

procedure TF_Miscelaneos.B_SalirClick(Sender: TObject);
begin
  Close;
end;

procedure TF_Miscelaneos.Preparar(k: integer);
begin
  if k = 7 then L_Programa.Caption := '7. NUMERO PAR O IMPAR'
  else if k = 8 then L_Programa.Caption := '8. FORMULA CUADRATICA'
  else L_Programa.Caption := 'MISCELANEOS';
end;

end.
