unit U_System;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, jpeg, Menus;

type
  TF_System = class(TForm)
    I_portada: TImage;
    MainMenu1: TMainMenu;
    Figurasgeomtricas1: TMenuItem;
    Estadsiticas1: TMenuItem;
    Personas1: TMenuItem;
    Matrices1: TMenuItem;
    Archivos1: TMenuItem;
    Archivos2: TMenuItem;
    Miscelneos1: TMenuItem;
    Cuadrado1: TMenuItem;
    Rectngulo1: TMenuItem;
    ringulo1: TMenuItem;
    Crculo1: TMenuItem;
    rombo1: TMenuItem;
    racecio1: TMenuItem;
    Menor1: TMenuItem;
    Mayor1: TMenuItem;
    Media1: TMenuItem;
    Mediana1: TMenuItem;
    Moda1: TMenuItem;
    Ordenar1: TMenuItem;
    Grupo1: TMenuItem;
    Mujeres1: TMenuItem;
    Hombres1: TMenuItem;
    Resta1: TMenuItem;
    Multiplicacin1: TMenuItem;
    ITraspuesta1: TMenuItem;
    Inversa1: TMenuItem;
    ParImpar1: TMenuItem;
    EcCuadrtica1: TMenuItem;
    Salir1: TMenuItem;
    I_potada_2: TImage;
    Image1: TImage;
    procedure Cuadrado1Click(Sender: TObject);
    procedure Salir1Click(Sender: TObject);
    procedure Rectngulo1Click(Sender: TObject);

     private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Cadena  : string;
  Numero  : real;
  Codigo_de_Error : integer;

  F_System: TF_System;

implementation

uses U_Cuadrado, U_Rectangulo;

{$R *.dfm}




procedure TF_System.Cuadrado1Click(Sender: TObject);
begin
  F_cuadrado.show;
end;

procedure TF_System.Salir1Click(Sender: TObject);
begin
  Close;
end;

procedure TF_System.Rectngulo1Click(Sender: TObject);
begin
  F_rectangulo.show;
end;

end.
