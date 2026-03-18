object frmGrid: TfrmGrid
  Left = 0
  Top = 0
  Width = 353
  Height = 147
  TabOrder = 0
  object pnlMain: TPanel
    Left = 0
    Top = 0
    Width = 353
    Height = 128
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object pnlMainLeft: TPanel
      Left = 0
      Top = 0
      Width = 353
      Height = 128
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      object pnlFilter: TPanel
        Left = 0
        Top = 0
        Width = 353
        Height = 23
        Align = alTop
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        Visible = False
        object Label1: TLabel
          Left = 4
          Top = 4
          Width = 40
          Height = 13
          Caption = #1060#1080#1083#1100#1090#1088
        end
        object SpeedButton1: TSpeedButton
          Left = 268
          Top = 0
          Width = 23
          Height = 22
          Action = actFilter
          Glyph.Data = {
            42020000424D4202000000000000420000002800000010000000100000000100
            1000030000000002000000000000000000000000000000000000007C0000E003
            00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
            1F7C1F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C00000000000000001F7C
            1F7C000000001F7C1F7C1F7C1F7C1F7C1F7C00000000FF7FFF7FFF7FFF7F0000
            0000000000001F7C1F7C1F7C1F7C1F7C00001F001F001F001F001F00FF7F0000
            1F7C00001F7C1F7C1F7C1F7C1F7C1F7C0000FF7FFF7FFF7FFF7FFF7FFF7F0000
            1F7C00001F7C104210421042000000001F001F001F001F001F001F00FF7F0000
            1F7C1F7C00000000FF7FFF7FFF7F0000FF7FFF7FFF7FFF7FFF7FFF7FFF7F0000
            1F7C1F7C00000000FF7F1000100000001F001F001F001F001F001F00FF7F0000
            1F7C1F7C00000000FF7FFF7FFF7F0000FF7FFF7FFF7FFF7FFF7FFF7FFF7F0000
            1F7C1F7C00000000FF7F1000100010000000FF7FFF7FFF7FFF7FFF7FFF7F0000
            1F7C00001F7C0000FF7FFF7FFF7FFF7F00001042104210421042104210421042
            1F7C00001F7C0000FF7F100010001000100000000000FF7FFF7FFF7FFF7F0000
            000010421F7C0000FF7FFF7FFF7FFF7FFF7FFF7F18630000000000000000FF7F
            FF7F10421F7C0000FF7F1000100010001000FF7F1863FF7F1000100010001000
            100010421F7C0000FF7FFF7FFF7FFF7FFF7FFF7F1863FF7FFF7FFF7FFF7FFF7F
            FF7F10421F7C0000000000000000000000000000000000000000000000000000
            000010421F7C}
        end
        object SpeedButton2: TSpeedButton
          Left = 292
          Top = 0
          Width = 117
          Height = 22
          Caption = '- '#1087#1088#1080#1084#1077#1088#1099' '#1092#1080#1083#1100#1090#1088#1072
          Flat = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          OnClick = SpeedButton2Click
        end
        object edtFilter: TEdit
          Left = 48
          Top = 0
          Width = 221
          Height = 21
          TabOrder = 0
        end
      end
      object grdGrid: TdxDBGrid
        Left = 0
        Top = 23
        Width = 353
        Height = 105
        Bands = <
          item
            Caption = 'left'
            Width = 50
          end>
        DefaultLayout = False
        HeaderPanelRowCount = 1
        SummaryGroups = <
          item
            DefaultGroup = True
            SummaryItems = <>
            Name = 'grdSummary'
          end>
        SummarySeparator = ', '
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        PopupMenu = popGrid
        TabOrder = 1
        BandColor = clBackground
        BandFont.Charset = DEFAULT_CHARSET
        BandFont.Color = clWindowText
        BandFont.Height = -11
        BandFont.Name = 'MS Sans Serif'
        BandFont.Style = []
        DataSource = dsrGrid
        Filter.Active = True
        Filter.DropDownCount = 20
        Filter.DropDownWidth = 300
        Filter.Criteria = {00000000}
        FixedBandLineColor = clPurple
        GroupPanelColor = clBackground
        GroupNodeColor = clMoneyGreen
        GroupNodeTextColor = clBlack
        HeaderFont.Charset = DEFAULT_CHARSET
        HeaderFont.Color = clNavy
        HeaderFont.Height = -11
        HeaderFont.Name = 'MS Sans Serif'
        HeaderFont.Style = []
        HideSelectionTextColor = clWhite
        HighlightTextColor = clWhite
        LookAndFeel = lfFlat
        OptionsBehavior = [edgoAutoSearch, edgoAutoSort, edgoDragScroll, edgoImmediateEditor, edgoMultiSelect, edgoTabThrough, edgoVertThrough]
        OptionsDB = [edgoCanNavigation, edgoLoadAllRecords, edgoSmartRefresh, edgoSmartReload]
        OptionsView = [edgoBandHeaderWidth, edgoIndicator, edgoRowAutoHeight, edgoUseBitmap]
        PreviewFont.Charset = DEFAULT_CHARSET
        PreviewFont.Color = clBlue
        PreviewFont.Height = -11
        PreviewFont.Name = 'MS Sans Serif'
        PreviewFont.Style = []
        RowFooterColor = clBtnFace
        RowFooterTextColor = clNavy
        OnCustomDrawCell = grdGridCustomDrawCell
      end
    end
  end
  object stbGrid: TStatusBar
    Left = 0
    Top = 128
    Width = 353
    Height = 19
    Panels = <
      item
        Width = 80
      end
      item
        Width = 50
      end
      item
        Width = 80
      end
      item
        Width = 25
      end
      item
        Width = 400
      end>
    SimplePanel = False
  end
  object actGrid: TActionList
    Images = DM.imgMain
    Left = 68
    Top = 32
    object actRefresh: TAction
      Category = 'UserGrid'
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1090#1072#1073#1083#1080#1094#1091
      ImageIndex = 63
      OnExecute = actRefreshExecute
    end
    object actShowGroup: TAction
      Category = 'UserGrid'
      Caption = #1055#1072#1085#1077#1083#1100' '#1075#1088#1091#1087#1087
      Hint = #1054#1090#1086#1073#1088#1072#1079#1080#1090#1100' '#1087#1072#1085#1077#1083#1100' '#1075#1088#1091#1087#1087
      ImageIndex = 53
      OnExecute = actShowGroupExecute
    end
    object actAutoWidth: TAction
      Category = 'UserGrid'
      Caption = #1040#1074#1090#1086#1088#1072#1079#1084#1077#1097#1077#1085#1080#1077
      Hint = #1040#1074#1090#1086#1088#1072#1079#1084#1077#1097#1077#1085#1080#1077' '#1087#1086#1083#1077#1081
      ImageIndex = 49
      OnExecute = actAutoWidthExecute
    end
    object actFileRun: TFileRun
      Category = 'File'
      Browse = False
      BrowseDlg.Title = 'Run'
      Caption = '&Run...'
      Hint = 'Run|Runs an application'
      Operation = 'open'
      ShowCmd = scShowNormal
    end
    object actSaveFile: TFileSaveAs
      Category = 'File'
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1082#1072#1082'...'
      Hint = 'Save As|Saves the active file with a new name'
      ImageIndex = 182
    end
    object actFullExpand: TAction
      Category = 'UserGrid'
      Caption = #1056#1072#1079#1074#1077#1088#1085#1091#1090#1100' '#1075#1088#1091#1087#1087#1099
      Hint = #1056#1072#1079#1074#1077#1088#1085#1091#1090#1100' '#1074#1089#1077' '#1075#1088#1091#1087#1087#1099
      ImageIndex = 97
      OnExecute = actFullExpandExecute
    end
    object actFullCollapse: TAction
      Category = 'UserGrid'
      Caption = #1057#1074#1077#1088#1085#1091#1090#1100' '#1075#1088#1091#1087#1087#1099
      Hint = #1057#1074#1077#1088#1085#1091#1090#1100' '#1074#1089#1077' '#1075#1088#1091#1087#1087#1099
      ImageIndex = 98
      OnExecute = actFullCollapseExecute
    end
    object actSaveToXls: TAction
      Category = 'Export'
      Caption = #1069#1082#1089#1087#1086#1088#1090' '#1074' Excel'
      Hint = #1069#1082#1089#1087#1086#1088#1090' '#1074' Excel'
      ImageIndex = 88
      OnExecute = actSaveToXlsExecute
    end
    object actSaveToHtml: TAction
      Category = 'Export'
      Caption = #1069#1082#1089#1087#1086#1088#1090' '#1074' Html'
      Hint = #1069#1082#1089#1087#1086#1088#1090' '#1074' Html'
      ImageIndex = 88
      OnExecute = actSaveToHtmlExecute
    end
    object actSaveToTxt: TAction
      Category = 'Export'
      Caption = #1069#1082#1089#1087#1086#1088#1090' '#1074' Text'
      Hint = #1069#1082#1089#1087#1086#1088#1090' '#1074' Text'
      ImageIndex = 88
      OnExecute = actSaveToTxtExecute
    end
    object actSaveToXml: TAction
      Category = 'Export'
      Caption = #1069#1082#1089#1087#1086#1088#1090' '#1074' XML'
      Hint = #1069#1082#1089#1087#1086#1088#1090' '#1074' XML'
      ImageIndex = 88
      OnExecute = actSaveToXmlExecute
    end
    object actShowOwnerName: TAction
      Category = 'Admin'
      Caption = 'actShowOwnerName'
      ShortCut = 49231
      OnExecute = actShowOwnerNameExecute
    end
    object actFilter: TAction
      Category = 'UserGrid'
      Hint = #1047#1072#1087#1091#1089#1090#1080#1090#1100' '#1092#1080#1083#1100#1090#1088
      ImageIndex = 188
      ShortCut = 120
      OnExecute = actFilterExecute
    end
    object actViewFast: TAction
      Category = 'UserGrid'
      Caption = #1041#1099#1089#1090#1088#1099#1081' '#1087#1088#1086#1089#1084#1086#1090#1088
      ImageIndex = 10
      ShortCut = 114
      OnExecute = actViewFastExecute
    end
    object actShowFilter: TAction
      Category = 'UserGrid'
      Caption = #1060#1080#1083#1100#1090#1088' '#1088#1072#1089#1096'.'
      Enabled = False
      ImageIndex = 188
      ShortCut = 118
      Visible = False
      OnExecute = actShowFilterExecute
    end
    object actInfo: TAction
      Category = 'Admin'
      Caption = #1054#1073#1097#1072#1103' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1103
      Hint = #1054#1073#1097#1072#1103' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1103
      ShortCut = 49225
      OnExecute = actInfoExecute
    end
    object actSync: TAction
      Category = 'Admin'
      Caption = #1057#1080#1085#1093#1088#1086#1085'. '#1087#1086#1083#1077#1081
      Hint = #1057#1080#1085#1093#1088#1086#1085'. '#1087#1086#1083#1077#1081
      ImageIndex = 187
      ShortCut = 49230
      OnExecute = actSyncExecute
    end
    object actSave: TAction
      Category = 'Admin'
      Caption = #1060#1080#1082#1089#1080#1088#1086#1074#1072#1090#1100
      Hint = #1060#1080#1082#1089#1080#1088#1086#1074#1072#1090#1100
      ImageIndex = 0
      OnExecute = actSaveExecute
    end
    object actGridEdit: TAction
      Category = 'Admin'
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1087#1086#1083#1077#1081
      Hint = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1087#1086#1083#1077#1081
      ImageIndex = 186
      OnExecute = actGridEditExecute
    end
    object actAdmin: TAction
      Category = 'Admin'
      Caption = 'actAdmin'
      ShortCut = 49217
      OnExecute = actAdminExecute
    end
    object actFileOpen: TFileOpen
      Category = 'File'
      Caption = #1054#1090#1082#1088#1099#1090#1100
      Hint = #1054#1090#1082#1088#1099#1090#1100'|'#1054#1090#1082#1088#1099#1090#1080#1077' '#1089#1091#1097#1077#1090#1074#1091#1102#1097#1077#1075#1086' '#1092#1072#1081#1083#1072
    end
    object actClearLocalFilter: TAction
      Category = 'UserGrid'
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1092#1080#1083#1100#1090#1088
      Hint = #1054#1095#1080#1089#1090#1080#1090#1100' '#1092#1080#1083#1100#1090#1088
      ImageIndex = 190
      OnExecute = actClearLocalFilterExecute
    end
    object actPack: TAction
      Category = 'UserGrid'
      Caption = #1059#1087#1072#1082#1086#1074#1072#1090#1100' '#1041#1044
      Hint = #1059#1087#1072#1082#1086#1074#1072#1090#1100' '#1041#1072#1079#1091' '#1044#1072#1085#1085#1099#1093
      ImageIndex = 185
      OnExecute = actPackExecute
    end
    object actSaveToDbf: TAction
      Category = 'Export'
      Caption = #1069#1082#1089#1087#1086#1088#1090' '#1074' Dbf '#1074#1089#1077' '#1079#1072#1087#1080#1089#1080
      Hint = #1069#1082#1089#1087#1086#1088#1090' '#1074' Dbf '#1074#1089#1077' '#1079#1072#1087#1080#1089#1080
      ImageIndex = 88
      OnExecute = actSaveToDbfExecute
    end
    object actSaveToDbfFilter: TAction
      Category = 'Export'
      Caption = #1069#1082#1089#1087#1086#1088#1090' '#1074' Dbf '#1087#1086' '#1092#1080#1083#1100#1090#1088#1091
      Enabled = False
      Hint = #1069#1082#1089#1087#1086#1088#1090' '#1074' Dbf '#1087#1086' '#1092#1080#1083#1100#1090#1088#1091
      ImageIndex = 88
      OnExecute = actSaveToDbfFilterExecute
    end
  end
  object popGrid: TPopupMenu
    Images = DM.imgMain
    Left = 68
    Top = 80
    object N13: TMenuItem
      Action = actClearLocalFilter
    end
    object N9: TMenuItem
      Action = actViewFast
    end
    object actShowFilter1: TMenuItem
      Action = actShowFilter
      Caption = #1060#1080#1083#1100#1090#1088' '#1088#1072#1089#1096#1080#1088'.'
      Hint = #1060#1080#1083#1100#1090#1088' '#1088#1072#1089#1096#1080#1088#1077#1085#1085#1099#1081
    end
    object N14: TMenuItem
      Caption = #1069#1082#1089#1087#1086#1088#1090
      object Excel1: TMenuItem
        Action = actSaveToXls
      end
      object Html1: TMenuItem
        Action = actSaveToHtml
      end
      object ext1: TMenuItem
        Action = actSaveToTxt
      end
      object XML1: TMenuItem
        Action = actSaveToXml
      end
      object Dbf1: TMenuItem
        Action = actSaveToDbf
      end
      object Dbf2: TMenuItem
        Action = actSaveToDbfFilter
      end
    end
    object N8: TMenuItem
      Caption = #1058#1072#1073#1083#1080#1094#1072
      ImageIndex = 71
      object N6: TMenuItem
        Action = actShowGroup
      end
      object N4: TMenuItem
        Action = actAutoWidth
      end
      object N12: TMenuItem
        Action = actPack
      end
    end
    object popAdmin: TMenuItem
      Caption = #1040#1076#1084#1080#1085#1080#1089#1090#1088#1072#1090#1086#1088
      Visible = False
      object N10: TMenuItem
        Action = actGridEdit
      end
      object N11: TMenuItem
        Action = actInfo
      end
      object actSync1: TMenuItem
        Action = actSync
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object N7: TMenuItem
        Action = actSave
      end
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object N16: TMenuItem
      Action = actFullCollapse
    end
    object N17: TMenuItem
      Action = actFullExpand
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object N1: TMenuItem
      Action = actRefresh
    end
  end
  object dsrGrid: TDataSource
    DataSet = hdsGrid
    Left = 16
    Top = 80
  end
  object hdsGrid: THalcyonDataSet
    AutoCalcFields = False
    AutoFlush = False
    ExactCount = True
    Exclusive = False
    LargeIntegerAs = asLargeInt
    LockProtocol = Default
    TranslateASCII = False
    UseDeleted = False
    UserID = 0
    Left = 16
    Top = 32
  end
end
