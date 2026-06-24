unit U_personas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, jpeg, Grids;

type
  TF_Personas = class(TForm)
    p_Cabecera: TPanel;
    L_UACh: TLabel;
    L_Irrigacion: TLabel;
    I_UACh: TImage;
    I_Irrigacion: TImage;
    G_Nombre: TStringGrid;
    L_Datos: TLabel;
    E_N: TEdit;
    B_Calcular: TButton;
    L_Edad_mayor_c: TLabel;
    L_Edad_menor_c: TLabel;
    L_Edad_mediana_c: TLabel;
    L_Edad_moda_c: TLabel;
    B_limpiar: TButton;
    B_salir: TButton;
    G_Edad: TStringGrid;
    G_Estatura: TStringGrid;
    L_menor_texto: TLabel;
    L_mayor_texto: TLabel;
    L_media_texto: TLabel;
    L_mediana_texto: TLabel;
    L_moda_texto: TLabel;
    G_Sexo: TStringGrid;
    L_Estatura_mayor_m: TLabel;
    L_Estatura_menor_m: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    L_edad_media_c: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    G_i: TStringGrid;
    L_estatura_mayor_c: TLabel;
    L_estatura_menor_c: TLabel;
    L_estatura_mediana_c: TLabel;
    L_estatura_moda_c: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    L_estatura_media_c: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    procedure E_NKeyPress(Sender: TObject; var Key: Char);
    procedure E_NChange(Sender: TObject);
    procedure B_CalcularClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure B_salirClick(Sender: TObject);
    procedure B_limpiarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_Personas: TF_Personas;

  // Declaración de variables del programador
  Cadena          : string;
  Numero          : real;
  i,
  N,
  N_veces         : byte;
  Codigo_de_Error : integer;
  Nombre          : Array[1..75] of String[50];
  Edad            : array[1..75] of byte;
  Estatura        : array[1..75] of real;
  Sexo            : array[1..75] of char;
  Edad_temp,
  Edad_menor_c,
  Edad_mayor_c,
  Edad_media_c,
  Edad_mediana_c,
  Edad_moda_c     : byte;

  Estatura_temp,
  Estatura_menor_c,
  Estatura_mayor_c,
  Estatura_media_c,
  Estatura_mediana_c,
  Estatura_moda_c    : real;



implementation

{$R *.dfm}

procedure TF_Personas.E_NKeyPress(Sender: TObject; var Key: Char);
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

procedure TF_Personas.E_NChange(Sender: TObject);
begin

  if E_N.Text <> '' then N := Cadena_a_byte(E_N.Text);
   If N <2 then N := 2;
   if N >75 then N:=75;

   G_i.RowCount:=N+1;
   if (G_i.DefaultRowHeight*G_i.RowCount+20)<510 then
      G_i.Height:=G_i.DefaultRowHeight * G_i.RowCount+G_Sexo.DefaultRowHeight
   else G_i.Height:=500;
   G_i.Cells[0,0]:='    i';
   for i:=1 to G_i.RowCount do G_i.Cells[0,i] := Byte_a_cadena(i,5);

   G_Nombre.RowCount:=N+1;
   if (G_nombre.DefaultRowHeight*G_nombre.RowCount+20)<510 then
      G_nombre.Height:=G_nombre.DefaultRowHeight * G_nombre.RowCount+G_Nombre.DefaultRowHeight
   else G_Nombre.Height:=500;
   G_Nombre.Cells[0,0]:='                                 NOMBRE';

   G_Edad.RowCount:=N+1;
   if (G_Edad.DefaultRowHeight*G_Edad.RowCount+20)<510 then
      G_Edad.Height:=G_Edad.DefaultRowHeight * G_Edad.RowCount+G_Edad.DefaultRowHeight
   else G_Edad.Height:=500;
   G_Edad.Cells[0,0]:='     Edad';

   G_Estatura.RowCount:=N+1;
   if (G_Estatura.DefaultRowHeight*G_Estatura.RowCount+20)<510 then
      G_Estatura.Height:=G_Estatura.DefaultRowHeight * G_Estatura.RowCount+G_Estatura.DefaultRowHeight
   else G_Estatura.Height:=500;
   G_Estatura.Cells[0,0]:=' Estatura';

   G_Sexo.RowCount:=N+1;
   if (G_Sexo.DefaultRowHeight*G_Sexo.RowCount+20)<510 then
      G_Sexo.Height:=G_Sexo.DefaultRowHeight * G_Sexo.RowCount+G_Sexo.DefaultRowHeight
   else G_Sexo.Height:=500;
   G_Sexo.Cells[0,0]:=' Sexo';

end;

{Se calculan estadisticas de edades del conjunto}

procedure Edad_menor_del_conjunto;
begin
   Edad_menor_c:=Edad[1];
   for i:=1 to N do
     if Edad[i]<Edad_menor_c then Edad_menor_c := Edad[i];
end;

procedure Edad_mayor_del_conjunto;
begin
   Edad_mayor_c:=Edad[1];
   for i:=1 to N do
     if Edad[i]>Edad_mayor_c then Edad_mayor_c := Edad[i];
end;

procedure Edad_media_del_conjunto;
var
  Suma : byte;
begin
   Suma := 0;;
   for i:=1 to N do Suma := Suma + Edad[i];
   Edad_media_c := Suma div N;
end;

{Se calculan estadisticas de estaturas del conjunto}

procedure Estatura_menor_del_conjunto;
begin
   Estatura_menor_c:=Estatura[1];
   for i:=1 to N do
     if Estatura[i]<Estatura_menor_c then Estatura_menor_c := Estatura[i];
end;

procedure Estatura_mayor_del_conjunto;
begin
   Estatura_mayor_c:=Estatura[1];
   for i:=1 to N do
     if Estatura[i]>Estatura_mayor_c then Estatura_mayor_c := Estatura[i];
end;

procedure Estatura_media_del_conjunto;
var
  Suma : real;
begin
   Suma := 0;
   for i:=1 to N do  Suma := Suma + Estatura[i];
   Estatura_media_c := Suma / N;
end;

procedure calcular_estadisticas_del_conjunto;
begin
  Edad_menor_del_conjunto;
  Edad_mayor_del_conjunto;
  Edad_media_del_conjunto;
  Estatura_menor_del_conjunto;
  Estatura_mayor_del_conjunto;
  Estatura_media_del_conjunto;
end;


procedure TF_Personas.B_CalcularClick(Sender: TObject);
begin
   if E_N.Text<>'' then N := Cadena_a_byte(E_N.Text);                             if N > 1 then
   begin
      for i:=1 to N do Edad[i] := Cadena_a_byte(G_Edad. Cells[0,i]);
      for i:=1 to N do Estatura[i] := Cadena_a_real(G_Estatura.Cells[0,i]);

      Calcular_estadisticas_del_conjunto;
      if Edad_menor_c<>0 then L_Edad_menor_c.Caption := byte_a_cadena(Edad_menor_c,3);
      if Edad_mayor_c<>0 then L_Edad_mayor_c.Caption := byte_a_cadena(Edad_mayor_c,3);
      if Edad_media_c<>0 then L_Edad_media_c.Caption := byte_a_cadena(Edad_media_c,3);
      if Edad_mediana_c<>0 then L_Edad_mediana_C.Caption := byte_a_cadena(Edad_mediana_c,3);
      if Edad_moda_c<>0 then L_Edad_moda_C.Caption  := byte_a_cadena(Edad_moda_c,3);


      if Estatura_menor_c<>0 then L_Estatura_menor_c.Caption := real_a_cadena(Estatura_menor_c,1,2);
      if Estatura_mayor_c<>0 then L_Estatura_mayor_c.Caption := real_a_cadena(Estatura_mayor_c,1,2);
      if Estatura_media_c<>0 then L_Estatura_media_c.Caption := real_a_cadena(Estatura_media_c,1,2);
      if Estatura_mediana_c<>0 then L_Estatura_mediana_C.Caption := real_a_cadena(Estatura_mediana_c,1,2);
      if Estatura_moda_c<>0 then L_Estatura_moda_C.Caption := real_a_cadena(Estatura_moda_c,1,2);
   end;
end;

procedure TF_Personas.FormActivate(Sender: TObject);
begin
  E_N.Text :='5';
  for i:=1 to G_Nombre.RowCount do cadena := G_Nombre.Cells[0,i];
  L_Edad_menor_c.Caption := '';
  L_Edad_mayor_c.Caption := '';
  L_Edad_media_c.Caption := '';
  L_Edad_mediana_c.Caption := '';
  L_Edad_moda_c.Caption := '';
  
    G_i.RowCount:=N+1;
   if (G_i.DefaultRowHeight*G_i.RowCount+20)<510 then
      G_i.Height:=G_i.DefaultRowHeight * G_i.RowCount+G_Sexo.DefaultRowHeight
   else G_i.Height:=500;
   G_i.Cells[0,0]:='    i';
   for i:=1 to G_i.RowCount do G_i.Cells[0,i] := Byte_a_cadena(i,5);

   G_Nombre.RowCount:=N+1;
   if (G_nombre.DefaultRowHeight*G_nombre.RowCount+20)<510 then
      G_nombre.Height:=G_nombre.DefaultRowHeight * G_nombre.RowCount+G_Nombre.DefaultRowHeight
   else G_Nombre.Height:=500;
   G_Nombre.Cells[0,0]:='                                 NOMBRE';

   G_Edad.RowCount:=N+1;
   if (G_Edad.DefaultRowHeight*G_Edad.RowCount+20)<510 then
      G_Edad.Height:=G_Edad.DefaultRowHeight * G_Edad.RowCount+G_Edad.DefaultRowHeight
   else G_Edad.Height:=500;
   G_Edad.Cells[0,0]:='     Edad';

   G_Estatura.RowCount:=N+1;
   if (G_Estatura.DefaultRowHeight*G_Estatura.RowCount+20)<510 then
      G_Estatura.Height:=G_Estatura.DefaultRowHeight * G_Estatura.RowCount+G_Estatura.DefaultRowHeight
   else G_Estatura.Height:=500;
   G_Estatura.Cells[0,0]:=' Estatura';

   G_Sexo.RowCount:=N+1;
   if (G_Sexo.DefaultRowHeight*G_Sexo.RowCount+20)<510 then
      G_Sexo.Height:=G_Sexo.DefaultRowHeight * G_Sexo.RowCount+G_Sexo.DefaultRowHeight
   else G_Sexo.Height:=500;
   G_Sexo.Cells[0,0]:=' Sexo';
end;

procedure TF_Personas.B_salirClick(Sender: TObject);
begin
  Close;
end;

procedure TF_Personas.B_limpiarClick(Sender: TObject);
begin
   for i:=1 to G_Nombre.RowCount do G_Nombre.Cells[0,i] := '';
   L_edad_menor_c.Caption := '';
   L_edad_mayor_c.Caption := '';
   L_edad_media_c.Caption := '';
   L_edad_mediana_c.Caption := '';
   L_edad_moda_c.Caption  := '';
   
   for i:=1 to G_Edad.RowCount do G_Edad.Cells[0,i] := '';
   for i:=1 to G_Estatura.RowCount do G_Estatura.Cells[0,i] := '';
   E_N.Text :='2';
end;


end.
