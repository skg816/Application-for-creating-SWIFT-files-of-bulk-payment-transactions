unit unTools;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  unxModal, ComCtrls, ActnList, ToolWin, Placemnt, StdCtrls, Mask, ToolEdit,
  ExtCtrls, RxCombos, StdActns, Buttons, Spin, Menus;

type
  TfmTools = class(TfmxModal)
    pgcTools: TPageControl;
    ToolButton1: TToolButton;
    TabSheet2: TTabSheet;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Label5: TLabel;
    Label3: TLabel;
    dedZP102: TDirectoryEdit;
    dedRtf: TDirectoryEdit;
    GroupBox4: TGroupBox;
    Label12: TLabel;
    Label13: TLabel;
    dedClientImp: TDirectoryEdit;
    dedClientExp: TDirectoryEdit;
    dedBase: TDirectoryEdit;
    TabSheet3: TTabSheet;
    GroupBox5: TGroupBox;
    Label6: TLabel;
    edtBin: TEdit;
    TabSheet4: TTabSheet;
    pnlVid: TPanel;
    rgpProject: TRadioGroup;
    Label1: TLabel;
    edtPredCode: TEdit;
    TabSheet1: TTabSheet;
    GroupBox1: TGroupBox;
    chbBic: TCheckBox;
    TabSheet5: TTabSheet;
    GroupBox6: TGroupBox;
    Label2: TLabel;
    spdClmCount: TSpinEdit;
    Label4: TLabel;
    edtChief: TEdit;
    Label7: TLabel;
    edtMainBK: TEdit;
    chbLa: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtPredCodeKeyPress(Sender: TObject; var Key: Char);
    procedure edtPredCodeExit(Sender: TObject);
    procedure edtBinExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmTools: TfmTools;

implementation

uses unDm, unInitialize;

{$R *.DFM}

procedure TfmTools.FormCreate(Sender: TObject);
begin
  inherited;
  strModal.IniSection := 'Tools';
  strModal.IniFileName := IZ.AppIni;
  strModal.RestoreFormPlacement;
  pgcTools.ActivePageIndex := 0;
end;

procedure TfmTools.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  strModal.SaveFormPlacement;
  inherited;
end;

procedure TfmTools.edtPredCodeKeyPress(Sender: TObject; var Key: Char);
begin
  IZ.OnDigitPress(Sender, Key);
end;

procedure TfmTools.edtPredCodeExit(Sender: TObject);
begin
  if length(edtPredCode.Text) < 9 then
  begin
    MessageDlg('Длина Кода предприятия должна = 9 !', mtError, [mbOk], 0);
    edtPredCode.SetFocus;
  end;
end;

procedure TfmTools.edtBinExit(Sender: TObject);
begin
  if length(edtBin.Text) < 3 then
  begin
    MessageDlg('Длина поля Бин филиала должна = 3 !', mtError, [mbOk], 0);
    edtBin.SetFocus;
  end;
end;

end.
