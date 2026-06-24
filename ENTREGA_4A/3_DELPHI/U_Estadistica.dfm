object F_Estadistica: TF_Estadistica
  Left = 0
  Top = 0
  Caption = 'Estadistica'
  ClientHeight = 500
  ClientWidth = 720
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object L_NDatos: TLabel
    Left = 16
    Top = 56
    Width = 90
    Height = 13
    Caption = 'Cuantos datos:'
  end
  object L_Mayor: TLabel
    Left = 392
    Top = 56
    Width = 36
    Height = 13
    Caption = 'Mayor:'
  end
  object L_Menor: TLabel
    Left = 392
    Top = 80
    Width = 36
    Height = 13
    Caption = 'Menor:'
  end
  object L_Media: TLabel
    Left = 392
    Top = 104
    Width = 34
    Height = 13
    Caption = 'Media:'
  end
  object L_Mediana: TLabel
    Left = 392
    Top = 128
    Width = 47
    Height = 13
    Caption = 'Mediana:'
  end
  object L_Moda: TLabel
    Left = 392
    Top = 152
    Width = 31
    Height = 13
    Caption = 'Moda:'
  end
  object L_Varianza: TLabel
    Left = 392
    Top = 176
    Width = 51
    Height = 13
    Caption = 'Varianza:'
  end
  object L_Desv: TLabel
    Left = 392
    Top = 200
    Width = 80
    Height = 13
    Caption = 'Desv. estandar:'
  end
  object G_Datos: TStringGrid
    Left = 16
    Top = 80
    Width = 220
    Height = 400
    ColCount = 3
    DefaultColWidth = 66
    FixedCols = 1
    RowCount = 6
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goTabs]
    TabOrder = 0
  end
  object P_Cabecera: TPanel
    Left = 0
    Top = 0
    Width = 720
    Height = 41
    Align = alTop
    Color = clNavy
    ParentBackground = False
    TabOrder = 1
    object L_Programa: TLabel
      Left = 16
      Top = 10
      Width = 100
      Height = 19
      Caption = 'ESTADISTICA'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object E_N: TEdit
    Left = 112
    Top = 52
    Width = 50
    Height = 21
    TabOrder = 2
    Text = '5'
    OnKeyPress = E_NKeyPress
  end
  object B_Generar: TButton
    Left = 176
    Top = 50
    Width = 120
    Height = 25
    Caption = 'Generar filas'
    TabOrder = 3
    OnClick = B_GenerarClick
  end
  object B_Calcular: TButton
    Left = 256
    Top = 84
    Width = 120
    Height = 33
    Caption = 'Calcular'
    TabOrder = 4
    OnClick = B_CalcularClick
  end
  object B_Ordenar: TButton
    Left = 256
    Top = 124
    Width = 120
    Height = 33
    Caption = 'Ordenar'
    TabOrder = 5
    OnClick = B_OrdenarClick
  end
  object B_Regresion: TButton
    Left = 256
    Top = 164
    Width = 120
    Height = 33
    Caption = 'Regresion'
    TabOrder = 6
    OnClick = B_RegresionClick
  end
  object B_Limpiar: TButton
    Left = 256
    Top = 204
    Width = 120
    Height = 33
    Caption = 'Limpiar'
    TabOrder = 7
    OnClick = B_LimpiarClick
  end
  object B_Salir: TButton
    Left = 256
    Top = 244
    Width = 120
    Height = 33
    Caption = 'Salir'
    TabOrder = 8
    OnClick = B_SalirClick
  end
  object M_Resultado: TMemo
    Left = 392
    Top = 232
    Width = 310
    Height = 248
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Consolas'
    Font.Style = []
    Lines.Strings = (
      '')
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 9
  end
end
