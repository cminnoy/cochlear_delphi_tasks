object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Task1'
  ClientHeight = 315
  ClientWidth = 453
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnClick = Button5Click
  OnCreate = FormCreate
  TextHeight = 15
  object Memo1: TMemo
    Left = 24
    Top = 24
    Width = 193
    Height = 145
    Lines.Strings = (
      'Memo1')
    TabOrder = 0
  end
  object Button1: TButton
    Left = 30
    Top = 184
    Width = 75
    Height = 25
    Caption = 'Thread1'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 134
    Top = 184
    Width = 75
    Height = 25
    Caption = 'Thread2'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 30
    Top = 224
    Width = 75
    Height = 25
    Caption = 'Thread3'
    TabOrder = 3
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 134
    Top = 224
    Width = 75
    Height = 25
    Caption = 'Thread4'
    TabOrder = 4
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 84
    Top = 264
    Width = 75
    Height = 25
    Caption = 'Thread5'
    TabOrder = 5
    OnClick = Button5Click
  end
  object Memo2: TMemo
    Left = 240
    Top = 24
    Width = 185
    Height = 145
    Lines.Strings = (
      'Memo2')
    TabOrder = 6
  end
end
