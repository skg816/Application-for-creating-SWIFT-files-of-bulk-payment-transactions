unit unxModal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unxBase, ComCtrls, ToolWin, ActnList, Placemnt, Menus, unDM;

type
  TfmxModal = class(TfmxBase)
    stbModal: TStatusBar;
    tlbModal: TToolBar;
    actModal: TActionList;
    actOk: TAction;
    actCancel: TAction;
    strModal: TFormStorage;
    popModal: TPopupMenu;
    actClose: TAction;
    actPaste: TAction;
    procedure actOkExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmxModal: TfmxModal;

implementation

{$R *.dfm}

procedure TfmxModal.actOkExecute(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TfmxModal.actCancelExecute(Sender: TObject);
begin
  ModalResult := mrNo;
end;

end.
