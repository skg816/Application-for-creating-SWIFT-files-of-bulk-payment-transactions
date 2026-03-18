unit main;

interface
{$I ..\DemoUtils\dxDemo.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls{$IFDEF DELPHI4}, ImgList{$ENDIF}, dxCntner, dxExEdtr, dxEdLib, Menus, ComCtrls,
  dxEditor, dxDBELib, Mask, dxCalc, jpeg, ExtDlgs, dxTL, dxDBEdtr, Db,
  DBTables, DBCtrls, dxExGrEd, dxExELib, dxLayout, dxGrClms;

type
  TfmWizardForm = class;

  TdxWizardDemoPage = class
  private
    FCaption: string;
    FDescription: string;
    FImageIndex: Integer;
    FPanel: TPanel;
  public
    property Caption: string read FCaption write FCaption;
    property Description: string read FDescription write FDescription;
    property ImageIndex: Integer read FImageIndex write FImageIndex;
    property Panel: TPanel read FPanel write FPanel;
  end;

  TdxWizardDemo = class
  private
    FActivePageIndex: Integer;
    FPageList: TList;
    FWizardForm: TfmWizardForm;
    function GetActivePage: TdxWizardDemoPage;
    function GetPage(Index: Integer): TdxWizardDemoPage;
    function GetPageCount: Integer;
    procedure SetActivePageIndex(Value: Integer);
  protected
    function AddPage: TdxWizardDemoPage;
    procedure Changed(APage: TdxWizardDemoPage);
    procedure Clear;
    property WizardForm: TfmWizardForm read FWizardForm;
  public
    constructor Create(AOwner: TfmWizardForm);
    destructor Destroy; override;
    procedure NextPage;
    procedure PrevPage;
    property ActivePage: TdxWizardDemoPage read GetActivePage;
    property PageCount: Integer read GetPageCount;
    property ActivePageIndex: Integer read FActivePageIndex write SetActivePageIndex;
    property Pages[Index: Integer]: TdxWizardDemoPage read GetPage;
  end;

  TfmWizardForm = class(TForm)
    Bevel: TBevel;
    bvBottom: TBevel;
    PTitle: TPanel;
    Panel1: TPanel;
    lbEditName: TLabel;
    lbEditDescription: TLabel;
    ImageClass: TImage;
    imgEditIcon: TImageList;
    ShapeImage: TShape;
    BPrev: TButton;
    BNext: TButton;
    BClose: TButton;
    cbShowHints: TdxCheckEdit;
    pmEdits: TPopupMenu;
    PageControl: TPageControl;
    tsEdit: TTabSheet;
    pnEdit: TPanel;
    PanelBk1: TPanel;
    Label10: TLabel;
    Bevel3: TBevel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    edAlignment: TdxImageEdit;
    cbEnabled: TdxCheckEdit;
    edMaxLength: TdxSpinEdit;
    cbReadOnly: TdxCheckEdit;
    cbAutoSelect: TdxCheckEdit;
    cbHideSelection: TdxCheckEdit;
    edPasswordChar: TdxEdit;
    BFont: TButton;
    BColor: TButton;
    Edit: TdxEdit;
    Label9: TLabel;
    pnHint: TPanel;
    lbHint: TLabel;
    spHint: TShape;
    tsMaskEdit: TTabSheet;
    FontDialog: TFontDialog;
    ColorDialog: TColorDialog;
    Panel_MaskEdit: TPanel;
    Label18: TLabel;
    MaskEdit: TdxMaskEdit;
    PanelBk2: TPanel;
    Label20: TLabel;
    Label1: TLabel;
    Bevel1: TBevel;
    cbIgnoreMaskBlank: TdxCheckEdit;
    edEditMask: TdxPopupEdit;
    tsMemo: TTabSheet;
    Panel_Memo: TPanel;
    Label22: TLabel;
    PanelBk3: TPanel;
    Label24: TLabel;
    edMemoSelectionBar: TdxCheckEdit;
    edMemoScrollBars: TdxPickEdit;
    cbMemoWantReturns: TdxCheckEdit;
    cbMemoWantTabs: TdxCheckEdit;
    cbMemoWordWrap: TdxCheckEdit;
    cbMemoHideScrollBars: TdxCheckEdit;
    Memo: TdxMemo;
    Label2: TLabel;
    Bevel2: TBevel;
    tsDateEdit: TTabSheet;
    Panel_DateEdit: TPanel;
    Label25: TLabel;
    PanelBk4: TPanel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    edDateOnError: TdxPickEdit;
    cbToday: TdxCheckEdit;
    cbClear: TdxCheckEdit;
    cbDateValidation: TdxCheckEdit;
    edDatePopupAlignment: TdxPickEdit;
    edDatePopupBorder: TdxPickEdit;
    cbSaveTime: TdxCheckEdit;
    cbUseEditMask: TdxCheckEdit;
    DateEdit: TdxDateEdit;
    Label3: TLabel;
    Bevel4: TBevel;
    tsButtonEdit: TTabSheet;
    Panel_ButtonEdit: TPanel;
    Label32: TLabel;
    PanelBk5: TPanel;
    Label35: TLabel;
    edViewStyle: TdxPickEdit;
    ButtonEdit: TdxButtonEdit;
    Label4: TLabel;
    Bevel5: TBevel;
    tsCheckEdit: TTabSheet;
    Panel_CheckEdit: TPanel;
    Label36: TLabel;
    PanelBk6: TPanel;
    Label38: TLabel;
    Label39: TLabel;
    Bevel7: TBevel;
    cbAllowGrayed: TdxCheckEdit;
    edCaption: TdxEdit;
    cbFullFocusRect: TdxCheckEdit;
    cbMultiLine: TdxCheckEdit;
    edNullStyle: TdxImageEdit;
    cbUseGlyph: TdxCheckEdit;
    CheckEdit: TdxCheckEdit;
    Label5: TLabel;
    Bevel6: TBevel;
    tsImageEdit: TTabSheet;
    Panel_ImageEdit: TPanel;
    Label40: TLabel;
    PanelBk7: TPanel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    edImagePopupAlignment: TdxPickEdit;
    edImagePopupBorder: TdxPickEdit;
    edDropDownWidth: TdxSpinEdit;
    edDropDownRows: TdxSpinEdit;
    ImageEdit: TdxImageEdit;
    Label6: TLabel;
    Bevel8: TBevel;
    Image16: TImageList;
    tsSpinEdit: TTabSheet;
    Panel_SpinEdit: TPanel;
    Label46: TLabel;
    PanelBk8: TPanel;
    Label48: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    edValueType: TdxPickEdit;
    edIncrement: TdxEdit;
    edMinValue: TdxEdit;
    edMaxValue: TdxEdit;
    cbEditorEnabled: TdxCheckEdit;
    SpinEdit: TdxSpinEdit;
    Label7: TLabel;
    Bevel9: TBevel;
    tsPickEdit: TTabSheet;
    Panel_PickEdit: TPanel;
    Label52: TLabel;
    PanelBk9: TPanel;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    edPickPopupAlignment: TdxPickEdit;
    edPickPopupBorder: TdxPickEdit;
    edPickDropDownWidth: TdxSpinEdit;
    edPickDropDownRows: TdxSpinEdit;
    cbDropDownListStyle: TdxCheckEdit;
    cbImmediateDropDown: TdxCheckEdit;
    cbRevertable: TdxCheckEdit;
    PickEdit: TdxPickEdit;
    Label8: TLabel;
    Bevel10: TBevel;
    tsCalcEdit: TTabSheet;
    Panel_CalcEdit: TPanel;
    Label58: TLabel;
    PanelBk10: TPanel;
    Label60: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    edCalcPopupAlignment: TdxPickEdit;
    edCalcPopupBorder: TdxPickEdit;
    cbQuickClose: TdxCheckEdit;
    cbShowButtonFrame: TdxCheckEdit;
    edButtonStyle: TdxPickEdit;
    edPrecision: TdxSpinEdit;
    cbBeepOnError: TdxCheckEdit;
    CalcEdit: TdxCalcEdit;
    tsHyperLinkEdit: TTabSheet;
    Panel_HyperLink: TPanel;
    Label64: TLabel;
    PanelBk11: TPanel;
    Bevel13: TBevel;
    cbSingleClick: TdxCheckEdit;
    cbHyperEdit: TdxCheckEdit;
    HyperLinkEdit: TdxHyperLinkEdit;
    Label11: TLabel;
    Bevel11: TBevel;
    Label12: TLabel;
    Bevel12: TBevel;
    tsTimeEdit: TTabSheet;
    Panel_TimeEdit: TPanel;
    Label67: TLabel;
    PanelBk12: TPanel;
    Label72: TLabel;
    edTimeEditFormat: TdxPickEdit;
    TimeEdit: TdxTimeEdit;
    Label13: TLabel;
    Bevel14: TBevel;
    tsCurrencyEdit: TTabSheet;
    Panel_CurrencyEdit: TPanel;
    Label87: TLabel;
    PanelBk13: TPanel;
    Label108: TLabel;
    Label109: TLabel;
    Label110: TLabel;
    Label111: TLabel;
    edDecimalPlaces: TdxSpinEdit;
    edDisplayFormat: TdxEdit;
    edCurrMinValue: TdxEdit;
    edCurrMaxValue: TdxEdit;
    CurrencyEdit: TdxCurrencyEdit;
    ImageListTime: TImageList;
    Label14: TLabel;
    Bevel15: TBevel;
    tsGraphicEdit: TTabSheet;
    Panel_GraphicEdit: TPanel;
    Label89: TLabel;
    PanelBk14: TPanel;
    pgGraphic: TPageControl;
    TabSheet21: TTabSheet;
    Label91: TLabel;
    Label106: TLabel;
    cbCenter: TdxCheckEdit;
    cbQuickDraw: TdxCheckEdit;
    cbStretch: TdxCheckEdit;
    edCustomFilter: TdxPickEdit;
    edTransparency: TdxPickEdit;
    TabSheet22: TTabSheet;
    Label93: TLabel;
    cbVisible: TdxCheckEdit;
    cbIsPopupMenu: TdxCheckEdit;
    edGraphicEditAlignment: TdxPickEdit;
    cbShowCaptions: TdxCheckEdit;
    cbToolbarPosStored: TdxCheckEdit;
    cbDblClickActivate: TdxCheckEdit;
    TabSheet23: TTabSheet;
    Bevel17: TBevel;
    Label92: TLabel;
    Label94: TLabel;
    cbCut: TdxCheckEdit;
    cbCopy: TdxCheckEdit;
    cbPaste: TdxCheckEdit;
    cbDelete: TdxCheckEdit;
    cbSaveToFile: TdxCheckEdit;
    cbLoadFromFile: TdxCheckEdit;
    cbCustom: TdxCheckEdit;
    edCustomButtonCaption: TdxEdit;
    edCustomButtonGlyph: TdxButtonEdit;
    GraphicEdit: TdxGraphicEdit;
    OpenPictureDialog: TOpenPictureDialog;
    tsBlobEdit: TTabSheet;
    Panel_BlobEdit: TPanel;
    Label95: TLabel;
    BlobImage: TImage;
    PanelBk15: TPanel;
    pgBlob: TPageControl;
    TabSheet25: TTabSheet;
    Label97: TLabel;
    Label98: TLabel;
    cbSizeablePopup: TdxCheckEdit;
    edBlobEditKind: TdxPickEdit;
    edBlobPaintStyle: TdxPickEdit;
    tsBlobMemo: TTabSheet;
    Label99: TLabel;
    Label100: TLabel;
    cbBlobMemoSelectionBar: TdxCheckEdit;
    edBlobMemoScrollBars: TdxPickEdit;
    cbBlobMemoWantReturns: TdxCheckEdit;
    cbBlobMemoWantTabs: TdxCheckEdit;
    cbBlobMemoWordWrap: TdxCheckEdit;
    cbBlobMemoHideScrollBars: TdxCheckEdit;
    cbBlobAlwaysSaveText: TdxCheckEdit;
    edBlobMemoMaxLength: TdxSpinEdit;
    tsBlobPicture: TTabSheet;
    Label101: TLabel;
    Label107: TLabel;
    cbPictureAutoSize: TdxCheckEdit;
    cbShowExPopupItems: TdxCheckEdit;
    cbShowPicturePopup: TdxCheckEdit;
    edPictureFilter: TdxPickEdit;
    edPictureTranparency: TdxPickEdit;
    BlobEdit: TdxBlobEdit;
    Label19: TLabel;
    Bevel16: TBevel;
    Label21: TLabel;
    Bevel18: TBevel;
    tsMRUEdit: TTabSheet;
    tsPopupEdit: TTabSheet;
    Panel2: TPanel;
    Label23: TLabel;
    PanelBk16: TPanel;
    Label26: TLabel;
    Label37: TLabel;
    Bevel19: TBevel;
    PopupEdit: TdxPopupEdit;
    Panel_MRUEdit: TPanel;
    Label31: TLabel;
    PanelBk17: TPanel;
    Label33: TLabel;
    Label53: TLabel;
    Bevel20: TBevel;
    seMaxItemCount: TdxSpinEdit;
    MRUEdit: TdxMRUEdit;
    cbShowEllipsis: TdxCheckEdit;
    OpenDialog: TOpenDialog;
    Label34: TLabel;
    Label41: TLabel;
    cbHideEditCursor: TdxCheckEdit;
    cbPopupAutoSize: TdxCheckEdit;
    Label47: TLabel;
    cbPopupClientEdge: TdxCheckEdit;
    cbPopupFlatBorder: TdxCheckEdit;
    Label59: TLabel;
    Label65: TLabel;
    cbPopupSizeable: TdxCheckEdit;
    peFormBorderStyle: TdxPickEdit;
    peFormCaption: TdxEdit;
    pePopupHeight: TdxSpinEdit;
    pePopupWidth: TdxSpinEdit;
    Label69: TLabel;
    pePopupMinHeight: TdxSpinEdit;
    pePopupMinWidth: TdxSpinEdit;
    Label70: TLabel;
    tsDBLookupEdit: TTabSheet;
    Panel_DBLookupEdit: TPanel;
    Label66: TLabel;
    PanelBk18: TPanel;
    Label68: TLabel;
    Label71: TLabel;
    Bevel21: TBevel;
    cbCanDeleteText: TdxCheckEdit;
    DBLookupEdit: TdxDBLookupEdit;
    edListFieldName: TdxEdit;
    Table: TTable;
    DataSource: TDataSource;
    TableLookup: TTable;
    DBNavigator1: TDBNavigator;
    cbLookupRevertable: TdxCheckEdit;
    TableEventNo: TAutoIncField;
    TableVenueNo: TIntegerField;
    TableEvent_Name: TStringField;
    TableEvent_Date: TDateField;
    TableEvent_Time: TTimeField;
    TableEvent_Description: TMemoField;
    TableTicket_price: TCurrencyField;
    TableEvent_Photo: TGraphicField;
    TableVenue: TStringField;
    tsDBExtLookupEdit: TTabSheet;
    Panel_DBExtLookupEdit: TPanel;
    Label74: TLabel;
    PanelBk19: TPanel;
    Label76: TLabel;
    Bevel22: TBevel;
    Label77: TLabel;
    cbCanDeleteTextExt: TdxCheckEdit;
    cbChooseByDblClick: TdxCheckEdit;
    DBNavigator2: TDBNavigator;
    DBExtLookupEdit: TdxDBExtLookupEdit;
    DBGridLayoutList: TdxDBGridLayoutList;
    DBExtLookupItem: TdxDBGridLayout;
    dsTableLookup: TDataSource;
    TabSheet1: TTabSheet;
    procedure FormCreate(Sender: TObject);
    procedure BCloseClick(Sender: TObject);
    procedure BNextClick(Sender: TObject);
    procedure BPrevClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure MenuItemClick(Sender: TObject);
    procedure ImageClassClick(Sender: TObject);
    procedure ShapeImageMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure cbShowHintsChange(Sender: TObject);
    procedure EditMouseEnter(Sender: TObject);
    procedure EditMouseLeave(Sender: TObject);
    procedure tsEditShow(Sender: TObject);
    procedure edAlignmentChange(Sender: TObject);
    procedure edMaxLengthChange(Sender: TObject);
    procedure edPasswordCharChange(Sender: TObject);
    procedure cbAutoSelectClick(Sender: TObject);
    procedure cbEnabledChange(Sender: TObject);
    procedure cbHideSelectionClick(Sender: TObject);
    procedure cbReadOnlyClick(Sender: TObject);
    procedure BFontClick(Sender: TObject);
    procedure BColorClick(Sender: TObject);
    procedure edEditMaskChange(Sender: TObject);
    procedure tsMaskEditShow(Sender: TObject);
    procedure cbIgnoreMaskBlankClick(Sender: TObject);
    procedure edEditMaskInitPopup(Sender: TObject);
    procedure edEditMaskCloseUp(Sender: TObject; var Text: String;
      var Accept: Boolean);
    procedure tsMemoShow(Sender: TObject);
    procedure edMemoScrollBarsChange(Sender: TObject);
    procedure cbMemoHideScrollBarsClick(Sender: TObject);
    procedure edMemoSelectionBarClick(Sender: TObject);
    procedure cbMemoWantReturnsClick(Sender: TObject);
    procedure cbMemoWantTabsClick(Sender: TObject);
    procedure cbMemoWordWrapClick(Sender: TObject);
    procedure edDateOnErrorChange(Sender: TObject);
    procedure edDatePopupAlignmentChange(Sender: TObject);
    procedure edDatePopupBorderChange(Sender: TObject);
    procedure cbTodayClick(Sender: TObject);
    procedure cbClearClick(Sender: TObject);
    procedure cbDateValidationClick(Sender: TObject);
    procedure cbSaveTimeClick(Sender: TObject);
    procedure cbUseEditMaskClick(Sender: TObject);
    procedure tsDateEditShow(Sender: TObject);
    procedure edViewStyleChange(Sender: TObject);
    procedure tsButtonEditShow(Sender: TObject);
    procedure ButtonEditButtonClick(Sender: TObject;
      AbsoluteIndex: Integer);
    procedure edCaptionChange(Sender: TObject);
    procedure edNullStyleChange(Sender: TObject);
    procedure cbAllowGrayedClick(Sender: TObject);
    procedure cbFullFocusRectClick(Sender: TObject);
    procedure cbMultiLineClick(Sender: TObject);
    procedure cbUseGlyphClick(Sender: TObject);
    procedure tsCheckEditShow(Sender: TObject);
    procedure tsImageEditShow(Sender: TObject);
    procedure edDropDownRowsChange(Sender: TObject);
    procedure edDropDownWidthChange(Sender: TObject);
    procedure edImagePopupAlignmentChange(Sender: TObject);
    procedure edImagePopupBorderChange(Sender: TObject);
    procedure tsSpinEditShow(Sender: TObject);
    procedure edIncrementChange(Sender: TObject);
    procedure edMinValueChange(Sender: TObject);
    procedure edMaxValueChange(Sender: TObject);
    procedure edValueTypeChange(Sender: TObject);
    procedure cbEditorEnabledClick(Sender: TObject);
    procedure tsPickEditShow(Sender: TObject);
    procedure edPickDropDownRowsChange(Sender: TObject);
    procedure edPickDropDownWidthChange(Sender: TObject);
    procedure edPickPopupAlignmentChange(Sender: TObject);
    procedure edPickPopupBorderChange(Sender: TObject);
    procedure cbDropDownListStyleClick(Sender: TObject);
    procedure cbImmediateDropDownClick(Sender: TObject);
    procedure cbRevertableClick(Sender: TObject);
    procedure tsCalcEditShow(Sender: TObject);
    procedure edButtonStyleChange(Sender: TObject);
    procedure edCalcPopupAlignmentChange(Sender: TObject);
    procedure edCalcPopupBorderChange(Sender: TObject);
    procedure edPrecisionChange(Sender: TObject);
    procedure cbBeepOnErrorClick(Sender: TObject);
    procedure cbQuickCloseClick(Sender: TObject);
    procedure cbShowButtonFrameClick(Sender: TObject);
    procedure tsHyperLinkEditShow(Sender: TObject);
    procedure cbSingleClickClick(Sender: TObject);
    procedure cbHyperEditClick(Sender: TObject);
    procedure tsTimeEditShow(Sender: TObject);
    procedure edTimeEditFormatChange(Sender: TObject);
    procedure tsCurrencyEditShow(Sender: TObject);
    procedure edDecimalPlacesChange(Sender: TObject);
    procedure edDisplayFormatChange(Sender: TObject);
    procedure edCurrMinValueChange(Sender: TObject);
    procedure edCurrMaxValueChange(Sender: TObject);
    procedure tsGraphicEditShow(Sender: TObject);
    procedure GraphicEditCustomClick(Sender: TObject);
    procedure edCustomFilterChange(Sender: TObject);
    procedure edTransparencyChange(Sender: TObject);
    procedure cbCenterClick(Sender: TObject);
    procedure cbQuickDrawClick(Sender: TObject);
    procedure cbStretchClick(Sender: TObject);
    procedure edGraphicEditAlignmentChange(Sender: TObject);
    procedure cbDblClickActivateClick(Sender: TObject);
    procedure cbIsPopupMenuClick(Sender: TObject);
    procedure cbShowCaptionsClick(Sender: TObject);
    procedure cbToolbarPosStoredClick(Sender: TObject);
    procedure cbVisibleClick(Sender: TObject);
    procedure ToolbarButtontClick(Sender: TObject);
    procedure edCustomButtonCaptionChange(Sender: TObject);
    procedure edCustomButtonGlyphButtonClick(Sender: TObject;
      AbsoluteIndex: Integer);
    procedure tsBlobEditShow(Sender: TObject);
    procedure edBlobEditKindChange(Sender: TObject);
    procedure edBlobPaintStyleChange(Sender: TObject);
    procedure cbSizeablePopupClick(Sender: TObject);
    procedure edBlobMemoScrollBarsChange(Sender: TObject);
    procedure edBlobMemoMaxLengthChange(Sender: TObject);
    procedure cbBlobAlwaysSaveTextClick(Sender: TObject);
    procedure cbBlobMemoHideScrollBarsClick(Sender: TObject);
    procedure cbBlobMemoSelectionBarClick(Sender: TObject);
    procedure cbBlobMemoWantReturnsClick(Sender: TObject);
    procedure cbBlobMemoWantTabsClick(Sender: TObject);
    procedure cbBlobMemoWordWrapClick(Sender: TObject);
    procedure edPictureFilterChange(Sender: TObject);
    procedure edPictureTranparencyChange(Sender: TObject);
    procedure cbPictureAutoSizeClick(Sender: TObject);
    procedure cbShowExPopupItemsClick(Sender: TObject);
    procedure cbShowPicturePopupClick(Sender: TObject);
    procedure PopupEditCloseUp(Sender: TObject; var Text: String;
      var Accept: Boolean);
    procedure MRUEditButtonClick(Sender: TObject);
    procedure tsMRUEditShow(Sender: TObject);
    procedure seMaxItemCountChange(Sender: TObject);
    procedure cbShowEllipsisClick(Sender: TObject);
    procedure tsPopupEditShow(Sender: TObject);
    procedure peFormBorderStyleChange(Sender: TObject);
    procedure peFormCaptionChange(Sender: TObject);
    procedure pePopupWidthChange(Sender: TObject);
    procedure pePopupHeightChange(Sender: TObject);
    procedure pePopupMinWidthChange(Sender: TObject);
    procedure pePopupMinHeightChange(Sender: TObject);
    procedure cbHideEditCursorClick(Sender: TObject);
    procedure cbPopupAutoSizeClick(Sender: TObject);
    procedure cbPopupClientEdgeClick(Sender: TObject);
    procedure cbPopupFlatBorderClick(Sender: TObject);
    procedure cbPopupSizeableClick(Sender: TObject);
    procedure tsDBLookupEditShow(Sender: TObject);
    procedure edListFieldNameChange(Sender: TObject);
    procedure cbCanDeleteTextClick(Sender: TObject);
    procedure cbLookupRevertableClick(Sender: TObject);
    procedure tsDBExtLookupEditShow(Sender: TObject);
    procedure cbCanDeleteTextExtClick(Sender: TObject);
    procedure cbChooseByDblClickClick(Sender: TObject);
  private
    FWizard: TdxWizardDemo;
    procedure AddMenuItem(const ACaption: string; AImageIndex: Integer);
    procedure AssignEnterLeaveEvents(AParent: TWinControl);
    procedure InitPageByTabSheet(APage: TdxWizardDemoPage; const ATabSheetName: string);
    procedure InitPanelBkColor(APanel: TPanel);
  protected
    procedure InitForm;
    procedure LoadPages;
    procedure PageChanged(APage: TdxWizardDemoPage);
    procedure UpdateButtons;
    procedure UpdatePopupMenu;
  public
    property Wizard: TdxWizardDemo read FWizard;
  end;

var
  fmWizardForm: TfmWizardForm;

implementation

{$R *.DFM}

uses
  MaskEd, preview, popup, dxDemoUtils;
                                                 
type
  TPageInfo = record
    Caption: string;
    ImageIndex: Integer;
    TabSheetName: string;
    Description: string;
  end;

const
  stPanelBkName = 'PanelBk';
  stDefaultHintText = 'Move the mouse over a control for a hint';
  TotalPageCount = 19;
  PagesInfo: array [0..TotalPageCount - 1] of TPageInfo = (
    (Caption: 'Edit'; ImageIndex: 0; TabSheetName: 'tsEdit';
       Description: 'TdxEdit is an improved version of the Windows single-line edit control.'),
    (Caption: 'Mask Edit'; ImageIndex: 1; TabSheetName: 'tsMaskEdit';
       Description: 'TdxMaskEdit is an improved version of the standard edit box that allows using different masks for data validation.'),
    (Caption: 'Memo'; ImageIndex: 2; TabSheetName: 'tsMemo';
       Description: 'TdxMemo is an edit control that allows editing data of memo/text type.'),
    (Caption: 'Date Edit'; ImageIndex: 3; TabSheetName: 'tsDateEdit';
       Description: 'TdxDateEdit is an edit control with a dropdown calendar. DateEdit perceived Smart Input: please type "TODAY", "TODAY+1" and other...'),
    (Caption: 'Button Edit'; ImageIndex: 4; TabSheetName: 'tsButtonEdit';
       Description: 'TdxButtonEdit is a standard edit box with an embedded button(s).'),
    (Caption: 'Check Edit'; ImageIndex: 5; TabSheetName: 'tsCheckEdit';
       Description: 'TdxCheckEdit is a check box edit control.'),
    (Caption: 'Image Edit'; ImageIndex: 6; TabSheetName: 'tsImageEdit';
       Description: 'TdxImageEdit is a button editor with a dropdown control, which can include both an image and its description for a specific value.'),
    (Caption: 'Spin Edit'; ImageIndex: 7; TabSheetName: 'tsSpinEdit';
       Description: 'TdxSpinEdit is an editor with spin buttons to increment or decrement numeric values.'),
    (Caption: 'Pick Edit'; ImageIndex: 8; TabSheetName: 'tsPickEdit';
       Description: 'TdxPickEdit is a button editor with an associated dropdown list box control, which contains a set of predefined values.'),
    (Caption: 'Calc Edit'; ImageIndex: 9; TabSheetName: 'tsCalcEdit';
       Description: 'TdxCalcEdit is a button edit control with a dropdown calculator window.'),
    (Caption: 'HyperLink Edit'; ImageIndex: 10; TabSheetName: 'tsHyperLinkEdit';
       Description: 'TdxHyperLinkEdit is a hyperlink (URL) editor, which can activate the default web-browser.'),
    (Caption: 'Time Edit'; ImageIndex: 11; TabSheetName: 'tsTimeEdit';
       Description: 'TdxTimeEdit is an editor for time values.'),
    (Caption: 'Currency Edit'; ImageIndex: 12; TabSheetName: 'tsCurrencyEdit';
       Description: 'TdxCurrencyEdit displays and edits currency values according to the regional settings.'),
    (Caption: 'Graphic Edit'; ImageIndex: 13; TabSheetName: 'tsGraphicEdit';
       Description: 'TdxGraphicEdit is an editor that works with images.'),
    (Caption: 'Blob Edit'; ImageIndex: 14; TabSheetName: 'tsBlobEdit';
       Description: 'TdxBlobEdit is a button type editor with the ability to display and edit BLOB data. The contents of Blobs are displayed within a sizeable dropdown window.'),
    (Caption: 'MRU Edit'; ImageIndex: 15; TabSheetName: 'tsMRUEdit';
       Description: 'TdxMRUEdit is a button type editor with the ability to display and edit a list of the most recently used (MRU) items.'),
    (Caption: 'Popup Edit'; ImageIndex: 16; TabSheetName: 'tsPopupEdit';
       Description: 'TdxPopupEdit is a button type editor with a dropdown window which can display another control.'),
    (Caption: 'DBLookup Edit'; ImageIndex: 17; TabSheetName: 'tsDBLookupEdit';
       Description: 'TdxDBLookupEdit is a component with a linked dropdown lookup list.'),
    (Caption: 'DBExtLookup Edit'; ImageIndex: 18; TabSheetName: 'tsDBExtLookupEdit';
       Description: 'Represents an extended lookup editor whose dropdown window includes the ExpressQuantumGrid.')
    );

{ TdxWizardDemo }

constructor TdxWizardDemo.Create(AOwner: TfmWizardForm);
begin
  inherited Create;
  FActivePageIndex := -1;
  FPageList := TList.Create;
  FWizardForm := AOwner;
end;

destructor TdxWizardDemo.Destroy;
begin
  Clear;
  inherited Destroy;
end;

procedure TdxWizardDemo.NextPage;
begin
  ActivePageIndex := ActivePageIndex + 1;
end;

procedure TdxWizardDemo.PrevPage;
begin
  ActivePageIndex := ActivePageIndex - 1;
end;

function TdxWizardDemo.AddPage: TdxWizardDemoPage;
begin
  Result := TdxWizardDemoPage.Create;
  FPageList.Add(Result);
end;

procedure TdxWizardDemo.Changed(APage: TdxWizardDemoPage);
begin
  WizardForm.PageChanged(APage);
end;

procedure TdxWizardDemo.Clear;
var
  I: Integer;
begin
  for I := 0 to FPageList.Count - 1 do
    TdxWizardDemoPage(FPageList[I]).Free;
  FPageList.Free;
end;

function TdxWizardDemo.GetActivePage: TdxWizardDemoPage;
begin
  if ActivePageIndex <> -1 then
    Result := Pages[ActivePageIndex]
  else
    Result := nil;
end;

function TdxWizardDemo.GetPage(Index: Integer): TdxWizardDemoPage;
begin
  Result := TdxWizardDemoPage(FPageList[Index]);
end;

function TdxWizardDemo.GetPageCount: Integer;
begin
  Result := FPageList.Count;
end;

procedure TdxWizardDemo.SetActivePageIndex(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if Value >= PageCount then Value := PageCount - 1;
  if FActivePageIndex <> Value then
  begin
    // Changing
    FActivePageIndex := Value;
    Changed(ActivePage);
  end;
end;

{ TfmWizardForm }

procedure TfmWizardForm.InitForm;
begin
  if Screen.Fonts.IndexOf('Tahoma') = -1 then
  begin
    ResetDefaultFontName(Self);
    ResetDefaultFontName(fmPopupTree.TreeList);
  end;
  ShapeImage.Cursor := crdxHandPointCursor;
  TfmWizardForm(ShapeImage).PopupMenu := ImageClass.PopupMenu;
  with ImageClass do
  begin
    Cursor := ShapeImage.Cursor;
    Picture.Bitmap.Width := 24;
    Picture.Bitmap.Height := 24;
  end;
  lbEditName.Font.Style := lbEditName.Font.Style + [fsBold];
  lbEditName.Font.Size := 9;
  lbHint.Font.Color := clInfoText;
  {$IFDEF DELPHI4}
  pmEdits.Images := imgEditIcon;
  {$ENDIF}
end;

procedure TfmWizardForm.LoadPages;
var
  I: Integer;
  APage: TdxWizardDemoPage;
begin
  ClearMenuItem(pmEdits.Items);
  for I := 0 to TotalPageCount - 1 do
  begin
    APage := Wizard.AddPage;
    APage.Caption := PagesInfo[I].Caption;
    APage.Description := PagesInfo[I].Description;
    APage.ImageIndex := PagesInfo[I].ImageIndex;
    InitPageByTabSheet(APage, PagesInfo[I].TabSheetName);
    AddMenuItem(APage.Caption, PagesInfo[I].ImageIndex);
  end;
end;

procedure TfmWizardForm.PageChanged(APage: TdxWizardDemoPage);
var
  I: Integer;
begin
  if Assigned(APage) then
  begin
    lbEditName.Caption := APage.Caption;
    lbEditDescription.Caption := APage.Description;
    // Image
    with ImageClass.Picture.Bitmap do
    begin
      Canvas.Brush.Color := clBtnFace;
      Canvas.FillRect(Rect(0, 0, Width, Height));
    end;
    imgEditIcon.Draw(ImageClass.Picture.Bitmap.Canvas, 0, 0, APage.ImageIndex);
    // Panel
    if Assigned(APage.Panel) then
      APage.Panel.Visible := True;
    for I := 0 to Wizard.PageCount - 1 do
      if Wizard.Pages[I] <> APage then
        if Assigned(Wizard.Pages[I].Panel) then
          Wizard.Pages[I].Panel.Visible := False;
  end;
  UpdateButtons;
  UpdatePopupMenu;
end;

procedure TfmWizardForm.UpdateButtons;
begin
  BPrev.Enabled := Wizard.ActivePageIndex > 0;
  BNext.Enabled := Wizard.ActivePageIndex < (Wizard.PageCount - 1);
end;

procedure TfmWizardForm.UpdatePopupMenu;
begin
  if (0 <= Wizard.ActivePageIndex) and (Wizard.ActivePageIndex < pmEdits.Items.Count) then
    pmEdits.Items[Wizard.ActivePageIndex].Checked := True;
end;

procedure TfmWizardForm.AddMenuItem(const ACaption: string; AImageIndex: Integer);
var
  AItem: TMenuItem;
begin
  AItem := TMenuItem.Create(Self);
  with AItem do
  begin
    Caption := ACaption;
    RadioItem := True;
  {$IFDEF DELPHI4}
    ImageIndex := AImageIndex;
  {$ENDIF}
    OnClick := MenuItemClick;
  end;
  if pmEdits.Items.Count = 9 then
    AItem.Break := mbBarBreak;
  pmEdits.Items.Add(AItem);
end;

procedure TfmWizardForm.AssignEnterLeaveEvents(AParent: TWinControl);
var
  AControl: TControl;
  I: Integer;
begin
  for I := 0 to AParent.ControlCount - 1 do
  begin
    AControl := AParent.Controls[I];
    if (AControl is TdxInplaceEdit) and (TdxEdit(AControl).Hint <> '') then
    begin
      TdxEdit(AControl).OnMouseEnter := EditMouseEnter;
      TdxEdit(AControl).OnMouseLeave := EditMouseLeave;
    end
    else
      if AControl is TwinControl then
        AssignEnterLeaveEvents(AControl as TwinControl);
  end;
end;

procedure TfmWizardForm.InitPageByTabSheet(APage: TdxWizardDemoPage; const ATabSheetName: string);
var
  I: Integer;
  ATabSheet: TTabSheet;
begin
  ATabSheet := nil;
  for I := 0 to PageControl.PageCount - 1 do
    if CompareText(PageControl.Pages[I].Name, ATabSheetName) = 0 then
    begin
      ATabSheet := PageControl.Pages[I];
      Break;
    end;
  if ATabSheet <> nil then
  begin
    if (ATabSheet.ControlCount > 0) and (ATabSheet.Controls[0] is TPanel) then
    begin
      APage.Panel := ATabSheet.Controls[0] as TPanel;
      if Assigned(APage.Panel) then
      begin
        APage.Panel.Visible := False;
        APage.Panel.Align := alClient;
        APage.Panel.Parent := Self;
        InitPanelBkColor(APage.Panel);
        AssignEnterLeaveEvents(APage.Panel);
        if Assigned(ATabSheet.OnEnter) then
          ATabSheet.OnEnter(APage.Panel);
      end;
    end;
  end;
end;

procedure TfmWizardForm.InitPanelBkColor(APanel: TPanel);
var
  AColor: TColor;
  AControl: TControl;
  I: Integer;
begin
  AColor := LightColor(APanel.Color, 3, 10);
  AColor := GetNearestColor(Self.Canvas.Handle, AColor);
  for I := 0 to APanel.ControlCount - 1 do
  begin
    AControl := APanel.Controls[I];
    if (AControl is TPanel) and
      (CompareText(Copy(AControl.Name, 1, Length(stPanelBkName)), stPanelBkName) = 0) then
    begin
      (AControl as TPanel).Color := AColor;
      Break;
    end;
  end;
end;

// Form Events

procedure TfmWizardForm.FormCreate(Sender: TObject);
begin
  // TODO restore form size
//  Width := 594;
//  Height := 435; //422;
  FWizard := TdxWizardDemo.Create(Self);
  InitForm;
  LoadPages;
  Wizard.ActivePageIndex := 0;
end;

procedure TfmWizardForm.FormDestroy(Sender: TObject);
begin
  FWizard.Free;
  FWizard := nil; 
end;

procedure TfmWizardForm.BCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfmWizardForm.BNextClick(Sender: TObject);
begin
  Wizard.NextPage;
end;

procedure TfmWizardForm.BPrevClick(Sender: TObject);
begin
  Wizard.PrevPage;
end;

procedure TfmWizardForm.MenuItemClick(Sender: TObject);
var
  AItem: TMenuItem;
begin
  AItem := Sender as TMenuItem;
  Wizard.ActivePageIndex := AItem.Parent.IndexOf(AItem);
  AItem.Checked := True;
end;

procedure TfmWizardForm.ImageClassClick(Sender: TObject);
var
  P: TPoint;
begin
  GetCursorPos(P);
  if ImageClass.PopupMenu <> nil then
    ImageClass.PopupMenu.Popup(P.X, P.Y);
end;

procedure TfmWizardForm.ShapeImageMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ImageClassClick(nil);
end;

procedure TfmWizardForm.cbShowHintsChange(Sender: TObject);
begin
  pnHint.Top := bvBottom.Top - 1;
  if cbShowHints.Checked then
    Height := Height + pnHint.Height - 4
  else
    Height := Height - pnHint.Height + 4;
  pnHint.Visible := cbShowHints.Checked;

  pnHint.Top := bvBottom.Top - 1;
  bvBottom.Top := pnHint.Top + pnHint.Height + 1;  
  lbHint.Caption := stDefaultHintText;
end;

procedure TfmWizardForm.EditMouseEnter(Sender: TObject);
begin
  if cbShowHints.Checked and (Sender is TControl) then
    lbHint.Caption := TControl(Sender).Hint;
end;

procedure TfmWizardForm.EditMouseLeave(Sender: TObject);
begin
  lbHint.Caption := '';
end;

// Init Panels (Pages)

// Edit
procedure TfmWizardForm.tsEditShow(Sender: TObject);
begin
  with Edit do
  begin
    edAlignment.Text := IntToStr(Integer(Alignment));
    edMaxLength.Text := IntToStr(MaxLength);
    edPasswordChar.Text := PasswordChar;
    cbAutoSelect.Checked := AutoSelect;
    cbEnabled.Checked := Enabled;
    cbHideSelection.Checked := HideSelection;
    cbReadOnly.Checked := ReadOnly;
  end;
end;

// Mask Edit
procedure TfmWizardForm.tsMaskEditShow(Sender: TObject);
begin
  edEditMask.Text := MaskEdit.EditMask;
  cbIgnoreMaskBlank.Checked := MaskEdit.IgnoreMaskBlank;
end;

// Memo Edit
procedure TfmWizardForm.tsMemoShow(Sender: TObject);
begin
  with Memo do
  begin
    edMemoScrollBars.ItemIndex := Integer(ScrollBars);
    cbMemoHideScrollBars.Checked := HideScrollBars;
    edMemoSelectionBar.Checked := SelectionBar;
    cbMemoWantReturns.Checked := WantReturns;
    cbMemoWantTabs.Checked := WantTabs;
    cbMemoWordWrap.Checked := WordWrap;
  end;
end;

// Date Edit
procedure TfmWizardForm.tsDateEditShow(Sender: TObject);
begin
  with DateEdit do
  begin
    edDateOnError.ItemIndex := Integer(DateOnError);
    edDatePopupAlignment.ItemIndex := Integer(PopupAlignment);
    edDatePopupBorder.ItemIndex := Integer(PopupBorder);
    cbToday.Checked := btnToday in DateButtons;
    cbClear.Checked := btnClear in DateButtons;
    cbDateValidation.Checked := DateValidation;
    cbSaveTime.Checked := SaveTime;
    cbUseEditMask.Checked := UseEditMask;
  end;
end;

// Button Edit
procedure TfmWizardForm.tsButtonEditShow(Sender: TObject);
begin
  edViewStyle.ItemIndex := Integer(ButtonEdit.ViewStyle);
end;

// Check Edit
procedure TfmWizardForm.tsCheckEditShow(Sender: TObject);
begin
  with CheckEdit do
  begin
    edCaption.Text := Caption;
    edNullStyle.Text := IntToStr(Integer(NullStyle));
    cbAllowGrayed.Checked := AllowGrayed;
    cbFullFocusRect.Checked := FullFocusRect;
    cbMultiLine.Checked := MultiLine;
  end;
end;

// Image Edit
procedure TfmWizardForm.tsImageEditShow(Sender: TObject);
begin
  with ImageEdit do
  begin
    edDropDownRows.Value := DropDownRows;
    edDropDownWidth.Value := DropDownWidth;
    edImagePopupAlignment.ItemIndex := Integer(PopupAlignment);
    edImagePopupBorder.ItemIndex := Integer(PopupBorder);
  end;
end;

// Spin Edit
procedure TfmWizardForm.tsSpinEditShow(Sender: TObject);
begin
  with SpinEdit do
  begin
    edIncrement.Text := FloatToStr(Increment);
    edMinValue.Text := FloatToStr(MinValue);
    edMaxValue.Text := FloatToStr(MaxValue);
    edValueType.ItemIndex := Integer(ValueType);
    cbEditorEnabled.Checked := EditorEnabled;
  end;
end;

// Pick Edit
procedure TfmWizardForm.tsPickEditShow(Sender: TObject);
begin
  with PickEdit do
  begin
    edPickDropDownRows.Value := DropDownRows;
    edPickDropDownWidth.Value := DropDownWidth;
    edPickPopupAlignment.ItemIndex := Integer(PopupAlignment);
    edPickPopupBorder.ItemIndex := Integer(PopupBorder);
    cbDropDownListStyle.Checked := DropDownListStyle;
    cbImmediateDropDown.Checked := ImmediateDropDown;
    cbRevertable.Checked := Revertable;
  end;
end;

// Calc Edit
procedure TfmWizardForm.tsCalcEditShow(Sender: TObject);
begin
  with CalcEdit do
  begin
    edButtonStyle.ItemIndex := Integer(ButtonStyle);
    edCalcPopupAlignment.ItemIndex := Integer(PopupAlignment);
    edCalcPopupBorder.ItemIndex := Integer(PopupBorder);
    edPrecision.Value := Precision;
    cbBeepOnError.Checked := BeepOnError;
    cbQuickClose.Checked := QuickClose;
    cbShowButtonFrame.Checked := ShowButtonFrame;
  end;
end;

// HyperLink Edit
procedure TfmWizardForm.tsHyperLinkEditShow(Sender: TObject);
begin
  cbSingleClick.Checked := HyperLinkEdit.SingleClick;
end;

// Time Edit
procedure TfmWizardForm.tsTimeEditShow(Sender: TObject);
begin
  edTimeEditFormat.ItemIndex := Integer(TimeEdit.TimeEditFormat);
end;

// Currency Edit
procedure TfmWizardForm.tsCurrencyEditShow(Sender: TObject);
begin
  with CurrencyEdit do
  begin
    edDecimalPlaces.Text := IntToStr(DecimalPlaces);
    edDisplayFormat.Text := DisplayFormat;
    edCurrMaxValue.Text := FloatToStr(MaxValue);
    edCurrMinValue.Text := FloatToStr(MinValue);
  end;
end;

// Graphic Edit
procedure TfmWizardForm.tsGraphicEditShow(Sender: TObject);
begin
  with GraphicEdit do
  begin
    LoadGraphicFilters(edCustomFilter.Items);
    cbCenter.Checked := Center;
    cbQuickDraw.Checked := QuickDraw;
    cbStretch.Checked := Stretch;
    edTransparency.ItemIndex := Integer(GraphicEdit.GraphicTransparency);
    with ToolbarLayout do
    begin
      edGraphicEditAlignment.ItemIndex := Integer(Alignment);
      cbDblClickActivate.Checked := DblClickActivate;
      cbIsPopupMenu.Checked := IsPopupMenu;
      cbShowCaptions.Checked := ShowCaptions;
      cbToolbarPosStored.Checked := ToolbarPosStored;
      cbVisible.Checked := ToolbarLayout.Visible;
      edCustomButtonCaption.Text := CustomButtonCaption;
      if Assigned(CustomButtonGlyph) and not (CustomButtonGlyph.Empty) then
        edCustomButtonGlyph.Text := '(Assigned)'
      else edCustomButtonGlyph.Text := '(Empty)';
      CustomButtonGlyph.Transparent := True;
      cbCut.Checked := ptbCut in Buttons;
      cbCopy.Checked := ptbCopy in Buttons;
      cbPaste.Checked := ptbPaste in Buttons;
      cbDelete.Checked := ptbDelete in Buttons;
      cbLoadFromFile.Checked := ptbLoad in Buttons;
      cbSaveToFile.Checked := ptbSave in Buttons;
      cbCustom.Checked := ptbCustom in Buttons;
    end;
  end;
end;

// MRU Edit
procedure TfmWizardForm.tsMRUEditShow(Sender: TObject);
begin
  seMaxItemCount.Value := MRUEdit.MaxItemCount;
  cbShowEllipsis.Checked := MRUEdit.ShowEllipsis; 
end;

// Popup Edit
procedure TfmWizardForm.tsPopupEditShow(Sender: TObject);
begin
  peFormBorderStyle.ItemIndex := Integer(PopupEdit.PopupFormBorderStyle);
  peFormCaption.Text := PopupEdit.PopupFormCaption;
  pePopupWidth.Value := PopupEdit.PopupWidth;
  pePopupHeight.Value := PopupEdit.PopupHeight;
  pePopupMinWidth.Value := PopupEdit.PopupMinWidth;
  pePopupMinHeight.Value := PopupEdit.PopupMinHeight;
  cbHideEditCursor.Checked := PopupEdit.HideEditCursor;
  cbPopupAutoSize.Checked := PopupEdit.PopupAutoSize;
  cbPopupClientEdge.Checked := PopupEdit.PopupClientEdge;
  cbPopupFlatBorder.Checked := PopupEdit.PopupFlatBorder;
  cbPopupSizeable.Checked := PopupEdit.PopupSizeable;
end;

// DBLookup
procedure TfmWizardForm.tsDBLookupEditShow(Sender: TObject);
begin
  edListFieldName.Text := DBLookupEdit.ListFieldName;
  cbCanDeleteText.Checked := DBLookupEdit.CanDeleteText;
  cbLookupRevertable.Checked := DBLookupEdit.Revertable;
end;

// DBExtLookup
procedure TfmWizardForm.tsDBExtLookupEditShow(Sender: TObject);
begin
  cbCanDeleteTextExt.Checked := DBExtLookupEdit.CanDeleteText;
  cbChooseByDblClick.Checked := DBExtLookupEdit.ChooseByDblClick;
end;

// -- Changed Events --

// Edit

procedure TfmWizardForm.edAlignmentChange(Sender: TObject);
begin
  Edit.Alignment := TAlignment(StrToInt(edAlignment.Text));
end;

procedure TfmWizardForm.edMaxLengthChange(Sender: TObject);
begin
  Edit.MaxLength := edMaxLength.IntValue;
end;

procedure TfmWizardForm.edPasswordCharChange(Sender: TObject);
begin
  if Length(edPasswordChar.Text) > 0 then
    Edit.PasswordChar := edPasswordChar.Text[1]
  else
    Edit.PasswordChar := #0;
end;

procedure TfmWizardForm.cbAutoSelectClick(Sender: TObject);
begin
  Edit.AutoSelect := cbAutoSelect.Checked;
end;

procedure TfmWizardForm.cbEnabledChange(Sender: TObject);
begin
  Edit.Enabled := cbEnabled.Checked;
end;

procedure TfmWizardForm.cbHideSelectionClick(Sender: TObject);
begin
  Edit.HideSelection := cbHideSelection.Checked;
end;

procedure TfmWizardForm.cbReadOnlyClick(Sender: TObject);
begin
  Edit.ReadOnly := cbReadOnly.Checked;
end;

procedure TfmWizardForm.BFontClick(Sender: TObject);
begin
  FontDialog.Font := Edit.Font;
  if FontDialog.Execute then
    Edit.Font := FontDialog.Font;
end;

procedure TfmWizardForm.BColorClick(Sender: TObject);
begin
  ColorDialog.Color := Edit.Color;
  if ColorDialog.Execute then
    Edit.Color := ColorDialog.Color;
end;

// Mask Edit

procedure TfmWizardForm.edEditMaskChange(Sender: TObject);
begin
  MaskEdit.EditMask := edEditMask.Text;
end;

procedure TfmWizardForm.edEditMaskInitPopup(Sender: TObject);
begin
  edEditMask.PopupControl := dxEditMaskForm;
  edEditMask.PopupFormCaption := dxEditMaskForm.Caption;
  dxEditMaskForm.InitProperties(MaskEdit);
end;

procedure TfmWizardForm.cbIgnoreMaskBlankClick(Sender: TObject);
begin
  MaskEdit.IgnoreMaskBlank := cbIgnoreMaskBlank.Checked;
end;

procedure TfmWizardForm.edEditMaskCloseUp(Sender: TObject;
  var Text: String; var Accept: Boolean);
begin
  if Accept then
  begin
    edEditMask.Text := dxEditMaskForm.ETest.EditMask;
    edEditMaskChange(nil);
    MaskEdit.IgnoreMaskBlank := dxEditMaskForm.ETest.IgnoreMaskBlank;
    cbIgnoreMaskBlank.Checked := MaskEdit.IgnoreMaskBlank;
    Accept := False;
  end;
end;

// Memo Edit

procedure TfmWizardForm.edMemoScrollBarsChange(Sender: TObject);
begin
  Memo.ScrollBars := TScrollStyle(edMemoScrollBars.ItemIndex);
end;

procedure TfmWizardForm.cbMemoHideScrollBarsClick(Sender: TObject);
begin
  Memo.HideScrollBars := cbMemoHideScrollBars.Checked;
end;

procedure TfmWizardForm.edMemoSelectionBarClick(Sender: TObject);
begin
  Memo.SelectionBar := edMemoSelectionBar.Checked;
end;

procedure TfmWizardForm.cbMemoWantReturnsClick(Sender: TObject);
begin
  Memo.WantReturns := cbMemoWantReturns.Checked;
end;

procedure TfmWizardForm.cbMemoWantTabsClick(Sender: TObject);
begin
  Memo.WantTabs := cbMemoWantTabs.Checked;
end;

procedure TfmWizardForm.cbMemoWordWrapClick(Sender: TObject);
begin
  Memo.WordWrap := cbMemoWordWrap.Checked;
end;

// Date Edit

procedure TfmWizardForm.edDateOnErrorChange(Sender: TObject);
begin
  DateEdit.DateOnError := TDateOnError(edDateOnError.ItemIndex);
end;

procedure TfmWizardForm.edDatePopupAlignmentChange(Sender: TObject);
begin
  DateEdit.PopupAlignment := TAlignment(edDatePopupAlignment.ItemIndex);
end;

procedure TfmWizardForm.edDatePopupBorderChange(Sender: TObject);
begin
  DateEdit.PopupBorder := TdxPopupBorder(edDatePopupBorder.ItemIndex);
end;

procedure TfmWizardForm.cbTodayClick(Sender: TObject);
begin
  with DateEdit, cbToday do
    if Checked then
      DateButtons := DateButtons + [btnToday]
    else
      DateButtons := DateButtons - [btnToday];
end;

procedure TfmWizardForm.cbClearClick(Sender: TObject);
begin
  with DateEdit, cbClear do
    if Checked then
      DateButtons := DateButtons + [btnClear]
    else
      DateButtons := DateButtons - [btnClear];
end;

procedure TfmWizardForm.cbDateValidationClick(Sender: TObject);
begin
  DateEdit.DateValidation := cbDateValidation.Checked;
end;

procedure TfmWizardForm.cbSaveTimeClick(Sender: TObject);
begin
  DateEdit.SaveTime := cbSaveTime.Checked;
end;

procedure TfmWizardForm.cbUseEditMaskClick(Sender: TObject);
begin
  DateEdit.UseEditMask := cbUseEditMask.Checked;
end;

// Button Edit

procedure TfmWizardForm.edViewStyleChange(Sender: TObject);
begin
  ButtonEdit.ViewStyle := TdxButtonEditViewStyle(edViewStyle.ItemIndex);
end;

procedure TfmWizardForm.ButtonEditButtonClick(Sender: TObject;
  AbsoluteIndex: Integer);

  function Check(const S: string): string;
  var
    Flag: Boolean;
    I: Integer;
  begin
    Result := Trim(S);
    Flag := True;
    for I := 1 to Length(Result) do
    begin
      if Flag then
      begin
        Result[I] := AnsiUpperCase(Result[I])[1];
        Flag := False;
      end;
      if Result[I] = #32 then
        Flag := True;
    end;
  end;

begin
  case AbsoluteIndex of
    0:
      ButtonEdit.Text := Check(ButtonEdit.Text);
    1:
      ButtonEdit.Text := '';
    2:
      begin
        MessageBox(Handle, 'You can call here some dialogs and manipulations...',
          'Some Dialog', MB_OK or MB_ICONINFORMATION);
        ButtonEdit.Text := '  some text';
      end;
  end;
end;

// Check Edit

procedure TfmWizardForm.edCaptionChange(Sender: TObject);
begin
  CheckEdit.Caption := edCaption.Text;
end;

procedure TfmWizardForm.edNullStyleChange(Sender: TObject);
begin
  CheckEdit.NullStyle := TdxShowNullFieldStyle(StrToInt(edNullStyle.Text));
end;

procedure TfmWizardForm.cbAllowGrayedClick(Sender: TObject);
begin
  CheckEdit.AllowGrayed := cbAllowGrayed.Checked;
end;

procedure TfmWizardForm.cbFullFocusRectClick(Sender: TObject);
begin
  CheckEdit.FullFocusRect := cbFullFocusRect.Checked;
end;

procedure TfmWizardForm.cbMultiLineClick(Sender: TObject);
begin
  CheckEdit.MultiLine := cbMultiLine.Checked;
end;

procedure TfmWizardForm.cbUseGlyphClick(Sender: TObject);
var
  B: TBitmap;
begin
  with CheckEdit do
    if cbUseGlyph.Checked then
    begin
      B := TBitmap.Create;
      try
        B.LoadFromResourceName(HInstance, 'CHECK_BMP');
        Glyph.Assign(B);
      finally
        B.Free;
      end;
      Style.BorderStyle := xbsFlat;
    end
    else
    begin
      Glyph.Assign(nil);
      Style.BorderStyle := xbsNone;
    end;
end;

// Image Edit

procedure TfmWizardForm.edDropDownRowsChange(Sender: TObject);
begin
  ImageEdit.DropDownRows := edDropDownRows.IntValue;
end;

procedure TfmWizardForm.edDropDownWidthChange(Sender: TObject);
begin
  ImageEdit.DropDownWidth := edDropDownWidth.IntValue;
end;

procedure TfmWizardForm.edImagePopupAlignmentChange(Sender: TObject);
begin
  ImageEdit.PopupAlignment := TAlignment(edImagePopupAlignment.ItemIndex);
end;

procedure TfmWizardForm.edImagePopupBorderChange(Sender: TObject);
begin
  ImageEdit.PopupBorder := TdxPopupBorder(edImagePopupBorder.ItemIndex);
end;

// Spin Edit

procedure TfmWizardForm.edIncrementChange(Sender: TObject);
begin
  if edIncrement.Text <> '' then
    try
      SpinEdit.Increment := StrToFloat(edIncrement.Text)
    except
    end
  else
    SpinEdit.Increment := 0;
end;

procedure TfmWizardForm.edMinValueChange(Sender: TObject);
begin
  if edMinValue.Text <> '' then
    try
      SpinEdit.MinValue := StrToFloat(edMinValue.Text)
    except
    end
  else
    SpinEdit.MinValue := 0;
end;

procedure TfmWizardForm.edMaxValueChange(Sender: TObject);
begin
  if edMaxValue.Text <> '' then
    try
      SpinEdit.MaxValue := StrToFloat(edMaxValue.Text)
    except
    end
  else
    SpinEdit.MaxValue := 0;
end;

procedure TfmWizardForm.edValueTypeChange(Sender: TObject);
begin
  SpinEdit.ValueType := TdxValueType(edValueType.ItemIndex);
end;

procedure TfmWizardForm.cbEditorEnabledClick(Sender: TObject);
begin
  SpinEdit.EditorEnabled := cbEditorEnabled.Checked;
end;

// Pick Edit
procedure TfmWizardForm.edPickDropDownRowsChange(Sender: TObject);
begin
  PickEdit.DropDownRows := edPickDropDownRows.IntValue;
end;

procedure TfmWizardForm.edPickDropDownWidthChange(Sender: TObject);
begin
  PickEdit.DropDownWidth := edPickDropDownWidth.IntValue;
end;

procedure TfmWizardForm.edPickPopupAlignmentChange(Sender: TObject);
begin
  PickEdit.PopupAlignment := TAlignment(edPickPopupAlignment.ItemIndex);
end;

procedure TfmWizardForm.edPickPopupBorderChange(Sender: TObject);
begin
  PickEdit.PopupBorder := TdxPopupBorder(edPickPopupBorder.ItemIndex);
end;

procedure TfmWizardForm.cbDropDownListStyleClick(Sender: TObject);
begin
  PickEdit.DropDownListStyle := cbDropDownListStyle.Checked;
end;

procedure TfmWizardForm.cbImmediateDropDownClick(Sender: TObject);
begin
  PickEdit.ImmediateDropDown := cbImmediateDropDown.Checked;
end;

procedure TfmWizardForm.cbRevertableClick(Sender: TObject);
begin
  PickEdit.Revertable := cbRevertable.Checked;
end;

// Calc Edit
procedure TfmWizardForm.edButtonStyleChange(Sender: TObject);
begin
  CalcEdit.ButtonStyle := TdxButtonStyle(edButtonStyle.ItemIndex);
end;

procedure TfmWizardForm.edCalcPopupAlignmentChange(Sender: TObject);
begin
  CalcEdit.PopupAlignment := TAlignment(edCalcPopupAlignment.ItemIndex);
end;

procedure TfmWizardForm.edCalcPopupBorderChange(Sender: TObject);
begin
  CalcEdit.PopupBorder := TdxPopupBorder(edCalcPopupBorder.ItemIndex);
end;

procedure TfmWizardForm.edPrecisionChange(Sender: TObject);
begin
  CalcEdit.Precision := edPrecision.IntValue;
end;

procedure TfmWizardForm.cbBeepOnErrorClick(Sender: TObject);
begin
  CalcEdit.BeepOnError := cbBeepOnError.Checked;
end;

procedure TfmWizardForm.cbQuickCloseClick(Sender: TObject);
begin
  CalcEdit.QuickClose := cbQuickClose.Checked;
end;

procedure TfmWizardForm.cbShowButtonFrameClick(Sender: TObject);
begin
  CalcEdit.ShowButtonFrame := cbShowButtonFrame.Checked;
end;

// HyperLink Edit
procedure TfmWizardForm.cbSingleClickClick(Sender: TObject);
begin
  HyperLinkEdit.SingleClick := cbSingleClick.Checked;
end;

procedure TfmWizardForm.cbHyperEditClick(Sender: TObject);
begin
  with HyperLinkEdit do
    if cbHyperEdit.Checked then
    begin
      Style.BorderStyle := xbsFlat;
      ReadOnly := False;
      Color := clWindow;
    end
    else
    begin
      Style.BorderStyle := xbsNone;
      ReadOnly := True;
      ParentColor := True;
    end;
end;

procedure TfmWizardForm.edTimeEditFormatChange(Sender: TObject);
begin
  TimeEdit.TimeEditFormat := TdxTimeEditFormat(edTimeEditFormat.ItemIndex);
end;

procedure TfmWizardForm.edDecimalPlacesChange(Sender: TObject);
begin
  CurrencyEdit.DecimalPlaces := edDecimalPlaces.IntValue;
end;

procedure TfmWizardForm.edDisplayFormatChange(Sender: TObject);
begin
  CurrencyEdit.DisplayFormat := edDisplayFormat.Text;
end;

procedure TfmWizardForm.edCurrMinValueChange(Sender: TObject);
begin
  if edCurrMinValue.Text <> '' then
    try
      CurrencyEdit.MinValue := StrToFloat(edCurrMinValue.Text);
      if FloatToStr(CurrencyEdit.MinValue) <> edCurrMinValue.Text then
        edCurrMinValue.Text := FloatToStr(CurrencyEdit.MinValue);  
    except
    end
  else
    CurrencyEdit.MinValue := 0;
end;

procedure TfmWizardForm.edCurrMaxValueChange(Sender: TObject);
begin
  if edCurrMaxValue.Text <> '' then
    try
      CurrencyEdit.MaxValue := StrToFloat(edCurrMaxValue.Text);
      if FloatToStr(CurrencyEdit.MaxValue) <> edCurrMaxValue.Text then
        edCurrMaxValue.Text := FloatToStr(CurrencyEdit.MaxValue);
    except
    end
  else
    CurrencyEdit.MaxValue := 0;
end;

// Graphic Edit

procedure TfmWizardForm.GraphicEditCustomClick(Sender: TObject);
begin
  fmPreview.GraphicEdit.Picture := GraphicEdit.Picture;
  if not IsPictureEmpty(fmPreview.GraphicEdit.Picture) then
  begin
    fmPreview.ClientWidth := GraphicEdit.Picture.Width;
    fmPreview.ClientHeight := GraphicEdit.Picture.Height;
  end;
  fmPreview.Show;
end;

procedure TfmWizardForm.edCustomFilterChange(Sender: TObject);
begin
  GraphicEdit.CustomFilter := edCustomFilter.Text;
end;

procedure TfmWizardForm.edTransparencyChange(Sender: TObject);
begin
  GraphicEdit.GraphicTransparency := TdxGraphicEditTransparency(edTransparency.ItemIndex);
end;

procedure TfmWizardForm.cbCenterClick(Sender: TObject);
begin
  GraphicEdit.Center := cbCenter.Checked;
end;

procedure TfmWizardForm.cbQuickDrawClick(Sender: TObject);
begin
  GraphicEdit.QuickDraw := cbQuickDraw.Checked;
end;

procedure TfmWizardForm.cbStretchClick(Sender: TObject);
begin
  GraphicEdit.Stretch := cbStretch.Checked;
end;

procedure TfmWizardForm.edGraphicEditAlignmentChange(Sender: TObject);
begin
  GraphicEdit.ToolbarLayout.Alignment := TdxPopupToolBarAlignment(edGraphicEditAlignment.ItemIndex);
end;

procedure TfmWizardForm.cbDblClickActivateClick(Sender: TObject);
begin
  GraphicEdit.DblClickActivate := cbDblClickActivate.Checked;
end;

procedure TfmWizardForm.cbIsPopupMenuClick(Sender: TObject);
begin
  GraphicEdit.ToolbarLayout.IsPopupMenu := cbIsPopupMenu.Checked;
end;

procedure TfmWizardForm.cbShowCaptionsClick(Sender: TObject);
begin
  GraphicEdit.ToolbarLayout.ShowCaptions := cbShowCaptions.Checked;
end;

procedure TfmWizardForm.cbToolbarPosStoredClick(Sender: TObject);
begin
  GraphicEdit.ToolbarPosStored := cbToolbarPosStored.Checked;
end;

procedure TfmWizardForm.cbVisibleClick(Sender: TObject);
begin
  GraphicEdit.ToolbarLayout.Visible := cbVisible.Checked;
end;

procedure TfmWizardForm.ToolbarButtontClick(Sender: TObject);
begin
  with GraphicEdit.ToolbarLayout, Sender as TdxCheckEdit do
    if Checked then
      Buttons := Buttons + [TdxPopupToolBarButton(Tag)]
    else
      Buttons := Buttons - [TdxPopupToolBarButton(Tag)];
end;

procedure TfmWizardForm.edCustomButtonCaptionChange(Sender: TObject);
begin
  GraphicEdit.ToolbarLayout.CustomButtonCaption := edCustomButtonCaption.Text;
end;

procedure TfmWizardForm.edCustomButtonGlyphButtonClick(Sender: TObject;
  AbsoluteIndex: Integer);
begin
  with GraphicEdit, ToolbarLayout do
  begin
    with OpenPictureDialog do
    begin
      Filter := GraphicFilter(TBitmap);
      if Execute then
        CustomButtonGlyph.LoadFromFile(FileName);
    end;
    if Assigned(CustomButtonGlyph) and not (CustomButtonGlyph.Empty) then
      edCustomButtonGlyph.Text := '(Assigned)'
    else
      edCustomButtonGlyph.Text := '(Empty)';
  end;
end;

procedure TfmWizardForm.tsBlobEditShow(Sender: TObject);
begin
  with BlobEdit do
  begin
    // Common
    edBlobEditKind.ItemIndex := Integer(BlobEditKind);
    edBlobEditKindChange(nil);
    edBlobPaintStyle.ItemIndex := Integer(BlobPaintStyle);
    cbSizeablePopup.Checked := SizeablePopup;
    // Memo
    edBlobMemoScrollBars.ItemIndex := Integer(MemoScrollBars);
    edBlobMemoMaxLength.Text := IntToStr(MemoMaxLength);
    cbBlobAlwaysSaveText.Checked := AlwaysSaveText;
    cbBlobMemoHideScrollBars.Checked := MemoHideScrollBars;
    cbBlobMemoSelectionBar.Checked := MemoSelectionBar;
    cbBlobMemoWantReturns.Checked := MemoWantReturns;
    cbBlobMemoWantTabs.Checked := MemoWantTabs;
    cbBlobMemoWordWrap.Checked := MemoWordWrap;
    // Picture
    LoadGraphicFilters(edPictureFilter.Items);
    edPictureFilter.Text := PictureFilter;
    cbPictureAutoSize.Checked := PictureAutoSize;
    edPictureTranparency.ItemIndex := Integer(PictureTransparency);
    cbShowExPopupItems.Checked := ShowExPopupItems;
    cbShowPicturePopup.Checked := ShowPicturePopup;
  end;
end;

// Blob Edit
procedure TfmWizardForm.edBlobEditKindChange(Sender: TObject);
var
  S: string;
begin
  with BlobEdit do
  begin
    BlobEditKind := TdxBlobEditKind(edBlobEditKind.ItemIndex);
    case BlobEditKind of
      bekMemo:
        Text := 'This example blob edit with memo text (BlobEditKind = bekMemo)';
      bekPict:
        begin
          PictureGraphicClass := nil;
          SavePicture(BlobImage.Picture, S);
          Text := S;
        end;
    end;
  end;
end;

procedure TfmWizardForm.edBlobPaintStyleChange(Sender: TObject);
begin
  BlobEdit.BlobPaintStyle := TdxBlobPaintStyle(edBlobPaintStyle.ItemIndex);
end;

procedure TfmWizardForm.cbSizeablePopupClick(Sender: TObject);
begin
  BlobEdit.SizeablePopup := cbSizeablePopup.Checked;
end;

procedure TfmWizardForm.edBlobMemoScrollBarsChange(Sender: TObject);
begin
  BlobEdit.MemoScrollBars := TScrollStyle(edBlobMemoScrollBars.ItemIndex);
end;

procedure TfmWizardForm.edBlobMemoMaxLengthChange(Sender: TObject);
begin
  BlobEdit.MemoMaxLength := edBlobMemoMaxLength.IntValue;
end;

procedure TfmWizardForm.cbBlobAlwaysSaveTextClick(Sender: TObject);
begin
  BlobEdit.AlwaysSaveText := cbBlobAlwaysSaveText.Checked;
end;

procedure TfmWizardForm.cbBlobMemoHideScrollBarsClick(Sender: TObject);
begin
  BlobEdit.MemoHideScrollBars := cbBlobMemoHideScrollBars.Checked;
end;

procedure TfmWizardForm.cbBlobMemoSelectionBarClick(Sender: TObject);
begin
  BlobEdit.MemoSelectionBar := cbBlobMemoSelectionBar.Checked;
end;

procedure TfmWizardForm.cbBlobMemoWantReturnsClick(Sender: TObject);
begin
  BlobEdit.MemoWantReturns := cbBlobMemoWantReturns.Checked;
end;

procedure TfmWizardForm.cbBlobMemoWantTabsClick(Sender: TObject);
begin
  BlobEdit.MemoWantTabs := cbBlobMemoWantTabs.Checked;
end;

procedure TfmWizardForm.cbBlobMemoWordWrapClick(Sender: TObject);
begin
  BlobEdit.MemoWordWrap := cbBlobMemoWordWrap.Checked;
end;

procedure TfmWizardForm.edPictureFilterChange(Sender: TObject);
begin
  BlobEdit.PictureFilter := edPictureFilter.Text;
end;

procedure TfmWizardForm.edPictureTranparencyChange(Sender: TObject);
begin
  BlobEdit.PictureTransparency := TdxGraphicEditTransparency(edPictureTranparency.ItemIndex);
end;

procedure TfmWizardForm.cbPictureAutoSizeClick(Sender: TObject);
begin
  BlobEdit.PictureAutoSize := cbPictureAutoSize.Checked;
end;

procedure TfmWizardForm.cbShowExPopupItemsClick(Sender: TObject);
begin
  BlobEdit.ShowExPopupItems := cbShowExPopupItems.Checked;
end;

procedure TfmWizardForm.cbShowPicturePopupClick(Sender: TObject);
begin
  BlobEdit.ShowPicturePopup := cbShowPicturePopup.Checked;
end;

// MRU Edit

procedure TfmWizardForm.MRUEditButtonClick(Sender: TObject);
begin
  if OpenDialog.Execute then
  begin
    MRUEdit.Text := ExtractFileName(OpenDialog.FileName);
    MRUEdit.AddItem(MRUEdit.Text); // Run - Time adding
  end;
end;

procedure TfmWizardForm.seMaxItemCountChange(Sender: TObject);
begin
  MRUEdit.MaxItemCount := seMaxItemCount.IntValue;
end;

procedure TfmWizardForm.cbShowEllipsisClick(Sender: TObject);
begin
  MRUEdit.ShowEllipsis := cbShowEllipsis.Checked;
end;

// Popup Edit

procedure TfmWizardForm.PopupEditCloseUp(Sender: TObject; var Text: String;
  var Accept: Boolean);
begin
  if fmPopupTree.TreeList.FocusedNode <> nil then
    Text := fmPopupTree.TreeList.FocusedNode.Values[0];
end;

procedure TfmWizardForm.peFormBorderStyleChange(Sender: TObject);
begin
  PopupEdit.PopupFormBorderStyle := TdxPopupEditFormBorderStyle(peFormBorderStyle.ItemIndex);
end;

procedure TfmWizardForm.peFormCaptionChange(Sender: TObject);
begin
  PopupEdit.PopupFormCaption := peFormCaption.Text; 
end;

procedure TfmWizardForm.pePopupWidthChange(Sender: TObject);
begin
  PopupEdit.PopupWidth := pePopupWidth.IntValue;
end;

procedure TfmWizardForm.pePopupHeightChange(Sender: TObject);
begin
  PopupEdit.PopupHeight := pePopupHeight.IntValue;
end;

procedure TfmWizardForm.pePopupMinWidthChange(Sender: TObject);
begin
  PopupEdit.PopupMinWidth := pePopupMinWidth.IntValue;
end;

procedure TfmWizardForm.pePopupMinHeightChange(Sender: TObject);
begin
  PopupEdit.PopupMinHeight := pePopupMinHeight.IntValue;
end;

procedure TfmWizardForm.cbHideEditCursorClick(Sender: TObject);
begin
  PopupEdit.HideEditCursor := cbHideEditCursor.Checked;
end;

procedure TfmWizardForm.cbPopupAutoSizeClick(Sender: TObject);
begin
  PopupEdit.PopupAutoSize := cbPopupAutoSize.Checked;
end;

procedure TfmWizardForm.cbPopupClientEdgeClick(Sender: TObject);
begin
  PopupEdit.PopupClientEdge := cbPopupClientEdge.Checked;
end;

procedure TfmWizardForm.cbPopupFlatBorderClick(Sender: TObject);
begin
  PopupEdit.PopupFlatBorder := cbPopupFlatBorder.Checked;
end;

procedure TfmWizardForm.cbPopupSizeableClick(Sender: TObject);
begin
  PopupEdit.PopupSizeable := cbPopupSizeable.Checked;
end;

// DBLookup Edit
procedure TfmWizardForm.edListFieldNameChange(Sender: TObject);
begin
  DBLookupEdit.ListFieldName := edListFieldName.Text;
end;

procedure TfmWizardForm.cbCanDeleteTextClick(Sender: TObject);
begin
  DBLookupEdit.CanDeleteText := cbCanDeleteText.Checked;
end;

procedure TfmWizardForm.cbLookupRevertableClick(Sender: TObject);
begin
  DBLookupEdit.Revertable := cbLookupRevertable.Checked;
end;

// DBExtLookup Edit

procedure TfmWizardForm.cbCanDeleteTextExtClick(Sender: TObject);
begin
  DBExtLookupEdit.CanDeleteText := cbCanDeleteTextExt.Checked;
end;

procedure TfmWizardForm.cbChooseByDblClickClick(Sender: TObject);
begin
  DBExtLookupEdit.ChooseByDblClick := cbChooseByDblClick.Checked;
end;

end.
