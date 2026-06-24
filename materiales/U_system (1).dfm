object F_system: TF_system
  Left = 192
  Top = 125
  Width = 928
  Height = 480
  Caption = 'System'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu1: TMainMenu
    Left = 328
    Top = 152
    object Figuras1: TMenuItem
      Caption = 'Figuras'
      object Cuadrado1: TMenuItem
        Caption = 'Cuadrado'
        OnClick = Cuadrado1Click
      end
      object Rectangulo1: TMenuItem
        Caption = 'Rectangulo'
        OnClick = Rectangulo1Click
      end
    end
  end
end
