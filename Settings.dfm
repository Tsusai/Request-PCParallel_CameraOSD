object Form2: TForm2
  Left = 190
  Top = 314
  BorderStyle = bsToolWindow
  Caption = 'Settings'
  ClientHeight = 215
  ClientWidth = 224
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  ScreenSnap = True
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 128
    Top = 8
    Width = 85
    Height = 13
    Caption = 'ex Ox378 = $378'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Edit1: TEdit
    Left = 128
    Top = 24
    Width = 57
    Height = 21
    Color = clGray
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    Text = '$0378'
  end
  object Button1: TButton
    Left = 8
    Top = 184
    Width = 75
    Height = 25
    Caption = 'Apply'
    TabOrder = 1
    OnClick = Button1Click
  end
  object RadioButton1: TRadioButton
    Left = 8
    Top = 24
    Width = 113
    Height = 17
    Caption = 'Parallel Port I/O'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object RadioButton2: TRadioButton
    Left = 8
    Top = 48
    Width = 177
    Height = 17
    Caption = 'USB Printing Support (DLL)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object RadioButton3: TRadioButton
    Left = 8
    Top = 72
    Width = 177
    Height = 17
    Caption = 'USB Printing Support (Int)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
end
