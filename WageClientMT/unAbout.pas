unit unAbout;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unxBase, jpeg, ExtCtrls, StdCtrls, RXCtrls, Buttons,
  dxCntner, dxEditor, dxExEdtr, dxEdLib, ComCtrls;

type
  TfmAbout = class(TfmxBase)
    RxLabel1: TRxLabel;
    BitBtn1: TBitBtn;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Bevel1: TBevel;
    Label4: TLabel;
    Label5: TLabel;
    Memo1: TMemo;
    TabSheet2: TTabSheet;
    Label3: TLabel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmAbout: TfmAbout;

  procedure OpenForm;

implementation

{$R *.dfm}

procedure OpenForm;
begin
  fmAbout := TfmAbout.Create(Application);
  try
    fmAbout.ShowModal;
  finally
    fmAbout.Release;
  end;
end;

procedure TfmAbout.FormShow(Sender: TObject);
begin
  inherited;
  BitBtn1.SetFocus;
end;

end.
