inherited fmNachEdit: TfmNachEdit
  Left = 316
  Top = 225
  Width = 280
  Height = 252
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel [0]
    Left = 12
    Top = 40
    Width = 49
    Height = 13
    Caption = #1060#1072#1084#1080#1083#1080#1103
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel [1]
    Left = 36
    Top = 68
    Width = 22
    Height = 13
    Caption = #1048#1084#1103
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel [2]
    Left = 12
    Top = 96
    Width = 47
    Height = 13
    Caption = #1054#1090#1095#1077#1089#1090#1074#1086
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel [3]
    Left = 36
    Top = 124
    Width = 23
    Height = 13
    Caption = #1056#1053#1053
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel [4]
    Left = 36
    Top = 152
    Width = 23
    Height = 13
    Caption = #1057#1095#1077#1090
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label6: TLabel [5]
    Left = 8
    Top = 180
    Width = 51
    Height = 13
    Caption = #1058#1072#1073#1077#1083#1100' '#8470
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  inherited stbModal: TStatusBar
    Top = 206
    Width = 272
  end
  inherited tlbModal: TToolBar
    Width = 272
    Height = 26
    TabOrder = 6
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
  object dbeFM: TDBEdit [8]
    Left = 68
    Top = 36
    Width = 193
    Height = 21
    CharCase = ecUpperCase
    DataField = 'FM'
    DataSource = fmNach.dsrNachEdit
    TabOrder = 0
  end
  object DBEdit2: TDBEdit [9]
    Left = 68
    Top = 64
    Width = 193
    Height = 21
    CharCase = ecUpperCase
    DataField = 'NM'
    DataSource = fmNach.dsrNachEdit
    TabOrder = 1
  end
  object DBEdit3: TDBEdit [10]
    Left = 68
    Top = 92
    Width = 193
    Height = 21
    CharCase = ecUpperCase
    DataField = 'FT'
    DataSource = fmNach.dsrNachEdit
    TabOrder = 2
  end
  object DBEdit4: TDBEdit [11]
    Left = 68
    Top = 120
    Width = 121
    Height = 21
    CharCase = ecUpperCase
    DataField = 'RNN'
    DataSource = fmNach.dsrNachEdit
    TabOrder = 3
    OnKeyPress = DBEdit4KeyPress
  end
  object DBEdit5: TDBEdit [12]
    Left = 68
    Top = 148
    Width = 153
    Height = 21
    CharCase = ecUpperCase
    DataField = 'LA'
    DataSource = fmNach.dsrNachEdit
    MaxLength = 12
    TabOrder = 4
    OnKeyPress = DBEdit4KeyPress
  end
  object DBEdit1: TDBEdit [13]
    Left = 68
    Top = 176
    Width = 121
    Height = 21
    CharCase = ecUpperCase
    DataField = 'TAB_NUM'
    DataSource = fmNach.dsrNachEdit
    MaxLength = 12
    TabOrder = 5
    OnKeyPress = DBEdit4KeyPress
  end
end
