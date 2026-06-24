object FormPrincipal: TFormPrincipal
  Left = 0
  Top = 0
  Caption = 'Programas 4A - Chapingo Irrigacion (Delphi VCL)'
  ClientHeight = 640
  ClientWidth = 1000
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 15
  object FBanner: TPanel
    Left = 0
    Top = 0
    Width = 1000
    Height = 110
    Align = alTop
    BevelOuter = bvNone
    BorderWidth = 8
    Color = clNavy
    ParentBackground = False
    TabOrder = 0
    object FImgIzq: TImage
      Left = 8
      Top = 8
      Width = 96
      Height = 94
      Align = alLeft
      Center = True
      Proportional = True
      Stretch = True
      Transparent = True
      ExplicitHeight = 105
    end
    object FImgDer: TImage
      Left = 896
      Top = 8
      Width = 96
      Height = 94
      Align = alRight
      Center = True
      Proportional = True
      Stretch = True
      Transparent = True
      ExplicitLeft = 856
      ExplicitHeight = 105
    end
    object FTituloLbl: TLabel
      AlignWithMargins = True
      Left = 104
      Top = 8
      Width = 792
      Height = 94
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alClient
      Alignment = taCenter
      AutoSize = False
      Caption = 
        'UNIVERSIDAD AUTONOMA CHAPINGO'#13#10'DEPARTAMENTO DE IRRIGACION'#13#10'Progr' +
        'amacion - Grupo 4A'
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -17
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      WordWrap = True
      ExplicitWidth = 800
    end
  end
  object FContent: TPanel
    Left = 0
    Top = 110
    Width = 1000
    Height = 530
    Align = alClient
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    ExplicitTop = 56
    ExplicitHeight = 584
  end
end
