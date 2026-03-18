inherited fmAbout: TfmAbout
  Top = 169
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsToolWindow
  Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
  ClientHeight = 292
  ClientWidth = 383
  OldCreateOrder = True
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object RxLabel1: TRxLabel
    Left = 8
    Top = 12
    Width = 226
    Height = 37
    Caption = 'WageClientMT'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -32
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ShadowPos = spRightBottom
  end
  object BitBtn1: TBitBtn
    Left = 292
    Top = 256
    Width = 75
    Height = 25
    TabOrder = 0
    Kind = bkOK
  end
  object PageControl1: TPageControl
    Left = 8
    Top = 56
    Width = 369
    Height = 189
    ActivePage = TabSheet1
    MultiLine = True
    TabIndex = 0
    TabOrder = 1
    TabPosition = tpRight
    object TabSheet1: TTabSheet
      object Label1: TLabel
        Left = 0
        Top = 4
        Width = 55
        Height = 13
        Caption = #1042#1077#1088#1089#1080#1103' 1.0'
      end
      object Label2: TLabel
        Left = 0
        Top = 28
        Width = 204
        Height = 13
        Caption = 'TOO Force Technology, Copyright (c) 2003'
      end
      object Bevel1: TBevel
        Left = 0
        Top = 60
        Width = 333
        Height = 9
        Shape = bsTopLine
      end
      object Label4: TLabel
        Left = 0
        Top = 68
        Width = 181
        Height = 13
        Caption = #1055#1086#1076#1076#1077#1088#1078#1080#1074#1072#1077#1084#1072#1103' '#1086#1087#1077#1088'-'#1072#1103' '#1089#1080#1089#1090#1077#1084#1072':'
      end
      object Label5: TLabel
        Left = 184
        Top = 68
        Width = 128
        Height = 13
        Caption = 'Windows 9X/NT/2000/XP'
      end
      object Memo1: TMemo
        Left = 0
        Top = 88
        Width = 337
        Height = 89
        Lines.Strings = (
          #1057#1083#1091#1078#1073#1072' '#1087#1086#1076#1076#1077#1088#1078#1082#1080':'
          ''
          #1044#1102#1089#1077#1084#1073#1072#1077#1074' '#1056#1091#1089#1090#1072#1084
          'e-mail: rustam_d@turanalem.kz'
          #1090#1077#1083'.: (3272) 500-125'
          #1074#1085'.: 2125')
        ReadOnly = True
        TabOrder = 0
      end
    end
    object TabSheet2: TTabSheet
      Caption = #1048#1089#1087#1088#1072#1074#1083#1077#1085#1080#1103
      ImageIndex = 1
      object Label3: TLabel
        Left = 0
        Top = 0
        Width = 342
        Height = 181
        Align = alClient
        Caption = #1069#1090#1086' '#1087#1077#1088#1074#1072#1103' '#1074#1077#1088#1089#1080#1103'.'#13#10#13#10#1048#1089#1087#1088#1072#1074#1083#1077#1085#1080#1081' '#1085#1077#1090'.'
      end
    end
  end
end
