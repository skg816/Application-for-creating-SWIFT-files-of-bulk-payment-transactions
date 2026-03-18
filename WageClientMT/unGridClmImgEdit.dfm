inherited fmGridClmImgEdit: TfmGridClmImgEdit
  Left = 489
  Top = 121
  Width = 350
  Height = 170
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel [0]
    Left = 8
    Top = 40
    Width = 48
    Height = 13
    Caption = #1047#1085#1072#1095#1077#1085#1080#1077
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel [1]
    Left = 8
    Top = 68
    Width = 50
    Height = 13
    Caption = #1054#1087#1080#1089#1072#1085#1080#1077
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel [2]
    Left = 20
    Top = 96
    Width = 38
    Height = 13
    Caption = #1048#1082#1086#1085#1082#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  inherited stbModal: TStatusBar
    Top = 124
    Width = 342
  end
  object cbxColor: TComboBoxEx [4]
    Left = 64
    Top = 92
    Width = 57
    Height = 22
    ItemsEx.CaseSensitive = False
    ItemsEx.SortType = stNone
    ItemsEx = <>
    Style = csExDropDownList
    StyleEx = []
    ItemHeight = 16
    TabOrder = 2
    Images = DM.imgMain
    DropDownCount = 15
  end
  object edtValue: TEdit [5]
    Left = 64
    Top = 36
    Width = 269
    Height = 21
    TabOrder = 0
  end
  object edtDescr: TEdit [6]
    Left = 64
    Top = 64
    Width = 269
    Height = 21
    TabOrder = 1
  end
  inherited tlbModal: TToolBar
    Width = 342
    TabOrder = 3
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
  inherited actModal: TActionList
    Left = 288
    Top = 4
  end
  inherited strModal: TFormStorage
    Left = 180
  end
  inherited popModal: TPopupMenu
    Left = 236
  end
end
