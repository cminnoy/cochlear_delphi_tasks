object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Task2'
  ClientHeight = 442
  ClientWidth = 524
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object Bevel1: TBevel
    Left = 25
    Top = 16
    Width = 232
    Height = 194
  end
  object RadioGroup1: TRadioGroup
    Left = 48
    Top = 24
    Width = 185
    Height = 105
    Caption = 'Select'
    TabOrder = 0
  end
  object RadioButtonFile: TRadioButton
    Left = 88
    Top = 49
    Width = 113
    Height = 17
    Caption = 'From File'
    TabOrder = 1
  end
  object RadioButtonGenerate: TRadioButton
    Left = 88
    Top = 89
    Width = 113
    Height = 17
    Caption = 'Generate'
    Checked = True
    TabOrder = 2
    TabStop = True
  end
  object Button1: TButton
    Left = 104
    Top = 149
    Width = 75
    Height = 25
    Caption = 'Proceed'
    TabOrder = 3
    OnClick = Button1Click
  end
  object ListView1: TListView
    Left = 25
    Top = 232
    Width = 472
    Height = 193
    Columns = <
      item
        AutoSize = True
        Caption = 'Sequence'
        MinWidth = 30
      end
      item
        AutoSize = True
        Caption = 'Occurrence'
        MinWidth = 30
      end>
    GridLines = True
    ReadOnly = True
    RowSelect = True
    ShowWorkAreas = True
    SortType = stText
    TabOrder = 4
    ViewStyle = vsReport
    OnCompare = ListView1Compare
  end
  object Memo1: TMemo
    Left = 272
    Top = 17
    Width = 217
    Height = 193
    Lines.Strings = (
      '')
    TabOrder = 5
  end
  object OpenDialog1: TOpenDialog
    Left = 200
    Top = 144
  end
end
