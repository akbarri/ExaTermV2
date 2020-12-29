object Form1: TForm1
  Left = 762
  Top = 203
  ActiveControl = ComboBox
  BorderStyle = bsDialog
  Caption = 'ExaTermV2'
  ClientHeight = 240
  ClientWidth = 320
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = -4
    Width = 320
    Height = 215
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 0
    OnChange = Memo1Change
  end
  object CheckBox: TCheckBox
    Left = 2
    Top = 214
    Width = 40
    Height = 25
    Caption = 'SU'
    TabOrder = 1
    OnClick = CheckBoxClick
  end
  object ComboBox: TComboBox
    Left = 40
    Top = 216
    Width = 281
    Height = 21
    AutoCloseUp = True
    DropDownCount = 400
    ItemHeight = 13
    TabOrder = 2
    OnKeyPress = ComboBoxKeyPress
  end
  object Tmr1: TTimer
    OnTimer = Tmr1Timer
    Left = 152
    Top = 120
  end
end
