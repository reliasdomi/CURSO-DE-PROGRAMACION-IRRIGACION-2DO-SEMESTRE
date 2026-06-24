object F_Personas: TF_Personas
  Left = 0
  Top = 0
  Caption = 'Personas / Poblacionales (16-35)'
  ClientHeight = 500
  ClientWidth = 760
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object L_NDatos: TLabel
    Left = 16
    Top = 56
    Width = 95
    Height = 13
    Caption = 'Cuantas personas:'
  end
  object L_Consulta: TLabel
    Left = 470
    Top = 88
    Width = 95
    Height = 13
    Caption = 'Consulta (16-35):'
  end
  object L_Resultado: TLabel
    Left = 470
    Top = 190
    Width = 270
    Height = 120
    AutoSize = False
    Caption = ''
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object G_i: TStringGrid
    Left = 16
    Top = 110
    Width = 44
    Height = 340
    ColCount = 1
    DefaultColWidth = 38
    FixedCols = 0
    RowCount = 6
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect]
    TabOrder = 0
  end
  object G_Nombre: TStringGrid
    Left = 62
    Top = 110
    Width = 184
    Height = 340
    ColCount = 1
    DefaultColWidth = 178
    FixedCols = 0
    RowCount = 6
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goTabs]
    TabOrder = 1
  end
  object G_Edad: TStringGrid
    Left = 248
    Top = 110
    Width = 70
    Height = 340
    ColCount = 1
    DefaultColWidth = 64
    FixedCols = 0
    RowCount = 6
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goTabs]
    TabOrder = 2
  end
  object G_Estatura: TStringGrid
    Left = 320
    Top = 110
    Width = 86
    Height = 340
    ColCount = 1
    DefaultColWidth = 80
    FixedCols = 0
    RowCount = 6
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goTabs]
    TabOrder = 3
  end
  object G_Sexo: TStringGrid
    Left = 408
    Top = 110
    Width = 56
    Height = 340
    ColCount = 1
    DefaultColWidth = 50
    FixedCols = 0
    RowCount = 6
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goTabs]
    TabOrder = 4
  end
  object P_Cabecera: TPanel
    Left = 0
    Top = 0
    Width = 760
    Height = 41
    Align = alTop
    Color = clNavy
    ParentBackground = False
    TabOrder = 5
    object L_Titulo: TLabel
      Left = 16
      Top = 10
      Width = 280
      Height = 19
      Caption = 'PERSONAS / POBLACIONALES (16-35)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object E_N: TEdit
    Left = 120
    Top = 52
    Width = 50
    Height = 21
    TabOrder = 6
    Text = '5'
    OnKeyPress = E_NKeyPress
  end
  object B_Generar: TButton
    Left = 184
    Top = 50
    Width = 120
    Height = 25
    Caption = 'Generar filas'
    TabOrder = 7
    OnClick = B_GenerarClick
  end
  object CB_Consulta: TComboBox
    Left = 470
    Top = 108
    Width = 270
    Height = 21
    Style = csDropDownList
    TabOrder = 8
    Items.Strings = (
      '16. Hombres en el grupo'
      '17. Mujeres en el grupo'
      '18. Edad mayor/menor (grupo)'
      '19. Estatura mayor/menor (grupo)'
      '20. Edad mayor/menor (mujeres)'
      '21. Edad mayor/menor (hombres)'
      '22. Mayores de edad'
      '23. Menores de edad'
      '24. Mujeres mayores de edad'
      '25. Mujeres menores de edad'
      '26. Hombres mayores de edad'
      '27. Hombres menores de edad'
      '28. Estatura mayor/menor (mujeres)'
      '29. Estatura mayor/menor (hombres)'
      '30. Promedio edad (grupo)'
      '31. Promedio estatura (grupo)'
      '32. Promedio edad (mujeres)'
      '33. Promedio edad (hombres)'
      '34. Promedio estatura (mujeres)'
      '35. Promedio estatura (hombres)')
  end
  object B_Consultar: TButton
    Left = 470
    Top = 144
    Width = 120
    Height = 33
    Caption = 'Consultar'
    TabOrder = 9
    OnClick = B_ConsultarClick
  end
  object B_Limpiar: TButton
    Left = 470
    Top = 330
    Width = 120
    Height = 33
    Caption = 'Limpiar'
    TabOrder = 10
    OnClick = B_LimpiarClick
  end
  object B_Salir: TButton
    Left = 470
    Top = 370
    Width = 120
    Height = 33
    Caption = 'Salir'
    TabOrder = 11
    OnClick = B_SalirClick
  end
end
