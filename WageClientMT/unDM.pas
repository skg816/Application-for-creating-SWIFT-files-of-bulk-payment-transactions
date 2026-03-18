unit unDM;

interface

uses
  SysUtils, Classes, DB, ImgList, Controls, Dialogs, Forms,
  DBTables, Halcn6DB;

type
  TDM = class(TDataModule)
    imgMain: TImageList;
    hdsTable: THalcyonDataSet;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{$R *.dfm}

procedure TDM.DataModuleCreate(Sender: TObject);
begin
{
  try
    if ParamCount > 0 then      //-- ParamStr(1) = test_DB
    begin
      oraSess.Server := ParamStr(1);
      oraSess.Tag := 1;
    end;
    oraSess.Connect;
  except
    on E:Exception do
    begin
      MessageDlg('Сервер БД не инициализирован !'#13#13 + '[Сообщение:' + E.Message + ']', mtError, [mbOk], 0);
      Application.Terminate;
    end;
  end;
}
end;

end.
