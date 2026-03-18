inherited fmTools: TfmTools
  Left = 407
  Top = 204
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsToolWindow
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
  ClientHeight = 348
  ClientWidth = 479
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited stbModal: TStatusBar
    Top = 329
    Width = 479
  end
  object pgcTools: TPageControl [1]
    Left = 0
    Top = 26
    Width = 479
    Height = 303
    ActivePage = TabSheet2
    Align = alClient
    TabIndex = 0
    TabOrder = 2
    object TabSheet2: TTabSheet
      Caption = #1060#1072#1081#1083#1099
      ImageIndex = 2
      object GroupBox2: TGroupBox
        Left = 0
        Top = 0
        Width = 471
        Height = 45
        Align = alTop
        Caption = #1041#1072#1079#1099' '#1076#1072#1085#1085#1099#1093
        TabOrder = 0
        object dedBase: TDirectoryEdit
          Left = 9
          Top = 16
          Width = 300
          Height = 21
          InitialDir = 'C:'
          NumGlyphs = 1
          TabOrder = 0
        end
      end
      object GroupBox3: TGroupBox
        Left = 0
        Top = 45
        Width = 471
        Height = 112
        Align = alTop
        Caption = #1042#1099#1093#1086#1076#1085#1099#1077' '#1092#1072#1081#1083#1099
        TabOrder = 1
        object Label5: TLabel
          Left = 8
          Top = 20
          Width = 204
          Height = 13
          Caption = #1055#1072#1087#1082#1072' '#1089#1075#1077#1085#1077#1088#1080#1088#1086#1074#1072#1085#1085#1099#1093' '#1092#1072#1081#1083#1086#1074' ZP102:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label3: TLabel
          Left = 8
          Top = 64
          Width = 96
          Height = 13
          Caption = #1055#1072#1087#1082#1072' '#1086#1090#1095#1077#1090#1086#1074' *.rtf:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object dedZP102: TDirectoryEdit
          Left = 9
          Top = 36
          Width = 300
          Height = 21
          InitialDir = 'C:'
          NumGlyphs = 1
          TabOrder = 0
        end
        object dedRtf: TDirectoryEdit
          Left = 9
          Top = 80
          Width = 300
          Height = 21
          InitialDir = 'C:'
          NumGlyphs = 1
          TabOrder = 1
        end
      end
      object GroupBox4: TGroupBox
        Left = 0
        Top = 157
        Width = 471
        Height = 118
        Align = alClient
        Caption = #1048#1084#1087#1086#1088#1090' '#1092#1072#1081#1083#1086#1074
        TabOrder = 2
        object Label12: TLabel
          Left = 8
          Top = 20
          Width = 143
          Height = 13
          Caption = #1055#1072#1087#1082#1072' '#1076#1083#1103' '#1080#1084#1087#1086#1088#1090#1072' '#1092#1072#1081#1083#1086#1074':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label13: TLabel
          Left = 8
          Top = 64
          Width = 147
          Height = 13
          Caption = #1055#1072#1087#1082#1072' '#1076#1083#1103' '#1101#1082#1089#1087#1086#1088#1090#1072' '#1092#1072#1081#1083#1086#1074':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object dedClientImp: TDirectoryEdit
          Left = 9
          Top = 36
          Width = 300
          Height = 21
          InitialDir = 'C:'
          NumGlyphs = 1
          TabOrder = 0
        end
        object dedClientExp: TDirectoryEdit
          Left = 9
          Top = 80
          Width = 300
          Height = 21
          InitialDir = 'C:'
          NumGlyphs = 1
          TabOrder = 1
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = #1050#1072#1088#1090#1086#1095#1082#1080
      ImageIndex = 2
      object GroupBox5: TGroupBox
        Left = 0
        Top = 0
        Width = 471
        Height = 275
        Align = alClient
        TabOrder = 0
        object Label6: TLabel
          Left = 8
          Top = 20
          Width = 70
          Height = 13
          Caption = #1041#1048#1053' '#1092#1080#1083#1080#1072#1083#1072
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label1: TLabel
          Left = 20
          Top = 48
          Width = 61
          Height = 13
          Caption = #1050#1086#1076' '#1087#1088#1077#1076#1087#1088'.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object edtBin: TEdit
          Left = 88
          Top = 16
          Width = 37
          Height = 21
          MaxLength = 3
          TabOrder = 0
          OnExit = edtBinExit
          OnKeyPress = edtPredCodeKeyPress
        end
        object edtPredCode: TEdit
          Left = 88
          Top = 44
          Width = 69
          Height = 21
          MaxLength = 9
          TabOrder = 1
          OnExit = edtPredCodeExit
          OnKeyPress = edtPredCodeKeyPress
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = #1042#1080#1076' '#1087#1088#1086#1077#1082#1090#1072
      ImageIndex = 3
      object pnlVid: TPanel
        Left = 0
        Top = 0
        Width = 471
        Height = 275
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        object rgpProject: TRadioGroup
          Left = 12
          Top = 8
          Width = 253
          Height = 73
          ItemIndex = 0
          Items.Strings = (
            #1053#1072#1095#1080#1089#1083#1077#1085#1080#1077' '#1079#1072#1088#1087#1083#1072#1090#1099' '#1085#1072' '#1082#1072#1088#1090#1086#1095#1082#1080
            #1053#1072#1095#1080#1089#1083#1077#1085#1080#1077' '#1076#1080#1074#1080#1076#1077#1085#1076#1086#1074)
          TabOrder = 0
        end
      end
    end
    object TabSheet1: TTabSheet
      Caption = #1057#1077#1088#1074#1080#1089
      ImageIndex = 3
      object GroupBox1: TGroupBox
        Left = 0
        Top = 0
        Width = 471
        Height = 275
        Align = alClient
        TabOrder = 0
        object chbBic: TCheckBox
          Left = 8
          Top = 20
          Width = 197
          Height = 17
          Alignment = taLeftJustify
          Caption = #1050#1083#1102#1095#1077#1074#1072#1090#1100' '#8470' '#1089#1095#1077#1090#1072' '#1089' '#1041#1048#1050' '#1073#1072#1085#1082#1072
          Checked = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          State = cbChecked
          TabOrder = 0
        end
        object chbLa: TCheckBox
          Left = 8
          Top = 44
          Width = 197
          Height = 17
          Alignment = taLeftJustify
          Caption = #1057#1095#1077#1090#1072' '#1090#1086#1083#1100#1082#1086' '#1094#1080#1092#1088#1086#1074#1099#1077
          Checked = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          State = cbChecked
          TabOrder = 1
        end
      end
    end
    object TabSheet5: TTabSheet
      Caption = #1054#1090#1095#1077#1090
      ImageIndex = 4
      object GroupBox6: TGroupBox
        Left = 0
        Top = 0
        Width = 471
        Height = 275
        Align = alClient
        TabOrder = 0
        object Label2: TLabel
          Left = 44
          Top = 20
          Width = 79
          Height = 13
          Caption = #1050#1086#1083'-'#1074#1086' '#1082#1086#1083#1086#1085#1086#1082
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label4: TLabel
          Left = 8
          Top = 52
          Width = 114
          Height = 13
          Caption = #1044#1086#1083#1078#1085#1086#1089#1090#1100' '#1076#1080#1088#1077#1082#1090#1086#1088#1072
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label7: TLabel
          Left = 8
          Top = 80
          Width = 117
          Height = 13
          Caption = #1044#1086#1083#1078#1085#1086#1089#1090#1100' '#1073#1091#1093#1075#1072#1083#1090#1077#1088#1072
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object spdClmCount: TSpinEdit
          Left = 132
          Top = 16
          Width = 45
          Height = 22
          MaxLength = 1
          MaxValue = 8
          MinValue = 1
          TabOrder = 0
          Value = 5
        end
        object edtChief: TEdit
          Left = 132
          Top = 48
          Width = 209
          Height = 21
          TabOrder = 1
          Text = #1044#1080#1088#1077#1082#1090#1086#1088
        end
        object edtMainBK: TEdit
          Left = 132
          Top = 76
          Width = 209
          Height = 21
          TabOrder = 2
          Text = #1043#1083'. '#1073#1091#1093#1075#1072#1083#1090#1077#1088
        end
      end
    end
  end
  inherited tlbModal: TToolBar
    Width = 479
    Height = 26
    List = False
    object ToolButton1: TToolButton
      Left = 0
      Top = 0
      Action = actOk
    end
  end
  inherited actModal: TActionList
    Left = 328
    Top = 8
  end
  inherited strModal: TFormStorage
    StoredProps.Strings = (
      'dedBase.Text'
      'dedClientExp.Text'
      'dedClientImp.Text'
      'dedRtf.Text'
      'dedZP102.Text'
      'edtBin.Text'
      'rgpProject.ItemIndex'
      'edtPredCode.Text'
      'chbBic.Checked'
      'spdClmCount.Value'
      'edtChief.Text'
      'edtMainBK.Text'
      'chbLa.Checked')
    Left = 396
    Top = 4
  end
  inherited popModal: TPopupMenu
    Left = 260
    Top = 12
  end
end
