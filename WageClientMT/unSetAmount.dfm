inherited fmSetAmount: TfmSetAmount
  Left = 210
  Top = 469
  Width = 233
  Height = 111
  Caption = #1059#1089#1090#1072#1085#1086#1074#1082#1072' '#1089#1091#1084#1084#1099
  PixelsPerInch = 96
  TextHeight = 13
  object lblCom: TLabel [0]
    Left = 184
    Top = 40
    Width = 14
    Height = 16
    Caption = '%'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  inherited stbModal: TStatusBar
    Top = 65
    Width = 225
  end
  inherited tlbModal: TToolBar
    Width = 225
    Height = 26
    object ToolButton1: TToolButton
      Left = 0
      Top = 0
      Action = actOk
    end
    object ToolButton2: TToolButton
      Left = 23
      Top = 0
      Action = actCancel
    end
  end
  object edtAmount: TdxCurrencyEdit [3]
    Left = 16
    Top = 36
    Width = 165
    TabOrder = 2
    Alignment = taRightJustify
    DisplayFormat = ',0.00'
    StoredValues = 1
  end
  inherited actModal: TActionList
    Left = 88
  end
  inherited strModal: TFormStorage
    Left = 140
  end
end
