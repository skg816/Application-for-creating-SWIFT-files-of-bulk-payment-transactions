unit unLico;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unxModal, Menus, Placemnt, ActnList, ToolWin, ComCtrls, unGrid,
  IdGlobal, ExtCtrls, StdCtrls, DB, dxTL, dxDBCtrl, dxDBGrid, RxLookup;

type
  TfmLico = class(TfmxModal)
    frmLico: TfrmGrid;
    rgbReceiv: TRadioButton;
    rgbSend: TRadioButton;
    actNew: TAction;
    actEdit: TAction;
    actDel: TAction;
    tlb11: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    tlbClose: TToolButton;
    ToolButton5: TToolButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure actNewExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actDelExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actOkExecute(Sender: TObject);
    procedure rgbReceivClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    qChang: boolean;
    qID: integer;
    procedure SetFilter;
  end;

  procedure Lico_GetId(aOwner: TComponent;
                       aCbx: TRxDBLookupCombo;
                       const Key: Word;
                       const aLType: integer
                       );
implementation

uses unInitialize, unMain, RxStrUtils, unTools, ToolEdit, unDM,
  unLicoOrgEdit, unSql;

{$R *.dfm}

procedure Lico_GetId(aOwner: TComponent;
                     aCbx: TRxDBLookupCombo;
                     const Key: Word;
                     const aLType: integer
                     );
var
  fmLico: TfmLico;
begin
  case Key of

  VK_RIGHT:
    aCbx.DropDown;

  VK_DELETE:
    aCbx.ResetField;

  VK_INSERT:
    begin
      fmLico := TfmLico.Create(aOwner);
      with fmLico, frmLico.hdsGrid do
      try
        actPaste.ShortCut := VK_RETURN;
        tlbClose.Action := actPaste;
        if not aCbx.Field.IsNull then qID := aCbx.Field.AsInteger;

        rgbReceiv.OnClick := nil;
        rgbSend.OnClick := nil;
        if aLType=1 then rgbSend.Checked := true;
        rgbReceiv.Enabled := false;
        rgbSend.Enabled := false;
        if ShowModal = mrOk then
        begin
          if qChang then
          begin
            aCbx.LookupSource.DataSet.Close;
            aCbx.LookupSource.DataSet.Open;
          end;
          if QR.Empty(frmLico.hdsGrid) then aCbx.ResetField
            else aCbx.KeyValue := FieldByName('ID').AsString;
          frmLico.FrmFree;
        end;
      finally
        Release;
      end;
    end;
  end;

end;

procedure TfmLico.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if FormStyle = fsMDIChild then
  begin
    frmLico.FrmFree;
    Action := caFree;
  end;
end;

procedure TfmLico.FormShow(Sender: TObject);
begin
  inherited;
  with frmLico do
  begin
    FrmInit('lico.dbf');
    SetFilter;
    LoadGridMy;
    grdGrid.SetFocus;
    qChang := false;
    SetSort('NAME', false);
    if (qID > -1) and (not hdsGrid.Eof) then hdsGrid.Locate('ID', qID,[]);
  end;
end;

procedure TfmLico.SetFilter;
begin
  //-- Фильтруем набор
  with frmLico.hdsGrid do
  begin
    Close;
    Filtered := false;
    Filter := 'LType=' + IntToStr(Ord(rgbSend.Checked));
    Filtered := true;
    Open;
  end;
end;

procedure TfmLico.actNewExecute(Sender: TObject);
begin
  LicoOrgEditExec(Self, frmLico.hdsGrid, 1, Ord(rgbSend.Checked));
  qChang := true;
end;

procedure TfmLico.actEditExecute(Sender: TObject);
begin
  LicoOrgEditExec(Self, frmLico.hdsGrid, 2, Ord(rgbSend.Checked));
  qChang := true;
end;

procedure TfmLico.actDelExecute(Sender: TObject);
begin
  LicoOrgEditExec(Self, frmLico.hdsGrid, 3, Ord(rgbSend.Checked));
  qChang := true;
end;

procedure TfmLico.FormCreate(Sender: TObject);
begin
  inherited;
  IZ.CheckMain(Sender);
  qID := -1;
end;

procedure TfmLico.actOkExecute(Sender: TObject);
begin
  if FormStyle = fsMDIChild then Close
    else ModalResult := mrOk;
end;

procedure TfmLico.rgbReceivClick(Sender: TObject);
begin
  inherited;
  frmLico.D_off;
  SetFilter;
  frmLico.D_on;
end;

end.
