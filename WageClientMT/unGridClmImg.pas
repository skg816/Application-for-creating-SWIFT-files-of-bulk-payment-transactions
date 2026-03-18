unit unGridClmImg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, ComCtrls, ToolWin, dxTL, dxTLClms,
  dxCntner, unxModal, Menus, Placemnt;

type
  TfmGridClmImg = class(TfmxModal)
    trlClmImg: TdxTreeList;
    clmDescr: TdxTreeListColumn;
    ToolButton3: TToolButton;
    actNew: TAction;
    actEdit: TAction;
    actDel: TAction;
    clmValue: TdxTreeListColumn;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    clmImg: TdxTreeListColumn;
    clmIndex: TdxTreeListColumn;
    ToolButton1: TToolButton;
    procedure actNewExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actDelExecute(Sender: TObject);
    procedure trlClmImgGetImageIndex(Sender: TObject;
      Node: TdxTreeListNode; var Index: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Exec(const AMode: integer);  //---1-Append,2-Edit,3-Delete
  end;

implementation

uses unDm, unGridClmImgEdit, unInitialize;

{$R *.dfm}

procedure TfmGridClmImg.Exec(const AMode: integer);  //---1-Append,2-Edit,3-Delete
var
  fmGridClmImgEdit: TfmGridClmImgEdit;
begin
  if (aMode > 1) and (trlClmImg.Count = 0) then exit;

  fmGridClmImgEdit := TfmGridClmImgEdit.Create(Self);
  with fmGridClmImgEdit do
  try
    try
      case AMode of
        1 : begin
              Caption := 'Создание';
              cbxColor.ItemIndex := 0;
              if ShowModal = mrOk then
              with trlClmImg.Add do
              begin
                Values[clmIndex.Index] := IntToStr(cbxColor.ItemIndex);
                Values[clmValue.Index] := Trim(edtValue.Text);
                Values[clmDescr.Index] := Trim(edtDescr.Text);
              end;
            end;
        2 : with trlClmImg.FocusedNode do
            begin
              Caption := 'Редактирование';
              cbxColor.ItemIndex := StrToInt(trlClmImg.FocusedNode.Values[clmIndex.Index]);
              edtValue.Text := Values[clmValue.Index];
              edtDescr.Text := Values[clmDescr.Index];
              if ShowModal = mrOk then
              begin
                Values[clmIndex.Index] := cbxColor.ItemIndex;
                Values[clmValue.Index] := Trim(edtValue.Text);
                Values[clmDescr.Index] := Trim(edtDescr.Text);
              end;
            end;
        3 : begin
              if MessageDlg('Вы действительно желаете удалить запись?',
                      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
                trlClmImg.FocusedNode.Destroy;
            end;
      end; // end case
    except
      on E:Exception do IZ.MsgException(E);
    end;
  finally
    Release;
  end;
end;

procedure TfmGridClmImg.actNewExecute(Sender: TObject);
begin
  inherited;
  Exec(1);
end;

procedure TfmGridClmImg.actEditExecute(Sender: TObject);
begin
  inherited;
  Exec(2);
end;

procedure TfmGridClmImg.actDelExecute(Sender: TObject);
begin
  inherited;
  Exec(3);
end;

procedure TfmGridClmImg.trlClmImgGetImageIndex(Sender: TObject;
  Node: TdxTreeListNode; var Index: Integer);
begin
  inherited;
  if Node.Values[clmIndex.Index] <> '' then
    Index := StrToInt(Node.Values[clmIndex.Index]);
end;

end.
