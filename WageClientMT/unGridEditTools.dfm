inherited fmGridEditTools: TfmGridEditTools
  Left = 268
  Top = 269
  Width = 598
  Height = 370
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1089#1090#1086#1083#1073#1094#1086#1074
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter2: TSplitter [0]
    Left = 351
    Top = 26
    Width = 5
    Height = 298
    Cursor = crHSplit
    Align = alRight
    Beveled = True
  end
  inherited stbModal: TStatusBar
    Top = 324
    Width = 590
  end
  inherited tlbModal: TToolBar
    Width = 590
    Height = 26
    object ToolButton1: TToolButton
      Left = 0
      Top = 0
      Action = actOk
    end
    object ToolButton2: TToolButton
      Left = 23
      Top = 0
      Width = 8
      Caption = 'ToolButton2'
      ImageIndex = 179
      Style = tbsSeparator
    end
    object ToolButton3: TToolButton
      Left = 31
      Top = 0
      Action = actSetImages
    end
    object ToolButton4: TToolButton
      Left = 54
      Top = 0
      Action = actClearImages
    end
  end
  object trlCustom: TdxTreeList [3]
    Left = 0
    Top = 26
    Width = 351
    Height = 298
    Bands = <
      item
      end>
    DefaultLayout = True
    HeaderPanelRowCount = 1
    Align = alClient
    DragMode = dmAutomatic
    TabOrder = 2
    LookAndFeel = lfFlat
    Options = [aoColumnSizing, aoTabThrough, aoRowSelect]
    OptionsEx = [aoUseBitmap, aoBandHeaderWidth, aoAutoCalcPreviewLines, aoBandSizing, aoBandMoving, aoDragScroll, aoDragExpand, aoAutoSearch, aoAutoCopySelectedToClipboard]
    TreeLineColor = clGrayText
    ShowLines = False
    ShowIndicator = True
    OnDblClick = trlCustomDblClick
    OnDragDrop = trlCustomDragDrop
    OnDragOver = trlCustomDragOver
    OnStartDrag = trlCustomStartDrag
    object trlClmVisible: TdxTreeListCheckColumn
      Caption = #1042#1080#1076
      Width = 35
      BandIndex = 0
      RowIndex = 0
      ValueChecked = 'True'
      ValueUnchecked = 'False'
    end
    object trlClmColumn: TdxTreeListColumn
      Caption = #1047#1072#1075#1086#1083#1086#1074#1086#1082
      Width = 133
      BandIndex = 0
      RowIndex = 0
    end
    object trlClmField: TdxTreeListColumn
      Caption = #1055#1086#1083#1077
      Width = 120
      BandIndex = 0
      RowIndex = 0
    end
    object trlClmSumFooter: TdxTreeListColumn
      Caption = #1054#1073#1097#1077#1077' '#1074#1099#1088#1072#1078#1077#1085#1080#1077
      BandIndex = 0
      RowIndex = 0
    end
    object trlClmSum: TdxTreeListColumn
      Caption = #1042#1099#1088#1072#1078#1077#1085#1080#1077
      BandIndex = 0
      RowIndex = 0
    end
    object trlClmColor: TdxTreeListColumn
      Caption = #1062#1074#1077#1090
      BandIndex = 0
      RowIndex = 0
    end
    object trlClmClass: TdxTreeListColumn
      Caption = #1050#1083#1072#1089#1089
      Width = 138
      BandIndex = 0
      RowIndex = 0
    end
  end
  object GroupBox2: TGroupBox [4]
    Left = 356
    Top = 26
    Width = 234
    Height = 298
    Align = alRight
    Caption = #1056#1077#1082#1074#1080#1079#1080#1090#1099' '#1089#1090#1086#1083#1073#1094#1086#1074
    TabOrder = 3
    object Label3: TLabel
      Left = 12
      Top = 28
      Width = 54
      Height = 13
      Caption = #1047#1072#1075#1086#1083#1086#1074#1086#1082
    end
    object Label4: TLabel
      Left = 12
      Top = 56
      Width = 62
      Height = 13
      Caption = #1062#1074#1077#1090' '#1090#1077#1082#1089#1090#1072
    end
    object edtTitle: TEdit
      Left = 88
      Top = 24
      Width = 137
      Height = 21
      TabOrder = 0
    end
    object ccbColor: TColorComboBox
      Left = 88
      Top = 52
      Width = 137
      Height = 22
      TabOrder = 1
    end
  end
  inherited actModal: TActionList
    Left = 216
    Top = 65532
    object actColor: TColorSelect [2]
      Category = 'Dialog'
      Caption = #1042#1099#1073#1086#1088' '#1094#1074#1077#1090#1072' '#1089#1090#1086#1083#1073#1094#1072
      Dialog.Ctl3D = True
      Hint = #1042#1099#1073#1086#1088' '#1094#1074#1077#1090#1072' '#1089#1090#1086#1083#1073#1094#1072
      ImageIndex = 110
    end
    object actSaveExpress: TAction [3]
      Caption = #1060#1080#1082#1089#1080#1088#1086#1074#1072#1090#1100' (F5)'
      Hint = #1060#1080#1082#1089#1080#1088#1086#1074#1072#1090#1100' '#1080#1079#1084#1077#1085#1077#1085#1080#1103
      ImageIndex = 0
      ShortCut = 116
      Visible = False
    end
    object actSetImages: TAction
      Caption = #1053#1072#1079#1085#1072#1095#1080#1090#1100' '#1080#1082#1086#1085#1082#1080
      Enabled = False
      Hint = #1053#1072#1079#1085#1072#1095#1080#1090#1100' '#1080#1082#1086#1085#1082#1080
      ImageIndex = 107
      OnExecute = actSetImagesExecute
    end
    object actClearImages: TAction
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1080#1082#1086#1085#1082#1080
      Enabled = False
      Hint = #1054#1095#1080#1089#1090#1080#1090#1100' '#1080#1082#1086#1085#1082#1080
      ImageIndex = 117
      OnExecute = actClearImagesExecute
    end
  end
  inherited strModal: TFormStorage
    Left = 268
    Top = 65532
  end
  inherited popModal: TPopupMenu
    Left = 320
    Top = 65532
  end
  object PopupMenu1: TPopupMenu
    Images = DM.imgMain
    Left = 320
    Top = 65532
  end
end
