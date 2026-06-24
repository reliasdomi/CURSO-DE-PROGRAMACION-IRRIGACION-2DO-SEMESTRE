{ ==================================================================
  INTEGRANTES - Grupo 4A - Irrigacion - U.A. Chapingo:
    - ELIAS DOMINGUEZ RUBEN
    - BISTRAIN BORRAZ ANGEL GABRIEL
    - CRUZ SIBAJA GIBRAN FRANCISCO
    - TORRES VALENCIA MARIO ALBERTO
  ================================================================== }
unit uPrincipal;
{ Formulario principal de la app VCL (RAD Studio / Delphi 12).
  Menu nativo (TMainMenu) con los 42 programas del Grupo 4A + area de contenido
  que se repuebla con controles nativos (TStringGrid, TEdit, TMemo, TPaintBox).
  Toda la UI se construye en codigo para que el .dfm sea minimo y no haya
  desajustes .dfm/.pas. La logica vive en uLogica.pas.
  Universidad Autonoma Chapingo - Departamento de Irrigacion. }

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes, System.Types, System.Math,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Menus, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Grids, Vcl.Imaging.pngimage, uLogica;

type
  TFormPrincipal = class(TForm)
    { Componentes visuales declarados en uPrincipal.dfm (visibles en el Designer).
      El resto de la UI (menu y controles por programa) se sigue construyendo en
      codigo en runtime para mantener el comportamiento dinamico de los 42 items. }
    FBanner: TPanel;
    FImgIzq: TImage;
    FImgDer: TImage;
    FTituloLbl: TLabel;
    FContent: TPanel;
    procedure FormCreate(Sender: TObject);
  private
    FMenu: TMainMenu;
    FAccion: TProc;                 { accion del boton Calcular del programa activo }
    FMemo: TMemo;
    FGridA, FGridB: TStringGrid;
    FEdN, FEdFilas, FEdCols: TEdit;
    FEdits: array of TEdit;
    FPaintBox: TPaintBox;
    { estado de la figura a dibujar }
    FFigTipo: Integer;
    FFigP: array[0..4] of Double;
    FFigInfo: string;
    { construccion del menu }
    procedure AddItem(Padre: TMenuItem; const Texto: string; Id: Integer);
    function NuevoSubmenu(const Texto: string): TMenuItem;
    { manejadores }
    procedure ItemClick(Sender: TObject);
    procedure DoCalcular(Sender: TObject);
    procedure DoAplicarDatos(Sender: TObject);
    procedure DoAplicarGrupo(Sender: TObject);
    procedure DoAplicarMat(Sender: TObject);
    procedure FigPaint(Sender: TObject);
    { utilidades de UI }
    procedure LimpiarContenido;
    function Lbl(const T: string; X, Y: Integer): TLabel;
    function Ed(X, Y, W: Integer): TEdit;
    function Btn(const T: string; X, Y, W: Integer; H: TNotifyEvent): TButton;
    function NuevoTitulo(const T: string): TLabel;
    { scaffolds }
    procedure ScaffoldDatos(const Titulo: string; Columnas: Integer; const Cab: array of string);
    procedure ScaffoldGrupo(const Titulo: string);
    procedure ScaffoldEntradas(const Titulo: string; const Etiquetas: array of string; ConFigura: Boolean);
    procedure ScaffoldMatriz(const Titulo: string; Doble, Fija2x2: Boolean);
    { lectura }
    function ReadVector(Grid: TStringGrid; Col: Integer): TVector;
    function ReadGrupo: TGrupo;
    function ReadMatriz(Grid: TStringGrid): TMatriz;
    function ValEdit(Indice: Integer; out V: Double): Boolean;
    { despachador }
    procedure Mostrar(Id: Integer);
  public
  end;

var
  FormPrincipal: TFormPrincipal;

implementation

{$R *.dfm}

var
  FInv: TFormatSettings;   { decimal con punto, para parseo robusto }

function F(X: Double): string;
begin
  Result := FormatFloat('0.00', X);
end;

function ParseReal(const S: string; out V: Double): Boolean;
var t: string;
begin
  t := Trim(S);
  if t = '' then Exit(False);
  if TryStrToFloat(t, V, FInv) then Exit(True);
  { aceptar coma decimal }
  t := StringReplace(t, ',', '.', [rfReplaceAll]);
  Result := TryStrToFloat(t, V, FInv);
end;

{ Busca un asset PNG en varias rutas candidatas relativas al .exe.
  Soporta tanto ejecutar desde Win32\Debug del IDE como copiar el .exe
  con la carpeta assets/ a un lado. Devuelve '' si no encuentra nada. }
function LocateAsset(const Nombre: string): string;
var base: string;
begin
  base := ExtractFilePath(Application.ExeName);
  Result := base + 'assets\' + Nombre;
  if FileExists(Result) then Exit;
  Result := base + '..\assets\' + Nombre;
  if FileExists(Result) then Exit;
  Result := base + '..\..\assets\' + Nombre;
  if FileExists(Result) then Exit;
  Result := base + '..\..\..\assets\' + Nombre;
  if not FileExists(Result) then Result := '';
end;

{ Carga un PNG en un TImage tolerando que el archivo no exista o este corrupto:
  en ese caso el TImage queda vacio y la app sigue corriendo sin tronar. }
procedure CargarLogo(Img: TImage; const Archivo: string);
var ruta: string;
begin
  ruta := LocateAsset(Archivo);
  if ruta = '' then Exit;
  try
    Img.Picture.LoadFromFile(ruta);
  except
    { PNG corrupto u otro error: ignorar }
  end;
end;

{ ===================== Construccion del menu ===================== }

procedure TFormPrincipal.AddItem(Padre: TMenuItem; const Texto: string; Id: Integer);
var mi: TMenuItem;
begin
  mi := TMenuItem.Create(Self);
  mi.Caption := Texto;
  mi.Tag := Id;
  mi.OnClick := ItemClick;
  Padre.Add(mi);
end;

function TFormPrincipal.NuevoSubmenu(const Texto: string): TMenuItem;
begin
  Result := TMenuItem.Create(Self);
  Result.Caption := Texto;
  FMenu.Items.Add(Result);
end;

procedure TFormPrincipal.FormCreate(Sender: TObject);
var mFig, mMisc, mEst, mDem, mMat: TMenuItem;
begin
  { El banner (FBanner + FImgIzq + FImgDer + FTituloLbl) y el panel de
    contenido (FContent) ya vienen declarados en uPrincipal.dfm. Aqui solo
    cargamos las imagenes en runtime desde la carpeta assets/ y armamos
    el menu dinamico con los 42 programas. }
  CargarLogo(FImgIzq, 'chapingo.png');
  CargarLogo(FImgDer, 'irrigacion.png');

  FMenu := TMainMenu.Create(Self);
  Self.Menu := FMenu;

  { Figuras }
  mFig := NuevoSubmenu('&Figuras');
  AddItem(mFig, '1. Cuadrado', 1);
  AddItem(mFig, '2. Rectangulo', 2);
  AddItem(mFig, '3. Triangulo', 3);
  AddItem(mFig, '4. Circulo', 4);
  AddItem(mFig, '5. Rombo', 5);
  AddItem(mFig, '6. Trapecio', 6);
  AddItem(mFig, '38. Poligono regular', 38);

  { Misc }
  mMisc := NuevoSubmenu('&Misc');
  AddItem(mMisc, '7. Par / Impar', 7);
  AddItem(mMisc, '8. Ecuacion cuadratica', 8);

  { Estadistica }
  mEst := NuevoSubmenu('&Estadistica');
  AddItem(mEst, '9. Numero mayor', 9);
  AddItem(mEst, '10. Numero menor', 10);
  AddItem(mEst, '11. Media aritmetica', 11);
  AddItem(mEst, '12. Mediana', 12);
  AddItem(mEst, '13. Moda', 13);
  AddItem(mEst, '14. Ordenar de menor a mayor', 14);
  AddItem(mEst, '15. Ordenar de mayor a menor', 15);
  AddItem(mEst, '36. Regresion lineal', 36);
  AddItem(mEst, '37. Varianza y desviacion estandar', 37);

  { Demografia }
  mDem := NuevoSubmenu('&Demografia');
  AddItem(mDem, '16. Hombres en el grupo', 16);
  AddItem(mDem, '17. Mujeres en el grupo', 17);
  AddItem(mDem, '18. Edad mayor/menor (grupo)', 18);
  AddItem(mDem, '19. Estatura mayor/menor (grupo)', 19);
  AddItem(mDem, '20. Edad mayor/menor (mujeres)', 20);
  AddItem(mDem, '21. Edad mayor/menor (hombres)', 21);
  AddItem(mDem, '22. Mayores de edad', 22);
  AddItem(mDem, '23. Menores de edad', 23);
  AddItem(mDem, '24. Mujeres mayores de edad', 24);
  AddItem(mDem, '25. Mujeres menores de edad', 25);
  AddItem(mDem, '26. Hombres mayores de edad', 26);
  AddItem(mDem, '27. Hombres menores de edad', 27);
  AddItem(mDem, '28. Estatura mayor/menor (mujeres)', 28);
  AddItem(mDem, '29. Estatura mayor/menor (hombres)', 29);
  AddItem(mDem, '30. Promedio edad (grupo)', 30);
  AddItem(mDem, '31. Promedio estatura (grupo)', 31);
  AddItem(mDem, '32. Promedio edad (mujeres)', 32);
  AddItem(mDem, '33. Promedio edad (hombres)', 33);
  AddItem(mDem, '34. Promedio estatura (mujeres)', 34);
  AddItem(mDem, '35. Promedio estatura (hombres)', 35);

  { Matrices }
  mMat := NuevoSubmenu('&Matrices');
  AddItem(mMat, '39. Suma de matrices', 39);
  AddItem(mMat, '40. Resta de matrices', 40);
  AddItem(mMat, '41. Matriz transpuesta', 41);
  AddItem(mMat, '42. Matriz inversa 2x2', 42);

  Mostrar(1);
end;

{ ===================== Utilidades de UI ===================== }

procedure TFormPrincipal.LimpiarContenido;
var i: Integer;
begin
  FAccion := nil;
  FMemo := nil; FGridA := nil; FGridB := nil;
  FEdN := nil; FEdFilas := nil; FEdCols := nil; FPaintBox := nil;
  SetLength(FEdits, 0);
  for i := FContent.ControlCount - 1 downto 0 do
    FContent.Controls[i].Free;
end;

function TFormPrincipal.Lbl(const T: string; X, Y: Integer): TLabel;
begin
  Result := TLabel.Create(FContent);
  Result.Parent := FContent;
  Result.Left := X; Result.Top := Y;
  Result.Caption := T;
end;

function TFormPrincipal.Ed(X, Y, W: Integer): TEdit;
begin
  Result := TEdit.Create(FContent);
  Result.Parent := FContent;
  Result.Left := X; Result.Top := Y; Result.Width := W;
  Result.Text := '';
end;

function TFormPrincipal.Btn(const T: string; X, Y, W: Integer; H: TNotifyEvent): TButton;
begin
  Result := TButton.Create(FContent);
  Result.Parent := FContent;
  Result.Left := X; Result.Top := Y; Result.Width := W; Result.Height := 28;
  Result.Caption := T;
  Result.OnClick := H;
end;

function TFormPrincipal.NuevoTitulo(const T: string): TLabel;
begin
  Result := Lbl(T, 16, 12);
  Result.Font.Style := [fsBold];
  Result.Font.Size := 12;
end;

{ ===================== Manejadores ===================== }

procedure TFormPrincipal.ItemClick(Sender: TObject);
begin
  Mostrar((Sender as TMenuItem).Tag);
end;

procedure TFormPrincipal.DoCalcular(Sender: TObject);
begin
  if Assigned(FMemo) then FMemo.Clear;
  if not Assigned(FAccion) then Exit;
  try
    FAccion();
  except
    on E: Exception do
      if Assigned(FMemo) then FMemo.Lines.Add('Error: ' + E.Message);
  end;
end;

procedure TFormPrincipal.DoAplicarDatos(Sender: TObject);
var n, r: Integer; v: Double;
begin
  if (FGridA = nil) or (FEdN = nil) then Exit;
  if not ParseReal(FEdN.Text, v) then Exit;
  n := Round(v);
  if n < 1 then n := 1;
  if n > 100 then n := 100;
  FGridA.RowCount := n + 1;
  for r := 1 to n do FGridA.Cells[0, r] := IntToStr(r);
end;

procedure TFormPrincipal.DoAplicarGrupo(Sender: TObject);
begin
  DoAplicarDatos(Sender);  { misma logica de cantidad de filas }
end;

procedure TFormPrincipal.DoAplicarMat(Sender: TObject);
var f, c, i: Integer; vf, vc: Double;

  procedure Dim(G: TStringGrid; const Etq: string);
  var k: Integer;
  begin
    if G = nil then Exit;
    G.ColCount := c + 1;
    G.RowCount := f + 1;
    G.Cells[0, 0] := Etq;
    for k := 1 to c do G.Cells[k, 0] := 'C' + IntToStr(k);
    for k := 1 to f do G.Cells[0, k] := 'F' + IntToStr(k);
  end;

begin
  if (FEdFilas = nil) or (FEdCols = nil) then Exit;
  if not ParseReal(FEdFilas.Text, vf) then Exit;
  if not ParseReal(FEdCols.Text, vc) then Exit;
  f := Round(vf); c := Round(vc);
  if f < 1 then f := 1; if f > 10 then f := 10;
  if c < 1 then c := 1; if c > 10 then c := 10;
  Dim(FGridA, 'A');
  Dim(FGridB, 'B');
  i := 0; { evita hint de variable no usada en algunos modos }
  if i > 0 then ;
end;

procedure TFormPrincipal.FigPaint(Sender: TObject);
var
  pb: TPaintBox;
  cv: TCanvas;
  cw, ch, cx, cy, margen: Integer;
  s, R, ang: Double;
  m, bw, bh, hw, hh, bM, bm2, h2, topY, botY, pr, i, x0, y0, x1, y1: Integer;

  function Escala(wU, hU: Double): Double;
  begin
    if wU <= 0 then wU := 1;
    if hU <= 0 then hU := 1;
    Result := Min((cw - 2 * margen) / wU, (ch - 2 * margen) / hU);
  end;

begin
  pb := Sender as TPaintBox;
  cv := pb.Canvas;
  cw := pb.Width; ch := pb.Height; margen := 30;
  cx := cw div 2; cy := ch div 2;
  cv.Brush.Color := clWhite;
  cv.FillRect(Rect(0, 0, cw, ch));
  cv.Pen.Color := clBlack;
  cv.Pen.Width := 2;
  cv.Brush.Style := bsClear;

  case FFigTipo of
    1: begin
         s := Escala(FFigP[0], FFigP[0]);
         m := Round(FFigP[0] * s) div 2;
         cv.Rectangle(cx - m, cy - m, cx + m, cy + m);
       end;
    2: begin
         s := Escala(FFigP[0], FFigP[1]);
         bw := Round(FFigP[0] * s) div 2;
         bh := Round(FFigP[1] * s) div 2;
         cv.Rectangle(cx - bw, cy - bh, cx + bw, cy + bh);
       end;
    3: begin
         s := Escala(FFigP[0], FFigP[1]);
         bw := Round(FFigP[0] * s) div 2;
         bh := Round(FFigP[1] * s) div 2;
         cv.Polygon([Point(cx, cy - bh), Point(cx + bw, cy + bh), Point(cx - bw, cy + bh)]);
       end;
    4: begin
         s := Escala(2 * FFigP[0], 2 * FFigP[0]);
         pr := Round(FFigP[0] * s);
         cv.Ellipse(cx - pr, cy - pr, cx + pr, cy + pr);
       end;
    5: begin
         s := Escala(FFigP[0], FFigP[1]);
         hw := Round(FFigP[0] * s) div 2;
         hh := Round(FFigP[1] * s) div 2;
         cv.Polygon([Point(cx, cy - hh), Point(cx + hw, cy), Point(cx, cy + hh), Point(cx - hw, cy)]);
       end;
    6: begin
         s := Escala(Max(FFigP[0], FFigP[1]), FFigP[2]);
         bM := Round(FFigP[0] * s) div 2;
         bm2 := Round(FFigP[1] * s) div 2;
         h2 := Round(FFigP[2] * s) div 2;
         topY := cy - h2; botY := cy + h2;
         cv.Polygon([Point(cx - bm2, topY), Point(cx + bm2, topY),
                     Point(cx + bM, botY), Point(cx - bM, botY)]);
       end;
    7: begin
         R := FFigP[1] / (2 * Sin(Pi / Round(FFigP[0])));
         s := Escala(2 * R, 2 * R);
         pr := Round(R * s);
         x0 := cx + Round(pr * Cos(-Pi / 2));
         y0 := cy + Round(pr * Sin(-Pi / 2));
         cv.MoveTo(x0, y0);
         for i := 1 to Round(FFigP[0]) do
         begin
           ang := -Pi / 2 + 2 * Pi * i / Round(FFigP[0]);
           x1 := cx + Round(pr * Cos(ang));
           y1 := cy + Round(pr * Sin(ang));
           cv.LineTo(x1, y1);
         end;
       end;
  end;

  if FFigInfo <> '' then
  begin
    cv.Brush.Style := bsSolid;
    cv.Brush.Color := clWhite;
    cv.Font.Color := clGreen;
    cv.Font.Style := [fsBold];
    cv.TextOut(8, ch - 20, FFigInfo);
  end;
end;

{ ===================== Scaffolds ===================== }

{ Tabla de N datos con 'Columnas' columnas de datos y cabeceras Cab[]. }
procedure TFormPrincipal.ScaffoldDatos(const Titulo: string; Columnas: Integer; const Cab: array of string);
var k: Integer;
begin
  LimpiarContenido;
  NuevoTitulo(Titulo);
  Lbl('Cantidad de datos (1-100):', 16, 50);
  FEdN := Ed(200, 47, 60);
  Btn('Aplicar', 270, 46, 80, DoAplicarDatos);
  Btn('Calcular', 360, 46, 90, DoCalcular);

  FGridA := TStringGrid.Create(FContent);
  FGridA.Parent := FContent;
  FGridA.Left := 16; FGridA.Top := 90;
  FGridA.Width := 360; FGridA.Height := 480;
  FGridA.FixedCols := 1; FGridA.FixedRows := 1;
  FGridA.ColCount := Columnas + 1;
  FGridA.RowCount := 6;
  FGridA.Options := FGridA.Options + [goEditing, goTabs];
  FGridA.Cells[0, 0] := '#';
  for k := 1 to Columnas do
    if k - 1 <= High(Cab) then FGridA.Cells[k, 0] := Cab[k - 1];

  FMemo := TMemo.Create(FContent);
  FMemo.Parent := FContent;
  FMemo.Left := 400; FMemo.Top := 90;
  FMemo.Width := 560; FMemo.Height := 480;
  FMemo.ReadOnly := True;
  FMemo.ScrollBars := ssBoth;
  FMemo.Font.Name := 'Consolas';
end;

procedure TFormPrincipal.ScaffoldGrupo(const Titulo: string);
begin
  LimpiarContenido;
  NuevoTitulo(Titulo);
  Lbl('Numero de personas (1-100):', 16, 50);
  FEdN := Ed(210, 47, 60);
  Btn('Aplicar', 280, 46, 80, DoAplicarGrupo);
  Btn('Calcular', 370, 46, 90, DoCalcular);

  FGridA := TStringGrid.Create(FContent);
  FGridA.Parent := FContent;
  FGridA.Left := 16; FGridA.Top := 90;
  FGridA.Width := 470; FGridA.Height := 480;
  FGridA.FixedCols := 1; FGridA.FixedRows := 1;
  FGridA.ColCount := 5;
  FGridA.RowCount := 6;
  FGridA.Options := FGridA.Options + [goEditing, goTabs];
  FGridA.Cells[0, 0] := '#';
  FGridA.Cells[1, 0] := 'Nombre';
  FGridA.Cells[2, 0] := 'Sexo(H/M)';
  FGridA.Cells[3, 0] := 'Edad';
  FGridA.Cells[4, 0] := 'Estatura';
  FGridA.ColWidths[1] := 140;

  FMemo := TMemo.Create(FContent);
  FMemo.Parent := FContent;
  FMemo.Left := 510; FMemo.Top := 90;
  FMemo.Width := 450; FMemo.Height := 480;
  FMemo.ReadOnly := True;
  FMemo.ScrollBars := ssBoth;
  FMemo.Font.Name := 'Consolas';
end;

procedure TFormPrincipal.ScaffoldEntradas(const Titulo: string; const Etiquetas: array of string; ConFigura: Boolean);
var i, y: Integer;
begin
  LimpiarContenido;
  NuevoTitulo(Titulo);
  SetLength(FEdits, Length(Etiquetas));
  y := 50;
  for i := 0 to High(Etiquetas) do
  begin
    Lbl(Etiquetas[i], 16, y + 4);
    FEdits[i] := Ed(230, y, 120);
    Inc(y, 34);
  end;
  Btn('Calcular', 16, y + 6, 110, DoCalcular);

  FMemo := TMemo.Create(FContent);
  FMemo.Parent := FContent;
  FMemo.Left := 16; FMemo.Top := y + 44;
  FMemo.Width := 460; FMemo.Height := 200;
  FMemo.ReadOnly := True;
  FMemo.ScrollBars := ssBoth;
  FMemo.Font.Name := 'Consolas';

  if ConFigura then
  begin
    FPaintBox := TPaintBox.Create(FContent);
    FPaintBox.Parent := FContent;
    FPaintBox.Left := 500; FPaintBox.Top := 50;
    FPaintBox.Width := 460; FPaintBox.Height := 460;
    FPaintBox.OnPaint := FigPaint;
  end;
end;

procedure TFormPrincipal.ScaffoldMatriz(const Titulo: string; Doble, Fija2x2: Boolean);
begin
  LimpiarContenido;
  NuevoTitulo(Titulo);

  if Fija2x2 then
  begin
    FGridA := TStringGrid.Create(FContent);
    FGridA.Parent := FContent;
    FGridA.Left := 16; FGridA.Top := 60;
    FGridA.FixedCols := 1; FGridA.FixedRows := 1;
    FGridA.ColCount := 3; FGridA.RowCount := 3;
    FGridA.Width := 230; FGridA.Height := 110;
    FGridA.Options := FGridA.Options + [goEditing, goTabs];
    FGridA.Cells[0, 0] := 'A';
    FGridA.Cells[1, 0] := 'C1'; FGridA.Cells[2, 0] := 'C2';
    FGridA.Cells[0, 1] := 'F1'; FGridA.Cells[0, 2] := 'F2';
    Btn('Calcular', 16, 190, 110, DoCalcular);
  end
  else
  begin
    Lbl('Filas (1-10):', 16, 50);
    FEdFilas := Ed(110, 47, 50);
    Lbl('Columnas (1-10):', 180, 50);
    FEdCols := Ed(300, 47, 50);
    Btn('Aplicar', 360, 46, 80, DoAplicarMat);
    Btn('Calcular', 450, 46, 90, DoCalcular);

    FGridA := TStringGrid.Create(FContent);
    FGridA.Parent := FContent;
    FGridA.Left := 16; FGridA.Top := 90;
    FGridA.Width := 360; FGridA.Height := 220;
    FGridA.FixedCols := 1; FGridA.FixedRows := 1;
    FGridA.ColCount := 2; FGridA.RowCount := 2;
    FGridA.Options := FGridA.Options + [goEditing, goTabs];
    FGridA.Cells[0, 0] := 'A';

    if Doble then
    begin
      FGridB := TStringGrid.Create(FContent);
      FGridB.Parent := FContent;
      FGridB.Left := 16; FGridB.Top := 330;
      FGridB.Width := 360; FGridB.Height := 220;
      FGridB.FixedCols := 1; FGridB.FixedRows := 1;
      FGridB.ColCount := 2; FGridB.RowCount := 2;
      FGridB.Options := FGridB.Options + [goEditing, goTabs];
      FGridB.Cells[0, 0] := 'B';
    end;
  end;

  FMemo := TMemo.Create(FContent);
  FMemo.Parent := FContent;
  FMemo.Left := 400; FMemo.Top := 90;
  FMemo.Width := 560; FMemo.Height := 470;
  FMemo.ReadOnly := True;
  FMemo.ScrollBars := ssBoth;
  FMemo.Font.Name := 'Consolas';
end;

{ ===================== Lectura ===================== }

function TFormPrincipal.ReadVector(Grid: TStringGrid; Col: Integer): TVector;
var r, n, k: Integer; v: Double;
begin
  n := Grid.RowCount - 1;
  SetLength(Result, 0);
  k := 0;
  for r := 1 to n do
    if ParseReal(Grid.Cells[Col, r], v) then
    begin
      SetLength(Result, k + 1);
      Result[k] := v;
      Inc(k);
    end;
  if k = 0 then
    raise Exception.Create('Capture al menos un dato valido en la tabla.');
end;

function TFormPrincipal.ReadGrupo: TGrupo;
var r, n, k: Integer; ed, es: Double; sx: string;
begin
  n := FGridA.RowCount - 1;
  SetLength(Result, 0);
  k := 0;
  for r := 1 to n do
  begin
    sx := UpperCase(Trim(FGridA.Cells[2, r]));
    if (sx <> 'H') and (sx <> 'M') then Continue;
    if not ParseReal(FGridA.Cells[3, r], ed) then Continue;
    if not ParseReal(FGridA.Cells[4, r], es) then Continue;
    SetLength(Result, k + 1);
    Result[k].Nombre := Trim(FGridA.Cells[1, r]);
    Result[k].Sexo := sx[1];
    Result[k].Edad := ed;
    Result[k].Estatura := es;
    Inc(k);
  end;
  if k = 0 then
    raise Exception.Create('Capture al menos una persona valida (Sexo H/M, Edad y Estatura).');
end;

function TFormPrincipal.ReadMatriz(Grid: TStringGrid): TMatriz;
var i, j, f, c: Integer; v: Double;
begin
  f := Grid.RowCount - 1; c := Grid.ColCount - 1;
  SetLength(Result, f, c);
  for i := 0 to f - 1 do
    for j := 0 to c - 1 do
    begin
      if not ParseReal(Grid.Cells[j + 1, i + 1], v) then
        raise Exception.CreateFmt('Celda %s(%d,%d) invalida.', [Grid.Cells[0, 0], i + 1, j + 1]);
      Result[i, j] := v;
    end;
end;

function TFormPrincipal.ValEdit(Indice: Integer; out V: Double): Boolean;
begin
  Result := (Indice <= High(FEdits)) and ParseReal(FEdits[Indice].Text, V);
end;

{ ===================== Despachador ===================== }

procedure TFormPrincipal.Mostrar(Id: Integer);

  procedure Demo(const Titulo: string; Filtro: TSexoFiltro; Campo: TCampo; Metrica: TMetrica);
  begin
    ScaffoldGrupo(Titulo);
    FAccion :=
      procedure
      var g: TGrupo; v: Double;
      begin
        g := ReadGrupo;
        if AgregaCampo(g, Filtro, Campo, Metrica, v) then
          FMemo.Lines.Add('Resultado = ' + F(v))
        else
          FMemo.Lines.Add('No hay datos para ese filtro.');
      end;
  end;

  procedure DemoMinMax(const Titulo: string; Filtro: TSexoFiltro; Campo: TCampo);
  begin
    ScaffoldGrupo(Titulo);
    FAccion :=
      procedure
      var g: TGrupo; vmin, vmax: Double;
      begin
        g := ReadGrupo;
        if AgregaCampo(g, Filtro, Campo, mtMaximo, vmax) and
           AgregaCampo(g, Filtro, Campo, mtMinimo, vmin) then
        begin
          FMemo.Lines.Add('Mayor = ' + F(vmax));
          FMemo.Lines.Add('Menor = ' + F(vmin));
        end
        else
          FMemo.Lines.Add('No hay datos para ese filtro.');
      end;
  end;

  procedure DemoConteo(const Titulo: string; Filtro: TSexoFiltro);
  begin
    ScaffoldGrupo(Titulo);
    FAccion :=
      procedure
      var g: TGrupo;
      begin
        g := ReadGrupo;
        FMemo.Lines.Add('Conteo = ' + IntToStr(ContarSexo(g, Filtro)));
      end;
  end;

  procedure DemoEdad(const Titulo: string; Filtro: TSexoFiltro; EsMayor: Boolean);
  begin
    ScaffoldGrupo(Titulo);
    FAccion :=
      procedure
      var g: TGrupo;
      begin
        g := ReadGrupo;
        FMemo.Lines.Add('Conteo = ' + IntToStr(ContarEdad(g, Filtro, EsMayor)));
      end;
  end;

begin
  case Id of
    { ---- Figuras ---- }
    1: begin
         ScaffoldEntradas('1. Cuadrado', ['Lado (>0):'], True);
         FAccion :=
           procedure
           var l: Double; r: TResFigura;
           begin
             if not ValEdit(0, l) or (l <= 0) then raise Exception.Create('Lado invalido (>0).');
             r := FigCuadrado(l);
             FMemo.Lines.Add('Area      = ' + F(r.Area));
             FMemo.Lines.Add('Perimetro = ' + F(r.Perimetro));
             FFigTipo := 1; FFigP[0] := l;
             FFigInfo := 'Area=' + F(r.Area) + '  Perim=' + F(r.Perimetro);
             FPaintBox.Invalidate;
           end;
       end;
    2: begin
         ScaffoldEntradas('2. Rectangulo', ['Base (>0):', 'Altura (>0):'], True);
         FAccion :=
           procedure
           var b, h: Double; r: TResFigura;
           begin
             if not ValEdit(0, b) or not ValEdit(1, h) or (b <= 0) or (h <= 0) then
               raise Exception.Create('Base y altura deben ser >0.');
             r := FigRectangulo(b, h);
             FMemo.Lines.Add('Area      = ' + F(r.Area));
             FMemo.Lines.Add('Perimetro = ' + F(r.Perimetro));
             FFigTipo := 2; FFigP[0] := b; FFigP[1] := h;
             FFigInfo := 'Area=' + F(r.Area) + '  Perim=' + F(r.Perimetro);
             FPaintBox.Invalidate;
           end;
       end;
    3: begin
         ScaffoldEntradas('3. Triangulo', ['Base (>0):', 'Altura (>0):', 'Lado 1 (>0):', 'Lado 2 (>0):'], True);
         FAccion :=
           procedure
           var b, h, l1, l2: Double; r: TResFigura;
           begin
             if not ValEdit(0, b) or not ValEdit(1, h) or not ValEdit(2, l1) or not ValEdit(3, l2) then
               raise Exception.Create('Capture base, altura y los dos lados (>0).');
             r := FigTriangulo(b, h, l1, l2);
             FMemo.Lines.Add('Area      = ' + F(r.Area));
             FMemo.Lines.Add('Perimetro = ' + F(r.Perimetro));
             FFigTipo := 3; FFigP[0] := b; FFigP[1] := h;
             FFigInfo := 'Area=' + F(r.Area) + '  Perim=' + F(r.Perimetro);
             FPaintBox.Invalidate;
           end;
       end;
    4: begin
         ScaffoldEntradas('4. Circulo', ['Radio (>0):'], True);
         FAccion :=
           procedure
           var ra: Double; r: TResFigura;
           begin
             if not ValEdit(0, ra) or (ra <= 0) then raise Exception.Create('Radio invalido (>0).');
             r := FigCirculo(ra);
             FMemo.Lines.Add('Area           = ' + F(r.Area));
             FMemo.Lines.Add('Circunferencia = ' + F(r.Perimetro));
             FFigTipo := 4; FFigP[0] := ra;
             FFigInfo := 'Area=' + F(r.Area) + '  Circ=' + F(r.Perimetro);
             FPaintBox.Invalidate;
           end;
       end;
    5: begin
         ScaffoldEntradas('5. Rombo', ['Diagonal mayor (>0):', 'Diagonal menor (>0):', 'Lado (>0):'], True);
         FAccion :=
           procedure
           var dm, dn, l: Double; r: TResFigura;
           begin
             if not ValEdit(0, dm) or not ValEdit(1, dn) or not ValEdit(2, l) then
               raise Exception.Create('Capture diagonales y lado (>0).');
             r := FigRombo(dm, dn, l);
             FMemo.Lines.Add('Area      = ' + F(r.Area));
             FMemo.Lines.Add('Perimetro = ' + F(r.Perimetro));
             FFigTipo := 5; FFigP[0] := dm; FFigP[1] := dn;
             FFigInfo := 'Area=' + F(r.Area) + '  Perim=' + F(r.Perimetro);
             FPaintBox.Invalidate;
           end;
       end;
    6: begin
         ScaffoldEntradas('6. Trapecio', ['Base mayor (>0):', 'Base menor (>0):', 'Altura (>0):', 'Lado 1 (>0):', 'Lado 2 (>0):'], True);
         FAccion :=
           procedure
           var baseMay, baseMen, h, l1, l2: Double; r: TResFigura;
           begin
             if not ValEdit(0, baseMay) or not ValEdit(1, baseMen) or not ValEdit(2, h)
                or not ValEdit(3, l1) or not ValEdit(4, l2) then
               raise Exception.Create('Capture las 5 medidas (>0).');
             r := FigTrapecio(baseMay, baseMen, h, l1, l2);
             FMemo.Lines.Add('Area      = ' + F(r.Area));
             FMemo.Lines.Add('Perimetro = ' + F(r.Perimetro));
             FFigTipo := 6; FFigP[0] := baseMay; FFigP[1] := baseMen; FFigP[2] := h;
             FFigInfo := 'Area=' + F(r.Area) + '  Perim=' + F(r.Perimetro);
             FPaintBox.Invalidate;
           end;
       end;
    38: begin
         ScaffoldEntradas('38. Poligono regular', ['Numero de lados (>=3):', 'Longitud de cada lado (>0):'], True);
         FAccion :=
           procedure
           var nl, l: Double; r: TResFigura;
           begin
             if not ValEdit(0, nl) or not ValEdit(1, l) or (nl < 3) or (l <= 0) then
               raise Exception.Create('Lados >=3 y longitud >0.');
             r := FigPoligono(Round(nl), l);
             FMemo.Lines.Add('Perimetro = ' + F(r.Perimetro));
             FMemo.Lines.Add('Area      = ' + F(r.Area));
             FFigTipo := 7; FFigP[0] := Round(nl); FFigP[1] := l;
             FFigInfo := 'Lados=' + IntToStr(Round(nl)) + '  Area=' + F(r.Area);
             FPaintBox.Invalidate;
           end;
       end;

    { ---- Misc ---- }
    7: begin
         ScaffoldEntradas('7. Par o impar', ['Numero entero:'], False);
         FAccion :=
           procedure
           var v: Double; n: Int64;
           begin
             if not ValEdit(0, v) then raise Exception.Create('Numero invalido.');
             n := Round(v);
             if EsPar(n) then FMemo.Lines.Add(IntToStr(n) + ' es PAR')
             else FMemo.Lines.Add(IntToStr(n) + ' es IMPAR');
           end;
       end;
    8: begin
         ScaffoldEntradas('8. Ecuacion cuadratica', ['A (<>0):', 'B:', 'C:'], False);
         FAccion :=
           procedure
           var a, b, c, disc, x1, x2: Double; k: Integer;
           begin
             if not ValEdit(0, a) or not ValEdit(1, b) or not ValEdit(2, c) then
               raise Exception.Create('Capture A, B y C.');
             if a = 0 then raise Exception.Create('A debe ser distinto de 0.');
             k := Cuadratica(a, b, c, disc, x1, x2);
             FMemo.Lines.Add('Discriminante = ' + F(disc));
             case k of
               0: FMemo.Lines.Add('No hay raices reales.');
               1: FMemo.Lines.Add('Una raiz real: X = ' + F(x1));
             else
               FMemo.Lines.Add('X1 = ' + F(x1));
               FMemo.Lines.Add('X2 = ' + F(x2));
             end;
           end;
       end;

    { ---- Estadistica (vector) ---- }
    9: begin
         ScaffoldDatos('9. Numero mayor', 1, ['Valor']);
         FAccion := procedure begin FMemo.Lines.Add('Mayor = ' + F(VecMaximo(ReadVector(FGridA, 1)))); end;
       end;
    10: begin
         ScaffoldDatos('10. Numero menor', 1, ['Valor']);
         FAccion := procedure begin FMemo.Lines.Add('Menor = ' + F(VecMinimo(ReadVector(FGridA, 1)))); end;
       end;
    11: begin
         ScaffoldDatos('11. Media aritmetica', 1, ['Valor']);
         FAccion := procedure begin FMemo.Lines.Add('Media = ' + F(VecMedia(ReadVector(FGridA, 1)))); end;
       end;
    12: begin
         ScaffoldDatos('12. Mediana', 1, ['Valor']);
         FAccion := procedure begin FMemo.Lines.Add('Mediana = ' + F(VecMediana(ReadVector(FGridA, 1)))); end;
       end;
    13: begin
         ScaffoldDatos('13. Moda', 1, ['Valor']);
         FAccion :=
           procedure
           var d: TVector; moda: Double; fr: Integer;
           begin
             d := ReadVector(FGridA, 1);
             moda := VecModa(d, fr);
             if fr <= 1 then FMemo.Lines.Add('No hay moda: todos aparecen una vez.')
             else
             begin
               FMemo.Lines.Add('Moda = ' + F(moda));
               FMemo.Lines.Add('Frecuencia = ' + IntToStr(fr));
             end;
           end;
       end;
    14, 15: begin
         if Id = 14 then ScaffoldDatos('14. Ordenar de menor a mayor', 1, ['Valor'])
         else ScaffoldDatos('15. Ordenar de mayor a menor', 1, ['Valor']);
         FAccion :=
           procedure
           var d, o: TVector; i: Integer;
           begin
             d := ReadVector(FGridA, 1);
             o := VecOrdenado(d, Id = 14);
             FMemo.Lines.Add('Ordenado:');
             for i := 0 to High(o) do FMemo.Lines.Add('  ' + F(o[i]));
           end;
       end;
    36: begin
         ScaffoldDatos('36. Regresion lineal (Y = a + bX)', 2, ['X', 'Y']);
         FAccion :=
           procedure
           var x, y: TVector; a, b: Double;
           begin
             x := ReadVector(FGridA, 1);
             y := ReadVector(FGridA, 2);
             if Length(x) <> Length(y) then
               raise Exception.Create('Debe capturar X e Y en cada fila (mismo numero de pares).');
             if Length(x) < 2 then raise Exception.Create('Se requieren al menos 2 pares.');
             if Regresion(x, y, a, b) then
             begin
               FMemo.Lines.Add('Y = a + bX');
               FMemo.Lines.Add('a = ' + F(a));
               FMemo.Lines.Add('b = ' + F(b));
             end
             else
               FMemo.Lines.Add('No se puede calcular: X no varia.');
           end;
       end;
    37: begin
         ScaffoldDatos('37. Varianza y desviacion estandar', 1, ['Valor']);
         FAccion :=
           procedure
           var d: TVector; me, mn, mx, vp, dp, vm, dm: Double; hayM: Boolean;
           begin
             d := ReadVector(FGridA, 1);
             VarianzaDesviacion(d, me, mn, mx, vp, dp, vm, dm, hayM);
             FMemo.Lines.Add('Media  = ' + F(me));
             FMemo.Lines.Add('Minimo = ' + F(mn));
             FMemo.Lines.Add('Maximo = ' + F(mx));
             FMemo.Lines.Add('Varianza poblacional       = ' + F(vp));
             FMemo.Lines.Add('Desv. estandar poblacional = ' + F(dp));
             if hayM then
             begin
               FMemo.Lines.Add('Varianza muestral          = ' + F(vm));
               FMemo.Lines.Add('Desv. estandar muestral    = ' + F(dm));
             end
             else
               FMemo.Lines.Add('Muestral: requiere n > 1');
           end;
       end;

    { ---- Demografia ---- }
    16: DemoConteo('16. Hombres en el grupo', sfHombres);
    17: DemoConteo('17. Mujeres en el grupo', sfMujeres);
    18: DemoMinMax('18. Edad mayor/menor (grupo)', sfTodos, cpEdad);
    19: DemoMinMax('19. Estatura mayor/menor (grupo)', sfTodos, cpEstatura);
    20: DemoMinMax('20. Edad mayor/menor (mujeres)', sfMujeres, cpEdad);
    21: DemoMinMax('21. Edad mayor/menor (hombres)', sfHombres, cpEdad);
    22: DemoEdad('22. Mayores de edad', sfTodos, True);
    23: DemoEdad('23. Menores de edad', sfTodos, False);
    24: DemoEdad('24. Mujeres mayores de edad', sfMujeres, True);
    25: DemoEdad('25. Mujeres menores de edad', sfMujeres, False);
    26: DemoEdad('26. Hombres mayores de edad', sfHombres, True);
    27: DemoEdad('27. Hombres menores de edad', sfHombres, False);
    28: DemoMinMax('28. Estatura mayor/menor (mujeres)', sfMujeres, cpEstatura);
    29: DemoMinMax('29. Estatura mayor/menor (hombres)', sfHombres, cpEstatura);
    30: Demo('30. Promedio edad (grupo)', sfTodos, cpEdad, mtPromedio);
    31: Demo('31. Promedio estatura (grupo)', sfTodos, cpEstatura, mtPromedio);
    32: Demo('32. Promedio edad (mujeres)', sfMujeres, cpEdad, mtPromedio);
    33: Demo('33. Promedio edad (hombres)', sfHombres, cpEdad, mtPromedio);
    34: Demo('34. Promedio estatura (mujeres)', sfMujeres, cpEstatura, mtPromedio);
    35: Demo('35. Promedio estatura (hombres)', sfHombres, cpEstatura, mtPromedio);

    { ---- Matrices ---- }
    39: begin
         ScaffoldMatriz('39. Suma de matrices (C = A + B)', True, False);
         FAccion :=
           procedure
           var a, b, c: TMatriz; i, j: Integer; s: string;
           begin
             a := ReadMatriz(FGridA); b := ReadMatriz(FGridB);
             c := MatSuma(a, b);
             FMemo.Lines.Add('C = A + B');
             for i := 0 to High(c) do
             begin
               s := '';
               for j := 0 to High(c[i]) do s := s + F(c[i, j]) + '  ';
               FMemo.Lines.Add(s);
             end;
           end;
       end;
    40: begin
         ScaffoldMatriz('40. Resta de matrices (C = A - B)', True, False);
         FAccion :=
           procedure
           var a, b, c: TMatriz; i, j: Integer; s: string;
           begin
             a := ReadMatriz(FGridA); b := ReadMatriz(FGridB);
             c := MatResta(a, b);
             FMemo.Lines.Add('C = A - B');
             for i := 0 to High(c) do
             begin
               s := '';
               for j := 0 to High(c[i]) do s := s + F(c[i, j]) + '  ';
               FMemo.Lines.Add(s);
             end;
           end;
       end;
    41: begin
         ScaffoldMatriz('41. Matriz transpuesta', False, False);
         FAccion :=
           procedure
           var a, t: TMatriz; i, j: Integer; s: string;
           begin
             a := ReadMatriz(FGridA);
             t := MatTranspuesta(a);
             FMemo.Lines.Add('Transpuesta:');
             for i := 0 to High(t) do
             begin
               s := '';
               for j := 0 to High(t[i]) do s := s + F(t[i, j]) + '  ';
               FMemo.Lines.Add(s);
             end;
           end;
       end;
    42: begin
         ScaffoldMatriz('42. Matriz inversa 2x2', False, True);
         FAccion :=
           procedure
           var a, inv: TMatriz; det: Double;
           begin
             a := ReadMatriz(FGridA);
             if MatInversa2x2(a, inv, det) then
             begin
               FMemo.Lines.Add('Determinante = ' + F(det));
               FMemo.Lines.Add('Inversa:');
               FMemo.Lines.Add('  ' + F(inv[0, 0]) + '  ' + F(inv[0, 1]));
               FMemo.Lines.Add('  ' + F(inv[1, 0]) + '  ' + F(inv[1, 1]));
             end
             else
               FMemo.Lines.Add('Determinante = ' + F(det) + sLineBreak + 'La matriz no tiene inversa.');
           end;
       end;
  else
    LimpiarContenido;
    NuevoTitulo('Seleccione un programa del menu.');
  end;
end;

initialization
  FInv := TFormatSettings.Create;
  FInv.DecimalSeparator := '.';
  FInv.ThousandSeparator := ',';

end.
