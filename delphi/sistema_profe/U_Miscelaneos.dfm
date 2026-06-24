object F_Miscelaneos: TF_Miscelaneos
  Left = 0
  Top = 0
  Caption = 'Miscelaneos'
  ClientHeight = 400
  ClientWidth = 560
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object L_ParImpar: TLabel
    Left = 16
    Top = 56
    Width = 130
    Height = 13
    Caption = '--- 7. Par o impar ---'
  end
  object L_Numero: TLabel
    Left = 16
    Top = 84
    Width = 41
    Height = 13
    Caption = 'Numero:'
  end
  object L_ResPar: TLabel
    Left = 16
    Top = 128
    Width = 50
    Height = 16
    Caption = ''
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object L_Cuadratica: TLabel
    Left = 16
    Top = 176
    Width = 200
    Height = 13
    Caption = '--- 8. Formula cuadratica (a x2 + b x + c) ---'
  end
  object L_A: TLabel
    Left = 16
    Top = 204
    Width = 11
    Height = 13
    Caption = 'a:'
  end
  object L_B: TLabel
    Left = 120
    Top = 204
    Width = 11
    Height = 13
    Caption = 'b:'
  end
  object L_C: TLabel
    Left = 224
    Top = 204
    Width = 11
    Height = 13
    Caption = 'c:'
  end
  object P_Cabecera: TPanel
    Left = 0
    Top = 0
    Width = 560
    Height = 41
    Align = alTop
    Color = clNavy
    ParentBackground = False
    TabOrder = 0
    object L_Programa: TLabel
      Left = 16
      Top = 10
      Width = 100
      Height = 19
      Caption = 'MISCELANEOS'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object E_Numero: TEdit
    Left = 64
    Top = 80
    Width = 120
    Height = 21
    TabOrder = 1
    Text = ''
  end
  object B_ParImpar: TButton
    Left = 200
    Top = 78
    Width = 130
    Height = 25
    Caption = 'Par o impar'
    TabOrder = 2
    OnClick = B_ParImparClick
  end
  object E_A: TEdit
    Left = 33
    Top = 200
    Width = 70
    Height = 21
    TabOrder = 3
    Text = ''
  end
  object E_B: TEdit
    Left = 137
    Top = 200
    Width = 70
    Height = 21
    TabOrder = 4
    Text = ''
  end
  object E_C: TEdit
    Left = 241
    Top = 200
    Width = 70
    Height = 21
    TabOrder = 5
    Text = ''
  end
  object B_Cuadratica: TButton
    Left = 330
    Top = 198
    Width = 130
    Height = 25
    Caption = 'Resolver'
    TabOrder = 6
    OnClick = B_CuadraticaClick
  end
  object M_ResCuad: TMemo
    Left = 16
    Top = 240
    Width = 444
    Height = 110
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Consolas'
    Font.Style = []
    Lines.Strings = (
      '')
    ParentFont = False
    ReadOnly = True
    TabOrder = 7
  end
  object B_Salir: TButton
    Left = 360
    Top = 360
    Width = 100
    Height = 28
    Caption = 'Salir'
    TabOrder = 8
    OnClick = B_SalirClick
  end
end
