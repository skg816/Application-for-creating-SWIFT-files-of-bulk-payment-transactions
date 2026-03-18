inherited fmLico: TfmLico
  Left = 301
  Top = 109
  Width = 507
  Height = 244
  Caption = #1070#1088#1080#1076#1080#1095#1077#1089#1082#1080#1077' '#1083#1080#1094#1072
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited stbModal: TStatusBar
    Top = 198
    Width = 499
    Visible = False
  end
  inherited tlbModal: TToolBar
    Width = 499
    Height = 26
    object tlbClose: TToolButton
      Left = 0
      Top = 0
      Action = actClose
    end
    object ToolButton5: TToolButton
      Left = 23
      Top = 0
      Width = 8
      Caption = 'ToolButton5'
      ImageIndex = 8
      Style = tbsSeparator
    end
    object tlb11: TToolButton
      Left = 31
      Top = 0
      Action = actNew
    end
    object ToolButton2: TToolButton
      Left = 54
      Top = 0
      Action = actEdit
    end
    object ToolButton3: TToolButton
      Left = 77
      Top = 0
      Action = actDel
    end
    object ToolButton4: TToolButton
      Left = 100
      Top = 0
      Width = 49
      Caption = 'ToolButton4'
      ImageIndex = 7
      Style = tbsSeparator
    end
    object rgbReceiv: TRadioButton
      Left = 149
      Top = 0
      Width = 108
      Height = 22
      Hint = '1'
      Caption = #1055#1086#1083#1091#1095#1072#1090#1077#1083#1080
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      TabStop = True
      OnClick = rgbReceivClick
    end
    object rgbSend: TRadioButton
      Left = 257
      Top = 0
      Width = 108
      Height = 22
      Hint = '0'
      Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1077#1083#1080
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = rgbReceivClick
    end
  end
  inline frmLico: TfrmGrid [2]
    Left = 0
    Top = 26
    Width = 499
    Height = 172
    Align = alClient
    TabOrder = 2
    inherited pnlMain: TPanel
      Width = 499
      Height = 153
      inherited pnlMainLeft: TPanel
        Width = 499
        Height = 153
        inherited pnlFilter: TPanel
          Width = 499
        end
        inherited grdGrid: TdxDBGrid
          Width = 499
          Height = 130
          KeyField = 'ID'
          OnDblClick = actEditExecute
          Filter.Criteria = {00000000}
        end
      end
    end
    inherited stbGrid: TStatusBar
      Top = 153
      Width = 499
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
      TableName = 'lico.DBF'
      Left = 64
      Top = 64
    end
  end
  inherited actModal: TActionList [3]
    Left = 260
    Top = 80
    inherited actClose: TAction
      ShortCut = 113
    end
    object actNew: TAction
      Caption = #1057#1086#1079#1076#1072#1090#1100
      Hint = #1057#1086#1079#1076#1072#1090#1100
      ImageIndex = 73
      ShortCut = 45
      OnExecute = actNewExecute
    end
    object actEdit: TAction
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      ImageIndex = 72
      ShortCut = 115
      OnExecute = actEditExecute
    end
    object actDel: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Hint = #1059#1076#1072#1083#1080#1090#1100
      ImageIndex = 6
      ShortCut = 46
      OnExecute = actDelExecute
    end
  end
  inherited strModal: TFormStorage [4]
    Active = False
    Left = 308
    Top = 80
  end
  inherited popModal: TPopupMenu
    Left = 356
    Top = 80
  end
end
