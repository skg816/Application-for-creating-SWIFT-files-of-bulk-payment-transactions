unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Db, DBTables, ExtCtrls, dxCntner, dxTL, dxGridMenus,
  dxDBGrid, dxGrClms, Mask, DBCtrls, Menus, dxDBTLCl, dxDBCtrl;

type
  TfmMain = class(TForm)
    StatusBar: TStatusBar;
    ProgressBar: TProgressBar;
    ta10000: TTable;
    ta10000ID: TIntegerField;
    ta10000CustomerName: TStringField;
    ta10000Company: TStringField;
    ta10000Address: TStringField;
    ta10000Customer: TBooleanField;
    ta10000City: TStringField;
    ta10000State: TStringField;
    ta10000PurchaseDate: TDateField;
    ta10000HomePhone: TStringField;
    ta10000PaymentType: TStringField;
    ta10000PaymentAmount: TBCDField;
    ds10000: TDataSource;
    GridImageList: TImageList;
    sdSave: TSaveDialog;
    Panel7: TPanel;
    dxDBGrid: TdxDBGrid;
    dxDBGridID: TdxDBGridMaskColumn;
    dxDBGridCustomerName: TdxDBGridMaskColumn;
    dxDBGridPurchaseDate: TdxDBGridDateColumn;
     dxDBGridPaymentAmount: TdxDBGridCurrencyColumn;
    dxDBGridCompany: TdxDBGridMaskColumn;
    dxDBGridCustomer: TdxDBGridCheckColumn;
    dxDBGridState: TdxDBGridPickColumn;
    dxDBGridCity: TdxDBGridMaskColumn;
    dxDBGridAddress: TdxDBGridMaskColumn;
    dxDBGridHomePhone: TdxDBGridMaskColumn;
    dxDBGridPaymentType: TdxDBGridImageColumn;
    MainMenu1: TMainMenu;
    miFile: TMenuItem;
    miEdit: TMenuItem;
    View1: TMenuItem;
    Options1: TMenuItem;
    Help1: TMenuItem;
    miSaveAsText: TMenuItem;
    miGenerate: TMenuItem;
    N1: TMenuItem;
    miExit: TMenuItem;
    miNew: TMenuItem;
    miSave: TMenuItem;
    miDelete: TMenuItem;
    miCancel: TMenuItem;
    miCopytoClipboard: TMenuItem;
    N2: TMenuItem;
    miGrouping: TMenuItem;
    miShowSummaryFooter: TMenuItem;
    miColumnSelector: TMenuItem;
    miAutoWidth: TMenuItem;
    miAutoPreview: TMenuItem;
    N3: TMenuItem;
    miStandardStyle: TMenuItem;
    miFlatStyle: TMenuItem;
    miUseLocate: TMenuItem;
    miSmartReload: TMenuItem;
    miSmartRefresh: TMenuItem;
    miCaseInsensitive: TMenuItem;
    miWeb: TMenuItem;
    pmDetail: TPopupMenu;
    piNew: TMenuItem;
    piSave: TMenuItem;
    piDelete: TMenuItem;
    N4: TMenuItem;
    piCopytoClipboard: TMenuItem;
    N5: TMenuItem;
    piSaveAsText: TMenuItem;
    miUltraFlatStyle: TMenuItem;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dxDBGridMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormActivate(Sender: TObject);
    procedure dxDBGridSelectedCountChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure abbNewClick(Sender: TObject);
    procedure abbSaveClick(Sender: TObject);
    procedure abbDeleteClick(Sender: TObject);
    procedure abbCopyClick(Sender: TObject);
    procedure abbGroupingClick(Sender: TObject);
    procedure addFooterClick(Sender: TObject);
    procedure abbColumnSelectorClick(Sender: TObject);
    procedure abbAutoWidthClick(Sender: TObject);
    procedure abbAutoPreviewClick(Sender: TObject);
    procedure abbDevExpWebClick(Sender: TObject);
    procedure abbUseLocateClick(Sender: TObject);
    procedure abbSmartReloadClick(Sender: TObject);
    procedure abbSmartRefreshClick(Sender: TObject);
    procedure abbCaseInsensitiveClick(Sender: TObject);
    procedure abbSaveAsClick(Sender: TObject);
    procedure abbExitClick(Sender: TObject);
    procedure abbStandardStyleClick(Sender: TObject);
    procedure dxDBGridEndColumnsCustomizing(Sender: TObject);
    procedure ds10000DataChange(Sender: TObject; Field: TField);
    procedure abbCancelClick(Sender: TObject);
  private
    DataFile : String;
  end;

var
  fmMain: TfmMain;

implementation

{$R *.DFM}

uses ShellApi;

const
  // Table fields
  ArrayLen = 10;
  stCustomerName: array [0 .. ArrayLen - 1] of String = (
    'John Doe', 'Jennie Valentine', 'Sam Hill', 'Karen Holmes', 'Bobbie Valentine',
    'Ricardo Menendez', 'Frank Frankson', 'Christa Christie', 'Alfred Newman', 'James Johnson');

  stCompany: array [0 .. ArrayLen - 1] of String = (
    'Doe Enterprises', 'Hill Corporation', 'Holmes World', 'Valentine Hearts', 'Menedez Development',
    'Frankson Media', 'Christies House of Design', 'Jones & Assoc', 'Newman Systems', 'Development House');

  stAddress: array [0 .. ArrayLen - 1] of String = (
    '123 Home Lane', '45 Hill St.', '9333 Holmes Dr.', '933 Heart St. Suite 1', '939 Center Street',
    '121 Media Center Drive', '349 Graphic Design Lane', '990 King Lane', '900 Newman Center', '93900 Carter Lane');

  stCity: array [0 .. ArrayLen - 1] of String = (
    'Homesville', 'Hillsville', 'Johnsonville', 'Chicago', 'Atlanta',
    'New York', 'Kingsville', 'Newman', 'Cartersville', 'Los Angeles');

  stState: array [0 .. ArrayLen - 1] of String = (
    'CA', 'NJ', 'NY', 'IL', 'GA', 'OK', 'OH', 'CT', 'MI', 'MA');

  stHomePhone: array [0 .. ArrayLen - 1] of String = (
    '(111)111-1111', '(222)222-2222', '(333)333-3333', '(898)745-1511', '(151)615-1611',
    '(339)339-3939', '(930)930-3093', '(029)020-9090', '(923)022-0834', '(228)320-8320');

  stPaymentType: array [0 .. 3] of String = (
    'CASH', 'VISA', 'MASTER', 'AMEX');

  // save to reg
  RegistryPath = '\Software\Developer Express\ExpressGrid\demos\Demo10000\';
  VerDemo = 1;

function GetRandomValue(A: array of String): String;
begin
  Result := A[Low(A) + Random(High(A)-Low(A) + 1)];
end;

function GetRandomPTValue: String;
begin
  case Random(100)+1 of
    1..50: Result := 'VISA';
    51..80: Result := 'MASTER';
    81..95: Result := 'AMEX';
    else Result := 'CASH';
  end;
end;

procedure TfmMain.FormCreate(Sender: TObject);
var
  AFileName : String;
begin
  dxDBGrid.LoadFromRegistry(RegistryPath);
  with ta10000 do
  begin
    Active := False;
    DatabaseName := ExtractFilePath(Application.ExeName);
    AFileName := DatabaseName;
    if AFileName <> '' then
      if AFileName[Length(AFileName)] <> '\' then
         AFileName := AFileName + '\';
    AFileName := AFileName + TableName + '.db';
    if FileExists(AFileName) then
      try Active := True; except end;
    dxDBGrid.Options := dxDBGrid.Options + [egoLoadAllRecords];
  end;
  miGrouping.Checked := dxDBGrid.ShowGroupPanel;
  miShowSummaryFooter.Checked := dxDBGrid.ShowSummaryFooter;
  miAutoWidth.Checked := egoAutoWidth in dxDBGrid.Options;
  miAutoPreview.Checked := egoPreview in dxDBGrid.Options;
  miUseLocate.Checked := egoUseLocate in dxDBGrid.Options;
  miSmartReload.Checked := egoSmartReload in dxDBGrid.Options;
  miSmartRefresh.Checked := egoSmartRefresh in dxDBGrid.Options;
  miCaseInsensitive.Checked := egoCaseInsensitive in dxDBGrid.Options;
  if dxDBGrid.LookAndFeel = lfFlat then
    miFlatStyle.Checked := True
  else miStandardStyle.Checked := True;
  DataFile := ExtractFilePath(Application.ExeName)+'ExpGrid.txt';
end;

procedure TfmMain.FormDestroy(Sender: TObject);
begin
  dxDBGrid.SaveToRegistry(RegistryPath);
end;

procedure TfmMain.FormActivate(Sender: TObject);
begin
  if not ta10000.Active then
  begin
    if MessageBox(Handle, 'The table is empty.'#13'Do you wish to generate 10000 records?', 'Question',
      MB_ICONQUESTION or MB_YESNO) = ID_YES then  Button1Click(nil);
  end;
end;

procedure TfmMain.Button1Click(Sender: TObject);
var
  I: Integer;
begin
  with ta10000 do
  begin
    Active := False;
    dxDBGrid.Options := dxDBGrid.Options - [egoLoadAllRecords];
    IndexDefs.Clear;
    IndexDefs.Add('ID', 'ID', [ixPrimary]);
    CreateTable;
    DisableControls;
    ProgressBar.Parent := StatusBar;
    try
      Active := True;
      ProgressBar.Max := 10000;
      ProgressBar.Width := StatusBar.Panels[0].Width;
      ProgressBar.Height := StatusBar.ClientHeight - 2;
      ProgressBar.Left := 0;
      ProgressBar.Top := 2;
      ProgressBar.Visible := True;
      // add records
      for I := 1 to ProgressBar.Max do
      begin
        Append;
        FieldByName('ID').AsInteger := I;
        FieldByName('CustomerName').AsString := GetRandomValue(stCustomerName);
        FieldByName('Company').AsString := GetRandomValue(stCompany);
        FieldByName('Address').AsString := GetRandomValue(stAddress);
        FieldByName('City').AsString := GetRandomValue(stCity);
        FieldByName('State').AsString := GetRandomValue(stState);
        FieldByName('Customer').AsBoolean := Boolean(Random(2));
        FieldByName('PurchaseDate').AsDateTime := Date - 100 + Random(100);
        FieldByName('HomePhone').AsString := GetRandomValue(stHomePhone);
        FieldByName('PaymentType').AsString := GetRandomPTValue;
        FieldByName('PaymentAmount').AsFloat := 49 + Random(200);
        Post;          
        ProgressBar.Position := I;
      end;
    finally
      ProgressBar.Visible := False;
      StatusBar.Refresh;
      EnableControls;
      dxDBGrid.Options := dxDBGrid.Options + [egoLoadAllRecords];
    end;
  end;
end;

procedure TfmMain.dxDBGridMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  p : TPoint;
begin
  if Button <> mbRight then exit;

  if TdxDBGridPopupMenuManager.Instance.ShowGridPopupMenu(TdxDBGrid(Sender)) then
    exit;

  if not(TdxDBGrid(Sender).GetHitTestInfoAt(X, Y) in [htColumn, htColumnEdge, htSummaryFooter, htSummaryNodeFooter, htGroupPanel])
  and PtInRect(ClientRect, Point(X, Y)) then
  begin
    dxDBGridSelectedCountChange(nil); // update items
    p := dxDBGrid.ClientToScreen(Point(X, Y));
    pmDetail.Popup(p.X, p.Y);
  end
end;

procedure TfmMain.dxDBGridSelectedCountChange(Sender: TObject);
begin
  miDelete.Enabled := (dxDBGrid.SelectedCount > 0);
  miCopytoClipboard.Enabled := dxDBGrid.SelectedCount > 0;
  miSaveAsText.Enabled := dxDBGrid.SelectedCount > 0;
  piDelete.Enabled := miDelete.Enabled;
  piCopytoClipboard.Enabled := miCopytoClipboard.Enabled;
  piSaveAsText.Enabled := miSaveAsText.Enabled;
end;

// clicks
procedure TfmMain.abbNewClick(Sender: TObject);
begin
  ta10000.Append;
end;

procedure TfmMain.abbSaveClick(Sender: TObject);
begin
  if (ta10000.State in dsEditModes) then
    ta10000.Post;
end;

procedure TfmMain.abbDeleteClick(Sender: TObject);
begin
  with dxDBGrid do
  begin
    if (FocusedNode <> nil) and (SelectedCount = 1) and
       FocusedNode.HasChildren then Exit;
    if (MessageBox(Handle, 'You are about to delete the selected records. Do you want to proceed?',
        'Confirm', MB_ICONWARNING or MB_YESNOCANCEL) = ID_YES) then
    if SelectedCount > 1 then DeleteSelection
    else
      if FocusedNode <> nil then TdxDBGridNode(FocusedNode).Delete;
  end;
end;

procedure TfmMain.abbCopyClick(Sender: TObject);
begin
  dxDBGrid.CopySelectedToClipboard;
end;

procedure TfmMain.abbGroupingClick(Sender: TObject);
begin
  miGrouping.Checked := not miGrouping.Checked;
  dxDBGrid.ShowGroupPanel := miGrouping.Checked;
end;

procedure TfmMain.addFooterClick(Sender: TObject);
begin
  miShowSummaryFooter.Checked := not miShowSummaryFooter.Checked;
  dxDBGrid.ShowSummaryFooter := miShowSummaryFooter.Checked;
end;

procedure TfmMain.abbColumnSelectorClick(Sender: TObject);
begin
  miColumnSelector.Checked := not miColumnSelector.Checked;
  if miColumnSelector.Checked then
    dxDBGrid.ColumnsCustomizing
  else dxDBGrid.EndColumnsCustomizing;
end;

procedure TfmMain.abbAutoWidthClick(Sender: TObject);
begin
  miAutoWidth.Checked := not miAutoWidth.Checked;
  if miAutoWidth.Checked then
    dxDBGrid.OptionsView := dxDBGrid.OptionsView + [edgoAutoWidth]
  else dxDBGrid.OptionsView := dxDBGrid.OptionsView - [edgoAutoWidth];
end;

procedure TfmMain.abbAutoPreviewClick(Sender: TObject);
begin
  miAutoPreview.Checked := not miAutoPreview.Checked;
  if miAutoPreview.Checked then
    dxDBGrid.OptionsView := dxDBGrid.OptionsView + [edgoPreview]
  else dxDBGrid.OptionsView := dxDBGrid.OptionsView - [edgoPreview];
end;

procedure TfmMain.abbDevExpWebClick(Sender: TObject);
begin
  ShellExecute(Handle, PChar('OPEN'), PChar('http://www.devexpress.com'), Nil, Nil, SW_SHOWMAXIMIZED);
end;

procedure TfmMain.abbUseLocateClick(Sender: TObject);
begin
  miUseLocate.Checked := not miUseLocate.Checked;
  if miUseLocate.Checked then
    dxDBGrid.OptionsDB := dxDBGrid.OptionsDB + [edgoUseLocate]
  else dxDBGrid.OptionsDB := dxDBGrid.OptionsDB - [edgoUseLocate];
end;

procedure TfmMain.abbSmartReloadClick(Sender: TObject);
begin
  miSmartReload.Checked := not miSmartReload.Checked;
  if miSmartReload.Checked then
    dxDBGrid.OptionsDB := dxDBGrid.OptionsDB + [edgoSmartReload]
  else dxDBGrid.OptionsDB := dxDBGrid.OptionsDB - [edgoSmartReload];
end;

procedure TfmMain.abbSmartRefreshClick(Sender: TObject);
begin
  miSmartRefresh.Checked := not miSmartRefresh.Checked;
  if miSmartRefresh.Checked then
    dxDBGrid.OptionsDB := dxDBGrid.OptionsDB + [edgoSmartRefresh]
  else
  begin
    dxDBGrid.OptionsDB := dxDBGrid.OptionsDB - [edgoSmartRefresh];
    ta10000.Refresh;
  end;
end;

procedure TfmMain.abbCaseInsensitiveClick(Sender: TObject);
begin
  miCaseInsensitive.Checked := not miCaseInsensitive.Checked;
  if miCaseInsensitive.Checked then
    dxDBGrid.OptionsBehavior := dxDBGrid.OptionsBehavior + [edgoCaseInsensitive]
  else dxDBGrid.OptionsBehavior := dxDBGrid.OptionsBehavior - [edgoCaseInsensitive];
end;

procedure TfmMain.abbSaveAsClick(Sender: TObject);
begin
  with sdSave do
  begin
    Title := 'Save selected records to text file';
    InitialDir := ExtractFilePath(Application.ExeName);
    FileName := ExtractFileName(DataFile);
    if Execute then
    begin
      DataFile := FileName;
      dxDBGrid.SaveSelectedToTextFile(DataFile);
    end;
  end;
end;

procedure TfmMain.abbExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfmMain.abbStandardStyleClick(Sender: TObject);
begin
  dxDBGrid.LookAndFeel := TdxLookAndFeel(TMenuItem(Sender).Tag);
end;

procedure TfmMain.dxDBGridEndColumnsCustomizing(Sender: TObject);
begin
  miColumnSelector.Checked := False;
end;

procedure TfmMain.ds10000DataChange(Sender: TObject; Field: TField);
begin
  miSave.Enabled := ta10000.State in dsEditModes;
  miCancel.Enabled := ta10000.State in dsEditModes;
  piSave.Enabled := miSave.Enabled;
end;

procedure TfmMain.abbCancelClick(Sender: TObject);
begin
  if (ta10000.State in dsEditModes) then
    ta10000.Cancel;
end;

end.
