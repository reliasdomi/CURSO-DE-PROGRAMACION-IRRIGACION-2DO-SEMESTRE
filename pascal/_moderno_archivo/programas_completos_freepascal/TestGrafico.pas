{ ==================================================================
  INTEGRANTES - Grupo 4A - Irrigacion - U.A. Chapingo:
    - ELIAS DOMINGUEZ RUBEN
    - BISTRAIN BORRAZ ANGEL GABRIEL
    - CRUZ SIBAJA GIBRAN FRANCISCO
    - TORRES VALENCIA MARIO ALBERTO
  ================================================================== }
program TestGrafico;
{ Diagnostico minimo del modo grafico (unit Graph / ptcgraph).
  Dice si InitGraph funciona en ESTA maquina y abre una ventana de prueba. }
{$mode objfpc}{$H+}
uses Graph, SysUtils;
var gd, gm: SmallInt; gr: Integer;
begin
  WriteLn('Iniciando modo grafico...');
  gd := Detect;
  InitGraph(gd, gm, '');
  gr := GraphResult;
  WriteLn('GraphResult = ', gr, '  (0 = grOk; correcto)');
  if gr <> grOk then
  begin
    WriteLn('FALLO: ', GraphErrorMsg(gr));
    WriteLn('Pulse ENTER para salir...');
    ReadLn;
    Halt(1);
  end;
  WriteLn('OK. Resolucion: ', GetMaxX + 1, ' x ', GetMaxY + 1);
  SetBkColor(Blue);
  ClearDevice;
  SetColor(Yellow);
  SetTextStyle(DefaultFont, HorizDir, 2);
  OutTextXY(80, 60, 'SI VES ESTO, EL MODO GRAFICO FUNCIONA');
  SetColor(White);
  Rectangle(150, 150, 450, 350);
  Circle(300, 250, 100);
  WriteLn('Debe haber una ventana azul con texto y figuras.');
  WriteLn('Pulse ENTER aqui para cerrar...');
  ReadLn;
  CloseGraph;
end.
