unit MaskEd;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, dxCntner, dxEditor, dxEdLib, dxExEdtr, dxTL;

type
  TdxEditMaskForm = class(TForm)
    Bevel3: TBevel;
    Label10: TLabel;
    Label1: TLabel;
    Bevel1: TBevel;
    Label2: TLabel;
    Bevel2: TBevel;
    BOK: TButton;
    BCancel: TButton;
    BMask: TButton;
    EMask: TdxEdit;
    Label3: TLabel;
    edBlankChar: TdxEdit;
    cbSaveLiteral: TdxCheckEdit;
    cbIgnoreMaskBlank: TdxCheckEdit;
    ETest: TdxMaskEdit;
    Grid: TdxTreeList;
    colDescription: TdxTreeListColumn;
    colSample: TdxTreeListColumn;
    colMask: TdxTreeListColumn;
    OpenDialog: TOpenDialog;
    procedure FormCreate(Sender: TObject);
    procedure BMaskClick(Sender: TObject);
    procedure edBlankCharChange(Sender: TObject);
    procedure cbSaveLiteralChange(Sender: TObject);
    procedure cbIgnoreMaskBlankChange(Sender: TObject);
    procedure GridClick(Sender: TObject);
    procedure GridChangeNode(Sender: TObject; OldNode,
      Node: TdxTreeListNode);
    procedure GridDblClick(Sender: TObject);
    procedure EMaskChange(Sender: TObject);
  private
  protected
    procedure SyncProperties(AMaskEdit: TdxMaskEdit);
  public
    procedure InitProperties(AMaskEdit: TdxMaskEdit);
    procedure LoadMasksFromFile(const FileName: string);
  end;

var
  dxEditMaskForm: TdxEditMaskForm;

implementation

{$R *.DFM}

uses
  Mask, dxDemoUtils, dxEditUtils{$IFDEF VER140}, MaskUtils{$ENDIF};

procedure TdxEditMaskForm.InitProperties(AMaskEdit: TdxMaskEdit);
begin
  ETest.EditMask := AMaskEdit.EditMask;
  ETest.IgnoreMaskBlank := AMaskEdit.IgnoreMaskBlank;
  SyncProperties(ETest);
end;

procedure TdxEditMaskForm.LoadMasksFromFile(const FileName: string);
begin
  // TODO
end;

procedure TdxEditMaskForm.SyncProperties(AMaskEdit: TdxMaskEdit);
begin
  if EMask.Text <> AMaskEdit.EditMask then
    EMask.Text := AMaskEdit.EditMask;
  edBlankChar.Text := MaskGetMaskBlank(AMaskEdit.EditMask);
  cbSaveLiteral.Checked := MaskGetMaskSave(AMaskEdit.EditMask);
  cbIgnoreMaskBlank.Checked := AMaskEdit.IgnoreMaskBlank;
end;

procedure TdxEditMaskForm.FormCreate(Sender: TObject);
begin
  if Screen.Fonts.IndexOf('Tahoma') = -1 then
    ResetDefaultFontName(Self);
end;

procedure TdxEditMaskForm.BMaskClick(Sender: TObject);
begin
  if OpenDialog.Execute then
    LoadMasksFromFile(OpenDialog.FileName);
end;

procedure TdxEditMaskForm.edBlankCharChange(Sender: TObject);
var
  ANewMask, S: string;
begin
  if Length(edBlankChar.Text) > 0 then
    S := edBlankChar.Text[1]
  else
    S := '';
  ANewMask := ETest.EditMask;
  if Pos(';', ANewMask) <> 0 then
    ANewMask := Copy(ANewMask, 1, Pos(';', ANewMask) - 1);
  if MaskGetMaskSave(ETest.EditMask) then
    ANewMask := ANewMask + ';1'
  else
    ANewMask := ANewMask + ';0';
  ANewMask := ANewMask + ';' + S;
  ETest.EditMask := ANewMask;
  SyncProperties(ETest);
end;

procedure TdxEditMaskForm.cbSaveLiteralChange(Sender: TObject);
var
  ANewMask, S: string;
begin
  if Length(edBlankChar.Text) > 0 then
    S := edBlankChar.Text[1]
  else
    S := '';
  ANewMask := ETest.EditMask;
  if Pos(';', ANewMask) <> 0 then
    ANewMask := Copy(ANewMask, 1, Pos(';', ANewMask) - 1);
  S := MaskGetMaskBlank(ETest.EditMask);
  if cbSaveLiteral.Checked then
    ANewMask := ANewMask + ';1'
  else
    ANewMask := ANewMask + ';0';
  ANewMask := ANewMask + ';' + S;
  ETest.EditMask := ANewMask;
  SyncProperties(ETest);
end;

procedure TdxEditMaskForm.cbIgnoreMaskBlankChange(Sender: TObject);
begin
  ETest.IgnoreMaskBlank := cbIgnoreMaskBlank.Checked;
  SyncProperties(ETest);
end;

procedure TdxEditMaskForm.GridClick(Sender: TObject);
begin
  if Grid.FocusedNode <> nil then
  begin
    ETest.EditMask := Grid.FocusedNode.Values[colMask.Index];
    SyncProperties(ETest);
  end;
end;

procedure TdxEditMaskForm.GridChangeNode(Sender: TObject; OldNode,
  Node: TdxTreeListNode);
begin
  GridClick(nil);
end;

procedure TdxEditMaskForm.GridDblClick(Sender: TObject);
begin
  ClosePopupForm(Self, True);
end;

procedure TdxEditMaskForm.EMaskChange(Sender: TObject);
begin
  ETest.EditMask := EMask.Text;
  SyncProperties(ETest);
end;

end.
