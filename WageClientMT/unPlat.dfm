inherited fmPlat: TfmPlat
  Left = 236
  Top = 116
  Width = 567
  Height = 334
  Caption = #1055#1083#1072#1090#1077#1078#1080
  FormStyle = fsMDIChild
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited stbModal: TStatusBar
    Top = 288
    Width = 559
    Visible = False
  end
  inherited tlbModal: TToolBar
    Width = 559
    Height = 26
    Visible = False
  end
  object pgcPlat: TPageControl [2]
    Left = 0
    Top = 26
    Width = 559
    Height = 247
    ActivePage = TabSheet2
    Align = alClient
    TabIndex = 1
    TabOrder = 2
    TabWidth = 130
    OnChange = pgcPlatChange
    object TabSheet1: TTabSheet
      Caption = #1044#1086#1082#1091#1084#1077#1085#1090#1099
      inline frmPlat: TfrmGrid
        Left = 0
        Top = 26
        Width = 551
        Height = 193
        Align = alClient
        TabOrder = 0
        inherited pnlMain: TPanel
          Width = 551
          Height = 174
          inherited pnlMainLeft: TPanel
            Width = 551
            Height = 174
            inherited pnlFilter: TPanel
              Width = 551
            end
            inherited grdGrid: TdxDBGrid
              Width = 551
              Height = 151
              KeyField = 'ID'
              OnDblClick = actEditExecute
              Filter.Criteria = {00000000}
            end
          end
        end
        inherited stbGrid: TStatusBar
          Top = 174
          Width = 551
        end
        inherited actGrid: TActionList
          Left = 116
          Top = 64
          inherited actFilter: TAction
            Enabled = False
          end
        end
        inherited popGrid: TPopupMenu
          Left = 116
          Top = 112
        end
        inherited dsrGrid: TDataSource
          Left = 64
          Top = 112
        end
        inherited hdsGrid: THalcyonDataSet
          DatabaseName = 'D:\MYPROJECT\WAGECLIENTMT\BASE'
          TableName = 'Plat.DBF'
          Left = 64
          Top = 64
        end
      end
      object ToolBar1: TToolBar
        Left = 0
        Top = 0
        Width = 551
        Height = 26
        AutoSize = True
        Caption = 'tlbModal'
        Color = clBtnFace
        EdgeBorders = [ebTop, ebBottom]
        Flat = True
        Images = DM.imgMain
        List = True
        ParentColor = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        object tlbClose: TToolButton
          Left = 0
          Top = 0
          Action = actClose
        end
        object ToolButton8: TToolButton
          Left = 23
          Top = 0
          Width = 8
          Caption = 'ToolButton6'
          ImageIndex = 4
          Style = tbsSeparator
        end
        object ToolButton9: TToolButton
          Left = 31
          Top = 0
          Action = actNew
        end
        object ToolButton18: TToolButton
          Left = 54
          Top = 0
          Action = actNewC
        end
        object ToolButton10: TToolButton
          Left = 77
          Top = 0
          Action = actEdit
        end
        object ToolButton11: TToolButton
          Left = 100
          Top = 0
          Action = actDel
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = #1053#1072#1095#1080#1089#1083#1077#1085#1085#1099#1077' '#1089#1091#1084#1084#1099
      ImageIndex = 1
      object ToolBar2: TToolBar
        Left = 0
        Top = 0
        Width = 551
        Height = 26
        AutoSize = True
        Caption = 'tlbModal'
        Color = clBtnFace
        EdgeBorders = [ebTop, ebBottom]
        Flat = True
        Images = DM.imgMain
        List = True
        ParentColor = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        object ToolButton16: TToolButton
          Left = 0
          Top = 0
          Action = actClose
        end
        object ToolButton17: TToolButton
          Left = 23
          Top = 0
          Width = 8
          Caption = 'ToolButton17'
          ImageIndex = 82
          Style = tbsSeparator
        end
        object ToolButton3: TToolButton
          Left = 31
          Top = 0
          Action = actNewN
        end
        object ToolButton15: TToolButton
          Left = 54
          Top = 0
          Action = actNewNC
        end
        object ToolButton4: TToolButton
          Left = 77
          Top = 0
          Action = actEditN
        end
        object ToolButton5: TToolButton
          Left = 100
          Top = 0
          Action = actDelN
        end
        object ToolButton6: TToolButton
          Left = 123
          Top = 0
          Width = 76
          Caption = 'ToolButton6'
          ImageIndex = 5
          Style = tbsSeparator
        end
        object ToolButton7: TToolButton
          Left = 199
          Top = 0
          Action = actMakeMT
        end
        object ToolButton13: TToolButton
          Left = 222
          Top = 0
          Width = 61
          Caption = 'ToolButton13'
          ImageIndex = 76
          Style = tbsSeparator
        end
        object ToolButton19: TToolButton
          Left = 283
          Top = 0
          Action = actMakeRtf
        end
        object ToolButton20: TToolButton
          Left = 306
          Top = 0
          Width = 8
          Caption = 'ToolButton20'
          ImageIndex = 82
          Style = tbsSeparator
        end
        object ToolButton21: TToolButton
          Left = 314
          Top = 0
          Action = actPodgon
        end
        object ToolButton22: TToolButton
          Left = 337
          Top = 0
          Width = 8
          Caption = 'ToolButton22'
          ImageIndex = 82
          Style = tbsSeparator
        end
        object ToolButton12: TToolButton
          Left = 345
          Top = 0
          Action = actSetSum
        end
        object ToolButton1: TToolButton
          Left = 368
          Top = 0
          Action = actDelAmount
        end
        object ToolButton2: TToolButton
          Left = 391
          Top = 0
          Action = actComAmount
        end
        object ToolButton14: TToolButton
          Left = 414
          Top = 0
          Caption = 'ToolButton14'
          DropdownMenu = popModal
          ImageIndex = 81
          Style = tbsDropDown
        end
      end
      inline frmNach: TfrmGrid
        Left = 0
        Top = 26
        Width = 551
        Height = 193
        Align = alClient
        TabOrder = 1
        inherited pnlMain: TPanel
          Width = 551
          Height = 174
          inherited pnlMainLeft: TPanel
            Width = 551
            Height = 174
            inherited pnlFilter: TPanel
              Width = 551
            end
            inherited grdGrid: TdxDBGrid
              Width = 551
              Height = 151
              KeyField = 'ID'
              OnDblClick = actEditNExecute
              Filter.Criteria = {00000000}
            end
          end
        end
        inherited stbGrid: TStatusBar
          Top = 174
          Width = 551
        end
        inherited actGrid: TActionList
          inherited actSaveToDbfFilter: TAction
            Enabled = True
          end
        end
        inherited hdsGrid: THalcyonDataSet
          DatabaseName = 'D:\MYPROJECT\WAGECLIENTMT\BASE'
          TableName = 'doc_6486.DBF'
        end
      end
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 273
    Width = 559
    Height = 15
    Align = alBottom
    Alignment = taLeftJustify
    BevelOuter = bvNone
    TabOrder = 3
    object Label1: TLabel
      Left = 4
      Top = 1
      Width = 35
      Height = 13
      Caption = #8470' '#1076#1086#1082'.'
    end
    object DBText1: TDBText
      Left = 44
      Top = 1
      Width = 69
      Height = 17
      DataField = 'DOC_NUM'
      DataSource = frmPlat.dsrGrid
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clPurple
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 116
      Top = 1
      Width = 49
      Height = 13
      Caption = #1044#1072#1090#1072' '#1088#1077#1075'.'
    end
    object DBText2: TDBText
      Left = 168
      Top = 1
      Width = 57
      Height = 17
      DataField = 'DOC_DATE'
      DataSource = frmPlat.dsrGrid
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clPurple
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 229
      Top = 1
      Width = 34
      Height = 13
      Caption = #1057#1091#1084#1084#1072
    end
    object DBText3: TDBText
      Left = 267
      Top = 1
      Width = 86
      Height = 17
      Alignment = taRightJustify
      DataField = 'AMOUNT'
      DataSource = frmPlat.dsrGrid
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 358
      Top = 1
      Width = 33
      Height = 13
      Caption = #1055#1086#1083#1091#1095'.'
    end
    object DBText4: TDBText
      Left = 396
      Top = 1
      Width = 133
      Height = 17
      DataField = 'NAME1'
      DataSource = frmPlat.dsrGrid
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clPurple
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
  end
  inherited actModal: TActionList
    Left = 376
    Top = 188
    inherited actClose: TAction
      ShortCut = 113
    end
    object actNew: TAction
      Category = 'Plat'
      Caption = #1057#1086#1079#1076#1072#1090#1100
      Hint = #1057#1086#1079#1076#1072#1090#1100
      ImageIndex = 73
      OnExecute = actNewExecute
    end
    object actEdit: TAction
      Category = 'Plat'
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      ImageIndex = 72
      OnExecute = actEditExecute
    end
    object actDel: TAction
      Category = 'Plat'
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Hint = #1059#1076#1072#1083#1080#1090#1100
      ImageIndex = 6
      OnExecute = actDelExecute
    end
    object actNewN: TAction
      Category = 'Nach'
      Caption = #1057#1086#1079#1076#1072#1090#1100
      Hint = #1057#1086#1079#1076#1072#1090#1100' '#1085#1072#1095#1080#1089#1083#1077#1085#1080#1077
      ImageIndex = 7
      ShortCut = 45
      OnExecute = actNewNExecute
    end
    object actEditN: TAction
      Category = 'Nach'
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100' '#1085#1072#1095#1080#1089#1083#1077#1085#1080#1077
      ImageIndex = 72
      ShortCut = 115
      OnExecute = actEditNExecute
    end
    object actDelN: TAction
      Category = 'Nach'
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1085#1072#1095#1080#1089#1083#1077#1085#1080#1077
      ImageIndex = 6
      ShortCut = 46
      OnExecute = actDelNExecute
    end
    object actMakeMT: TAction
      Category = 'Nach'
      Caption = #1057#1086#1079#1076#1072#1090#1100' '#1092#1072#1081#1083' '#1092#1086#1088#1084#1072#1090#1072' '#1052#1058'102'
      Hint = #1057#1086#1079#1076#1072#1090#1100' '#1092#1072#1081#1083' '#1092#1086#1088#1084#1072#1090#1072' '#1052#1058'102'
      ImageIndex = 147
      OnExecute = actMakeMTExecute
    end
    object actImportE2b: TAction
      Category = 'Import'
      Caption = #1048#1084#1087#1086#1088#1090' e2b '#1092#1072#1081#1083#1072
      Hint = #1048#1084#1087#1086#1088#1090' e2b '#1092#1072#1081#1083#1072
      ImageIndex = 81
      OnExecute = actImportE2bExecute
    end
    object actSetSum: TAction
      Category = 'Nach'
      Caption = #1057#1091#1084#1084#1072' '#1087#1086' '#1092#1080#1083#1100#1090#1088#1091
      Hint = #1059#1089#1090#1072#1085#1086#1074#1082#1072' '#1089#1091#1084#1084#1099' '#1087#1086' '#1092#1080#1083#1100#1090#1088#1091' '#1076#1083#1103' '#1074#1099#1073#1088#1072#1085#1085#1099#1093' '#1089#1086#1090#1088#1091#1076#1085#1080#1082#1086#1074
      ImageIndex = 75
      OnExecute = actSetSumExecute
    end
    object actDelAmount: TAction
      Category = 'Nach'
      Caption = #1059#1076#1072#1083#1077#1085#1080#1077' '#1087#1086' '#1092#1080#1083#1100#1090#1088#1091
      Hint = #1059#1076#1072#1083#1077#1085#1080#1077' '#1087#1086' '#1092#1080#1083#1100#1090#1088#1091
      ImageIndex = 113
      OnExecute = actDelAmountExecute
    end
    object actComAmount: TAction
      Category = 'Nach'
      Caption = #1057#1085#1103#1090#1100' '#1082#1086#1084#1084#1080#1089#1080#1102
      Hint = #1057#1085#1103#1090#1100' '#1082#1086#1084#1084#1080#1089#1080#1102' '#1087#1086' '#1092#1080#1083#1100#1090#1088#1091
      ImageIndex = 174
      OnExecute = actComAmountExecute
    end
    object actNewNC: TAction
      Category = 'Nach'
      Caption = #1057#1086#1079#1076#1072#1090#1100' '#1087#1086' '#1082#1086#1087#1080#1080
      Hint = #1057#1086#1079#1076#1072#1090#1100' '#1087#1086' '#1082#1086#1087#1080#1080
      ImageIndex = 124
      ShortCut = 8237
      OnExecute = actNewNCExecute
    end
    object actMakeE2b: TAction
      Category = 'Nach'
      Caption = #1057#1086#1079#1076#1072#1090#1100' e2b '#1092#1072#1081#1083
      ImageIndex = 74
      OnExecute = actMakeE2bExecute
    end
    object actNewC: TAction
      Category = 'Plat'
      Caption = #1057#1086#1079#1076#1072#1090#1100' '#1087#1086' '#1082#1086#1087#1080#1080
      Hint = #1057#1086#1079#1076#1072#1090#1100' '#1087#1086' '#1082#1086#1087#1080#1080
      ImageIndex = 124
      OnExecute = actNewCExecute
    end
    object actImpNach: TAction
      Category = 'Import'
      Caption = #1048#1084#1087#1086#1088#1090' '#1092#1072#1081#1083#1072' '#1085#1072#1095#1080#1089#1083'. dbf'
      Hint = #1048#1084#1087#1086#1088#1090' '#1092#1072#1081#1083#1072' '#1085#1072#1095#1080#1089#1083#1077#1085#1080#1081' dbf'
      ImageIndex = 81
      OnExecute = actImpNachExecute
    end
    object actImp102: TAction
      Category = 'Import'
      Caption = #1048#1084#1087#1086#1088#1090' '#1085#1072#1095#1080#1089#1083'. '#1080#1079' '#1092#1072#1081#1083#1072' 102'
      Hint = #1048#1084#1087#1086#1088#1090' '#1085#1072#1095#1080#1089#1083'. '#1080#1079' '#1092#1072#1081#1083#1072' 102'
      ImageIndex = 81
      OnExecute = actImp102Execute
    end
    object actMakeRtf: TAction
      Category = 'Nach'
      Caption = #1057#1086#1079#1076#1072#1090#1100' '#1086#1090#1095#1077#1090
      Hint = #1057#1086#1079#1076#1072#1090#1100' '#1086#1090#1095#1077#1090
      ImageIndex = 46
      OnExecute = actMakeRtfExecute
    end
    object actPodgon: TAction
      Category = 'Nach'
      Caption = #1055#1086#1076#1086#1075#1085#1072#1090#1100' '#1056#1053#1053
      Hint = #1055#1086#1076#1086#1075#1085#1072#1090#1100' '#1056#1053#1053
      ImageIndex = 129
      OnExecute = actPodgonExecute
    end
  end
  inherited strModal: TFormStorage
    Active = False
    Left = 300
    Top = 120
  end
  inherited popModal: TPopupMenu
    Left = 376
    Top = 128
    object N1: TMenuItem
      Action = actImpNach
    end
    object N1021: TMenuItem
      Action = actImp102
    end
    object e2b1: TMenuItem
      Caption = 'e2b '#1092#1086#1088#1084#1072#1090
      object actImportE2b1: TMenuItem
        Action = actImportE2b
      end
      object e2b2: TMenuItem
        Action = actMakeE2b
      end
    end
  end
end
