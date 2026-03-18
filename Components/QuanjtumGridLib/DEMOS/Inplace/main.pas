unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  dxCntner, dxTL, ComCtrls, Db, DBTables, Menus, dxDBCtrl, ExtCtrls, Buttons,
  Spin, StdCtrls, dxExEdtr, dxCalc, dxDBEdtr, dxEdLib, dxEditor, dxGrClms,
  dxDBGrid, dxDBTLCl, ImgList;

type
  TfmMain = class(TForm)
    pgColumns: TPageControl;
    GridImageList: TImageList;
    tProducts: TTable;
    tProductsID: TIntegerField;
    tProductsNAME: TStringField;
    tProductsDescription: TStringField;
    dsContacts: TDataSource;
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
    tsStandard: TTabSheet;
    tsMask: TTabSheet;
    tsButton: TTabSheet;
    tsDate: TTabSheet;
    tsCheck: TTabSheet;
    tsImage: TTabSheet;
    tsSpin: TTabSheet;
    tsLookup: TTabSheet;
    tsPickList: TTabSheet;
    tsCalc: TTabSheet;
    Label1: TLabel;
    edEditMask: TdxEdit;
    Panel1: TPanel;
    btRestoreDefaults: TButton;
    btRestoreDefaultWidth: TButton;
    rgEditButtonStyle: TdxPickEdit;
    Label2: TLabel;
    Label3: TLabel;
    Shape1: TShape;
    btLoadImage: TButton;
    imGlyph: TImage;
    cbToggleEvent: TdxCheckEdit;
    cbBorder3D: TdxCheckEdit;
    rgShowNullFieldStyle: TdxPickEdit;
    Label4: TLabel;
    edValueChecked: TdxEdit;
    Label5: TLabel;
    edValueUnChecked: TdxEdit;
    cbShowDescription: TdxCheckEdit;
    Label7: TLabel;
    edDropDownRows: TdxSpinEdit;
    cbEditorEnabled: TdxCheckEdit;
    Label8: TLabel;
    edIncrement: TdxSpinEdit;
    Label9: TLabel;
    edMinValue: TdxSpinEdit;
    lbMaxValue: TLabel;
    edMaxValue: TdxSpinEdit;
    Label10: TLabel;
    edDropDownRowsLookup: TdxSpinEdit;
    cbImmediateDropDown: TdxCheckEdit;
    Label11: TLabel;
    edListFieldName: TdxEdit;
    lbListFieldIndex: TLabel;
    edListFieldIndex: TdxSpinEdit;
    Label13: TLabel;
    edListWidth: TdxSpinEdit;
    Label12: TLabel;
    edDropDownRowsPickList: TdxSpinEdit;
    cbImmediateDropDownPickList: TdxCheckEdit;
    cbBeepOnError: TdxCheckEdit;
    rgButtonStyle: TdxPickEdit;
    cbShowButtonFrame: TdxCheckEdit;
    Label14: TLabel;
    edPrecision: TdxSpinEdit;
    edClickKey: THotKey;
    Label15: TLabel;
    edClearKey: THotKey;
    Label16: TLabel;
    cbAlignment: TdxPickEdit;
    Label17: TLabel;
    edCaption: TdxEdit;
    Label18: TLabel;
    edMinWidth: TdxSpinEdit;
    Label19: TLabel;
    edWidth: TdxSpinEdit;
    cbReadOnly: TdxCheckEdit;
    Label20: TLabel;
    cbSort: TdxPickEdit;
    cbVisible: TdxCheckEdit;
    Label21: TLabel;
    cbSizing: TdxCheckEdit;
    Label22: TLabel;
    Shape2: TShape;
    btnLoadImage: TButton;
    imHeaderGlyph: TImage;
    cbDisableEditor: TdxCheckEdit;
    cbDisableCaption: TdxCheckEdit;
    cbFieldName: TdxPickEdit;
    MainMenu: TMainMenu;
    File1: TMenuItem;
    View1: TMenuItem;
    Help1: TMenuItem;
    About1: TMenuItem;
    miExit: TMenuItem;
    miColumns: TMenuItem;
    N1: TMenuItem;
    miFlat: TMenuItem;
    miAutoPreview: TMenuItem;
    OpenPictureDialog: TOpenDialog;
    tsBlobMemo: TTabSheet;
    tsBlobPicture: TTabSheet;
    tContactsPicture: TGraphicField;
    cbMemoWordWrap: TdxCheckEdit;
    rgMemoScrollBars: TdxPickEdit;
    rgPopupBorder: TdxPickEdit;
    cbSizeablePopup: TdxCheckEdit;
    rgPopupBorderIm: TdxPickEdit;
    cbPictureAutoSize: TdxCheckEdit;
    cbSizeablePopupIm: TdxCheckEdit;
    BitBtn1: TBitBtn;
    OpenBmpDialog: TOpenDialog;
    tContactsCurrency: TCurrencyField;
    tContactsTime: TTimeField;
    tContactsHyperLink: TStringField;
    tsCurrency: TTabSheet;
    tsTime: TTabSheet;
    tsHyperLink: TTabSheet;
    Label29: TLabel;
    seDecimalPlaces: TdxSpinEdit;
    Label30: TLabel;
    pEditFontColor: TPanel;
    Label31: TLabel;
    hkStartKey: THotKey;
    ColorDialog: TColorDialog;
    cbUseCtrlIncrement: TdxCheckEdit;
    cbUseCtrl: TdxCheckEdit;
    Label32: TLabel;
    pEditBackgroundColor: TPanel;
    cbSingleClick: TdxCheckEdit;
    Label33: TLabel;
    Label34: TLabel;
    edMin: TdxSpinEdit;
    edMax: TdxSpinEdit;
    Label35: TLabel;
    cbDateOnError: TdxPickEdit;
    cbDateValidation: TdxCheckEdit;
    cbOnDateValidateInput: TdxCheckEdit;
    cbUseLargeImages: TdxCheckEdit;
    cbMultiLineText: TdxCheckEdit;
    Label36: TLabel;
    edImageListWidth: TdxSpinEdit;
    LargeImages: TImageList;
    cbShowExPopupItems: TdxCheckEdit;
    cbShowPicturePopup: TdxCheckEdit;
    cbQuickClose: TdxCheckEdit;
    chbAlwaysSaveText: TdxCheckEdit;
    chbMemoWantTabs: TdxCheckEdit;
    dxDBGrid: TdxDBGrid;
    colStandard: TdxDBGridColumn;
    colMask: TdxDBGridMaskColumn;
    colCurrency: TdxDBGridCurrencyColumn;
    colButton: TdxDBGridButtonColumn;
    colDate: TdxDBGridDateColumn;
    colTime: TdxDBGridTimeColumn;
    colCheck: TdxDBGridCheckColumn;
    colSpin: TdxDBGridSpinColumn;
    colImage: TdxDBGridImageColumn;
    colLookup: TdxDBGridLookupColumn;
    colPickList: TdxDBGridPickColumn;
    colBlobMemo: TdxDBGridBlobColumn;
    colBlobPicture: TdxDBGridBlobColumn;
    colCalc: TdxDBGridCalcColumn;
    colHyperLink: TdxDBGridHyperLinkColumn;
    dxEditStyleController: TdxEditStyleController;
    dxCheckEditStyleController: TdxCheckEditStyleController;
    cbCharCase: TdxPickEdit;
    Label6: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    edPasswordChar: TdxEdit;
    seMaxLength: TdxSpinEdit;
    cbVerticalAlignment: TdxPickEdit;
    Label41: TLabel;
    cbToday: TdxCheckEdit;
    cbClear: TdxCheckEdit;
    cbSaveTime: TdxCheckEdit;
    edButtonCount: TdxSpinEdit;
    lbButtonCount: TLabel;
    Label42: TLabel;
    cbTimeFormat: TdxPickEdit;
    Label43: TLabel;
    Label44: TLabel;
    edValueGrayed: TdxEdit;
    edAllowGrayed: TdxCheckEdit;
    cbImageIncremental: TdxCheckEdit;
    cbCanDeleteText: TdxCheckEdit;
    cbPickListCanDeleteText: TdxCheckEdit;
    cbPickListRevertable: TdxCheckEdit;
    cbPickListSorted: TdxCheckEdit;
    Label45: TLabel;
    Label46: TLabel;
    Label23: TLabel;
    sePopupWidth: TdxSpinEdit;
    sePopupHeight: TdxSpinEdit;
    Label24: TLabel;
    Label27: TLabel;
    cbBlobStyle: TdxPickEdit;
    Label28: TLabel;
    seMaxLen: TdxSpinEdit;
    Label37: TLabel;
    edMemoMaxLength: TdxSpinEdit;
    cbHideScrollBars: TdxCheckEdit;
    cbSelectionBar: TdxCheckEdit;
    cbWantReturns: TdxCheckEdit;
    Label25: TLabel;
    sePopupWidthIm: TdxSpinEdit;
    Label26: TLabel;
    sePopupHeightIm: TdxSpinEdit;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    edCurrencyDisplayFormat: TdxEdit;
    cbDisableGrouping: TdxCheckEdit;
    edDisplayChecked: TdxEdit;
    edDisplayUnChecked: TdxEdit;
    edDisplayNull: TdxEdit;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    tsMRU: TTabSheet;
    colMRU: TdxDBGridMRUColumn;
    memoMRU: TdxMemo;
    Label53: TLabel;
    procedure tContactsCalcFields(DataSet: TDataSet);
    procedure dxDBGridChangeColumn(Sender: TObject; Node: TdxTreeListNode;
      Column: Integer);
    procedure dxDBGridColumnMoved(Sender: TObject; FromIndex,
      ToIndex: LongInt);
    procedure FormActivate(Sender: TObject);
    procedure pgColumnsChange(Sender: TObject);
    procedure colButtonEditButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btLoadImageClick(Sender: TObject);
    procedure btRestoreDefaultsClick(Sender: TObject);
    procedure btRestoreDefaultWidthClick(Sender: TObject);
    procedure colCheckToggleClick(Sender: TObject; const Text: String;
      State: TdxCheckBoxState);
    procedure btnLoadImageClick(Sender: TObject);
    procedure dxDBGridMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure About1Click(Sender: TObject);
    procedure miColumnsClick(Sender: TObject);
    procedure miFlatClick(Sender: TObject);
    procedure miAutoPreviewClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure pEditFontColorClick(Sender: TObject);
    procedure pEditBackgroundColorClick(Sender: TObject);
    procedure cbDateOnErrorChange(Sender: TObject);
    procedure colDateDateValidateInput(Sender: TObject;
      const AText: String; var ADate: TDateTime; var AMessage: String;
      var AError: Boolean);
    procedure cbAlignmentChange(Sender: TObject);
    procedure edCaptionExit(Sender: TObject);
    procedure cbSortChange(Sender: TObject);
    procedure cbFieldNameChange(Sender: TObject);
    procedure edWidthExit(Sender: TObject);
    procedure edMinWidthExit(Sender: TObject);
    procedure edEditMaskExit(Sender: TObject);
    procedure edClickKeyExit(Sender: TObject);
    procedure cbTodayChange(Sender: TObject);
    procedure cbClearChange(Sender: TObject);
    procedure cbDateValidationChange(Sender: TObject);
    procedure cbOnDateValidateInputChange(Sender: TObject);
    procedure cbUseCtrlChange(Sender: TObject);
    procedure edValueCheckedExit(Sender: TObject);
    procedure edValueUnCheckedExit(Sender: TObject);
    procedure cbBorder3DChange(Sender: TObject);
    procedure cbEditorEnabledChange(Sender: TObject);
    procedure cbUseCtrlIncrementChange(Sender: TObject);
    procedure edIncrementExit(Sender: TObject);
    procedure edMinValueExit(Sender: TObject);
    procedure edMaxValueExit(Sender: TObject);
    procedure edDropDownRowsExit(Sender: TObject);
    procedure cbShowDescriptionChange(Sender: TObject);
    procedure cbUseLargeImagesChange(Sender: TObject);
    procedure cbMultiLineTextChange(Sender: TObject);
    procedure edImageListWidthExit(Sender: TObject);
    procedure edClearKeyExit(Sender: TObject);
    procedure edDropDownRowsLookupExit(Sender: TObject);
    procedure cbImmediateDropDownChange(Sender: TObject);
    procedure edListFieldNameExit(Sender: TObject);
    procedure edListFieldIndexExit(Sender: TObject);
    procedure edListWidthExit(Sender: TObject);
    procedure edDropDownRowsPickListExit(Sender: TObject);
    procedure cbImmediateDropDownPickListChange(Sender: TObject);
    procedure cbMemoWordWrapChange(Sender: TObject);
    procedure sePopupWidthExit(Sender: TObject);
    procedure sePopupHeightExit(Sender: TObject);
    procedure cbSizeablePopupChange(Sender: TObject);
    procedure chbAlwaysSaveTextChange(Sender: TObject);
    procedure chbMemoWantTabsChange(Sender: TObject);
    procedure cbBlobStyleChange(Sender: TObject);
    procedure edMemoMaxLengthExit(Sender: TObject);
    procedure sePopupWidthImExit(Sender: TObject);
    procedure sePopupHeightImExit(Sender: TObject);
    procedure cbPictureAutoSizeChange(Sender: TObject);
    procedure cbSizeablePopupImChange(Sender: TObject);
    procedure cbShowPicturePopupChange(Sender: TObject);
    procedure cbShowExPopupItemsChange(Sender: TObject);
    procedure cbBeepOnErrorChange(Sender: TObject);
    procedure cbShowButtonFrameChange(Sender: TObject);
    procedure cbQuickCloseChange(Sender: TObject);
    procedure edPrecisionExit(Sender: TObject);
    procedure seDecimalPlacesExit(Sender: TObject);
    procedure edMinExit(Sender: TObject);
    procedure edMaxExit(Sender: TObject);
    procedure hkStartKeyExit(Sender: TObject);
    procedure cbSingleClickChange(Sender: TObject);
    procedure cbReadOnlyClick(Sender: TObject);
    procedure cbSizingClick(Sender: TObject);
    procedure cbVisibleClick(Sender: TObject);
    procedure cbDisableEditorClick(Sender: TObject);
    procedure cbDisableCaptionClick(Sender: TObject);
    procedure cbCharCaseChange(Sender: TObject);
    procedure edPasswordCharExit(Sender: TObject);
    procedure seMaxLengthExit(Sender: TObject);
    procedure cbVerticalAlignmentChange(Sender: TObject);
    procedure rgEditButtonStyleChange(Sender: TObject);
    procedure cbSaveTimeChange(Sender: TObject);
    procedure edButtonCountExit(Sender: TObject);
    procedure colButtonButtonClick(Sender: TObject;
      AbsoluteIndex: Integer);
    procedure cbTimeFormatChange(Sender: TObject);
    procedure rgShowNullFieldStyleChange(Sender: TObject);
    procedure edValueGrayedExit(Sender: TObject);
    procedure edAllowGrayedChange(Sender: TObject);
    procedure cbImageIncrementalChange(Sender: TObject);
    procedure cbCanDeleteTextChange(Sender: TObject);
    procedure cbPickListCanDeleteTextChange(Sender: TObject);
    procedure cbPickListRevertableChange(Sender: TObject);
    procedure cbPickListSortedChange(Sender: TObject);
    procedure rgMemoScrollBarsChange(Sender: TObject);
    procedure rgPopupBorderChange(Sender: TObject);
    procedure cbHideScrollBarsChange(Sender: TObject);
    procedure cbSelectionBarChange(Sender: TObject);
    procedure cbWantReturnsChange(Sender: TObject);
    procedure edCurrencyDisplayFormatExit(Sender: TObject);
    procedure cbDisableGroupingChange(Sender: TObject);
    procedure edDisplayCheckedExit(Sender: TObject);
    procedure edDisplayUnCheckedExit(Sender: TObject);
    procedure edDisplayNullExit(Sender: TObject);
    procedure memoMRUExit(Sender: TObject);
    procedure colMRUChange(Sender: TObject);
    procedure seMaxLenExit(Sender: TObject);
    procedure rgPopupBorderImChange(Sender: TObject);
    procedure rgButtonStyleChange(Sender: TObject);
  private
    procedure BindColumn2TabSheet(AColumn : TdxDBGridColumn; ATabSheet : TTabSheet);
    function ColumnByTabSheet(ATabSheet : TTabSheet): TdxDBGridColumn;
    function TabSheetByColumn(AColumn : TdxDBGridColumn): TTabSheet;
    procedure LoadProperties;
  public
  end;

var
  fmMain: TfmMain;

implementation

{$R *.DFM}

// init controls
procedure TfmMain.FormCreate(Sender: TObject);
var i : Integer;
begin
  tProducts.DataBaseName := '..\Data\';
  tContacts.DataBaseName := '..\Data\';
  tProducts.Open;  
  tContacts.Open;

  BindColumn2TabSheet(colStandard, tsStandard);
  BindColumn2TabSheet(TdxDBGridColumn(colMask), tsMask);
  BindColumn2TabSheet(TdxDBGridColumn(colButton), tsButton);
  BindColumn2TabSheet(TdxDBGridColumn(colDate), tsDate);
  BindColumn2TabSheet(TdxDBGridColumn(colCheck), tsCheck);
  BindColumn2TabSheet(TdxDBGridColumn(colImage), tsImage);
  BindColumn2TabSheet(TdxDBGridColumn(colSpin), tsSpin);
  BindColumn2TabSheet(TdxDBGridColumn(colLookup), tsLookup);
  BindColumn2TabSheet(TdxDBGridColumn(colPickList), tsPickList);
  BindColumn2TabSheet(TdxDBGridColumn(colCalc), tsCalc);
  BindColumn2TabSheet(TdxDBGridColumn(colBlobMemo), tsBlobMemo);
  BindColumn2TabSheet(TdxDBGridColumn(colBlobPicture), tsBlobPicture);
  BindColumn2TabSheet(TdxDBGridColumn(colCurrency), tsCurrency);
  BindColumn2TabSheet(TdxDBGridColumn(colTime), tsTime);
  BindColumn2TabSheet(TdxDBGridColumn(colHyperLink), tsHyperLink);
  BindColumn2TabSheet(TdxDBGridColumn(colMRU), tsMRU);  
  // load list box
  cbFieldName.Items.Clear;
  for i := 0 to tContacts.FieldCount - 1 do
    cbFieldName.Items.Add(tContacts.Fields[i].FieldName);
  LoadProperties;
  // init items
  miFlat.Checked := dxDBGrid.LookAndFeel = lfFlat;
  miAutoPreview.Checked := edgoPreview in dxDBGrid.OptionsView;
end;

procedure TfmMain.BindColumn2TabSheet(AColumn: TdxDBGridColumn; ATabSheet: TTabSheet);
begin
  AColumn.Tag := Integer(ATabSheet);
  ATabSheet.Tag := Integer(AColumn);
end;

//returns the column tied to  the given TabSheet
function TfmMain.ColumnByTabSheet(ATabSheet : TTabSheet): TdxDBGridColumn;
begin
  Result := TdxDBGridColumn(ATabSheet.Tag);
end;

//returns TabsSheet tied to the given column
function TfmMain.TabSheetByColumn(AColumn : TdxDBGridColumn): TTabSheet;
begin
  Result := TTabSheet(AColumn.Tag);
end;

procedure TfmMain.LoadProperties;
begin
  // Standard
  cbAlignment.ItemIndex := Integer(colStandard.Alignment);
  cbCharCase.ItemIndex := Integer(colStandard.CharCase);
  cbVerticalAlignment.ItemIndex := Integer(colStandard.VertAlignment);
  edPasswordChar.Text := colStandard.PasswordChar;
  edCaption.Text := colStandard.Caption;
  cbSort.ItemIndex := Integer(colStandard.Sorted);
  imHeaderGlyph.Picture.Bitmap.Assign(colStandard.HeaderGlyph);
  edMinWidth.Value := colStandard.MinWidth;
  edWidth.Value := colStandard.Width;
  cbFieldName.ItemIndex := cbFieldName.Items.IndexOf(colStandard.FieldName);
  cbReadOnly.Checked := colStandard.ReadOnly;
  cbReadOnly.Enabled := True;
  if Assigned(colStandard.Field) and
     not colStandard.Field.CanModify then cbReadOnly.Enabled := False;
  cbSizing.Checked := colStandard.Sizing;
  cbVisible.Checked := colStandard.Visible;
  cbDisableEditor.Checked := colStandard.DisableEditor;
  cbDisableCaption.Checked := colStandard.DisableCaption;
  seMaxLength.Value := colStandard.MaxLength;
  cbDisableGrouping.Checked := colStandard.DisableGrouping;
  // Mask
  edEditMask.Text := colMask.EditMask;
  // Button
  rgEditButtonStyle.ItemIndex := Integer(colButton.EditButtonStyle);
  edClickKey.HotKey := colButton.ClickKey;
  imGlyph.Picture.Bitmap.Assign(colButton.Glyph);
  edButtonCount.IntValue := colButton.Buttons.Count;
  // Date
  cbToday.Checked := btnToday in colDate.DateButtons;
  cbClear.Checked := btnClear in colDate.DateButtons;
  cbDateValidation.Checked := colDate.DateValidation;
  cbDateOnError.ItemIndex := Integer(colDate.DateOnError);
  cbOnDateValidateInput.Checked := Assigned(colDate.OnDateValidateInput);
  cbSaveTime.Checked := colDate.SaveTime;
  // Time
  cbUseCtrl.Checked := colTime.UseCtrlIncrement;
  cbTimeFormat.ItemIndex := Integer(colTime.TimeEditFormat);
  // Check
  rgShowNullFieldStyle.ItemIndex := Integer(colCheck.ShowNullFieldStyle);
  edValueChecked.Text := colCheck.ValueChecked;
  edValueUnChecked.Text := colCheck.ValueUnChecked;
  edValueGrayed.Text := colCheck.ValueGrayed;
  cbBorder3D.Checked := colCheck.Border3D;
  edAllowGrayed.Checked := colCheck.AllowGrayed;
  edDisplayChecked.Text := colCheck.DisplayChecked;
  edDisplayUnChecked.Text := colCheck.DisplayUnChecked;
  edDisplayNull.Text := colCheck.DisplayNull;
  // Image
  edDropDownRows.Value := colImage.DropDownRows;
  cbShowDescription.Checked := colImage.ShowDescription;
  cbUseLargeImages.Checked := Assigned(colImage.LargeImages);
  cbMultiLineText.Checked := colImage.MultiLineText;
  edImageListWidth.Value := colImage.ListWidth;
  cbImageIncremental.Checked := colImage.Incremental;
  // Spin
  cbEditorEnabled.Checked := colSpin.EditorEnabled;
  edIncrement.Text := FloatToStr(colSpin.Increment);
  edMinValue.Text := FloatToStr(colSpin.MinValue);
  edMaxValue.Text := FloatToStr(colSpin.MaxValue);
  cbUseCtrlIncrement.Checked := colSpin.UseCtrlIncrement;
  //Lookup
  edClearKey.HotKey := colLookup.ClearKey;
  edDropDownRowsLookup.Value := colLookup.DropDownRows;
  cbImmediateDropDown.Checked := colLookup.ImmediateDropDown;
  edListFieldName.Text := colLookup.ListFieldName;
  edListFieldIndex.Value := colLookup.ListFieldIndex;
  edListWidth.Value := colLookup.ListWidth;
  cbCanDeleteText.Checked := colLookup.CanDeleteText;
  // PickList
  edDropDownRowsPickList.Value := colPickList.DropDownRows;
  cbImmediateDropDownPickList.Checked := colPickList.ImmediateDropDown;
  cbPickListCanDeleteText.Checked := colPickList.CanDeleteText;
  cbPickListRevertable.Checked := colPickList.Revertable;
  cbPickListSorted.Checked := (colPickList.Sorted <> csNone);
  // Calc
  cbBeepOnError.Checked := colCalc.BeepOnError;
  cbShowButtonFrame.Checked := colCalc.ShowButtonFrame;
  rgButtonStyle.ItemIndex := Integer(colCalc.ButtonStyle);
  edPrecision.Value := colCalc.Precision;
  cbQuickClose.Checked := colCalc.QuickClose;

  //BlobMemo
  rgMemoScrollBars.ItemIndex := Integer(colBlobMemo.MemoScrollBars);
  cbMemoWordWrap.Checked := colBlobMemo.MemoWordWrap;
  rgPopupBorder.ItemIndex := Integer(colBlobMemo.PopupBorder);
  sePopupWidth.Value := colBlobMemo.PopupWidth;
  sePopupHeight.Value := colBlobMemo.PopupHeight;
  cbSizeablePopup.Checked := colBlobMemo.SizeablePopup;
  cbBlobStyle.ItemIndex := Integer(colBlobMemo.BlobPaintStyle);
  seMaxLen.Value := colBlobMemo.MaxDisplayLength;
  edMemoMaxLength.Value := colBlobMemo.MemoMaxLength;
  chbAlwaysSaveText.Checked := colBlobMemo.AlwaysSaveText;
  chbMemoWantTabs.Checked := colBlobMemo.MemoWantTabs;
  cbHideScrollBars.Checked := colBlobMemo.MemoHideScrollBars;
  cbSelectionBar.Checked := colBlobMemo.MemoSelectionBar;
  cbWantReturns.Checked := colBlobMemo.MemoWantReturns;
  // BlobPicture
  rgPopupBorderIm.ItemIndex := Integer(colBlobPicture.PopupBorder);
  sePopupWidthIm.Value := colBlobPicture.PopupWidth;
  sePopupHeightIm.Value := colBlobPicture.PopupHeight;
  cbSizeablePopupIm.Checked := colBlobPicture.SizeablePopup;
  cbPictureAutoSize.Checked := colBlobPicture.PictureAutoSize;
  cbShowPicturePopup.Checked := colBlobPicture.ShowPicturePopup;
  cbShowExPopupItems.Checked := colBlobPicture.ShowExPopupItems;

  // Currency
  seDecimalPlaces.Value := colCurrency.DecimalPlaces;
  edMin.Text := FormatFloat('0.#######',colCurrency.MinValue);
  edMax.Text := FormatFloat('0.#######',colCurrency.MaxValue);
  edCurrencyDisplayFormat.Text := colCurrency.DisplayFormat;
  
  // HyperLink
  pEditFontColor.Color := colHyperLink.EditFontColor;
  pEditbackgroundColor.Color := colHyperLink.EditBackgroundColor;
  hkStartKey.HotKey := colHyperLink.StartKey;
  cbSingleClick.Checked := colHyperLink.SingleClick;

  //MRU
  memoMRU.Lines.Assign(colMRU.Items);
end;

// Close Main Form
// Calc field CustName
procedure TfmMain.tContactsCalcFields(DataSet: TDataSet);
begin
  tContactsCustName.AsString := tContactsFirstName.AsString + ' ' + tContactsLastName.AsString;
end;

// call refresh PageControl
procedure TfmMain.FormActivate(Sender: TObject);
begin
  dxDBGridChangeColumn(nil, nil, 0);
end;

// call refresh PageControl
procedure TfmMain.dxDBGridColumnMoved(Sender: TObject; FromIndex,
  ToIndex: LongInt);
begin
  dxDBGridChangeColumn(nil, nil, 0);
end;

// refresh PageControl
procedure TfmMain.dxDBGridChangeColumn(Sender: TObject;
  Node: TdxTreeListNode; Column: Integer);
begin
  pgColumns.ActivePage := TabSheetByColumn(TdxDBGridColumn(dxDBGrid.VisibleColumns[dxDBGrid.FocusedColumn]));
end;

// change Active Page - find Column
procedure TfmMain.pgColumnsChange(Sender: TObject);
begin
  dxDBGrid.FocusedColumn := ColumnByTabSheet(pgColumns.ActivePage).Index;
  LoadProperties;
end;

// show drop down memo editor - exanple InplaceButtonEdit
procedure TfmMain.colButtonEditButtonClick(Sender: TObject);
begin

end;

// Refresh buttons if properties changed
procedure TfmMain.btLoadImageClick(Sender: TObject);
begin
  with OpenPictureDialog do
  if Execute then
  begin
    imGlyph.Picture.LoadFromFile(FileName);
    colButton.Glyph.Assign(imGlyph.Picture.Bitmap);
  end;
end;

// RestoreDefaults
procedure TfmMain.btRestoreDefaultsClick(Sender: TObject);
var
  Column : TdxDBGridColumn;
begin
   with dxDBGrid do
   begin
     CancelEditor;
     BeginUpdate;
     try
       Column := TdxDBGridColumn(ColumnByTabSheet(pgColumns.ActivePage));
       if Column <> nil then
         Column.RestoreDefaults;
     finally
       EndUpdate;
     end;
   end;
   LoadProperties;
end;

// RestoreDefaultWidth
procedure TfmMain.btRestoreDefaultWidthClick(Sender: TObject);
var
  Column : TdxDBGridColumn;
begin
   with dxDBGrid do
   begin
     CancelEditor;
     BeginUpdate;
     try
       Column := TdxDBGridColumn(ColumnByTabSheet(pgColumns.ActivePage));
       if Column <> nil then
         Column.RestoreDefaultWidth;
     finally
       EndUpdate;
     end;
   end;
   LoadProperties;
end;

procedure TfmMain.colCheckToggleClick(Sender: TObject; const Text: String;
  State: TdxCheckBoxState);
begin
  cbToggleEvent.Checked := State = cbsChecked;
end;

procedure TfmMain.btnLoadImageClick(Sender: TObject);
begin
  with OpenPictureDialog do
  if Execute then
  begin
    imHeaderGlyph.Picture.LoadFromFile(FileName);
    colStandard.HeaderGlyph.Assign(imHeaderGlyph.Picture.Bitmap);
  end;
end;

procedure TfmMain.dxDBGridMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  edWidth.Value := colStandard.Width;
end;

procedure TfmMain.About1Click(Sender: TObject);
begin
  MessageBox(Self.Handle, 'Inplace editors demo...', 'Information', MB_ICONINFORMATION);
end;

procedure TfmMain.miColumnsClick(Sender: TObject);
begin
  dxDBGrid.ColumnsCustomizing;
end;

procedure TfmMain.miFlatClick(Sender: TObject);
begin
  dxDBGrid.CancelEditor;
  if dxDBGrid.LookAndFeel = lfFlat then
  begin
    dxDBGrid.LookAndFeel := lfstandard;
    dxEditStyleController.BorderStyle := xbs3D;
    dxCheckEditStyleController.ButtonStyle := bts3D;
  end else
  begin
    dxDBGrid.LookAndFeel := lfFlat;
    dxEditStyleController.BorderStyle := xbsFlat;
    dxCheckEditStyleController.ButtonStyle := btsFlat;
  end;
  miFlat.Checked := dxDBGrid.LookAndFeel = lfFlat;
end;

procedure TfmMain.miAutoPreviewClick(Sender: TObject);
begin
  dxDBGrid.CancelEditor;
  if edgoPreview in dxDBGrid.OptionsView then
    dxDBGrid.OptionsView := dxDBGrid.OptionsView - [edgoPreview]
  else dxDBGrid.OptionsView := dxDBGrid.OptionsView + [edgoPreview];
  miAutoPreview.Checked := edgoPreview in dxDBGrid.OptionsView;
end;

procedure TfmMain.BitBtn1Click(Sender: TObject);
begin
 if OpenBmpDialog.Execute then
  with tContacts do begin
   Edit;
   TGraphicField(FieldByName('Picture')).LoadFromFile(OpenBmpDialog.FileName);
   Post;
  end;
end;

procedure TfmMain.pEditFontColorClick(Sender: TObject);
begin
  if ColorDialog.Execute then
  begin
    pEditFontColor.Color := ColorDialog.Color;
    colHyperLink.EditFontColor := pEditFontColor.Color;
  end;
end;

procedure TfmMain.pEditBackgroundColorClick(Sender: TObject);
begin
  if ColorDialog.Execute then begin
    pEditBackgroundColor.Color := ColorDialog.Color;
    colHyperLink.EditbackgroundColor := pEditBackgroundColor.Color;
  end;
end;

procedure TfmMain.cbDateOnErrorChange(Sender: TObject);
begin
  colDate.DateOnError := TDateOnError(cbDateOnError.ItemIndex);
end;

procedure TfmMain.colDateDateValidateInput(Sender: TObject;
  const AText: String; var ADate: TDateTime; var AMessage: String;
  var AError: Boolean);
begin
  // check valid date
  if AError then
    AMessage := 'Example OnDateValidateInput (Custom Message): Invalid Date!'
  else
  // check range
  if ADate < Date then
  begin
    Application.MessageBox(PChar('Example OnDateValidateInput (Custom Validate): please input Date >= Today'#13+
     'Current Date is '+AText), 'Error', 0);
     AError := False;
     Abort;
  end;
end;

procedure TfmMain.cbAlignmentChange(Sender: TObject);
begin
  colStandard.Alignment := TAlignment(cbAlignment.ItemIndex);
end;

procedure TfmMain.edCaptionExit(Sender: TObject);
begin
  colStandard.Caption := edCaption.Text;
end;

procedure TfmMain.cbSortChange(Sender: TObject);
begin
  colStandard.Sorted := TdxTreeListColumnSort(cbSort.ItemIndex);
end;

procedure TfmMain.cbFieldNameChange(Sender: TObject);
begin
  if cbFieldName.ItemIndex <> -1 then
    colStandard.FieldName := cbFieldName.Items[cbFieldName.ItemIndex];
end;

procedure TfmMain.edWidthExit(Sender: TObject);
begin
   colStandard.Width := edWidth.IntValue;
end;

procedure TfmMain.edMinWidthExit(Sender: TObject);
begin
  colStandard.MinWidth := edMinWidth.IntValue;
end;

procedure TfmMain.edEditMaskExit(Sender: TObject);
begin
  colMask.EditMask := edEditMask.Text;
end;

procedure TfmMain.edClickKeyExit(Sender: TObject);
begin
  colButton.ClickKey := edClickKey.HotKey;
end;

procedure TfmMain.cbTodayChange(Sender: TObject);
begin
  if cbToday.Checked then
    colDate.DateButtons := colDate.DateButtons + [btnToday]
  else colDate.DateButtons := colDate.DateButtons - [btnToday];
end;

procedure TfmMain.cbClearChange(Sender: TObject);
begin
  if cbClear.Checked then
    colDate.DateButtons := colDate.DateButtons + [btnClear]
  else colDate.DateButtons := colDate.DateButtons - [btnClear];
end;

procedure TfmMain.cbDateValidationChange(Sender: TObject);
begin
  colDate.DateValidation := cbDateValidation.Checked;
end;

procedure TfmMain.cbOnDateValidateInputChange(Sender: TObject);
begin
  if cbOnDateValidateInput.Checked then
    colDate.OnDateValidateInput := colDateDateValidateInput
  else colDate.OnDateValidateInput := nil;
end;

procedure TfmMain.cbUseCtrlChange(Sender: TObject);
begin
  colTime.UseCtrlIncrement := cbUseCtrl.Checked;
end;

procedure TfmMain.edValueCheckedExit(Sender: TObject);
begin
  colCheck.ValueChecked := edValueChecked.Text;
end;

procedure TfmMain.edValueUnCheckedExit(Sender: TObject);
begin
  colCheck.ValueUnChecked := edValueUnChecked.Text;
end;

procedure TfmMain.cbBorder3DChange(Sender: TObject);
begin
  colCheck.Border3D := cbBorder3D.Checked;
end;

procedure TfmMain.cbEditorEnabledChange(Sender: TObject);
begin
  colSpin.EditorEnabled := cbEditorEnabled.Checked;
end;

procedure TfmMain.cbUseCtrlIncrementChange(Sender: TObject);
begin
  colSpin.UseCtrlIncrement := cbUseCtrlIncrement.Checked;
end;

procedure TfmMain.edIncrementExit(Sender: TObject);
begin
  colSpin.Increment := edIncrement.IntValue;
end;

procedure TfmMain.edMinValueExit(Sender: TObject);
begin
  colSpin.MinValue := edMinValue.IntValue;
end;

procedure TfmMain.edMaxValueExit(Sender: TObject);
begin
  colSpin.MaxValue := edMaxValue.IntValue;
end;

procedure TfmMain.edDropDownRowsExit(Sender: TObject);
begin
  colImage.DropDownRows := edDropDownRows.IntValue;
end;

procedure TfmMain.cbShowDescriptionChange(Sender: TObject);
begin
  colImage.ShowDescription := cbShowDescription.Checked;
end;

procedure TfmMain.cbUseLargeImagesChange(Sender: TObject);
begin
  if cbUseLargeImages.Checked then
    colImage.LargeImages := LargeImages
  else colImage.LargeImages := nil;
end;

procedure TfmMain.cbMultiLineTextChange(Sender: TObject);
begin
  colImage.MultiLineText := cbMultiLineText.Checked;
end;

procedure TfmMain.edImageListWidthExit(Sender: TObject);
begin
  colImage.ListWidth := edImageListWidth.IntValue;
end;

procedure TfmMain.edClearKeyExit(Sender: TObject);
begin
  colLookup.ClearKey := edClearKey.HotKey;
end;

procedure TfmMain.edDropDownRowsLookupExit(Sender: TObject);
begin
  colLookup.DropDownRows := edDropDownRowsLookup.IntValue;
end;

procedure TfmMain.cbImmediateDropDownChange(Sender: TObject);
begin
  colLookup.ImmediateDropDown := cbImmediateDropDown.Checked;
end;

procedure TfmMain.edListFieldNameExit(Sender: TObject);
begin
  colLookup.ListFieldName := edListFieldName.Text;
end;

procedure TfmMain.edListFieldIndexExit(Sender: TObject);
begin
  colLookup.ListFieldIndex := edListFieldIndex.IntValue;
end;

procedure TfmMain.edListWidthExit(Sender: TObject);
begin
  colLookup.ListWidth := edListWidth.IntValue;
end;

procedure TfmMain.edDropDownRowsPickListExit(Sender: TObject);
begin
  colPickList.DropDownRows := edDropDownRowsPickList.IntValue;
end;

procedure TfmMain.cbImmediateDropDownPickListChange(Sender: TObject);
begin
  colPickList.ImmediateDropDown := cbImmediateDropDownPickList.Checked;
end;

procedure TfmMain.cbMemoWordWrapChange(Sender: TObject);
begin
  colBlobMemo.MemoWordWrap := cbMemoWordWrap.Checked;
end;

procedure TfmMain.sePopupWidthExit(Sender: TObject);
begin
  colBlobMemo.PopupWidth := sePopupWidth.IntValue;
end;

procedure TfmMain.sePopupHeightExit(Sender: TObject);
begin
  colBlobMemo.PopupHeight := sePopupHeight.IntValue;
end;

procedure TfmMain.cbSizeablePopupChange(Sender: TObject);
begin
  colBlobMemo.SizeablePopup := cbSizeablePopup.Checked;
end;

procedure TfmMain.chbAlwaysSaveTextChange(Sender: TObject);
begin
  colBlobMemo.AlwaysSaveText := chbAlwaysSaveText.Checked;
end;

procedure TfmMain.chbMemoWantTabsChange(Sender: TObject);
begin
  colBlobMemo.MemoWantTabs := chbMemoWantTabs.Checked;
end;

procedure TfmMain.cbBlobStyleChange(Sender: TObject);
begin
  colBlobMemo.BlobPaintStyle := TdxBlobPaintStyle(cbBlobStyle.ItemIndex);
end;

procedure TfmMain.edMemoMaxLengthExit(Sender: TObject);
begin
  colBlobMemo.MemoMaxLength := edMemoMaxLength.IntValue;
end;

procedure TfmMain.sePopupWidthImExit(Sender: TObject);
begin
  colBlobPicture.PopupWidth := sePopupWidthIm.IntValue;
end;

procedure TfmMain.sePopupHeightImExit(Sender: TObject);
begin
  colBlobPicture.PopupHeight := sePopupHeightIm.IntValue;
end;

procedure TfmMain.cbPictureAutoSizeChange(Sender: TObject);
begin
  colBlobPicture.PictureAutoSize := cbPictureAutoSize.Checked;
end;

procedure TfmMain.cbSizeablePopupImChange(Sender: TObject);
begin
  colBlobPicture.SizeablePopup := cbSizeablePopupIm.Checked;
end;

procedure TfmMain.cbShowPicturePopupChange(Sender: TObject);
begin
  colBlobPicture.ShowPicturePopup := cbShowPicturePopup.Checked;
end;

procedure TfmMain.cbShowExPopupItemsChange(Sender: TObject);
begin
  colBlobPicture.ShowExPopupItems := cbShowExPopupItems.Checked;
end;

procedure TfmMain.cbBeepOnErrorChange(Sender: TObject);
begin
  colCalc.BeepOnError := cbBeepOnError.Checked;
end;

procedure TfmMain.cbShowButtonFrameChange(Sender: TObject);
begin
  colCalc.ShowButtonFrame := cbShowButtonFrame.Checked;
end;

procedure TfmMain.cbQuickCloseChange(Sender: TObject);
begin
  colCalc.QuickClose := cbQuickClose.Checked;
end;

procedure TfmMain.edPrecisionExit(Sender: TObject);
begin
  colCalc.Precision := edPrecision.IntValue;
end;

procedure TfmMain.seDecimalPlacesExit(Sender: TObject);
begin
  colCurrency.DecimalPlaces := seDecimalPlaces.IntValue;
end;

procedure TfmMain.edMinExit(Sender: TObject);
begin
  colCurrency.MinValue := edMin.IntValue;
end;

procedure TfmMain.edMaxExit(Sender: TObject);
begin
  colCurrency.MaxValue := edMax.IntValue;
end;

procedure TfmMain.hkStartKeyExit(Sender: TObject);
begin
  colHyperLink.StartKey := hkStartKey.HotKey;
end;

procedure TfmMain.cbSingleClickChange(Sender: TObject);
begin
  colHyperLink.SingleClick := cbSingleClick.Checked;
end;

procedure TfmMain.cbReadOnlyClick(Sender: TObject);
begin
  if cbReadOnly.Enabled then
    colStandard.ReadOnly := cbReadOnly.Checked;
end;

procedure TfmMain.cbSizingClick(Sender: TObject);
begin
  colStandard.Sizing := cbSizing.Checked;
end;

procedure TfmMain.cbVisibleClick(Sender: TObject);
begin
  colStandard.Visible := cbVisible.Checked;
end;

procedure TfmMain.cbDisableEditorClick(Sender: TObject);
begin
  colStandard.DisableEditor := cbDisableEditor.Checked;
end;

procedure TfmMain.cbDisableCaptionClick(Sender: TObject);
begin
  colStandard.DisableCaption := cbDisableCaption.Checked;
end;

procedure TfmMain.cbCharCaseChange(Sender: TObject);
begin
  colStandard.CharCase := TEditCharCase(cbCharCase.ItemIndex);
end;

procedure TfmMain.edPasswordCharExit(Sender: TObject);
begin
  if edPasswordChar.Text <> '' then
    colStandard.PasswordChar := edPasswordChar.Text[1]
  else colStandard.PasswordChar := #0;
end;

procedure TfmMain.seMaxLengthExit(Sender: TObject);
begin
  colStandard.MaxLength := seMaxLength.IntValue;
end;

procedure TfmMain.cbVerticalAlignmentChange(Sender: TObject);
begin
  colStandard.VertAlignment := TTextLayout(cbVerticalAlignment.ItemIndex);
end;

procedure TfmMain.rgEditButtonStyleChange(Sender: TObject);
begin
  colButton.EditButtonStyle := TdxEditButtonStyle(rgEditButtonStyle.ItemIndex);
  edButtonCount.IntValue := colButton.Buttons.Count;
end;

procedure TfmMain.cbSaveTimeChange(Sender: TObject);
begin
  colDate.SaveTime := cbSaveTime.Checked;
end;

procedure TfmMain.edButtonCountExit(Sender: TObject);
begin
  while colButton.Buttons.Count <> edButtonCount.IntValue do
  begin
    if colButton.Buttons.Count > edButtonCount.IntValue then
      colButton.Buttons[colButton.Buttons.Count - 1].Free
    else colButton.Buttons.Add;
  end;
end;

procedure TfmMain.colButtonButtonClick(Sender: TObject;
  AbsoluteIndex: Integer);
begin
  MessageDlg('You click on Button Column. Button No. ' + IntToStr(AbsoluteIndex + 1), mtInformation, [mbOK],0);
end;

procedure TfmMain.cbTimeFormatChange(Sender: TObject);
begin
  colTime.TimeEditFormat := TdxTimeEditFormat(cbTimeFormat.ItemIndex);
end;

procedure TfmMain.rgShowNullFieldStyleChange(Sender: TObject);
begin
  colCheck.ShowNullFieldStyle := TdxShowNullFieldStyle(rgShowNullFieldStyle.ItemIndex);
end;

procedure TfmMain.edValueGrayedExit(Sender: TObject);
begin
  colCheck.ValueGrayed := edValueGrayed.Text;
end;

procedure TfmMain.edAllowGrayedChange(Sender: TObject);
begin
  colCheck.AllowGrayed := edAllowGrayed.Checked;
end;

procedure TfmMain.cbImageIncrementalChange(Sender: TObject);
begin
  colImage.Incremental := cbImageIncremental.Checked;
end;

procedure TfmMain.cbCanDeleteTextChange(Sender: TObject);
begin
  colLookup.CanDeleteText := cbCanDeleteText.Checked;
end;

procedure TfmMain.cbPickListCanDeleteTextChange(Sender: TObject);
begin
  colPickList.CanDeleteText := cbPickListCanDeleteText.Checked;
end;

procedure TfmMain.cbPickListRevertableChange(Sender: TObject);
begin
  colPickList.Revertable := cbPickListRevertable.Checked;
end;

procedure TfmMain.cbPickListSortedChange(Sender: TObject);
begin
  if cbPickListSorted.Checked then
    colPickList.Sorted := csDown
  else
    colPickList.Sorted := csNone;
end;

procedure TfmMain.rgMemoScrollBarsChange(Sender: TObject);
begin
  colBlobMemo.MemoScrollBars := TScrollStyle(rgMemoScrollBars.ItemIndex);
end;

procedure TfmMain.rgPopupBorderChange(Sender: TObject);
begin
  colBlobMemo.PopupBorder := TdxPopupBorder(rgPopupBorder.ItemIndex);
end;

procedure TfmMain.cbHideScrollBarsChange(Sender: TObject);
begin
  colBlobMemo.MemoHideScrollBars := cbHideScrollBars.Checked;
end;

procedure TfmMain.cbSelectionBarChange(Sender: TObject);
begin
  colBlobMemo.MemoSelectionBar := cbSelectionBar.Checked;
end;

procedure TfmMain.cbWantReturnsChange(Sender: TObject);
begin
  colBlobMemo.MemoWantReturns := cbWantReturns.Checked;
end;

procedure TfmMain.edCurrencyDisplayFormatExit(Sender: TObject);
begin
  colCurrency.DisplayFormat := edCurrencyDisplayFormat.Text;
end;

procedure TfmMain.cbDisableGroupingChange(Sender: TObject);
begin
  colStandard.DisableGrouping := cbDisableGrouping.Checked;
end;

procedure TfmMain.edDisplayCheckedExit(Sender: TObject);
begin
  colCheck.DisplayChecked := edDisplayChecked.Text;
end;

procedure TfmMain.edDisplayUnCheckedExit(Sender: TObject);
begin
  colCheck.DisplayUnChecked := edDisplayUnChecked.Text;
end;

procedure TfmMain.edDisplayNullExit(Sender: TObject);
begin
  colCheck.DisplayNull := edDisplayNull.Text;
end;

procedure TfmMain.memoMRUExit(Sender: TObject);
begin
  colMRU.Items.Assign(memoMRU.Lines);
end;

procedure TfmMain.colMRUChange(Sender: TObject);
begin
  memoMRU.Lines.Assign(colMRU.Items);
end;

procedure TfmMain.seMaxLenExit(Sender: TObject);
begin
  colBlobMemo.MaxDisplayLength := seMaxLen.IntValue;
end;

procedure TfmMain.rgPopupBorderImChange(Sender: TObject);
begin
  colBlobPicture.PopupBorder := TdxPopupBorder(rgPopupBorderIm.ItemIndex);
end;

procedure TfmMain.rgButtonStyleChange(Sender: TObject);
begin
  colCalc.ButtonStyle := TdxButtonStyle(rgButtonStyle.ItemIndex);
end;

end.


