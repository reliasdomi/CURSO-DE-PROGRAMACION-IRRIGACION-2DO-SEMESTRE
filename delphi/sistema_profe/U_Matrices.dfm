object F_Matrices: TF_Matrices
  Left = 0
  Top = 0
  Caption = 'Matrices'
  ClientHeight = 520
  ClientWidth = 740
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object L_Filas: TLabel
    Left = 16
    Top = 56
    Width = 28
    Height = 13
    Caption = 'Filas:'
  end
  object L_Cols: TLabel
    Left = 120
    Top = 56
    Width = 50
    Height = 13
    Caption = 'Columnas:'
  end
  object L_A: TLabel
    Left = 16
    Top = 86
    Width = 60
    Height = 13
    Caption = 'Matriz A:'
  end
  object L_B: TLabel
    Left = 16
    Top = 278
    Width = 60
    Height = 13
    Caption = 'Matriz B:'
  end
  object L_R: TLabel
    Left = 250
    Top = 86
    Width = 80
    Height = 13
    Caption = 'Resultado:'
  end
  object L_Mensaje: TLabel
    Left = 470
    Top = 360
    Width = 250
    Height = 60
    AutoSize = False
    Caption = ''
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object G_A: TStringGrid
    Left = 16
    Top = 104
    Width = 210
    Height = 160
    ColCount = 2
    DefaultColWidth = 64
    FixedCols = 0
    FixedRows = 0
    RowCount = 2
    Options = [goVertLine, goHorzLine, goRangeSelect, goEditing, goTabs]
    TabOrder = 0
  end
  object G_B: TStringGrid
    Left = 16
    Top = 296
    Width = 210
    Height = 160
    ColCount = 2
    DefaultColWidth = 64
    FixedCols = 0
    FixedRows = 0
    RowCount = 2
    Options = [goVertLine, goHorzLine, goRangeSelect, goEditing, goTabs]
    TabOrder = 1
  end
  object G_R: TStringGrid
    Left = 250
    Top = 104
    Width = 210
    Height = 160
    ColCount = 2
    DefaultColWidth = 64
    FixedCols = 0
    FixedRows = 0
    RowCount = 2
    Options = [goVertLine, goHorzLine, goRangeSelect]
    TabOrder = 2
  end
  object P_Cabecera: TPanel
    Left = 0
    Top = 0
    Width = 740
    Height = 41
    Align = alTop
    Color = clNavy
    ParentBackground = False
    TabOrder = 3
    object L_Programa: TLabel
      Left = 16
      Top = 10
      Width = 100
      Height = 19
      Caption = 'MATRICES'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object E_Filas: TEdit
    Left = 60
    Top = 52
    Width = 40
    Height = 21
    TabOrder = 4
    Text = '2'
  end
  object E_Cols: TEdit
    Left = 176
    Top = 52
    Width = 40
    Height = 21
    TabOrder = 5
    Text = '2'
  end
  object B_Generar: TButton
    Left = 240
    Top = 50
    Width = 130
    Height = 25
    Caption = 'Generar matrices'
    TabOrder = 6
    OnClick = B_GenerarClick
  end
  object B_Suma: TButton
    Left = 480
    Top = 104
    Width = 130
    Height = 33
    Caption = 'Suma (A+B)'
    TabOrder = 7
    OnClick = B_SumaClick
  end
  object B_Resta: TButton
    Left = 480
    Top = 144
    Width = 130
    Height = 33
    Caption = 'Resta (A-B)'
    TabOrder = 8
    OnClick = B_RestaClick
  end
  object B_Transpuesta: TButton
    Left = 480
    Top = 184
    Width = 130
    Height = 33
    Caption = 'Transpuesta de A'
    TabOrder = 9
    OnClick = B_TranspuestaClick
  end
  object B_Inversa: TButton
    Left = 480
    Top = 224
    Width = 130
    Height = 33
    Caption = 'Inversa 2x2 de A'
    TabOrder = 10
    OnClick = B_InversaClick
  end
  object B_Salir: TButton
    Left = 480
    Top = 296
    Width = 130
    Height = 33
    Caption = 'Salir'
    TabOrder = 11
    OnClick = B_SalirClick
  end
end
