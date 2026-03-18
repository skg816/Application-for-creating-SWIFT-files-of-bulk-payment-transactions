unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  dxCalc, Menus, dxCntner;

type
  TfmMain = class(TForm)
    MainMenu1: TMainMenu;
    miEdit: TMenuItem;
    miCopy: TMenuItem;
    miPaste: TMenuItem;
    miView: TMenuItem;
    miStandard: TMenuItem;
    miFlat: TMenuItem;
    miExtraFlat: TMenuItem;
    N1: TMenuItem;
    miShowButtonFrame: TMenuItem;
    miShowFocusRect: TMenuItem;
    N2: TMenuItem;
    miBeepOnError: TMenuItem;
    miHelp: TMenuItem;
    miAbout: TMenuItem;
    dxCalcDisplay: TdxCalcDisplay;
    dxCalculator: TdxCalculator;
    procedure miAboutClick(Sender: TObject);
    procedure miCopyClick(Sender: TObject);
    procedure miPasteClick(Sender: TObject);
    procedure miStandardClick(Sender: TObject);
    procedure miShowButtonFrameClick(Sender: TObject);
    procedure miShowFocusRectClick(Sender: TObject);
    procedure miBeepOnErrorClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

{$R *.DFM}

procedure TfmMain.miAboutClick(Sender: TObject);
begin
  Windows.MessageBox(Handle, 'Developer Express Inc.'#13#10'dxCalculator demo', 'About dxCalculator', MB_ICONINFORMATION or MB_OK);
end;

procedure TfmMain.miCopyClick(Sender: TObject);
begin
  dxCalculator.CopyToClipboard;
end;

procedure TfmMain.miPasteClick(Sender: TObject);
begin
  dxCalculator.PasteFromClipboard;
end;

procedure TfmMain.miStandardClick(Sender: TObject);
const
  ButtonStyleCount = 3;
  CalcButtonStyle : Array [0..ButtonStyleCount - 1] of TdxButtonStyle = (bsStandard, bsFlat, bsExtraFlat);
begin
  Assert(((TComponent(Sender).Tag >= 0) and (TComponent(Sender).Tag < ButtonStyleCount)), 'Button Style index is out of range');
  dxCalculator.ButtonStyle := CalcButtonStyle[TComponent(Sender).Tag];
  TMenuItem(Sender).Checked := True;
end;

procedure TfmMain.miShowButtonFrameClick(Sender: TObject);
begin
   dxCalculator.ShowButtonFrame := not dxCalculator.ShowButtonFrame;
   miShowButtonFrame.Checked := dxCalculator.ShowButtonFrame;
end;

procedure TfmMain.miShowFocusRectClick(Sender: TObject);
begin
   dxCalculator.ShowFocusRect := not dxCalculator.ShowFocusRect;
   miShowFocusRect.Checked := dxCalculator.ShowFocusRect;
end;

procedure TfmMain.miBeepOnErrorClick(Sender: TObject);
begin
   dxCalculator.BeepOnError := not dxCalculator.BeepOnError;
   miBeepOnError.Checked := dxCalculator.BeepOnError;
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
   {set MenuItems}
   miBeepOnError.Checked := dxCalculator.BeepOnError;
   miShowButtonFrame.Checked := dxCalculator.ShowButtonFrame;
   miShowFocusRect.Checked := dxCalculator.ShowFocusRect;

   miStandard.Checked := dxCalculator.ButtonStyle = bsStandard;
   miFlat.Checked := dxCalculator.ButtonStyle = bsFlat;
   miExtraFlat.Checked := dxCalculator.ButtonStyle = bsExtraFlat;
end;

end.
