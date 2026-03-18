unit unInitialize;

interface

uses
   Forms, Dialogs, SysUtils, Classes, IniFiles, FileUtil, Windows, RxDBComb,
   RxLookup, Controls, RXDBCtrl, DBCtrls, Math;

type
  TInit = class          //--Класс инициализации
    AppDir: string;
    AppIni: string;
    AppLog: string;
    AppDoc: string;
    AppIniStore: TIniFile;
  public
    constructor Create;
    destructor Destroy;
    procedure Log(const aStr: string; const aOpen: boolean = false);
    procedure MsgMemo(const aStr: string; const aCaption: string = 'Служебное сообщение');
    procedure MsgException(const aException: Exception);
    procedure CheckMain(Sender: TObject);
    //--Events
    procedure OnDigitPress(Sender: TObject; var aKey: Char);
    procedure SetModalFormSize(aForm: TControl);
    procedure LookupKeyDown(aLcb: TObject; const aKey: Word);
    function AddErr(const aList, aStr : string; var aErr: boolean): string;
    function Luhn(const aCard: string): string;
    function CheckBic(const aBic, aLa: string): string;
    function CheckRNN(const aRNN: string): string;
    function Round2(const aValue: Double): Double;
  end;

const
  RnnPodgon = '000000111112';

var
  IZ: TInit;

implementation

uses unDM, unMsgMemo, unTools;

{ TInitialize }

constructor TInit.Create;
begin
  inherited Create;
  {Запрещаем изменять форматы (даты, времени) при изменении настроек Windows}
  Application.UpdateFormatSettings := False;
  {Устанавливаем разделитель дат и кратк. формат даты}
  DateSeparator := '.';
  ShortDateFormat := 'dd.mm.yy';
  {Устанавливаем разделители чисел}
  ThousandSeparator := ' ';
  DecimalSeparator  := '.';
  {Устанавливаем формат валюты}
  CurrencyDecimals  := 2;

  AppDir := ExtractFileDir(Application.ExeName) + '\';
  AppIni := copy(Application.ExeName, 1, length(Application.ExeName)-3) + 'ini';
  AppLog := copy(Application.ExeName, 1, length(Application.ExeName)-3) + 'log';
  AppDoc := copy(Application.ExeName, 1, length(Application.ExeName)-3) + 'doc';
  AppIniStore := TIniFile.Create(AppIni);
  if not FileExists(AppLog) then Log('Create log File - ' + AppIni, true);
end;

destructor TInit.Destroy;
begin
  AppIniStore.Free;
  inherited Destroy;
end;

function TInit.Luhn(const aCard: string): string;
var
  i, k, n, e: byte;
begin
  Result := '';
  n := length(aCard);
  if n = 0 then exit;
  k := 0;
  for i := 1 to n do
  if odd(n + 2 - i) then
     k := k + StrToInt(aCard[i])
  else
  begin
     e := StrToInt(aCard[i])*2;
     if e > 9 then k := k + 1 + (e mod 10) else k := k + e;
  end;
  n := (10 - (k mod 10)) mod 10;
  Result := IntToStr(n);
end;

procedure TInit.SetModalFormSize(aForm: TControl);
begin
  with TForm(aForm) do
  begin
    WindowState := wsNormal;
    Position := poDeskTopCenter;
    Height := 500;
    Width := 650;
  end;
end;

procedure TInit.OnDigitPress(Sender: TObject; var aKey: Char);
begin
  if not (aKey in ['0'..'9', ',', #8, #9]) then aKey := #0;
end;

procedure TInit.Log(const aStr: string; const aOpen: boolean = false);
var
  vFile: TextFile;
begin
  AssignFile(vFile, AppLog);
  {$I-}
  if (aOpen) or
     (Round(FileUtil.GetFileSize(AppLog)/1024) > 1024) //fmToolsAdmin.spdLogSize.Value)
   then Rewrite(vFile)
    else Append(vFile);
  {$I+}
  if IOResult = 0 then
  begin
    Writeln(vFile, #13#10'(*' + DateTimeToStr(Now) + '*) ' + aStr);
    CloseFile(vFile);
  end;
end;

procedure TInit.MsgMemo(const aStr: string; const aCaption: string = 'Служебное сообщение');
begin
  fmMsgMemo := TfmMsgMemo.Create(Application);
  with fmMsgMemo do
  try
    Caption := aCaption;
    memMsg.Lines.Text := AStr;
    ShowModal;
  finally
    fmMsgMemo.Release;
  end;
end;

procedure TInit.MsgException(const aException: Exception);
var
  vErr: string;
begin
  vErr := 'Ошибка в программе !'#13#13'[Сообщение:' + aException.Message + ']';

  MessageDlg(vErr, mtError, [mbOk], 0);
  Log(vErr);
end;

procedure TInit.LookupKeyDown(aLcb: TObject; const aKey: Word);
begin
  if aKey = VK_RIGHT then TRxDBLookupCombo(aLcb).DropDown
    else if aKey = VK_DELETE	then TRxDBLookupCombo(aLcb).ResetField;
end;

procedure TInit.CheckMain(Sender: TObject);
begin
  with TForm(Sender) do
  if Owner.Name = 'fmMain' then
  begin
    FormStyle := fsMDIChild;
    WindowState := wsMaximized;
  end
  else
    SetModalFormSize(TForm(Sender));
end;

function TInit.AddErr(const aList, aStr : string; var aErr: boolean): string;
begin
  aErr := true;
  Result := aList + #13'- ' + aStr + ' !;';
end;

function TInit.CheckBic(const aBic, aLa: string): string;
var
  vCode_Bic,
  vStn_La,
  vSum_La,
  vStn_Bic,
  vCode_La: integer;
  vKey_La,
  vNew_La: string;
begin
  Result := '';
  vCode_Bic :=StrToInt(aBic);
  vNew_La := aLa;
  vNew_La[7] := '0';
  vCode_La := StrToInt(vNew_La);
  vStn_La := 371371371;
  vSum_La := 0;
  vStn_Bic := 713;
  //--------------------------------------------------
  IF (vCode_Bic >= 100000) AND (vCode_Bic <= 999999) then begin
      vStn_Bic := 13713;
      vCode_Bic := vCode_Bic div 10;
  END;
  IF (vCode_Bic >= 100000000) AND (vCode_Bic <= 999999999) then begin
      vStn_Bic := 713;
      vCode_Bic := vCode_Bic mod 1000;
  END;
  //-------------- Расчет довеска в БИК банка --------------
  WHILE vCode_Bic <> 0 do
  begin
    vSum_La := (vSum_La + (vCode_Bic MOD 10)*(vStn_Bic MOD 10) MOD 10) MOD 10;
    vCode_Bic := vCode_Bic div 10;
    vStn_Bic := vStn_Bic div 10;
  END;
  //-------------- Расчет полного довеска ------------------
  WHILE vCode_La <> 0 do
  begin
    vSum_La := (vSum_La + (vCode_La MOD 10)*(vStn_La MOD 10) MOD 10) MOD 10;
    vCode_La := vCode_La div 10;
    vStn_La := vStn_La div 10;
  END;
  //------------------- Расчет ключа -----------------------
  vSum_La := vSum_La*3 mod 10;
  vKey_La := format('%1.1d', [vSum_La]);
  vNew_La := Copy(vNew_La,1,6) + vKey_La + Copy(vNew_La, 8, 2);
  if vNew_La <> aLa then
   Result :=  'Неверный 7-й разряд в счете: '+ aLa + ', правильный счет: ' + vNew_La;
end;

function TInit.CheckRNN(const aRNN: string): string;
const
  ves: array [1..20] of integer = (1,2,3,4,5,6,7,8,9,10,1,2,3,4,5,6,7,8,9,10);
var
  i,
  j,
  Krnn,
  Kres,
  sumves: integer;
begin
  result := '';

  Krnn := StrToInt(aRNN[12]);
  for i := 0 to 9 do
  begin
    sumves := 0;
    for j := 1 to 11 do sumves := sumves + StrToInt(aRNN[j])*ves[j+i];
    Kres := sumves mod 11;
    if Kres < 10 then break;
  end;

  if Krnn <> Kres then
    Result := Copy(aRNN,1,11) + IntToStr(Kres);
end;

function TInit.Round2(const aValue: Double): Double;
begin
  SetRoundMode(rmNearest);
  Result := RoundTo(aValue + 0.000001, -2); // 1.255 = 1.26
end;


end.
