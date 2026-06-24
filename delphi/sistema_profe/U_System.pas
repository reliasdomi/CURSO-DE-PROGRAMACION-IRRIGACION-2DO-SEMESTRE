unit U_System;

{ Formulario principal: menu general (TMainMenu) que abre un formulario
  por categoria. Cada item lleva su Tag = numero de programa y comparte
  el manejador ItemClick (estilo despachador). }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Menus;

type
  TF_System = class(TForm)
    P_Cabecera: TPanel;
    L_Titulo: TLabel;
    L_Subtitulo: TLabel;
    L_Instruccion: TLabel;
    MainMenu1: TMainMenu;
    M_Figuras: TMenuItem;
    M_Cuadrado: TMenuItem;
    M_Rectangulo: TMenuItem;
    M_Triangulo: TMenuItem;
    M_Circulo: TMenuItem;
    M_Rombo: TMenuItem;
    M_Trapecio: TMenuItem;
    M_Poligono: TMenuItem;
    M_Estadistica: TMenuItem;
    M_Mayor: TMenuItem;
    M_Menor: TMenuItem;
    M_Media: TMenuItem;
    M_Mediana: TMenuItem;
    M_Moda: TMenuItem;
    M_OrdenarAsc: TMenuItem;
    M_OrdenarDesc: TMenuItem;
    M_Regresion: TMenuItem;
    M_Varianza: TMenuItem;
    M_Personas: TMenuItem;
    M_Matrices: TMenuItem;
    M_Suma: TMenuItem;
    M_Resta: TMenuItem;
    M_Transpuesta: TMenuItem;
    M_Inversa: TMenuItem;
    M_Miscelaneos: TMenuItem;
    M_ParImpar: TMenuItem;
    M_Cuadratica: TMenuItem;
    M_Salir: TMenuItem;
    procedure ItemClick(Sender: TObject);
    procedure M_SalirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_System: TF_System;

implementation

uses
  U_Figuras, U_Estadistica, U_Personas, U_Matrices, U_Miscelaneos;

{$R *.dfm}

procedure TF_System.ItemClick(Sender: TObject);
var
  k: integer;
begin
  k := (Sender as TMenuItem).Tag;
  case k of
    1, 2, 3, 4, 5, 6, 38:
      begin F_Figuras.Preparar(k); F_Figuras.Show; end;
    7, 8:
      begin F_Miscelaneos.Preparar(k); F_Miscelaneos.Show; end;
    9, 10, 11, 12, 13, 14, 15, 36, 37:
      begin F_Estadistica.Preparar(k); F_Estadistica.Show; end;
    16:
      F_Personas.Show;
    39, 40, 41, 42:
      begin F_Matrices.Preparar(k); F_Matrices.Show; end;
  end;
end;

procedure TF_System.M_SalirClick(Sender: TObject);
begin
  Close;
end;

end.
