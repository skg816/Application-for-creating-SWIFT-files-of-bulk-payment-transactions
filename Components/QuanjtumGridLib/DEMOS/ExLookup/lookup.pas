unit lookup;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, dxCntner, dxTL, dxDBGrid, dxGrClms, dxExGrEd, dxExEdtr,
  dxDBTLCl, dxDBCtrl;

type
  TfmPopup = class(TForm)
    PopupPanel: TPanel;
    PopupGrid: TdxDBGrid;
    PopupGridID: TdxDBGridMaskColumn;
    PopupGridName: TdxDBGridMaskColumn;
    PopupGridDescriptionMemo: TdxDBGridMemoColumn;
    PopupGridPicture: TdxDBGridGraphicColumn;
    PopupGridDescription: TdxDBGridMaskColumn;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    PopupGridColumn6: TdxDBGridColumn;
    procedure PopupGridDblClick(Sender: TObject);
    procedure PopupGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PopupGridMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmPopup: TfmPopup;

implementation

uses main;

{$R *.DFM}

//closes the form containing PopupGrid
procedure TfmPopup.PopupGridDblClick(Sender: TObject);
begin
  (GetParentForm(PopupGrid) as TdxPopupEditForm).ClosePopup(True);
end;

procedure TfmPopup.PopupGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ((Key in [VK_UP, VK_DOWN]) and (ssAlt in Shift)) or
      ((Key = VK_F4) and not (ssAlt in Shift)) or (Key = VK_ESCAPE) then
    (GetParentForm(PopupGrid) as TdxPopupEditForm).ClosePopup(False);
  if Key = VK_RETURN then PopupGridDblClick(nil);
end;

procedure TfmPopup.PopupGridMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (Button = mbLeft) and (PopupGrid.GetHitTestInfoAt(X, Y) in RowHitTests) then
    PopupGridDblClick(nil);
end;

end.
