inherited fmxModal: TfmxModal
  Left = 593
  Top = 405
  Width = 559
  Height = 431
  Caption = 'fmxModal'
  OldCreateOrder = True
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object stbModal: TStatusBar
    Left = 0
    Top = 385
    Width = 551
    Height = 19
    Panels = <>
    SimplePanel = False
  end
  object tlbModal: TToolBar
    Left = 0
    Top = 0
    Width = 551
    Height = 24
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
  end
  object actModal: TActionList
    Images = DM.imgMain
    Left = 152
    object actOk: TAction
      Category = 'Modal'
      Caption = 'actOk'
      Hint = #1054#1050
      ImageIndex = 178
      ShortCut = 8205
      OnExecute = actOkExecute
    end
    object actCancel: TAction
      Category = 'Modal'
      Caption = 'actCancel'
      Hint = #1054#1090#1084#1077#1085#1072
      ImageIndex = 62
      ShortCut = 27
      OnExecute = actCancelExecute
    end
    object actClose: TAction
      Category = 'Modal'
      Caption = #1047#1072#1082#1088#1099#1090#1100
      Hint = #1047#1072#1082#1088#1099#1090#1100' '#1086#1082#1085#1086
      ImageIndex = 60
      OnExecute = actOkExecute
    end
    object actPaste: TAction
      Category = 'Modal'
      Caption = #1042#1099#1073#1088#1072#1090#1100
      Hint = #1042#1099#1073#1088#1072#1090#1100
      ImageIndex = 3
      OnExecute = actOkExecute
    end
  end
  object strModal: TFormStorage
    Options = []
    StoredValues = <>
    Left = 200
  end
  object popModal: TPopupMenu
    Images = DM.imgMain
    Left = 252
  end
end
