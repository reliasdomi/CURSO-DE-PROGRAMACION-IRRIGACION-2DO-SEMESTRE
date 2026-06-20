unit U_Menor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, jpeg, Grids;

type
  TF_EStadisticas = class(TForm)
    p_Cabecera: TPanel;
    L_UACh: TLabel;
    L_Irrigacion: TLabel;
    I_UACh: TImage;
    I_Irrigacion: TImage;
    G_X: TStringGrid;
    L_Datos: TLabel;
    E_N: TEdit;
    B_Calcular: TButton;
    L_mayor: TLabel;
    L_menor: TLabel;
    L_media: TLabel;
    L_mediana: TLabel;
    L_moda: TLabel;
    B_limpiar: TButton;
    B_salir: TButton;
    G_X_asc: TStringGrid;
    B_ordenar: TButton;
    procedure E_NKeyPress(Sender: TObject; var Key: Char);
    procedure E_NChange(Sender: TObject);
    procedure B_CalcularClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure B_salirClick(Sender: TObject);
    procedure B_limpiarClick(Sender: TObject);
    procedure B_ordenarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Cadena  : string;
  Numero  : real;
  i,
  N       : byte;
  Codigo_de_Error : integer;
  X       : Array[1..20] of real;
  Xmenor,
  Xmayor,
  Xmedia  : real;

  F_EStadisticas: TF_EStadisticas;

implementation

{$R *.dfm}

procedure TF_EStadisticas.E_NKeyPress(Sender: TObject; var Key: Char);
begin
  if not  (Key in ['0'..'9',#8]) then Key := #0;
end;


function Cadena_a_byte(cadena:string): byte;
var
  Numero_byte : byte;
begin
  if cadena<>'' then val(cadena, Numero_byte, Codigo_de_error) else Numero_byte:=0;
  Cadena_a_byte := Numero_byte ;
end;

function Cadena_a_real(cadena:string): real;
var
  Numero_real : real;
begin
  if cadena<>'' then val(cadena, Numero_real, Codigo_de_error) else Numero_real:=0;
  Cadena_a_real := Numero_real ;
end;

function Byte_a_Cadena(Numero, campo:byte): string;
begin
  Str(Numero:campo,cadena);
  Byte_a_Cadena:= Cadena;
end;

function real_a_Cadena(Numero:real; campo, decimales:byte): string;
begin
  Str(Numero:campo:decimales,cadena);
  real_a_Cadena:= Cadena;
end;

procedure TF_EStadisticas.E_NChange(Sender: TObject);
begin

  if E_N.Text <> '' then N := Cadena_a_byte(E_N.Text);
   If N <2 then N := 2;
   if N >75 then N:=75;
   G_X.RowCount:=N+1;
   if (G_X.DefaultRowHeight*G_X.RowCount+20)<510 then
      G_X.Height:=G_X.DefaultRowHeight * G_X.RowCount+G_X.DefaultRowHeight
   else G_X.Height:=500;
   G_X.Cells[0,0]:='       i';
   G_X.Cells[1,0]:='       X';
   for i:=1 to G_X.RowCount do G_X.Cells[0,i]:=byte_a_cadena(i,7);

   G_X_asc.RowCount:=N+1;
   if (G_X_asc.DefaultRowHeight*G_X.RowCount+20)<510 then
      G_X_asc.Height:=G_X.DefaultRowHeight * G_X.RowCount+G_X.DefaultRowHeight
   else G_X_asc.Height:=500;
   G_X_asc.Cells[0,0]:='       i';
   G_X_asc.Cells[1,0]:='       X';
   for i:=1 to G_X_asc.RowCount do G_X_asc.Cells[0,i]:=byte_a_cadena(i,7);

end;

procedure menor;
begin
   Xmenor:=X[1];
   for i:=1 to N do
     if X[i]<Xmenor then Xmenor := X[i];
end;

procedure mayor;
begin
   Xmayor:=X[1];
   for i:=1 to N do
     if X[i]>Xmayor then Xmayor := X[i];
end;

procedure media;
var
  Suma : real;
begin
   Suma := 0;;
   for i:=1 to N do Suma := Suma + X[i];
   Xmedia := Suma / N;
end;

procedure TF_EStadisticas.B_CalcularClick(Sender: TObject);
begin
   if E_N.Text<>'' then N := Cadena_a_byte(E_N.Text);
   if N > 1 then
   begin
      for i:=1 to N do X[i] := Cadena_a_real(G_X.Cells[1,i]);
      Menor;
      Mayor;
      Media;
      L_menor.Caption := real_a_cadena(Xmenor,1,2);
      L_mayor.Caption := real_a_cadena(Xmayor,1,2);
      L_media.Caption := real_a_cadena(Xmedia,1,2);
   end;
end;

procedure TF_EStadisticas.FormActivate(Sender: TObject);
begin
  E_N.Text :='5';
  for i:=1 to G_X.RowCount do cadena := G_X.Cells[0,i];
  L_menor.Caption := '';
  L_mayor.Caption := '';
  L_media.Caption := '';

   if (G_X.DefaultRowHeight*G_X.RowCount+20)<510 then
      G_X.Height:=G_X.DefaultRowHeight * G_X.RowCount+G_X.DefaultRowHeight
   else G_X.Height:=500;

   G_X.Cells[0,0]:='       i';
   G_X.Cells[1,0]:='       X';
   for i:=1 to G_X.RowCount do G_X.Cells[0,i]:=byte_a_cadena(i,7);
end;

procedure TF_EStadisticas.B_salirClick(Sender: TObject);
begin
  Close;
end;

procedure TF_EStadisticas.B_limpiarClick(Sender: TObject);
begin
   E_n.Text :='2';
   for i:=1 to G_X.RowCount do G_X.Cells[1,i] := '';
   L_menor.Caption := '';
   L_mayor.Caption := '';
   L_media.Caption := '';
   L_mediana.Caption := '';
   L_moda.Caption  := '';

   for i:=1 to G_X_asc.RowCount do G_X_asc.Cells[1,i] := '';
end;

procedure TF_EStadisticas.B_ordenarClick(Sender: TObject);
var
  N_veces : byte;
  Xtemp   : real;
begin
  if E_N.Text<>'' then
  begin
    for i:=1 to N do X[i] := Cadena_a_real(G_X.Cells[1,i]);
    for N_veces := 1 to N do
     for i:=1 to N-1 do
     begin
       if X[i+1] < X[i] then
       begin
         Xtemp := X[i+1];
         X[i+1] := X[i];
         X[i] := Xtemp;
       end;
     end;
     for i:=1 to N do G_X_asc.Cells[1,i] := Real_a_cadena(X[i],1,2);
  end;
end;

end.
