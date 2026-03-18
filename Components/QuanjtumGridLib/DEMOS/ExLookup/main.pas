unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Spin, dxGrClEx, dxGrClms, dxDBGrid, dxTL, dxCntner,
  Db, DBTables, ExtCtrls, dxLayout, Menus, dxExGrEd, dxExEdtr, dxDBCtrl,
  dxDBTLCl, dxEdLib, dxEditor;

type
  TfmMain = class(TForm)
    pcPageControl: TPageControl;
    tsPopup: TTabSheet;
    tsLookup: TTabSheet;
    tsExtLookup: TTabSheet;
    cbPBorderStyle: TdxPickEdit;
    edPCaption: TdxEdit;
    cbPClientEdge: TdxCheckEdit;
    cbPFlatBorder: TdxCheckEdit;
    cbPSizeable: TdxCheckEdit;
    cbPAutoSize: TdxCheckEdit;
    edLDropDownRows: TdxEdit;
    cbLImmediateDropDown: TdxCheckEdit;
    cbLListFieldName: TdxPickEdit;
    edEFormCaption: TdxEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    dxDBGrid: TdxDBGrid;
    colID: TdxDBGridSpinColumn;
    colFirstName: TdxDBGridMaskColumn;
    colPopup: TdxDBGridPopupColumn;
    colLookup: TdxDBGridLookupColumn;
    colExtLookup: TdxDBGridExtLookupColumn;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    sePMinWidth: TdxSpinEdit;
    sePMinHeight: TdxSpinEdit;
    sePWidth: TdxSpinEdit;
    sePHeight: TdxSpinEdit;
    seLListFieldIndex: TdxSpinEdit;
    seLListWidth: TdxSpinEdit;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    cbEClientEdge: TdxCheckEdit;
    cbEFlatBorder: TdxCheckEdit;
    cbESizeable: TdxCheckEdit;
    cbEAutoSize: TdxCheckEdit;
    seEPopupWidth: TdxSpinEdit;
    seEPopupHeight: TdxSpinEdit;
    seEPopupMinWidth: TdxSpinEdit;
    seEPopupMinHeight: TdxSpinEdit;
    tContacts: TTable;
    tContactsID: TAutoIncField;
    tContactsProductID: TIntegerField;
    tContactsFirstName: TStringField;
    tContactsLastName: TStringField;
    tContactsCompany: TStringField;
    tContactsPrefix: TStringField;
    tContactsTitle: TStringField;
    tContactsAddress: TStringField;
    tContactsCity: TStringField;
    tContactsState: TStringField;
    tContactsZipCode: TStringField;
    tContactsSource: TStringField;
    tContactsCustomer: TStringField;
    tContactsPurchaseDate: TDateField;
    tContactsHomePhone: TStringField;
    tContactsFaxPhone: TStringField;
    tContactsPaymentType: TStringField;
    tContactsSpouse: TStringField;
    tContactsOccupation: TStringField;
    tContactsPaymentAmount: TBCDField;
    tContactsDescription: TMemoField;
    tContactsproduct: TStringField;
    tContactsCustName: TStringField;
    tContactsPicture: TGraphicField;
    tContactsCurrency: TCurrencyField;
    tContactsTime: TTimeField;
    tContactsHyperLink: TStringField;
    dsContacts: TDataSource;
    tProducts: TTable;
    dsProducts: TDataSource;
    dxDBGridLayoutList2: TdxDBGridLayoutList;
    dxDBGridLayoutList2Item8: TdxDBGridLayout;
    hkEClearKey: THotKey;
    hkLClearKey: THotKey;
    cbEBorderStyle: TdxPickEdit;
    dxEditStyleController1: TdxEditStyleController;
    dxCheckEditStyleController1: TdxCheckEditStyleController;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure dxDBGridChangeColumn(Sender: TObject; Node: TdxTreeListNode;
      Column: Integer);
    procedure dxDBGridColumnMoved(Sender: TObject; FromIndex,
      ToIndex: Integer);
    procedure pcPageControlChange(Sender: TObject);
    procedure colPopupPopup(Sender: TObject; const EditText: String);
    procedure colPopupCloseUp(Sender: TObject; var Text: String;
      var Accept: Boolean);
    procedure colExtLookupCloseUp(Sender: TObject; var Text: String;
      var Accept: Boolean);
    procedure cbPBorderStyleClick(Sender: TObject);
    procedure edPCaptionChange(Sender: TObject);
    procedure cbPClientEdgeClick(Sender: TObject);
    procedure cbPFlatBorderClick(Sender: TObject);
    procedure cbPSizeableClick(Sender: TObject);
    procedure cbPAutoSizeClick(Sender: TObject);
    procedure sePMinWidthExit(Sender: TObject);
    procedure sePMinHeightChange(Sender: TObject);
    procedure sePWidthExit(Sender: TObject);
    procedure sePHeightExit(Sender: TObject);
    procedure hkLClearKeyExit(Sender: TObject);
    procedure edLDropDownRowsExit(Sender: TObject);
    procedure cbLListFieldNameClick(Sender: TObject);
    procedure cbLImmediateDropDownClick(Sender: TObject);
    procedure seLListFieldIndexChange(Sender: TObject);
    procedure seLListWidthChange(Sender: TObject);
    procedure hkEClearKeyExit(Sender: TObject);
    procedure cbEBorderStyleClick(Sender: TObject);
    procedure edEFormCaptionChange(Sender: TObject);
    procedure cbEClientEdgeClick(Sender: TObject);
    procedure cbEFlatBorderClick(Sender: TObject);
    procedure cbESizeableClick(Sender: TObject);
    procedure cbEAutoSizeClick(Sender: TObject);
    procedure seEPopupWidthExit(Sender: TObject);
    procedure seEPopupHeightExit(Sender: TObject);
    procedure seEPopupMinWidthExit(Sender: TObject);
    procedure seEPopupMinHeightExit(Sender: TObject);
  private
    procedure BindColumn2TabSheet(AColumn : TdxDBGridColumn; ATabSheet : TTabSheet);
    function ColumnByTabSheet(ATabSheet : TTabSheet): TdxDBGridColumn;
    function TabSheetByColumn(AColumn : TdxDBGridColumn): TTabSheet;
    procedure LoadProperties;
  public
    { Public declarations }
  end;

const
    PopupBorderStyle: array[0..3] of string = (
      'pbsDialog', 'pbsDialogHelp', 'pbsSimple', 'pbsSysPanel');

var
  fmMain: TfmMain;

implementation

uses lookup{$IFDEF VER140}, Variants{$ENDIF};

{$R *.DFM}

procedure TfmMain.FormCreate(Sender: TObject);
var i : Integer;
begin
  if not tProducts.Active then begin
    tProducts.DataBaseName := '..\Data\';
    tProducts.Open;
  end;
  if not tContacts.Active then begin
    tContacts.DataBaseName := '..\Data\';
    tContacts.Open;
  end;

  // fill the TControls[] array
  BindColumn2TabSheet(TdxDBGridColumn(colPopup), tsPopup);
  BindColumn2TabSheet(TdxDBGridColumn(colLookup), tsLookup);
  BindColumn2TabSheet(TdxDBGridColumn(colExtLookup), tsextLookup);

  // load combo boxes
  for i := 0 to 3 do
  begin
    cbPBorderStyle.Items.Add(PopupBorderStyle[i]);
    cbEBorderStyle.Items.Add(PopupBorderStyle[i]);
  end;
  LoadProperties;
end;

procedure TfmMain.BindColumn2TabSheet(AColumn : TdxDBGridColumn; ATabSheet : TTabSheet);
begin
  AColumn.Tag := Integer(ATabSheet);
  ATabSheet.Tag := Integer(AColumn);
end;

function TfmMain.ColumnByTabSheet(ATabSheet : TTabSheet): TdxDBGridColumn;
begin
  Result := TdxDBGridColumn(ATabSheet.Tag);
end;

function TfmMain.TabSheetByColumn(AColumn : TdxDBGridColumn): TTabSheet;
begin
  Result := TTabSheet(AColumn.Tag);
end;

procedure TfmMain.LoadProperties;
var
   i: Integer;
begin
  // for Popup column
  cbPBorderStyle.ItemIndex := Integer(colPopup.PopupFormBorderStyle);
  edPCaption.Text := colPopup.PopupFormCaption;
  cbPClientEdge.Checked := colPopup.PopupFormClientEdge;
  cbPFlatBorder.Checked := colPopup.PopupFormFlatBorder;
  cbPSizeable.Checked := colPopup.PopupFormSizeable;
  cbPAutoSize.Checked := colPopup.PopupAutoSize;
  sePMinWidth.Value := colPopup.PopupMinWidth;
  sePMinHeight.Value := colPopup.PopupMinHeight;
  sePWidth.Value := colPopup.PopupWidth;
  sePHeight.Value := colPopup.PopupHeight;
  // for Lookup column
  hkLClearKey.HotKey := colLookup.ClearKey;
  edLDropDownRows.Text := IntToStr(colLookup.DropDownRows);
  cbLImmediateDropDown.Checked := colLookup.ImmediateDropDown;
  for i := 0 to cbLListFieldName.Items.Count - 1 do
    if cbLListFieldName.Items.Strings[i] = colLookup.ListFieldName then
    cbLListFieldName.ItemIndex := i;
  seLListFieldIndex.Value := colLookup.ListFieldIndex;
  seLListWidth.Value := colLookup.ListWidth;
  // for ExtLookup column
  hkEClearKey.HotKey := colExtLookup.ClearKey;
  cbEBorderStyle.ItemIndex := Integer(colExtLookup.PopupFormBorderStyle);
  edEFormCaption.Text := colExtLookup.PopupFormCaption;
  cbEClientEdge.Checked := colExtLookup.PopupFormClientEdge;
  cbEFlatBorder.Checked := colExtLookup.PopupFormFlatBorder;
  cbESizeable.Checked := colExtLookup.PopupFormSizeable;
  cbEAutoSize.Checked := colExtLookup.PopupAutoSize;
  seEPopupWidth.Value := colExtLookup.PopupWidth;
  seEPopupHeight.Value := colExtLookup.PopupHeight;
  seEPopupMinWidth.Value := colExtLookup.PopupMinWidth;
  seEPopupMinHeight.Value := colExtLookup.PopupMinHeight;
end;

// call refresh PageControl
procedure TfmMain.FormActivate(Sender: TObject);
begin
  dxDBGridChangeColumn(nil, nil, 0);
end;

// refresh PageControl
procedure TfmMain.dxDBGridChangeColumn(Sender: TObject;
  Node: TdxTreeListNode; Column: Integer);
begin
  with dxDBGrid do
    pcPageControl.ActivePage := TabSheetByColumn(TdxDBGridColumn(VisibleColumns[FocusedColumn]));
end;

// call refresh PageControl
procedure TfmMain.dxDBGridColumnMoved(Sender: TObject; FromIndex,
  ToIndex: Integer);
begin
  dxDBGridChangeColumn(nil, nil, 0);
end;

// change Active Page - find Column
procedure TfmMain.pcPageControlChange(Sender: TObject);
begin
  dxDBGrid.FocusedColumn := ColumnByTabSheet(pcPageControl.ActivePage).Index;
  LoadProperties;
end;

// data assign
procedure TfmMain.colPopupPopup(Sender: TObject; const EditText: String);
var
  MasterField: TField;
begin
  with colPopup.Field do
  begin
    MasterField := DataSet.FieldByName(KeyFields);
    tProducts.Locate(LookupKeyFields, MasterField.Value, []);
  end;
end;

// data assign
procedure TfmMain.colPopupCloseUp(Sender: TObject; var Text: String;
  var Accept: Boolean);
var
  MasterField: TField;
  AValue: Variant;
begin
  if Accept then
  with colPopup.Field do
  begin
    MasterField := DataSet.FieldByName(KeyFields);
    AValue := tProducts.FieldByName(LookupKeyFields).Value;
    if MasterField.CanModify then
    begin
      DataSet.Edit;
      if VarIsNull(AValue) then MasterField.Clear
      else MasterField.Value := AValue;
    end;
  end;
  // Refresh Width
  LoadProperties;
end;

// Refresh buttons if properties changed
procedure TfmMain.colExtLookupCloseUp(Sender: TObject; var Text: String;
  var Accept: Boolean);
begin
  LoadProperties;
end;

procedure TfmMain.cbPBorderStyleClick(Sender: TObject);
begin
  colPopup.PopupFormBorderStyle := TdxPopupEditFormBorderStyle(cbPBorderStyle.ItemIndex);
end;

procedure TfmMain.edPCaptionChange(Sender: TObject);
begin
  colPopup.PopupFormCaption := edPCaption.Text;
end;

procedure TfmMain.cbPClientEdgeClick(Sender: TObject);
begin
  colPopup.PopupFormClientEdge := cbPClientEdge.Checked;
end;

procedure TfmMain.cbPFlatBorderClick(Sender: TObject);
begin
  colPopup.PopupFormFlatBorder := cbPFlatBorder.Checked;
end;

procedure TfmMain.cbPSizeableClick(Sender: TObject);
begin
  colPopup.PopupFormSizeable := cbPSizeable.Checked;
end;

procedure TfmMain.cbPAutoSizeClick(Sender: TObject);
begin
  colPopup.PopupAutoSize := cbPAutoSize.checked;
end;

procedure TfmMain.sePMinWidthExit(Sender: TObject);
begin
  colPopup.PopupMinWidth := Round(sePMinWidth.Value);
end;

procedure TfmMain.sePMinHeightChange(Sender: TObject);
begin
  colPopup.PopupMinHeight := Round(sePMinHeight.Value);
end;

procedure TfmMain.sePWidthExit(Sender: TObject);
begin
  colPopup.PopupWidth := Round(sePWidth.Value);
end;

procedure TfmMain.sePHeightExit(Sender: TObject);
begin
  colPopup.PopupHeight := Round(sePHeight.Value);
end;

procedure TfmMain.hkLClearKeyExit(Sender: TObject);
begin
  colLookup.ClearKey := hkLClearKey.HotKey;
end;

procedure TfmMain.edLDropDownRowsExit(Sender: TObject);
begin
  colLookup.DropDownRows := StrToInt(edLDropDownRows.Text);
end;

procedure TfmMain.cbLListFieldNameClick(Sender: TObject);
begin
  colLookup.ListFieldName := cbLListFieldName.Items.Strings[cbLListFieldName.ItemIndex];
end;

procedure TfmMain.cbLImmediateDropDownClick(Sender: TObject);
begin
  colLookup.ImmediateDropDown := cbLImmediateDropDown.Checked;
end;

procedure TfmMain.seLListFieldIndexChange(Sender: TObject);
begin
  colLookup.ListFieldIndex := Round(seLListFieldIndex.Value);
end;

procedure TfmMain.seLListWidthChange(Sender: TObject);
begin
  colLookup.ListWidth := Round(seLListWidth.Value);
end;

procedure TfmMain.hkEClearKeyExit(Sender: TObject);
begin
  colExtLookup.ClearKey := hkEClearKey.HotKey;
end;

procedure TfmMain.cbEBorderStyleClick(Sender: TObject);
begin
  colExtLookup.PopupFormBorderStyle := TdxPopupEditFormBorderStyle(cbEBorderStyle.ItemIndex);
end;

procedure TfmMain.edEFormCaptionChange(Sender: TObject);
begin
  colExtLookup.PopupFormCaption := edEFormCaption.Text;
end;

procedure TfmMain.cbEClientEdgeClick(Sender: TObject);
begin
  colExtLookup.PopupFormClientEdge := cbEClientEdge.Checked;
end;

procedure TfmMain.cbEFlatBorderClick(Sender: TObject);
begin
  colExtLookup.PopupFormFlatBorder := cbEFlatBorder.Checked;
end;

procedure TfmMain.cbESizeableClick(Sender: TObject);
begin
  colExtLookup.PopupFormSizeable := cbESizeable.Checked;
end;

procedure TfmMain.cbEAutoSizeClick(Sender: TObject);
begin
  colExtLookup.PopupAutoSize := cbEAutoSize.Checked;
end;

procedure TfmMain.seEPopupWidthExit(Sender: TObject);
begin
  colExtLookup.PopupWidth := Round(seEPopupWidth.Value);
end;

procedure TfmMain.seEPopupHeightExit(Sender: TObject);
begin
  colExtLookup.PopupHeight := Round(seEPopupHeight.Value);
end;

procedure TfmMain.seEPopupMinWidthExit(Sender: TObject);
begin
  colExtLookup.PopupMinWidth := Round(seEPopupMinWidth.Value);
end;

procedure TfmMain.seEPopupMinHeightExit(Sender: TObject);
begin
  colExtLookup.PopupMinHeight := Round(seEPopupMinHeight.Value);
end;

end.
















