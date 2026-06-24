program P_system;

uses
  Forms,
  U_system in 'U_system.pas' {F_system},
  U_Cuadrado in '..\FIGUAS GEOMETRICAS\CUADRADO\U_Cuadrado.pas' {F_Cuadrado},
  U_Rectangulo in '..\FIGUAS GEOMETRICAS\RECTANGULO\U_Rectangulo.pas' {F_Rectangulo};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TF_system, F_system);
  Application.CreateForm(TF_Cuadrado, F_Cuadrado);
  Application.CreateForm(TF_Rectangulo, F_Rectangulo);
  Application.Run;
end.
