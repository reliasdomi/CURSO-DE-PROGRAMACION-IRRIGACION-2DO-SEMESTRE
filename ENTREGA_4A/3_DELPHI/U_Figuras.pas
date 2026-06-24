{ ==================================================================
  INTEGRANTES - Grupo 4A - Irrigacion - U.A. Chapingo:
    - ELIAS DOMINGUEZ RUBEN
    - BISTRAIN BORRAZ ANGEL GABRIEL
    - CRUZ SIBAJA GIBRAN FRANCISCO
    - TORRES VALENCIA MARIO ALBERTO
  ================================================================== }
unit U_Figuras;

{ Figuras geometricas (programas 1-6 y 38). Un solo formulario que, segun
  el Tag recibido en Preparar, pide los datos en cajas E_ y DIBUJA la figura
  en un TPaintBox con el Canvas (Rectangle / Ellipse / Polygon / LineTo). }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TF_Figuras = class(TForm)
    P_Cabecera: TPanel;
    L_Figura: TLabel;
    L_1: TLabel;
    L_2: TLabel;
    L_3: TLabel;
    L_4: TLabel;
    E_1: TEdit;
    E_2: TEdit;
    E_3: TEdit;
    E_4: TEdit;
    B_Calcular: TButton;
    B_Limpiar: TButton;
    B_Salir: TButton;
    L_Area: TLabel;
    L_Perimetro: TLabel;
    PB_Dibujo: TPaintBox;
    procedure B_CalcularClick(Sender: TObject);
    procedure B_LimpiarClick(Sender: TObject);
    procedure B_SalirClick(Sender: TObject);
    procedure PB_DibujoPaint(Sender: TObject);
  private
    FTipo: integer;
    FParam: array[1..4] of double;
    FInfo: string;
    FListo: boolean;
    function Escala(uAncho, uAlto: double): double;
  public
    procedure Preparar(k: integer);
  end;

var
  F_Figuras: TF_Figuras;

implementation

uses
  U_Comun, Math;

{$R *.dfm}

procedure TF_Figuras.Preparar(k: integer);
begin
  FTipo := k;
  FListo := False;
  E_1.Text := ''; E_2.Text := ''; E_3.Text := ''; E_4.Text := '';
  L_Area.Caption := 'Area:';
  L_Perimetro.Caption := 'Perimetro:';
  { por defecto solo 1 entrada visible }
  L_2.Visible := False; E_2.Visible := False;
  L_3.Visible := False; E_3.Visible := False;
  L_4.Visible := False; E_4.Visible := False;
  case k of
    1: begin L_Figura.Caption := '1. CUADRADO';
             L_1.Caption := 'Lado:'; end;
    2: begin L_Figura.Caption := '2. RECTANGULO';
             L_1.Caption := 'Base:'; L_2.Caption := 'Altura:';
             L_2.Visible := True; E_2.Visible := True; end;
    3: begin L_Figura.Caption := '3. TRIANGULO';
             L_1.Caption := 'Base:'; L_2.Caption := 'Altura:';
             L_3.Caption := 'Lado 2:'; L_4.Caption := 'Lado 3:';
             L_2.Visible := True; E_2.Visible := True;
             L_3.Visible := True; E_3.Visible := True;
             L_4.Visible := True; E_4.Visible := True; end;
    4: begin L_Figura.Caption := '4. CIRCULO';
             L_1.Caption := 'Radio:'; end;
    5: begin L_Figura.Caption := '5. ROMBO';
             L_1.Caption := 'Diagonal mayor:'; L_2.Caption := 'Diagonal menor:';
             L_2.Visible := True; E_2.Visible := True; end;
    6: begin L_Figura.Caption := '6. TRAPECIO';
             L_1.Caption := 'Base mayor:'; L_2.Caption := 'Base menor:';
             L_3.Caption := 'Altura:';
             L_2.Visible := True; E_2.Visible := True;
             L_3.Visible := True; E_3.Visible := True; end;
    38: begin L_Figura.Caption := '38. POLIGONO REGULAR';
             L_1.Caption := 'Numero de lados:'; L_2.Caption := 'Longitud del lado:';
             L_2.Visible := True; E_2.Visible := True; end;
  end;
  PB_Dibujo.Invalidate;
end;

procedure TF_Figuras.B_CalcularClick(Sender: TObject);
var
  a, b, c, d, lado, area, perim: double;
  n: integer;
begin
  a := Cadena_a_real(E_1.Text);
  b := Cadena_a_real(E_2.Text);
  c := Cadena_a_real(E_3.Text);
  d := Cadena_a_real(E_4.Text);
  area := 0; perim := 0;
  FParam[1] := a; FParam[2] := b; FParam[3] := c; FParam[4] := d;
  case FTipo of
    1: begin area := a * a; perim := 4 * a; end;
    2: begin area := a * b; perim := 2 * (a + b); end;
    3: begin area := a * b / 2; perim := a + c + d; end;
    4: begin area := Pi * a * a; perim := 2 * Pi * a; end;
    5: begin area := a * b / 2;
            lado := Sqrt(Sqr(a / 2) + Sqr(b / 2));
            perim := 4 * lado; end;
    6: begin area := (a + b) / 2 * c;
            lado := Sqrt(Sqr(c) + Sqr((a - b) / 2));
            perim := a + b + 2 * lado; end;
    38: begin n := Cadena_a_entero(E_1.Text);
             if n < 3 then n := 3;
             FParam[1] := n; FParam[2] := b;
             perim := n * b;
             area := perim * (b / (2 * Tan(Pi / n))) / 2; end;
  end;
  FInfo := 'Area = ' + real_a_Cadena(area, 1, 2) +
           '   Perimetro = ' + real_a_Cadena(perim, 1, 2);
  L_Area.Caption := 'Area: ' + real_a_Cadena(area, 1, 2);
  L_Perimetro.Caption := 'Perimetro: ' + real_a_Cadena(perim, 1, 2);
  FListo := True;
  PB_Dibujo.Invalidate;
end;

procedure TF_Figuras.B_LimpiarClick(Sender: TObject);
begin
  Preparar(FTipo);
end;

procedure TF_Figuras.B_SalirClick(Sender: TObject);
begin
  Close;
end;

function TF_Figuras.Escala(uAncho, uAlto: double): double;
var sx, sy: double;
begin
  if uAncho <= 0 then uAncho := 1;
  if uAlto  <= 0 then uAlto  := 1;
  sx := (PB_Dibujo.Width  - 40) / uAncho;
  sy := (PB_Dibujo.Height - 40) / uAlto;
  if sx < sy then Result := sx else Result := sy;
end;

procedure TF_Figuras.PB_DibujoPaint(Sender: TObject);
var
  cv: TCanvas;
  cx, cy, m, bw, bh, hw, hh, pr, i, x0, y0, x1, y1: integer;
  bM, bm2, h2, topY, botY, n: integer;
  s, ang, radio: double;
begin
  cv := PB_Dibujo.Canvas;
  cv.Brush.Color := clWhite;
  cv.FillRect(Rect(0, 0, PB_Dibujo.Width, PB_Dibujo.Height));
  cv.Pen.Color := clBlack;
  cv.Pen.Width := 2;
  cv.Brush.Style := bsClear;
  cx := PB_Dibujo.Width div 2;
  cy := PB_Dibujo.Height div 2;
  if not FListo then Exit;
  case FTipo of
    1: begin
         s := Escala(FParam[1], FParam[1]);
         m := Round(FParam[1] * s) div 2;
         cv.Rectangle(cx - m, cy - m, cx + m, cy + m);
       end;
    2: begin
         s := Escala(FParam[1], FParam[2]);
         bw := Round(FParam[1] * s) div 2;
         bh := Round(FParam[2] * s) div 2;
         cv.Rectangle(cx - bw, cy - bh, cx + bw, cy + bh);
       end;
    3: begin
         s := Escala(FParam[1], FParam[2]);
         bw := Round(FParam[1] * s) div 2;
         bh := Round(FParam[2] * s) div 2;
         cv.Polygon([Point(cx, cy - bh), Point(cx + bw, cy + bh),
                     Point(cx - bw, cy + bh)]);
       end;
    4: begin
         s := Escala(2 * FParam[1], 2 * FParam[1]);
         pr := Round(FParam[1] * s);
         cv.Ellipse(cx - pr, cy - pr, cx + pr, cy + pr);
       end;
    5: begin
         s := Escala(FParam[1], FParam[2]);
         hw := Round(FParam[1] * s) div 2;
         hh := Round(FParam[2] * s) div 2;
         cv.Polygon([Point(cx, cy - hh), Point(cx + hw, cy),
                     Point(cx, cy + hh), Point(cx - hw, cy)]);
       end;
    6: begin
         s := Escala(FParam[1], FParam[3]);
         bM  := Round(FParam[1] * s) div 2;
         bm2 := Round(FParam[2] * s) div 2;
         h2  := Round(FParam[3] * s) div 2;
         topY := cy - h2; botY := cy + h2;
         cv.Polygon([Point(cx - bm2, topY), Point(cx + bm2, topY),
                     Point(cx + bM, botY), Point(cx - bM, botY)]);
       end;
    38: begin
         n := Round(FParam[1]);
         if n < 3 then n := 3;
         radio := FParam[2] / (2 * Sin(Pi / n));
         s := Escala(2 * radio, 2 * radio);
         pr := Round(radio * s);
         x0 := cx + Round(pr * Cos(-Pi / 2));
         y0 := cy + Round(pr * Sin(-Pi / 2));
         cv.MoveTo(x0, y0);
         for i := 1 to n do
         begin
           ang := -Pi / 2 + 2 * Pi * i / n;
           x1 := cx + Round(pr * Cos(ang));
           y1 := cy + Round(pr * Sin(ang));
           cv.LineTo(x1, y1);
         end;
       end;
  end;
  cv.Brush.Style := bsSolid;
  cv.Brush.Color := clWhite;
  cv.Font.Color := clGreen;
  cv.Font.Style := [fsBold];
  cv.TextOut(6, PB_Dibujo.Height - 20, FInfo);
end;

end.
