unit U_system;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus;

type
  TF_system = class(TForm)
    MainMenu1: TMainMenu;
    Figuras1: TMenuItem;
    Cuadrado1: TMenuItem;
    Rectangulo1: TMenuItem;
    procedure Cuadrado1Click(Sender: TObject);
    procedure Rectangulo1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_system: TF_system;

implementation

uses U_Cuadrado, U_Rectangulo;

{$R *.dfm}

procedure TF_system.Cuadrado1Click(Sender: TObject);
begin
  F_cuadrado.show;
end;

procedure TF_system.Rectangulo1Click(Sender: TObject);
begin
  F_rectangulo.show;
end;

end.
