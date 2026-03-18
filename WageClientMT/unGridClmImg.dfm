inherited fmGridClmImg: TfmGridClmImg
  Left = 202
  Top = 342
  Width = 492
  Height = 373
  Caption = #1053#1072#1079#1085#1072#1095#1077#1085#1080#1077' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1081
  PixelsPerInch = 96
  TextHeight = 13
  inherited stbModal: TStatusBar
    Top = 327
    Width = 484
  end
  object trlClmImg: TdxTreeList [1]
    Left = 0
    Top = 24
    Width = 484
    Height = 303
    Bands = <
      item
      end>
    DefaultLayout = True
    HeaderPanelRowCount = 1
    Align = alClient
    TabOrder = 2
    Images = DM.imgMain
    TreeLineColor = clGrayText
    ShowRoot = False
    OnGetImageIndex = trlClmImgGetImageIndex
    OnGetSelectedIndex = trlClmImgGetImageIndex
    object clmImg: TdxTreeListColumn
      Alignment = taLeftJustify
      MinWidth = 16
      Width = 33
      BandIndex = 0
      RowIndex = 0
    end
    object clmIndex: TdxTreeListColumn
      Width = 44
      BandIndex = 0
      RowIndex = 0
    end
    object clmValue: TdxTreeListColumn
      Caption = #1047#1085#1072#1095#1077#1085#1080#1077
      Width = 125
      BandIndex = 0
      RowIndex = 0
    end
    object clmDescr: TdxTreeListColumn
      Caption = #1054#1087#1080#1089#1072#1085#1080#1077
      Width = 265
      BandIndex = 0
      RowIndex = 0
    end
  end
  inherited tlbModal: TToolBar
    Width = 484
    object ToolButton1: TToolButton
      Left = 0
      Top = 0
      Action = actClose
    end
    object ToolButton3: TToolButton
      Left = 23
      Top = 0
      Width = 8
      Caption = 'ToolButton3'
      ImageIndex = 63
      Style = tbsSeparator
    end
    object ToolButton4: TToolButton
      Left = 31
      Top = 0
      Action = actNew
    end
    object ToolButton5: TToolButton
      Left = 54
      Top = 0
      Action = actEdit
    end
    object ToolButton6: TToolButton
      Left = 77
      Top = 0
      Action = actDel
    end
  end
  inherited actModal: TActionList
    Left = 312
    Top = 4
    object actNew: TAction
      Caption = #1057#1086#1079#1076#1072#1090#1100
      Hint = #1057#1086#1079#1076#1072#1090#1100
      ImageIndex = 73
      OnExecute = actNewExecute
    end
    object actEdit: TAction
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100
      ImageIndex = 72
      OnExecute = actEditExecute
    end
    object actDel: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Hint = #1059#1076#1072#1083#1080#1090#1100
      ImageIndex = 62
      OnExecute = actDelExecute
    end
  end
end
