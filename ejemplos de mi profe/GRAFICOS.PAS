program demo_graph;
uses
  Crt,
  Graph;
var
  GraphDriver,
  ModeGraph     : integer;
  GraphPath     : string;
  Xi,
  Yi,
  Xf,
  Yf            : integer;
  Ashurado,
  Color         : word;
  i             : byte;
  Tecla         : char;
  Cadena        : string;

procedure Detecta_tarjeta_de_graficacion;
begin
  DetectGraph(GraphDriver,ModeGraph);
end;

procedure inicializa_modo_grafico;
begin
  Detecta_tarjeta_de_graficacion;
  InitGraph(GraphDriver,ModeGraph,'');
end;

procedure dibuja_pixeles_Aleatorios;
begin
  inicializa_modo_grafico;
  Randomize;
  repeat
    repeat
      Color := Random(GetMaxColor);
    until color > 0;
    repeat
      Xi := random(GetmaxX);
    until Xi>0;
    repeat
      Yi  := Random(GetMaxY);
    until Yi > 0;
    PutPixel(Xi,Yi,Color);
    Delay(50);
  until KeyPressed;
  Tecla := ReadKey;
  CloseGraph;
end;

procedure dibuja_circulos_concentricos;
var
  radio : integer;
begin
  inicializa_modo_grafico;
  Randomize;
  repeat
    repeat
       Color := Random(GetMaxColor);
    until Color>0;
    SetColor(Color);
    for i:=1 to 10 do
    begin
       Xi    := GetMaxX div 2;
       Yi    := GetMaxY div 2;
       radio := GetMaxY div 10;
     PutPixel(Xi,Yi,GetColor);
     Circle(Xi,Yi,i*radio);
     Delay(100);
    end;
    ClearDevice;
  until KeyPressed;
  Tecla := ReadKey;
  CloseGraph;
end;


procedure dibuja_circulos_aleatorios;
var
  radio : integer;
begin
  inicializa_modo_grafico;
  randomize;

  repeat
   SetColor(Random(GetMaxColor));
   repeat
      Xi := random(GetmaxX)-20;
    until (Xi >20) and (Xi<GetMaxX-20);
    repeat
      Yi := random(GetMaxY)-20;
    until (Yi >20) and (Yi<GetMaxY-20) ;
    repeat
      radio := random(GetMaxY-Yi)-10;
    until (radio > 10) and (radio<(GetMaxY-Yi)+10);
    PutPixel(Xi,Yi,GetColor);
    Circle(Xi,Yi,radio);
    Delay(100);
  until KeyPressed;
  Tecla := ReadKey;
  CloseGraph;
end;

procedure dibuja_rectangulos_aleatorios;
begin
  inicializa_modo_grafico;
  randomize;
  repeat
     repeat
       Color := random(GetMaxColor);
     until Color > 0;
     SetColor(Color);
   repeat
      Xf := random(GetmaxX)-20;
    until (Xf > 20) and (Xf<GetMaxX-20);
    repeat
      Yf := random(GetMaxY)-20;
    until (Yf >20) and (Yf<GetMaxY-20) ;
    repeat
      Xi :=  random(Xf);
    until Xi<Xf;
    repeat
      Yi := random(Yf);
    until Yi < Yf;
    Rectangle(Xi, Yi, Xf, Yf);
    Delay(100);
  until KeyPressed;
  Tecla := ReadKey;
  CloseGraph;
end;

procedure dibuja_rectangulos_concentricos;
begin
  inicializa_modo_grafico;
  randomize;
  repeat
    for i:=1 to 10 do
    begin
      SetColor(i);
      Xi := (GetMaxX div 2)- ((GetMaxX div 20)*i);
      Xf := (GetMaxX div 2)+ ((GetMaxX div 20)*i);
      Yi := (GetMaxY div 2)- ((GetMaxY div 20)*i);
      Yf := (GetMaxY div 2)+ ((GetMaxY div 20)*i);
      Rectangle(Xi, Yi, Xf, Yf);
      Delay(100);
    end;
    ClearDevice;
  until KeyPressed;
  Tecla := ReadKey;
  CloseGraph;
end;

procedure dibuja_barras_aleatorias;
begin
  inicializa_modo_grafico;
  randomize;
  repeat
     repeat
       Color := random(GetMaxColor);
     until Color > 0;
     repeat
       Ashurado := random(20);
     until Ashurado > 0;
     SetFillStyle(Ashurado,Color);
   repeat
      Xf := random(GetmaxX)-20;
    until (Xf > 20) and (Xf<GetMaxX-20);
    repeat
      Yf := random(GetMaxY)-20;
    until (Yf >20) and (Yf<GetMaxY-20) ;
    repeat
      Xi :=  random(Xf);
    until Xi<Xf;
    repeat
      Yi := random(Yf);
    until Yi < Yf;
    Bar(Xi, Yi, Xf, Yf);
    Delay(100);
  until KeyPressed;
  Tecla := ReadKey;
  CloseGraph;
end;

procedure dibuja_barras_concentricas;
begin
  inicializa_modo_grafico;
  randomize;
  repeat
    for i:=10 downto 1 do
    begin
      Color    := i;
      Ashurado := i;
      SetFillStyle(Ashurado,Color);
       Xi := (GetMaxX div 2)- ((GetMaxX div 20)*i);
       Xf := (GetMaxX div 2)+ ((GetMaxX div 20)*i);
       Yi := (GetMaxY div 2)- ((GetMaxY div 20)*i);
       Yf := (GetMaxY div 2)+ ((GetMaxY div 20)*i);
       Bar(Xi, Yi, Xf, Yf);
       Delay(200);
    end;
    ClearDevice;
  until KeyPressed;
  Tecla := ReadKey;
  CloseGraph;
end;

procedure dibuja_grafica_de_barras_2D;
begin
  inicializa_modo_grafico;
  randomize;
  repeat
    for i:=1 to 10 do
    begin
      Color    := i;
      Ashurado := i;
      SetFillStyle(Ashurado,Color);
       Xi := (GetMaxX div 10)+(GetMaxX div 15)*i;
       Xf := (GetMaxX div 10)+(GetMaxX div 15)*(i+1);
       Yi := (GetMaxY div 15)*i;
       Yf :=  GetmaxY-(GetMaxY div 10);
       Bar(Xi, Yi, Xf, Yf);
       Delay(100);
    end;
    Delay(400);
    ClearDevice;
  until KeyPressed;
  Tecla := ReadKey;
  CloseGraph;
end;

procedure dibuja_grafica_de_barras_3D;
var
  Fondo  : word;
  Arriba : Boolean;
begin
  inicializa_modo_grafico;
  randomize;
  Arriba := True;
  repeat
    Fondo := random(30);
    for i:=1 to 10 do
    begin
      Color    := i;
      Ashurado := i;
      SetFillStyle(Ashurado,Color);
       Xi := (GetMaxX div 20)+(GetMaxX div 15)*i+30;
       Xf := (GetMaxX div 20)+(GetMaxX div 15)*(i+1)+20;
       Yi := (GetMaxY div 15)*i;
       Yf :=  GetmaxY-(GetMaxY div 10);
       Bar3D(Xi, Yi, Xf, Yf,Fondo,Arriba);
       Delay(100);
    end;
    Delay(400);
    ClearDevice;
  until KeyPressed;
  Tecla := ReadKey;
  CloseGraph;
end;

procedure dibuja_arcos_aleatorios;
var
  Angulo_de_inicio,
  Angulo_de_finalizacion,
  radio : word;
begin
  inicializa_modo_grafico;
  randomize;
  repeat
   SetColor(Random(GetMaxColor));
   repeat
      Xi := random(GetmaxX)-20;
    until (Xi >20) and (Xi<GetMaxX-20);
    repeat
      Yi := random(GetMaxY)-20;
    until (Yi >20) and (Yi<GetMaxY-20) ;
    repeat
      radio := random(GetMaxY div 10);
    until (radio > 10) and (radio<(GetMaxY div 10));
    repeat
      Angulo_de_finalizacion := random (360);
    until (Angulo_de_Finalizacion>0) and (Angulo_de_finalizacion<360);
    repeat
      Angulo_de_inicio := random (Angulo_de_finalizacion);
    until (Angulo_de_inicio > 0) and
          (Angulo_de_inicio < Angulo_de_finalizacion);
    Arc(Xi,Yi,Angulo_de_inicio,Angulo_de_finalizacion,radio);
    Delay(300);
  until KeyPressed;
  Tecla := ReadKey;
  CloseGraph;
end;

procedure dibuja_barras_de_pastel_aleatorias;
var
  Angulo_de_inicio,
  Angulo_de_finalizacion,
  radio : word;
begin
  inicializa_modo_grafico;
  randomize;
  repeat
    repeat
      Color := random(GetMaxColor);
    until Color > 0;
    repeat
      Ashurado := random(20);
    until Ashurado > 0;
    SetFillStyle(Ashurado,Color);
    SetColor(Random(GetMaxColor));
    repeat
       Xi := random(GetmaxX)-20;
     until (Xi >20) and (Xi<GetMaxX-20);
     repeat
       Yi := random(GetMaxY)-20;
     until (Yi >20) and (Yi<GetMaxY-20) ;
     repeat
       radio := random(GetMaxY div 10);
     until (radio > 10) and (radio<(GetMaxY div 10));
     repeat
       Angulo_de_finalizacion := random (360);
     until (Angulo_de_Finalizacion>0) and (Angulo_de_finalizacion<360);
     repeat
       Angulo_de_inicio := random (Angulo_de_finalizacion);
     until (Angulo_de_inicio > 0) and
           (Angulo_de_inicio < Angulo_de_finalizacion);
     PieSlice(Xi,Yi,Angulo_de_inicio,Angulo_de_finalizacion,radio);
     Delay(300);
  until KeyPressed;
  Tecla := ReadKey;
  CloseGraph;
end;

procedure dibuja_lineas_aleatorias;
begin
  inicializa_modo_grafico;
  randomize;
  repeat
    repeat
      Color := random(GetMaxColor);
    until Color > 0;
    SetColor(Random(GetMaxColor));
    repeat
       Xf := random(GetmaxX)-20;
     until (Xf >20) and (Xf<GetMaxX-20);
     repeat
       Yf := random(GetMaxY)-20;
     until (Yf >20) and (Yf<GetMaxY-20) ;
     repeat
       Xi := random(Xf);
     until (Xi > 0) and (Xi<Xf);
     repeat
       Yi := random(Yf);
     until (Yi > 0) and (Yi< Yf) ;
     Line(Xi,Yi,Xf,Yf);
     Delay(300);
  until KeyPressed;
  Tecla := ReadKey;
  CloseGraph;
end;

procedure dibuja_lineas_continuas;
begin
  inicializa_modo_grafico;
  randomize;
  repeat
     Xf := random(GetmaxX)-20;
   until (Xf >20) and (Xf<GetMaxX-20);
   repeat
     Yf := random(GetMaxY)-20;
   until (Yf >20) and (Yf<GetMaxY-20) ;
   repeat
     Xi := random(Xf);
   until (Xi > 0) and (Xi<Xf);
   repeat
     Yi := random(Yf);
   until (Yi > 0) and (Yi< Yf) ;
   repeat
      Color := random(GetMaxColor);
   until Color > 0;
   SetColor(Random(GetMaxColor));
   Line(Xi,Yi,Xf,Yf);
   Delay(300);
  repeat
    repeat
       Xf := random(GetmaxX)-20;
     until (Xf >20) and (Xf<GetMaxX-20);
     repeat
       Yf := random(GetMaxY)-20;
     until (Yf >20) and (Yf<GetMaxY-20) ;
     repeat
       Color := random(GetMaxColor);
     until Color > 0;
     SetColor(Random(GetMaxColor));
     LineTo(Xf,Yf);
     Delay(300);
  until KeyPressed;
  Tecla := ReadKey;
  CloseGraph;
end;

procedure dibuja_Textos_horizontales;
var
  Tipo_de_font,
  Direccion_font,
  Tamanio_de_font  : word;
  j                : byte;

begin
  inicializa_modo_grafico;
  randomize;
  repeat
     repeat
       Color := random(GetMaxColor);
     until Color > 0;
     SetColor(Random(GetMaxColor));
     For i:=1 to 10 do
     begin
       SetColor(i);
       Yi := 10;
       Tipo_de_font := i;
       for j:=1 to 5 do
       begin
         Tamanio_de_font:= j;
         SetTextStyle(Tipo_de_Font,HorizDir,Tamanio_de_font);
         Yi := Yi + TextHeight('Hola')+1;
         OutTextXY(250,Yi, 'Hola');
       end;
       Delay(200);
       ClearDevice;
     end;
  until KeyPressed;
  Tecla := ReadKey;
  CloseGraph;
end;

procedure dibuja_Textos_verticales;
var
  Tipo_de_font,
  Direccion_font,
  Tamanio_de_font  : word;
  j                : byte;

begin
  inicializa_modo_grafico;
  randomize;
  repeat
     repeat
       Color := random(GetMaxColor);
     until Color > 0;
     SetColor(Random(GetMaxColor));
     For i:=1 to 10 do
     begin
       Tipo_de_font := i;
       SetColor(i);
       Xi := 100;
       for j:=1 to 5 do
       begin
         Tamanio_de_font:= j;
         SetTextStyle(Tipo_de_Font,VertDir,Tamanio_de_font);
         OutTextXY(Xi,(GetmaxY div 8), 'Texto');
         Xi := Xi + TextWidth('T')+7;
       end;
       Delay(200);
       ClearDevice;
     end;
  until KeyPressed;
  Tecla := ReadKey;
  CloseGraph;
end;

begin
  dibuja_pixeles_Aleatorios;
  dibuja_circulos_aleatorios;
  dibuja_circulos_concentricos;
  dibuja_rectangulos_aleatorios;
  dibuja_rectangulos_concentricos;
  dibuja_barras_aleatorias;
  dibuja_barras_concentricas;
  dibuja_grafica_de_barras_2D;
  dibuja_grafica_de_barras_3D;
  dibuja_arcos_aleatorios;
  dibuja_barras_de_pastel_aleatorias;
  dibuja_lineas_aleatorias;
  dibuja_lineas_continuas;
  dibuja_Textos_horizontales;
  dibuja_textos_verticales;
end.

