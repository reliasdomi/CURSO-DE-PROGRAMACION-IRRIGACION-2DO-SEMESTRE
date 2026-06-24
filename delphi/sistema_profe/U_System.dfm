object F_System: TF_System
  Left = 0
  Top = 0
  Caption = 'Sistema de Programas 4A - Irrigacion'
  ClientHeight = 360
  ClientWidth = 640
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object P_Cabecera: TPanel
    Left = 0
    Top = 0
    Width = 640
    Height = 130
    Align = alTop
    Color = clNavy
    ParentBackground = False
    TabOrder = 0
    object L_Titulo: TLabel
      Left = 24
      Top = 20
      Width = 401
      Height = 25
      Caption = 'UNIVERSIDAD AUTONOMA CHAPINGO'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object L_Subtitulo: TLabel
      Left = 24
      Top = 52
      Width = 286
      Height = 19
      Caption = 'Departamento de Irrigacion  -  Grupo 4A'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clSilver
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object L_Instruccion: TLabel
      Left = 24
      Top = 92
      Width = 380
      Height = 16
      Caption = 'Elija un programa en el menu de arriba. 42 programas del curso.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clYellow
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
  end
  object MainMenu1: TMainMenu
    Left = 560
    Top = 160
    object M_Figuras: TMenuItem
      Caption = 'Figuras'
      object M_Cuadrado: TMenuItem
        Tag = 1
        Caption = '1. Cuadrado'
        OnClick = ItemClick
      end
      object M_Rectangulo: TMenuItem
        Tag = 2
        Caption = '2. Rectangulo'
        OnClick = ItemClick
      end
      object M_Triangulo: TMenuItem
        Tag = 3
        Caption = '3. Triangulo'
        OnClick = ItemClick
      end
      object M_Circulo: TMenuItem
        Tag = 4
        Caption = '4. Circulo'
        OnClick = ItemClick
      end
      object M_Rombo: TMenuItem
        Tag = 5
        Caption = '5. Rombo'
        OnClick = ItemClick
      end
      object M_Trapecio: TMenuItem
        Tag = 6
        Caption = '6. Trapecio'
        OnClick = ItemClick
      end
      object M_Poligono: TMenuItem
        Tag = 38
        Caption = '38. Poligono regular'
        OnClick = ItemClick
      end
    end
    object M_Estadistica: TMenuItem
      Caption = 'Estadistica'
      object M_Mayor: TMenuItem
        Tag = 9
        Caption = '9. Numero mayor'
        OnClick = ItemClick
      end
      object M_Menor: TMenuItem
        Tag = 10
        Caption = '10. Numero menor'
        OnClick = ItemClick
      end
      object M_Media: TMenuItem
        Tag = 11
        Caption = '11. Media aritmetica'
        OnClick = ItemClick
      end
      object M_Mediana: TMenuItem
        Tag = 12
        Caption = '12. Mediana'
        OnClick = ItemClick
      end
      object M_Moda: TMenuItem
        Tag = 13
        Caption = '13. Moda'
        OnClick = ItemClick
      end
      object M_OrdenarAsc: TMenuItem
        Tag = 14
        Caption = '14. Ordenar de menor a mayor'
        OnClick = ItemClick
      end
      object M_OrdenarDesc: TMenuItem
        Tag = 15
        Caption = '15. Ordenar de mayor a menor'
        OnClick = ItemClick
      end
      object M_Regresion: TMenuItem
        Tag = 36
        Caption = '36. Regresion lineal simple'
        OnClick = ItemClick
      end
      object M_Varianza: TMenuItem
        Tag = 37
        Caption = '37. Varianza y desviacion estandar'
        OnClick = ItemClick
      end
    end
    object M_Personas: TMenuItem
      Tag = 16
      Caption = 'Personas (16-35)'
      OnClick = ItemClick
    end
    object M_Matrices: TMenuItem
      Caption = 'Matrices'
      object M_Suma: TMenuItem
        Tag = 39
        Caption = '39. Suma de matrices'
        OnClick = ItemClick
      end
      object M_Resta: TMenuItem
        Tag = 40
        Caption = '40. Resta de matrices'
        OnClick = ItemClick
      end
      object M_Transpuesta: TMenuItem
        Tag = 41
        Caption = '41. Matriz transpuesta'
        OnClick = ItemClick
      end
      object M_Inversa: TMenuItem
        Tag = 42
        Caption = '42. Matriz inversa 2x2'
        OnClick = ItemClick
      end
    end
    object M_Miscelaneos: TMenuItem
      Caption = 'Miscelaneos'
      object M_ParImpar: TMenuItem
        Tag = 7
        Caption = '7. Numero par o impar'
        OnClick = ItemClick
      end
      object M_Cuadratica: TMenuItem
        Tag = 8
        Caption = '8. Formula cuadratica'
        OnClick = ItemClick
      end
    end
    object M_Salir: TMenuItem
      Caption = 'Salir'
      OnClick = M_SalirClick
    end
  end
end
