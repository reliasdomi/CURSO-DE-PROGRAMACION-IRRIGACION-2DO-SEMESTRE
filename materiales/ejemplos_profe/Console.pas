unit Console;

{ ------------------------------------------------------------------
  Console.pas  -  RECONSTRUCCION de la unidad del profesor.

  El programa de ejemplo (archivos.PAS / archivos.dpr) usa
  'uses Console, Librerias', pero la fuente original se perdio: solo
  quedaron los .dcu compilados de Delphi 7, inservibles en Delphi 12
  y en Free Pascal.

  Esta unidad reconstruye la API deduciendola de como la llama el
  ejemplo. Se implementa todo sobre la API de consola de Windows para
  que compile IGUAL en Delphi 12 Athens y en Free Pascal 3.2.2.

  Coordenadas 1-based estilo Crt (col 1, fila 1 = esquina superior izq).
  Colores 0..15 estilo DOS (mismo orden que los atributos de Win).
  ------------------------------------------------------------------ }

{$IFDEF FPC}{$MODE DELPHI}{$ENDIF}
{$H+}

interface

uses
  {$IFDEF MSWINDOWS}Windows,{$ENDIF}
  SysUtils;

var
  { Globales que el ejemplo usa sin declararlos: los exporta esta unidad }
  cadena          : string;
  Tecla           : char;
  Codigo_de_error : Integer;
  i               : Integer;
  opcion          : Byte;
  Texto_de_opcion : array[1..10] of string;

procedure gotoXY(x, y: Byte);
procedure ClrScr;
procedure limpia_pantalla(bg, fg: Byte);
procedure Escribe_texto(x, y, bg, fg: Byte; const Texto: string);
procedure sonido(freq, dur: Word);
procedure Plantilla(Borde, Fondo, Letra: Byte);
procedure Cajita(Borde, Fondo, Letra: Byte);
procedure Dibuja_cuadro(x1, y1, x2, y2, c1, c2: Byte);
procedure selector_vertical(x, y, bg, fg, bgSel, fgSel, nOpc, w, yLast: Byte;
                            var opcion: Byte);
procedure pausa(x, y, bg, fg: Byte);
function  ReadKey: Char;

implementation

var
  hOut, hIn : THandle;
  PendScan  : Char;   { segundo byte pendiente de una tecla extendida }

{ ---------- primitivas de pantalla ---------- }

procedure SetColor(bg, fg: Byte);
begin
  SetConsoleTextAttribute(hOut, Word(fg or (bg shl 4)));
end;

procedure gotoXY(x, y: Byte);
var
  p: COORD;
begin
  p.X := SmallInt(x) - 1;
  p.Y := SmallInt(y) - 1;
  SetConsoleCursorPosition(hOut, p);
end;

procedure ClrScr;
var
  info    : TConsoleScreenBufferInfo;
  home    : COORD;
  total   : DWORD;
  escritos: DWORD;
begin
  if not GetConsoleScreenBufferInfo(hOut, info) then Exit;
  home.X := 0; home.Y := 0;
  total := DWORD(info.dwSize.X) * DWORD(info.dwSize.Y);
  FillConsoleOutputCharacterA(hOut, AnsiChar(' '), total, home, escritos);
  FillConsoleOutputAttribute(hOut, info.wAttributes, total, home, escritos);
  SetConsoleCursorPosition(hOut, home);
end;

procedure limpia_pantalla(bg, fg: Byte);
begin
  SetColor(bg, fg);
  ClrScr;
end;

procedure Escribe_texto(x, y, bg, fg: Byte; const Texto: string);
begin
  gotoXY(x, y);
  SetColor(bg, fg);
  Write(Texto);
end;

procedure sonido(freq, dur: Word);
begin
  Windows.Beep(freq, dur);
end;

{ Dibuja un recuadro con lineas (CP437). Relleno opcional del interior. }
procedure Caja(x1, y1, x2, y2, bg, fg: Byte; Doble, Rellena: Boolean);
var
  cx, cy: Integer;
  esqSI, esqSD, esqII, esqID, hor, ver: Char;
begin
  if Doble then
  begin
    esqSI := #201; esqSD := #187; esqII := #200; esqID := #188;
    hor := #205; ver := #186;
  end
  else
  begin
    esqSI := #218; esqSD := #191; esqII := #192; esqID := #217;
    hor := #196; ver := #179;
  end;
  SetColor(bg, fg);

  if Rellena then
    for cy := y1 + 1 to y2 - 1 do
    begin
      gotoXY(x1 + 1, cy);
      for cx := x1 + 1 to x2 - 1 do Write(' ');
    end;

  { bordes horizontales }
  gotoXY(x1, y1); Write(esqSI);
  for cx := x1 + 1 to x2 - 1 do Write(hor);
  Write(esqSD);
  gotoXY(x1, y2); Write(esqII);
  for cx := x1 + 1 to x2 - 1 do Write(hor);
  Write(esqID);
  { bordes verticales }
  for cy := y1 + 1 to y2 - 1 do
  begin
    gotoXY(x1, cy); Write(ver);
    gotoXY(x2, cy); Write(ver);
  end;
end;

procedure Plantilla(Borde, Fondo, Letra: Byte);
begin
  limpia_pantalla(Fondo, Letra);
  Caja(1, 1, 80, 25, Fondo, Borde, True, False);
end;

procedure Cajita(Borde, Fondo, Letra: Byte);
begin
  limpia_pantalla(Fondo, Letra);
  Caja(10, 4, 71, 24, Fondo, Borde, False, False);
end;

procedure Dibuja_cuadro(x1, y1, x2, y2, c1, c2: Byte);
begin
  Caja(x1, y1, x2, y2, c1, c2, False, False);
end;

{ ---------- teclado ---------- }

function ReadKey: Char;
var
  rec   : TInputRecord;
  leidos: DWORD;
  vk    : Word;
  ch    : AnsiChar;
begin
  if PendScan <> #0 then
  begin
    Result := PendScan;
    PendScan := #0;
    Exit;
  end;

  Result := #0;
  while True do
  begin
    if not ReadConsoleInputA(hIn, rec, 1, leidos) then Exit;
    if leidos = 0 then Continue;
    if rec.EventType <> KEY_EVENT then Continue;
    if not rec.Event.KeyEvent.bKeyDown then Continue;
    vk := rec.Event.KeyEvent.wVirtualKeyCode;
    ch := rec.Event.KeyEvent.AsciiChar;

    if ch <> #0 then
    begin
      Result := Char(ch);
      Exit;
    end;

    { teclas extendidas: devolver #0 y dejar el scan DOS pendiente }
    case vk of
      VK_UP    : PendScan := #72;
      VK_DOWN  : PendScan := #80;
      VK_LEFT  : PendScan := #75;
      VK_RIGHT : PendScan := #77;
      VK_PRIOR : PendScan := #73;  { Re Pag }
      VK_NEXT  : PendScan := #81;  { Av Pag }
      VK_HOME  : PendScan := #71;
      VK_END   : PendScan := #79;
      VK_INSERT: PendScan := #82;
      VK_DELETE: PendScan := #83;
      VK_F1    : PendScan := #59;
      VK_F2    : PendScan := #60;
      VK_F3    : PendScan := #61;
      VK_F4    : PendScan := #62;
    else
      Continue;  { tecla sin char ni scan util (Shift, Ctrl...): ignorar }
    end;
    Result := #0;
    Exit;
  end;
end;

procedure pausa(x, y, bg, fg: Byte);
begin
  Escribe_texto(x, y, bg, fg, ' Presione una tecla... ');
  ReadKey;
end;

{ ---------- menu vertical ---------- }

procedure selector_vertical(x, y, bg, fg, bgSel, fgSel, nOpc, w, yLast: Byte;
                            var opcion: Byte);
var
  cur: Integer;
  t: Char;

  procedure Pinta;
  var
    j: Integer;
    s: string;
  begin
    for j := 1 to nOpc do
    begin
      s := Texto_de_opcion[j];
      while Length(s) < 18 do s := s + ' ';
      if j = cur then Escribe_texto(x, y + j - 1, bgSel, fgSel, ' ' + s)
                 else Escribe_texto(x, y + j - 1, bg, fg, ' ' + s);
    end;
  end;

begin
  if nOpc < 1 then begin opcion := 0; Exit; end;
  cur := 1;
  Pinta;
  repeat
    t := ReadKey;
    if t = #0 then
    begin
      t := ReadKey;
      case t of
        #72: if cur > 1 then Dec(cur) else cur := nOpc;     { Arriba }
        #80: if cur < nOpc then Inc(cur) else cur := 1;     { Abajo }
      end;
      Pinta;
    end;
  until (t = #13) or (t = #27);

  if t = #27 then opcion := 0 else opcion := Byte(cur);
end;

initialization
  hOut := GetStdHandle(STD_OUTPUT_HANDLE);
  hIn  := GetStdHandle(STD_INPUT_HANDLE);
  PendScan := #0;
  SetConsoleOutputCP(437);
  SetConsoleCP(437);
  for i := 1 to 10 do Texto_de_opcion[i] := '';
  cadena := '';
  Tecla := #0;
  Codigo_de_error := 0;
  opcion := 0;

end.
