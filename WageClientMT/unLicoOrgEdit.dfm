inherited fmLicoOrgEdit: TfmLicoOrgEdit
  Left = 204
  Top = 248
  Width = 535
  Height = 197
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel [0]
    Left = 8
    Top = 40
    Width = 76
    Height = 13
    Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel [1]
    Left = 368
    Top = 68
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
  object Label5: TLabel [2]
    Left = 216
    Top = 68
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
  object Label6: TLabel [3]
    Left = 32
    Top = 68
    Width = 56
    Height = 13
    Caption = #1041#1048#1050' '#1041#1072#1085#1082#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label7: TLabel [4]
    Left = 252
    Top = 96
    Width = 66
    Height = 13
    Caption = #1056#1077#1079#1080#1076#1077#1085#1089#1090#1074#1086
  end
  object Label8: TLabel [5]
    Left = 252
    Top = 124
    Width = 66
    Height = 13
    Caption = #1057#1077#1082#1090#1086#1088' '#1101#1082#1086#1085'.'
  end
  inherited stbModal: TStatusBar
    Top = 151
    Width = 527
  end
  inherited tlbModal: TToolBar
    Width = 527
    Height = 26
    TabOrder = 7
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
  object dbeNAME: TDBEdit [8]
    Left = 92
    Top = 36
    Width = 425
    Height = 21
    DataField = 'NAME'
    DataSource = dsrFrom
    TabOrder = 0
  end
  object DBEdit4: TDBEdit [9]
    Left = 396
    Top = 64
    Width = 121
    Height = 21
    DataField = 'RNN'
    DataSource = dsrFrom
    TabOrder = 3
    OnKeyPress = DBEdit5KeyPress
  end
  object DBEdit5: TDBEdit [10]
    Left = 244
    Top = 64
    Width = 120
    Height = 21
    DataField = 'ACCOUNT'
    DataSource = dsrFrom
    MaxLength = 9
    TabOrder = 2
    OnKeyPress = DBEdit5KeyPress
  end
  object DBEdit6: TDBEdit [11]
    Left = 92
    Top = 64
    Width = 120
    Height = 21
    DataField = 'BIC'
    DataSource = dsrFrom
    MaxLength = 9
    TabOrder = 1
    OnKeyPress = DBEdit5KeyPress
  end
  object DBRadioGroup1: TDBRadioGroup [12]
    Left = 324
    Top = 88
    Width = 193
    Height = 29
    Columns = 2
    DataField = 'IRS'
    DataSource = dsrFrom
    Items.Strings = (
      #1056#1077#1079#1080#1076#1077#1085#1090
      #1053#1077' '#1088#1077#1079#1080#1076#1077#1085#1090)
    TabOrder = 5
    Values.Strings = (
      '1'
      '2')
  end
  object lcbDict: TRxDBLookupCombo [13]
    Left = 324
    Top = 120
    Width = 193
    Height = 21
    DropDownCount = 15
    DropDownWidth = 300
    Color = clInfoBk
    DataField = 'SECO'
    DataSource = dsrFrom
    FieldsDelimiter = '-'
    ListStyle = lsDelimited
    LookupField = 'CODE'
    LookupDisplay = 'CODE;SHORT_NAME'
    LookupDisplayIndex = 1
    LookupSource = dsrDict
    TabOrder = 6
    OnKeyDown = lcbDictKeyDown
  end
  object pnlFio: TPanel [14]
    Left = 16
    Top = 92
    Width = 237
    Height = 49
    BevelOuter = bvNone
    TabOrder = 4
    object Label2: TLabel
      Left = 8
      Top = 4
      Width = 62
      Height = 13
      Caption = #1060#1048#1054' '#1088#1091#1082#1086#1074'.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 4
      Top = 32
      Width = 66
      Height = 13
      Caption = #1060#1048#1054' '#1075#1083'. '#1073#1091#1093'.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object DBEdit2: TDBEdit
      Left = 76
      Top = 0
      Width = 153
      Height = 21
      DataField = 'CHIEF'
      DataSource = dsrFrom
      TabOrder = 0
    end
    object DBEdit3: TDBEdit
      Left = 76
      Top = 28
      Width = 153
      Height = 21
      DataField = 'MAINBK'
      DataSource = dsrFrom
      TabOrder = 1
    end
  end
  object hdsDict: THalcyonDataSet
    AutoCalcFields = False
    AutoFlush = False
    DatabaseName = 'D:\MYPROJECT\WAGECLIENTMT\BASE'
    ExactCount = True
    Exclusive = False
    LargeIntegerAs = asLargeInt
    LockProtocol = Default
    TableName = 'dict.dbf'
    TranslateASCII = False
    UseDeleted = False
    UserID = 0
    Left = 320
  end
  object dsrDict: TDataSource
    DataSet = hdsDict
    Left = 324
    Top = 48
  end
  object hdsFrom: THalcyonDataSet
    AutoCalcFields = False
    AutoFlush = False
    DatabaseName = 'D:\MYPROJECT\WAGECLIENTMT\BASE'
    ExactCount = True
    Exclusive = False
    LargeIntegerAs = asLargeInt
    LockProtocol = Default
    TableName = 'lico.DBF'
    TranslateASCII = False
    UseDeleted = False
    UserID = 0
    Left = 448
  end
  object dsrFrom: TDataSource
    DataSet = hdsFrom
    Left = 448
    Top = 48
  end
end
