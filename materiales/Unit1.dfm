object Form1: TForm1
  Left = 192
  Top = 125
  Width = 928
  Height = 480
  Caption = 'Form1'
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
    Left = 264
    Top = 104
    object figuras1: TMenuItem
      Caption = 'figuras'
      object Cuadrado1: TMenuItem
        Caption = 'Cuadrado'
      end
      object REctangulo1: TMenuItem
        Caption = 'REctangulo'
      end
      object riangulo1: TMenuItem
        Caption = 'Triangulo'
      end
    end
    object estadisticas1: TMenuItem
      Caption = 'Estadisticas'
      object Mayor1: TMenuItem
        Caption = 'Mayor'
      end
      object Menor1: TMenuItem
        Caption = 'Menor'
      end
      object Media1: TMenuItem
        Caption = 'Media'
      end
      object MediN1: TMenuItem
        Caption = 'MediN'
      end
      object Moda1: TMenuItem
        Caption = 'Moda'
      end
    end
    object Personas1: TMenuItem
      Caption = 'Personas'
      object Comjumto1: TMenuItem
        Caption = 'Comjumto'
      end
      object Mujeres1: TMenuItem
        Caption = 'Mujeres'
      end
      object Hombre1: TMenuItem
        Caption = 'Hombre'
      end
    end
    object matrices1: TMenuItem
      Caption = 'matrices'
    end
    object Archivos1: TMenuItem
      Caption = 'Archivos'
      object Miscelaneos1: TMenuItem
        Caption = 'Texto'
      end
      object Binarios1: TMenuItem
        Caption = 'Binarios'
      end
    end
    object Miscelaneos2: TMenuItem
      Caption = 'Miscelaneos'
      object ParImpar1: TMenuItem
        Caption = 'Par-Impar'
      end
      object cCuadratica1: TMenuItem
        Caption = 'c. Cuadratica'
      end
    end
    object Salir1: TMenuItem
      Caption = 'Salir'
    end
  end
end
