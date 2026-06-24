object F_Figuras: TF_Figuras
  Left = 0
  Top = 0
  Caption = 'Figuras geometricas'
  ClientHeight = 470
  ClientWidth = 660
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object L_1: TLabel
    Left = 16
    Top = 64
    Width = 90
    Height = 13
    Caption = 'Lado:'
  end
  object L_2: TLabel
    Left = 16
    Top = 96
    Width = 90
    Height = 13
    Caption = 'Altura:'
  end
  object L_3: TLabel
    Left = 16
    Top = 128
    Width = 90
    Height = 13
    Caption = 'Lado 2:'
  end
  object L_4: TLabel
    Left = 16
    Top = 160
    Width = 90
    Height = 13
    Caption = 'Lado 3:'
  end
  object L_Area: TLabel
    Left = 16
    Top = 248
    Width = 32
    Height = 13
    Caption = 'Area:'
  end
  object L_Perimetro: TLabel
    Left = 16
    Top = 272
    Width = 55
    Height = 13
    Caption = 'Perimetro:'
  end
  object PB_Dibujo: TPaintBox
    Left = 300
    Top = 56
    Width = 344
    Height = 396
    OnPaint = PB_DibujoPaint
  end
  object P_Cabecera: TPanel
    Left = 0
    Top = 0
    Width = 660
    Height = 41
    Align = alTop
    Color = clNavy
    ParentBackground = False
    TabOrder = 0
    object L_Figura: TLabel
      Left = 16
      Top = 10
      Width = 100
      Height = 19
      Caption = 'FIGURA'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object E_1: TEdit
    Left = 130
    Top = 60
    Width = 130
    Height = 21
    TabOrder = 1
    Text = ''
  end
  object E_2: TEdit
    Left = 130
    Top = 92
    Width = 130
    Height = 21
    TabOrder = 2
    Text = ''
  end
  object E_3: TEdit
    Left = 130
    Top = 124
    Width = 130
    Height = 21
    TabOrder = 3
    Text = ''
  end
  object E_4: TEdit
    Left = 130
    Top = 156
    Width = 130
    Height = 21
    TabOrder = 4
    Text = ''
  end
  object B_Calcular: TButton
    Left = 16
    Top = 200
    Width = 80
    Height = 33
    Caption = 'Calcular'
    TabOrder = 5
    OnClick = B_CalcularClick
  end
  object B_Limpiar: TButton
    Left = 102
    Top = 200
    Width = 80
    Height = 33
    Caption = 'Limpiar'
    TabOrder = 6
    OnClick = B_LimpiarClick
  end
  object B_Salir: TButton
    Left = 188
    Top = 200
    Width = 72
    Height = 33
    Caption = 'Salir'
    TabOrder = 7
    OnClick = B_SalirClick
  end
end
