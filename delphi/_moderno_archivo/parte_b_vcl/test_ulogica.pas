{ ==================================================================
  INTEGRANTES - Grupo 4A - Irrigacion - U.A. Chapingo:
    - ELIAS DOMINGUEZ RUBEN
    - BISTRAIN BORRAZ ANGEL GABRIEL
    - CRUZ SIBAJA GIBRAN FRANCISCO
    - TORRES VALENCIA MARIO ALBERTO
  ================================================================== }
program test_ulogica;
{ Smoke-test de la capa pura uLogica.pas con FPC -Mdelphi (sin VCL).
  No forma parte de la app; solo valida la logica compartida. }
{$MODE DELPHI}
uses SysUtils, uLogica;

var
  d, x, y: TVector;
  g: TGrupo;
  a, b, inv: TMatriz;
  va, vb, det: Double;
  fr: Integer;
  me, mn, mx, vp, dp, vm, dm: Double; hayM: Boolean;
  disc, x1, x2: Double;

procedure Chk(const Nombre: string; Cond: Boolean);
begin
  if Cond then WriteLn('OK  ', Nombre)
  else begin WriteLn('FALLA ', Nombre); Halt(1); end;
end;

begin
  { Figuras }
  Chk('FigCuadrado area', Abs(FigCuadrado(5).Area - 25) < 1e-9);
  Chk('FigCirculo perim', Abs(FigCirculo(3).Perimetro - 2*Pi*3) < 1e-9);
  Chk('FigPoligono cuadrado', Abs(FigPoligono(4, 2).Area - 4) < 1e-6);

  { Escalares }
  Chk('EsPar', EsPar(4) and not EsPar(7));
  Chk('Cuadratica 2 raices', Cuadratica(1,-3,2,disc,x1,x2)=2);
  Chk('Cuadratica raices x^2-3x+2', (Abs(x1-2)<1e-9) and (Abs(x2-1)<1e-9));

  { Vector }
  SetLength(d,5); d[0]:=4; d[1]:=8; d[2]:=15; d[3]:=16; d[4]:=23;
  Chk('VecMaximo', VecMaximo(d)=23);
  Chk('VecMinimo', VecMinimo(d)=4);
  Chk('VecMedia', Abs(VecMedia(d)-13.2)<1e-9);
  Chk('VecMediana impar', VecMediana(d)=15);
  SetLength(d,4); d[0]:=10; d[1]:=2; d[2]:=8; d[3]:=4;
  Chk('VecMediana par', VecMediana(d)=6);  { ordenado 2,4,8,10 -> (4+8)/2 }
  SetLength(d,5); d[0]:=1; d[1]:=2; d[2]:=2; d[3]:=3; d[4]:=2;
  Chk('VecModa', (VecModa(d,fr)=2) and (fr=3));

  { Regresion: y=2x+1 }
  SetLength(x,3); SetLength(y,3);
  x[0]:=1; x[1]:=2; x[2]:=3; y[0]:=3; y[1]:=5; y[2]:=7;
  Chk('Regresion ok', Regresion(x,y,va,vb));
  Chk('Regresion a=1 b=2', (Abs(va-1)<1e-9) and (Abs(vb-2)<1e-9));

  { Desviacion: 2,4,4,4,5,5,7,9 -> media 5, var pob 4, desv pob 2 }
  SetLength(d,8); d[0]:=2; d[1]:=4; d[2]:=4; d[3]:=4; d[4]:=5; d[5]:=5; d[6]:=7; d[7]:=9;
  VarianzaDesviacion(d, me, mn, mx, vp, dp, vm, dm, hayM);
  Chk('Desv media', me=5);
  Chk('Desv pob var', Abs(vp-4)<1e-9);
  Chk('Desv pob std', Abs(dp-2)<1e-9);

  { Demografia }
  SetLength(g,4);
  g[0].Nombre:='A'; g[0].Sexo:='H'; g[0].Edad:=20; g[0].Estatura:=1.7;
  g[1].Nombre:='B'; g[1].Sexo:='M'; g[1].Edad:=17; g[1].Estatura:=1.6;
  g[2].Nombre:='C'; g[2].Sexo:='H'; g[2].Edad:=15; g[2].Estatura:=1.5;
  g[3].Nombre:='D'; g[3].Sexo:='M'; g[3].Edad:=30; g[3].Estatura:=1.8;
  Chk('ContarSexo H', ContarSexo(g, sfHombres)=2);
  Chk('ContarSexo M', ContarSexo(g, sfMujeres)=2);
  Chk('ContarEdad mayores', ContarEdad(g, sfTodos, True)=2);
  Chk('ContarEdad menores', ContarEdad(g, sfTodos, False)=2);
  Chk('ContarEdad mujeres mayores', ContarEdad(g, sfMujeres, True)=1);
  Chk('AgregaCampo prom edad H', AgregaCampo(g, sfHombres, cpEdad, mtPromedio, va) and (Abs(va-17.5)<1e-9));
  Chk('AgregaCampo max est', AgregaCampo(g, sfTodos, cpEstatura, mtMaximo, va) and (Abs(va-1.8)<1e-9));

  { Matrices }
  SetLength(a,2,2); SetLength(b,2,2);
  a[0,0]:=1; a[0,1]:=2; a[1,0]:=3; a[1,1]:=4;
  b[0,0]:=5; b[0,1]:=6; b[1,0]:=7; b[1,1]:=8;
  Chk('MatSuma', (MatSuma(a,b)[0,0]=6) and (MatSuma(a,b)[1,1]=12));
  Chk('MatResta', (MatResta(b,a)[0,0]=4) and (MatResta(b,a)[1,1]=4));
  Chk('MatTranspuesta', MatTranspuesta(a)[0,1]=3);
  Chk('MatInversa ok', MatInversa2x2(a, inv, det) and (Abs(det-(-2))<1e-9));
  Chk('MatInversa val', Abs(inv[0,0]-(-2))<1e-9);
  SetLength(a,2,2); a[0,0]:=1; a[0,1]:=2; a[1,0]:=2; a[1,1]:=4;
  Chk('MatInversa det0', not MatInversa2x2(a, inv, det));

  WriteLn;
  WriteLn('TODOS LOS TESTS PASARON');
end.
