program P_System;

uses
  Forms,
  U_System in 'U_System.pas' {F_System},
  U_Cuadrado in '..\FIGUAS GEOMETRICAS\CUADRADO\U_Cuadrado.pas' {F_Cuadrado},
  U_Rectangulo in '..\FIGUAS GEOMETRICAS\RECTANGULO\U_Rectangulo.pas' {F_Rectangulo};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TF_System, F_System);
  Application.CreateForm(TF_Cuadrado, F_Cuadrado);
  Application.CreateForm(TF_Rectangulo, F_Rectangulo);
  Application.Run;
end.
