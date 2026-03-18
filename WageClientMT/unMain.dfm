inherited fmMain: TfmMain
  Left = 294
  Top = 108
  Width = 461
  Height = 198
  Caption = 'WageClientMT'
  Color = clGray
  FormStyle = fsMDIForm
  Menu = menMain
  WindowMenu = window
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited stbModal: TStatusBar
    Top = 133
    Width = 453
    Panels = <
      item
        Width = 180
      end
      item
        Width = 50
      end
      item
        Width = 150
      end
      item
        Width = 150
      end
      item
        Width = 50
      end>
  end
  inherited tlbModal: TToolBar
    Width = 453
    Height = 26
    object ToolButton1: TToolButton
      Left = 0
      Top = 0
      Action = actExit
    end
    object ToolButton2: TToolButton
      Left = 23
      Top = 0
      Width = 78
      Caption = 'ToolButton2'
      ImageIndex = 53
      Style = tbsSeparator
    end
    object ToolButton3: TToolButton
      Left = 101
      Top = 0
      Action = actPlat
    end
    object ToolButton5: TToolButton
      Left = 124
      Top = 0
      Width = 8
      Caption = 'ToolButton5'
      ImageIndex = 96
      Style = tbsSeparator
    end
    object ToolButton4: TToolButton
      Left = 132
      Top = 0
      Action = actLico
    end
    object ToolButton7: TToolButton
      Left = 155
      Top = 0
      Width = 50
      Caption = 'ToolButton7'
      ImageIndex = 97
      Style = tbsSeparator
    end
    object ToolButton6: TToolButton
      Left = 205
      Top = 0
      Action = actTools
    end
  end
  inherited actModal: TActionList
    Left = 148
    Top = 32
    inherited actOk: TAction
      Visible = False
    end
    inherited actCancel: TAction
      Visible = False
    end
    object actExit: TAction
      Category = 'Main'
      Caption = #1042#1099#1093#1086#1076
      Hint = #1042#1099#1093#1086#1076' '#1080#1079' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
      ImageIndex = 64
      OnExecute = actExitExecute
    end
    object actWinClose: TWindowClose
      Category = 'Window'
      Caption = #1047#1072#1082#1088#1099#1090#1100
      Enabled = False
      Hint = #1047#1072#1082#1088#1099#1090#1100' '#1086#1082#1085#1086
      ImageIndex = 60
    end
    object actWinCascade: TWindowCascade
      Category = 'Window'
      Caption = #1050#1072#1089#1082#1072#1076#1085#1086
      Enabled = False
      Hint = #1050#1072#1089#1082#1072#1076#1085#1086
      ImageIndex = 179
    end
    object actWinTitleHoriz: TWindowTileHorizontal
      Category = 'Window'
      Caption = #1043#1086#1088#1080#1079#1086#1085#1090#1072#1083#1100#1085#1086
      Enabled = False
      Hint = #1043#1086#1088#1080#1079#1086#1085#1090#1072#1083#1100#1085#1086
      ImageIndex = 180
    end
    object actWinTitleVert: TWindowTileVertical
      Category = 'Window'
      Caption = #1042#1077#1088#1090#1080#1082#1072#1083#1100#1085#1086
      Enabled = False
      Hint = #1042#1077#1088#1090#1080#1082#1072#1083#1100#1085#1086
      ImageIndex = 181
    end
    object actWinMinAll: TWindowMinimizeAll
      Category = 'Window'
      Caption = #1057#1074#1077#1088#1085#1091#1090#1100' '#1074#1089#1077
      Enabled = False
      Hint = #1057#1074#1077#1088#1085#1091#1090#1100' '#1074#1089#1077
    end
    object actWinArrange: TWindowArrange
      Category = 'Window'
      Caption = #1059#1087#1086#1088#1103#1076#1086#1095#1080#1090#1100' '#1089#1074#1077#1088#1085#1091#1090#1086#1077
      Enabled = False
      Hint = #1059#1087#1086#1088#1103#1076#1086#1095#1080#1090#1100' '#1089#1074#1077#1088#1085#1091#1090#1086#1077
    end
    object actAbout: TAction
      Category = 'Main'
      Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
      OnExecute = actAboutExecute
    end
    object actHelp: TAction
      Category = 'Main'
      Caption = #1055#1086#1084#1086#1097#1100
      ImageIndex = 41
      OnExecute = actHelpExecute
    end
    object actCloseAll: TAction
      Category = 'Window'
      Caption = #1047#1072#1082#1088#1099#1090#1100' '#1074#1089#1077
      Hint = #1047#1072#1082#1088#1099#1090#1100' '#1074#1089#1077
      OnExecute = actCloseAllExecute
    end
    object actLico: TAction
      Category = 'SP'
      Caption = #1070#1088#1080#1076#1080#1095#1077#1089#1080#1082#1080#1077' '#1083#1080#1094#1072
      Hint = #1070#1088#1080#1076#1080#1095#1077#1089#1080#1082#1080#1077' '#1083#1080#1094#1072
      ImageIndex = 95
      OnExecute = actLicoExecute
    end
    object actTools: TAction
      Category = 'Main'
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
      Hint = #1053#1072#1089#1090#1088#1086#1081#1082#1080
      ImageIndex = 71
      OnExecute = actToolsExecute
    end
    object actPlat: TAction
      Category = 'SP'
      Caption = #1055#1083#1072#1090#1077#1078#1080
      Hint = #1055#1083#1072#1090#1077#1078#1080
      ImageIndex = 74
      OnExecute = actPlatExecute
    end
  end
  inherited strModal: TFormStorage
    Options = [fpPosition]
    Left = 308
    Top = 32
  end
  inherited popModal: TPopupMenu
    Left = 344
    Top = 32
  end
  object menMain: TMainMenu
    Images = DM.imgMain
    Left = 200
    Top = 32
    object N1: TMenuItem
      Caption = #1060#1072#1081#1083
      object N5: TMenuItem
        Action = actExit
      end
    end
    object N4: TMenuItem
      Caption = #1057#1077#1088#1074#1080#1089
      GroupIndex = 3
      object N12: TMenuItem
        Action = actPlat
      end
      object N13: TMenuItem
        Caption = '-'
      end
      object N11: TMenuItem
        Action = actTools
      end
    end
    object N2: TMenuItem
      Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      GroupIndex = 3
      object N3: TMenuItem
        Action = actLico
      end
    end
    object window: TMenuItem
      Caption = #1054#1082#1085#1086
      GroupIndex = 4
      object Close1: TMenuItem
        Action = actWinClose
      end
      object Arrange1: TMenuItem
        Action = actWinArrange
      end
      object Cascade1: TMenuItem
        Action = actWinCascade
      end
      object MinimizeAll1: TMenuItem
        Action = actWinMinAll
      end
      object ileHorizontally1: TMenuItem
        Action = actWinTitleHoriz
      end
      object ileVertically1: TMenuItem
        Action = actWinTitleVert
      end
      object N10: TMenuItem
        Action = actCloseAll
      end
    end
    object N6: TMenuItem
      Caption = '?'
      GroupIndex = 5
      object N9: TMenuItem
        Action = actHelp
      end
      object N8: TMenuItem
        Caption = '-'
      end
      object N7: TMenuItem
        Action = actAbout
      end
    end
  end
end
