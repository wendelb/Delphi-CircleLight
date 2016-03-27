object FrmCircleLight: TFrmCircleLight
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'CircleLight'
  ClientHeight = 281
  ClientWidth = 543
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Timer: TTimer
    Interval = 20
    OnTimer = TimerTimer
    Left = 256
    Top = 128
  end
end
