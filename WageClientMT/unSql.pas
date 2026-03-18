unit unSql;

interface

uses
  SysUtils, Forms, Dialogs, DB, dxDBELib, Halcn6DB, Classes;

type
  TQry = class          //--Класс инициализации
  public
    qTable: THalcyonDataSet;
    Debug: boolean;
    qPathDB: string;
    constructor Create(const aDataBase: string);
    destructor Destroy;

    procedure CopyFields(const aTableName, aFilter: string; aTable: THalcyonDataSet; const aPath: string = '');
    function GetOpen(aOwner: TComponent; const aTableName: string; const aType: boolean = true; const aPath: string = ''): THalcyonDataSet;
    function StrByNum(const aTableName, aFilter: string; const aNum: integer = 1; const aDefault: string = ''; const aPath: string = ''): string;
    function StrByName(const aTableName, aFilter, aName: string; const aDefault: string = ''; const aPath: string = ''): string;
    function GetCount(const aTableName, aFilter: string; const aPath: string = ''): integer;
    function GenID(const aTableName: string; const aField: string = 'ID'; const aPath: string = ''): integer;
    function FieldExists(const aFieldName: string; const aTable: THalcyonDataSet; const aPath: string = ''): boolean;
    function GetAgregate(const aTableName, aFilter, aFieldName: string; const aPath: string = ''): Double;
    function CheckRowUniq(const aTableName, aFilter: string; const aPath: string = ''): boolean;
    procedure DelByFilter(const aTableName, aFilter: string; const aPath: string = '');
    function Empty(const aTable: THalcyonDataSet): boolean;
  end;

var
  QR: TQry;

implementation

uses unDM, unInitialize;

{ TSql }

//------------Make--------------------------------
constructor TQry.Create(const aDataBase: string);
begin
  inherited Create;
  Debug := false;
  qTable := DM.hdsTable;
  qTable.DataBaseName := aDataBase;
  qPathDB := aDataBase;
end;

destructor TQry.Destroy;
begin
  qTable := nil;
  inherited Destroy;
end;

procedure TQry.DelByFilter(const aTableName, aFilter: string; const aPath: string = '');
begin
  with qTable do
  begin
    TableName := aTableName;
    if aPath = '' then DatabaseName := qPathDB else DatabaseName := aPath;
    Filter := aFilter;
    Filtered := true;
    Open;
    while not qTable.Eof do Delete;
    Close;
    Filtered := false;
    Filter := '';
  end;
end;

procedure TQry.CopyFields(const aTableName, aFilter: string; aTable: THalcyonDataSet; const aPath: string = '');
var
  i: integer;
begin
  with qTable do
  begin
    TableName := aTableName;
    if aPath = '' then DatabaseName := qPathDB else DatabaseName := aPath;
    Filter := aFilter;
    Filtered := true;
    Open;
    if not Empty(qTable) then
      for i := 0 to Fields.Count - 1 do aTable.Fields[i].Value := Fields[i].Value;
    Close;
    Filtered := false;
    Filter := '';
  end;
end;

function TQry.GetOpen(aOwner: TComponent; const aTableName: string; const aType: boolean = true; const aPath: string = ''): THalcyonDataSet;
var
  vTable: THalcyonDataSet;
begin
  //-- Пока не работает процедура!
  Result := nil;
  if Debug then IZ.Log(aTableName);
  vTable := THalcyonDataSet.Create(aOwner);
  with vTable do
  begin
    if aPath = '' then DatabaseName := qPathDB else DatabaseName := aPath;
    AutoCalcFields := false;
    TranslateASCII := false;
    ExactCount := true;
    TableName := aTableName;
    if aType then Open;
  end;
  Result := vTable;
end;

function TQry.CheckRowUniq(const aTableName, aFilter: string; const aPath: string = ''): boolean;
begin
  Result := false;
  with qTable do
  begin
    TableName := aTableName;
    if aPath = '' then DatabaseName := qPathDB else DatabaseName := aPath;
    Filter := aFilter;
    Filtered := true;
    Open;
    if not Empty(qTable) then Result := true;
    Close;
    Filtered := false;
    Filter := '';
  end;
end;

function TQry.StrByNum(const aTableName, aFilter: string; const aNum: integer = 1; const aDefault: string = ''; const aPath: string = ''): string;
begin
  Result := aDefault;
  with qTable do
  begin
    TableName := aTableName;
    if aPath = '' then DatabaseName := qPathDB else DatabaseName := aPath;
    Filter := aFilter;
    Filtered := true;
    Open;
    if not Empty(qTable) then Result := Fields[aNum - 1].AsString;
    Close;
    Filtered := false;
    Filter := '';
  end;
end;

function TQry.StrByName(const aTableName, aFilter, aName: string; const aDefault: string = ''; const aPath: string = ''): string;
begin
  Result := aDefault;
  with qTable do
  begin
    TableName := aTableName;
    if aPath = '' then DatabaseName := qPathDB else DatabaseName := aPath;
    Filter := aFilter;
    Filtered := true;
    Open;
    if not Empty(qTable) then Result := FieldByName(aName).AsString;
    Close;
    Filtered := false;
    Filter := '';
  end;
end;

function TQry.GetCount(const aTableName, aFilter: string; const aPath: string = ''): integer;
begin
  Result := 0;
  with qTable do
  begin
    TableName := aTableName;
    if aPath = '' then DatabaseName := qPathDB else DatabaseName := aPath;
    Filter := aFilter;
    Filtered := true;
    Open;
    if not Empty(qTable) then Result := RecordCount;
    Close;
    Filtered := false;
    Filter := '';
  end;
end;

function TQry.GenID(const aTableName: string; const aField: string = 'ID'; const aPath: string = ''): integer;
var
  aValue: integer;
begin
  Result := 0;
  aValue := 0;
  with qTable do
  begin
    TableName := aTableName;
    if aPath = '' then DatabaseName := qPathDB else DatabaseName := aPath;
    Open;
    while not qTable.Eof do
    begin
      if FieldByName(aField).AsInteger > aValue then aValue := FieldByName(aField).AsInteger;
      Next;
    end;
    Close;
    Result := aValue + 1;
  end;
end;

function TQry.FieldExists(const aFieldName: string; const aTable: THalcyonDataSet; const aPath: string = ''): boolean;
var
  j: integer;
begin
  Result := false;
  for j:=0 to aTable.Fields.Count - 1 do
  if AnsiUpperCase(aTable.Fields[j].FieldName) = AnsiUpperCase(aFieldName) then
  begin
    Result := true;
    Break;
  end;
end;

function TQry.GetAgregate(const aTableName, aFilter, aFieldName: string; const aPath: string = ''): Double;
var
  aSum: Double;
begin
  Result := 0;
  aSum := 0;
  with qTable do
  begin
    TableName := aTableName;
    if aPath = '' then DatabaseName := qPathDB else DatabaseName := aPath;
    if aFilter <> '' then
    begin
      Filter := aFilter;
      Filtered := true;
    end;
    Open;
    while not qTable.Eof do
    begin
      aSum := aSum + FieldByName(aFieldName).AsFloat;
      Next;
    end;
    Close;
    if Filtered then
    begin
      Filtered := false;
      Filter := '';
    end;
  end;
  Result := aSum;
end;

function TQry.Empty(const aTable: THalcyonDataSet): boolean;
begin
  Result := aTable.RecordCount = 0;

   //-- В старой версии Halcyon 6.70 RecordCount=0 при ExactCount = true давал ошибку!!!
{  Result := false;

  with qTable do
  begin
    TableName := aTable.TableName;
    DatabaseName := aTable.DatabaseName;
    Filter := aTable.Filter;
    Filtered := true;
    Open;
    try
      if RecordCount = 0 then
        Result := true;
    except
      Result := true;
    end;
    Close;
    Filtered := false;
    Filter := '';
  end;
}
end;

end.
