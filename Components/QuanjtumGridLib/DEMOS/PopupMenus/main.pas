unit Main;

interface

uses
  Windows, Forms, Menus, Controls, Db, DBTables, dxGrClms, dxTL, dxDBGrid, Classes,
  dxCntner, dxDBTLCl, dxDBCtrl;

type
  TMainForm = class(TForm)
    Table1: TTable;
    DataSource1: TDataSource;
    GridImageList: TImageList;
    dxDBGrid1: TdxDBGrid;
    dxDBGrid1FirstName: TdxDBGridColumn;
    dxDBGrid1LastName: TdxDBGridColumn;
    dxDBGrid1Company: TdxDBGridColumn;
    dxDBGrid1Customer: TdxDBGridCheckColumn;
    dxDBGrid1PaymentType: TdxDBGridImageColumn;
    dxDBGrid1PaymentAmount: TdxDBGridColumn;
    dxDBGrid1Date: TdxDBGridDateColumn;
    dxDBGrid1Time: TdxDBGridTimeColumn;
    dxDBGrid1Copies: TdxDBGridSpinColumn;
    procedure FormCreate(Sender: TObject);
    procedure dxDBGrid1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses SysUtils, dxGridMenus;
{$R *.DFM}

procedure TMainForm.FormCreate(Sender: TObject);
begin
  Table1.DatabaseName := '..\Data\';
  Table1.Open;
  dxDBGrid1.FullExpand;
end;

procedure TMainForm.dxDBGrid1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (Button <> mbRight) or (Shift <> []) then Exit;
  TdxDBGridPopupMenuManager.Instance.ShowGridPopupMenu(Sender as TdxDBGrid);
end;

end.
