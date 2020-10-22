object Form1: TForm1
  Left = 919
  Top = 203
  BorderStyle = bsDialog
  Caption = 'ExaTerm'
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
    TabOrder = 1
    OnChange = Memo1Change
  end
  object Edit1: TEdit
    Left = 40
    Top = 216
    Width = 280
    Height = 21
    TabOrder = 0
    OnKeyPress = Edit1KeyPress
  end
  object SU: TCheckBox
    Left = 0
    Top = 216
    Width = 41
    Height = 25
    Caption = 'SU'
    TabOrder = 2
  end
  object tmr1: TTimer
    OnTimer = tmr1Timer
    Left = 152
    Top = 120
  end
end
