{*******************************************************}
{                                                       }
{       DCOM Library v1.0                               }
{       DCOM permissions Unit                           }
{       Copyright (c) 2001 ATOL technology              }
{       www.atol.ru и www.barcode.ru                    }
{       mailto:bary@atol.ru                             }
{                                                       }
{*******************************************************}

unit BDcomPrm;

interface

uses
  Windows, ActiveX, ComObj, Registry,
  {$ifndef ver100}
  SysConst,
  {$endif}
  SysUtils;

const
  // begin_ntddk begin_ntifs
  // This is the *current* ACL revision

  ACL_REVISION     = 2;
  ACL_REVISION_DS  = 4;

const
  // This is the history of ACL revisions.  Add a new one whenever
  // ACL_REVISION is updated

  ACL_REVISION1    = 1;
  ACL_REVISION2    = 2;
  ACL_REVISION3    = 3;
  ACL_REVISION4    = 4;
  MIN_ACL_REVISION = ACL_REVISION2;
  MAX_ACL_REVISION = ACL_REVISION4;

const
  //  The following are the predefined ace types that go into the AceType
  //  field of an Ace header.

  ACCESS_MIN_MS_ACE_TYPE              = $0;
  ACCESS_ALLOWED_ACE_TYPE             = $0;
  ACCESS_DENIED_ACE_TYPE              = $1;
  SYSTEM_AUDIT_ACE_TYPE               = $2;
  SYSTEM_ALARM_ACE_TYPE               = $3;
  ACCESS_MAX_MS_V2_ACE_TYPE           = $3;

  ACCESS_ALLOWED_COMPOUND_ACE_TYPE    = $4;
  ACCESS_MAX_MS_V3_ACE_TYPE           = $4;

  ACCESS_MIN_MS_OBJECT_ACE_TYPE       = $5;
  ACCESS_ALLOWED_OBJECT_ACE_TYPE      = $5;
  ACCESS_DENIED_OBJECT_ACE_TYPE       = $6;
  SYSTEM_AUDIT_OBJECT_ACE_TYPE        = $7;
  SYSTEM_ALARM_OBJECT_ACE_TYPE        = $8;
  ACCESS_MAX_MS_OBJECT_ACE_TYPE       = $8;

  ACCESS_MAX_MS_V4_ACE_TYPE           = $8;
  ACCESS_MAX_MS_ACE_TYPE              = $8;

const
  // Current security descriptor revision value
  SECURITY_DESCRIPTOR_REVISION        = 1;
  SECURITY_DESCRIPTOR_REVISION1       = 1;

const
  RPC_C_AUTHN_NONE                 = 0;
  RPC_C_AUTHN_DCE_PRIVATE          = 1;
  RPC_C_AUTHN_DCE_PUBLIC           = 2;
  RPC_C_AUTHN_DEC_PUBLIC           = 4;
  RPC_C_AUTHN_GSS_NEGOTIATE        = 9;
  RPC_C_AUTHN_WINNT                = 10;
  RPC_C_AUTHN_GSS_KERBEROS         = 16;
  RPC_C_AUTHN_MSN                  = 17;
  RPC_C_AUTHN_DPA                  = 18;
  RPC_C_AUTHN_MQ                   = 100;
  RPC_C_AUTHN_DEFAULT              = $FFFFFFFF;

const
  // Legacy Authentication Level
  RPC_C_AUTHN_LEVEL_DEFAULT        = 0;
  RPC_C_AUTHN_LEVEL_NONE           = 1;
  RPC_C_AUTHN_LEVEL_CONNECT        = 2;
  RPC_C_AUTHN_LEVEL_CALL           = 3;
  RPC_C_AUTHN_LEVEL_PKT            = 4;
  RPC_C_AUTHN_LEVEL_PKT_INTEGRITY  = 5;
  RPC_C_AUTHN_LEVEL_PKT_PRIVACY    = 6;

const
  RPC_C_AUTHZ_NONE                 = 0;
  RPC_C_AUTHZ_NAME                 = 1;
  RPC_C_AUTHZ_DCE                  = 2;
  RPC_C_AUTHZ_DEFAULT              = $ffffffff;

const
  // Legacy Impersonation Level
  RPC_C_IMP_LEVEL_DEFAULT          = 0;
  RPC_C_IMP_LEVEL_ANONYMOUS        = 1;
  RPC_C_IMP_LEVEL_IDENTIFY         = 2;
  RPC_C_IMP_LEVEL_IMPERSONATE      = 3;
  RPC_C_IMP_LEVEL_DELEGATE         = 4;

const
  EOAC_NONE                        = $0;
  EOAC_DEFAULT                     = $800;
  EOAC_MUTUAL_AUTH                 = $1;
  EOAC_STATIC_CLOAKING             = $20;
  EOAC_DYNAMIC_CLOAKING            = $40;
  // These are only valid for CoInitializeSecurity
  EOAC_SECURE_REFS                 = $2;
  EOAC_ACCESS_CONTROL              = $4;
  EOAC_APPID                       = $8;
  EOAC_NO_CUSTOM_MARSHAL           = $2000;
  EOAC_DISABLE_AAA                 = $1000;

const
  // HKEY_CLASSES_ROOT
  REGSTR_KEY_APPID = 'AppID';
  REGSTR_KEY_CLSID = 'CLSID';

const
  // HKEY_LOCAL_MACHINE
  REGSTR_KEY_OLE = 'Software\Microsoft\OLE';
  REGSTR_KEY_LOCAL_APPID = 'Software\Classes\AppID';
  REGSTR_KEY_RPC = 'Software\Microsoft\Rpc';

  REGSTR_VAL_RUNAS = 'RunAs';
  REGSTR_VAL_ENABLEDCOM = 'EnableDCOM';
  REGSTR_VAL_ENABLEREMOTECONNECT = 'EnableRemoteConnect';
  REGSTR_VAL_DCOMPROTOCOLS = 'DCOM Protocols';
  REGSTR_VAL_APPID = 'AppID';
  REGSTR_VAL_LEGACYSECUREREFERENCES = 'LegacySecureReferences';
  REGSTR_VAL_LEGACYAUTHENTICATIONLEVEL = 'LegacyAuthenticationLevel';
  REGSTR_VAL_IMPERSONATIONLEVEL = 'LegacyImpersonationLevel';
  REGSTR_VAL_DEFAULTLAUNCHPERMISSION = 'DefaultLaunchPermission';
  REGSTR_VAL_DEFAULTACCESSPERMISSION = 'DefaultAccessPermission';
  REGSTR_VAL_ACCESSPERMISSION = 'AccessPermission';
  REGSTR_VAL_LAUNCHPERMISSION = 'LaunchPermission';

const
  YesNoToChar: array[Boolean] of Char = ('N', 'Y');
  InteractiveUserValue = 'Interactive User';

const
  STR_DCOM_DOWNLOAD = 'http://www.microsoft.com/com/resources/downloads.asp';
  STR_NO_DCOM       = 'Не установлена поддержка DCOM.'+
   ' Для получения поддержки DCOM обратитесь по ссылке:'#13#10 +
    STR_DCOM_DOWNLOAD;
  STR_NO_DCOMPROTOCOL = 'Не разрешен ни один из протоколов DCOM.'+
      ' Запустите утилиту DCOMCNFG.EXE для рашрешения протоколов';


type
  {$ifdef ver100}
  PSIDAndAttributes = ^TSIDAndAttributes;
  _SID_AND_ATTRIBUTES = record
    Sid: PSID;
    Attributes: DWORD;
  end;
  TSIDAndAttributes = _SID_AND_ATTRIBUTES;
  SID_AND_ATTRIBUTES = _SID_AND_ATTRIBUTES;
  {$endif}

  { TTokenUser }

  _TOKEN_USER = record
    User: SID_AND_ATTRIBUTES;
  end;
  TTOKEN_USER = _TOKEN_USER;
  TTokenUser = TTOKEN_USER;
  PTokenUser = ^TTokenUser;

  { TAceHeader }

  _ACE_HEADER = record
    AceType: Byte;
    AceFlags: Byte;
    AceSize: WORD;
  end;
  ACE_HEADER = _ACE_HEADER;
  TAceHeader = ACE_HEADER;
  PAceHeader = ^TAceHeader;

  { TAccessAllowedAce }

  _ACCESS_ALLOWED_ACE = record
    Header: ACE_HEADER;
    Mask: ACCESS_MASK;
    SidStart: DWORD;
  end;
  ACCESS_ALLOWED_ACE = _ACCESS_ALLOWED_ACE;
  TAccessAllowedAce = ACCESS_ALLOWED_ACE;
  PAccessAllowedAce = ^TAccessAllowedAce;

  { TAccessDeniedAce }
  _ACCESS_DENIED_ACE = record
    Header: ACE_HEADER;
    Mask: ACCESS_MASK;
    SidStart: DWORD;
  end;
  ACCESS_DENIED_ACE = _ACCESS_DENIED_ACE;
  TAccessDeniedAce = ACCESS_DENIED_ACE;
  PAccessDeniedAce = ^TAccessDeniedAce;

  { TSystemAuditAce }

  _SYSTEM_AUDIT_ACE = record
    Header: ACE_HEADER;
    Mask: ACCESS_MASK;
    SidStart: DWORD;
  end;
  SYSTEM_AUDIT_ACE = _SYSTEM_AUDIT_ACE;
  TSystemAuditAce = SYSTEM_AUDIT_ACE;
  PSystemAuditAce = ^TSystemAuditAce;

  { TAclSizeInformation }

  _ACL_SIZE_INFORMATION = record
    AceCount: DWORD;
    AclBytesInUse: DWORD;
    AclBytesFree: DWORD;
  end;
  ACL_SIZE_INFORMATION = _ACL_SIZE_INFORMATION;
  TAclSizeInformation = ACL_SIZE_INFORMATION;

  { TAclRevisionInformation }

  _ACL_REVISION_INFORMATION = record
    AclRevision: DWORD;
  end;
  ACL_REVISION_INFORMATION = _ACL_REVISION_INFORMATION;
  TAclRevisionInformation = ACL_REVISION_INFORMATION;

  { TCoInitializeSecurity }

  TCoInitializeSecurityProc =  function (pSecDesc: PSecurityDescriptor;
    cAuthSvc: Longint;
    asAuthSvc: PSOleAuthenticationService;
    pReserved1: Pointer;
    dwAuthnLevel, dImpLevel: Longint;
    pReserved2: Pointer;
    dwCapabilities: Longint;
    pReserved3: Pointer): HResult; stdcall;

  PCoAuthInfo = ^TCoAuthInfo;
  TCoAuthInfo = record
    dwAuthnSvc: DWORD;
    dwAuthzSvc: DWORD;
    pwszServerPrincName: LPWSTR;
    dwAuthnLevel: DWORD;
    dwImpersonationLevel: DWORD;
    pAuthIdentityData: Pointer; //COAUTHIDENTITY
    dwCapabilities: DWORD;
  end;

  PCoServerInfo = ^TCoServerInfo;
  TCoServerInfo = record
    dwReserved1: Longint;
    pwszName: LPWSTR;
    pAuthInfo: PCoAuthInfo;
    dwReserved2: Longint;
  end;

  { TCoCreateInstanceEx }

  TCoCreateInstanceExProc = function (const clsid: TCLSID;
    unkOuter: IUnknown; dwClsCtx: Longint; ServerInfo: PCoServerInfo;
    dwCount: Longint; rgmqResults: PMultiQIArray): HResult stdcall;

procedure ListDefaultAccessACL(var S: String);
procedure ListDefaultLaunchACL(var S: String);
//!!! Поменять AppID на TGUID
procedure ListAppIDAccessACL(AppID: PChar; var S: String);
procedure ListAppIDLaunchACL(AppID: PChar; var S: String);

procedure ChangeDefaultAccessACL(Principal: PChar; SetPrincipal: Boolean;
  Permit: Boolean);
procedure ChangeDefaultLaunchACL(Principal: PChar; SetPrincipal: Boolean;
  Permit: Boolean);
procedure ChangeAppIDAccessACL(AppID, Principal: PChar; SetPrincipal: Boolean;
  Permit: Boolean);
procedure ChangeAppIDLaunchACL(AppID, Principal: PChar; SetPrincipal,
  Permit: Boolean);

procedure ListNamedValueSD(RootKey: HKEY; KeyName, ValueName: PChar;
  var S: String);
procedure AddPrincipalToNamedValueSD(RootKey: HKEY;
  KeyName, ValueName, Principal: PChar; Permit: BOOL);
procedure RemovePrincipalFromNamedValueSD(RootKey: HKEY;
  KeyName, ValueName, Principal: PChar);
// use FreeMem,
function GetCurrentUserSID: PSID;
// use FreeMem
function GetPrincipalSID(lpAccountName: PChar): PSID;
// use FreeMem
function CreateNewSD: PSecurityDescriptor;
function CreateNullDacl: PSecurityDescriptor;
// use FreeMem, Check result = ERROR_SUCCESS
function GetNamedValueSD(RootKey: HKEY; KeyName, ValueName: PChar;
  var pSD: PSecurityDescriptor): DWORD;
procedure SetNamedValueSD(RootKey: HKEY; KeyName, ValueName: PChar;
  pSD: PSecurityDescriptor);
procedure ListSDACL(pSD: PSecurityDescriptor; var S: String);
procedure ListACL(const Acl: TACL; var S: String);
procedure CopyACL(OldACL, NewACL: PACL);
procedure RemovePrincipalFromACL(Acl: PACL; Principal: PChar);
procedure AddAccessAllowedACEToACL(OldAcl: PACL; var NewAcl: PACL;
  PermissionMask: DWORD; Principal: PChar);
procedure AddAccessDeniedACEToACL(OldACL: PACL; var NewAcl: PACL;
  PermissionMask: DWORD; Principal: PChar);
function MakeSDAbsolute(OldSD: PSecurityDescriptor): PSecurityDescriptor;

function IsGuidIn(const AGUID: TGUID; const AGUIDs: array of TGUID): Boolean;
function IsDCOMOk: Boolean;
function IsInitializeSecurityOk: Boolean;
procedure InitializeDefaultSecurity;
function IsEnabledDCOM: Boolean;
function IsDCOMProtocolsEnabled: Boolean;
procedure SetEnableDCOM(const Value: Boolean);
function IsInteractiveUser(const ClassID: TGUID): Boolean;
procedure SetInteractiveUser(const ClassID: TGUID; const Value: Boolean);
procedure RemoveLegacySecureReferences;
// if not IsInitializeSecurityOk then use this proc
procedure SetDefaultDCOMCommunicationProperties;

function CreateRemoteComObjectEx(const MachineName: WideString;
  const ClassID: TGUID): IUnknown;

function CLSIDToFileName(const CLSID: TGUID): String;

implementation

var
  CoInitializeSecurity: TCoInitializeSecurityProc = nil;
  CoCreateInstanceEx: TCoCreateInstanceExProc = nil;
  
procedure MakeAppIDKeyName(KeyName, AppID: PChar);
begin
  StrCopy(keyName, 'AppID\');
  StrCopy(PChar(@keyName[6]), AppID);
end;

procedure ChangeDefaultAccessACL(Principal: PChar; SetPrincipal: Boolean;
  Permit: Boolean);
begin
  if SetPrincipal then
  begin
    // !!! почему сначала нужно выполнить remove, а потом выполнить add
    // нельзя ли изменить все сразу
    RemovePrincipalFromNamedValueSD(HKEY_LOCAL_MACHINE, REGSTR_KEY_OLE,
      REGSTR_VAL_DEFAULTACCESSPERMISSION, Principal);
    AddPrincipalToNamedValueSD(HKEY_LOCAL_MACHINE, REGSTR_KEY_OLE,
      REGSTR_VAL_DEFAULTACCESSPERMISSION, Principal, Permit);
  end
  else
    RemovePrincipalFromNamedValueSD(HKEY_LOCAL_MACHINE, REGSTR_KEY_OLE,
      REGSTR_VAL_DEFAULTACCESSPERMISSION, Principal);
end;

procedure ChangeDefaultLaunchACL(Principal: PChar; SetPrincipal: Boolean;
  Permit: Boolean);
begin
  if SetPrincipal then
  begin
    RemovePrincipalFromNamedValueSD(HKEY_LOCAL_MACHINE, REGSTR_KEY_OLE,
      REGSTR_VAL_DEFAULTLAUNCHPERMISSION, Principal);
    AddPrincipalToNamedValueSD(HKEY_LOCAL_MACHINE, REGSTR_KEY_OLE,
      REGSTR_VAL_DEFAULTLAUNCHPERMISSION, Principal, Permit);
  end
  else
    RemovePrincipalFromNamedValueSD(HKEY_LOCAL_MACHINE, REGSTR_KEY_OLE,
      REGSTR_VAL_DEFAULTLAUNCHPERMISSION, Principal);
end;

procedure ChangeAppIDAccessACL(AppID, Principal: PChar; SetPrincipal: Boolean;
  Permit: Boolean);
var
  keyName: array [0..255] of Char;
begin
  MakeAppIDKeyName(KeyName, AppID);
  if SetPrincipal then
  begin
    RemovePrincipalFromNamedValueSD(HKEY_CLASSES_ROOT, keyName, REGSTR_VAL_ACCESSPERMISSION, Principal);
    AddPrincipalToNamedValueSD(HKEY_CLASSES_ROOT, keyName, REGSTR_VAL_ACCESSPERMISSION, Principal, Permit);
  end
  else
    RemovePrincipalFromNamedValueSD(HKEY_CLASSES_ROOT, keyName, REGSTR_VAL_ACCESSPERMISSION, Principal);
end;

procedure ChangeAppIDLaunchACL(AppID, Principal: PChar; SetPrincipal,
  Permit: Boolean);
var
  keyName: array [0..255] of Char;
begin
  MakeAppIDKeyName(KeyName, AppID);
  if SetPrincipal then
  begin
    RemovePrincipalFromNamedValueSD(HKEY_CLASSES_ROOT, keyName, REGSTR_VAL_LAUNCHPERMISSION, Principal);
    AddPrincipalToNamedValueSD(HKEY_CLASSES_ROOT, keyName, REGSTR_VAL_LAUNCHPERMISSION, Principal, Permit);
  end
  else
    RemovePrincipalFromNamedValueSD(HKEY_CLASSES_ROOT, keyName, REGSTR_VAL_LAUNCHPERMISSION, Principal);
end;

function GetErrorMessage(ErrorCode: DWORD): String;
begin
  Result := Format(SWin32Error, [ErrorCode, SysErrorMessage(ErrorCode)])
end;

function MakeLastWin32ErrorMessage: String;
var
  LastError: DWORD;
begin
  LastError := GetLastError;
  if LastError <> ERROR_SUCCESS then
    Result := Format(SWin32Error, [LastError, SysErrorMessage(LastError)])
  else
    Result := SUnkWin32Error;
end;

function GetCurrentUserSID: PSID;
var
  ptknUser: PTokenUser;
  tknHandle: THandle;
  tknSize: DWORD;
  sidLength: DWORD;
begin
  if not OpenProcessToken(GetCurrentProcess, TOKEN_QUERY, tknHandle) then
    RaiseLastWin32Error;
  ptknUser := nil;
  tknSize := 0;
  try
    GetTokenInformation(tknHandle, TokenUser, ptknUser, 0, tknSize);
    GetMem(ptknUser, tknSize);
    try
      if not GetTokenInformation(tknHandle, TokenUser, ptknUser, tknSize, tknSize) then
        RaiseLastWin32Error;
      sidLength := GetLengthSid(ptknUser.User.Sid);
      GetMem(Result, sidLength);
      move(ptknUser.User.Sid^, Result^, sidLength);
    finally
      FreeMem(ptknUser);
    end;
  finally
    CloseHandle(tknHandle);
  end;
end;

function GetPrincipalSID(lpAccountName: PChar): PSID;
var
  sidSize: DWORD;
  refDomain: array [0..255] of Char;
  refDomainSize: DWORD;
  snu: SID_NAME_USE;
begin
  sidSize := 0;
  refDomainSize := 255;
  Result := nil;
  if not LookupAccountName(nil, lpAccountName, Result, sidSize,
    refDomain, refDomainSize, snu) then
  begin
    if GetLastError <> ERROR_INSUFFICIENT_BUFFER then
      RaiseLastWin32Error;
  end;

  GetMem(Result, sidSize);
  try
    refDomainSize := 255;
    if not LookupAccountName(nil, lpAccountName, Result, sidSize,
      refDomain, refDomainSize, snu) then RaiseLastWin32Error;
  except
    FreeMem(Result);
    raise;
  end;
end;

function CreateNewSD: PSecurityDescriptor;
var
  pdacl: PACL;
  sidLength: DWORD;
  sid: PSID;
  groupSID: PSID;
  ownerSID: PSID;
  sdSize: Integer;
  daclSize: Integer;
begin
  sid := GetCurrentUserSID;
  try
    sidLength := GetLengthSid(sid);
    sdSize := SizeOf(TSecurityDescriptor) +
       (2 * sidLength) +
       SizeOf(TACL) +
       SizeOf(TAccessAllowedACE) +
       sidLength;

    GetMem(Result, sdSize);
    try
      groupSID := PSID(Integer(Result) + SizeOf(TSecurityDescriptor));
      ownerSID := PSID(Integer(groupSID) + sidLength);
      pdacl := PACL(Integer(ownerSID) + sidLength);
      if not InitializeSecurityDescriptor(Result, SECURITY_DESCRIPTOR_REVISION) then
        RaiseLastWin32Error;
      daclSize := SizeOf(TACL) + SizeOf(TAccessAllowedAce) + sidLength;
      if not InitializeAcl(pdacl^, daclSize, ACL_REVISION2) and not IsValidACL(pdacl^) then
        RaiseLastWin32Error;
      if not AddAccessAllowedAce(pdacl^, ACL_REVISION2, COM_RIGHTS_EXECUTE, sid) then
        RaiseLastWin32Error;
      if not SetSecurityDescriptorDacl(Result, True, pdacl, False) then
        RaiseLastWin32Error;
      Move(sid^, groupSID^, sidLength);
      if not SetSecurityDescriptorGroup(Result, groupSID, False) then
        RaiseLastWin32Error;
      Move(sid^, ownerSID^, sidLength);
      if not SetSecurityDescriptorOwner(Result, ownerSID, False) then
        RaiseLastWin32Error;
      if not IsValidSecurityDescriptor(Result) then
        RaiseLastWin32Error;
    except
      FreeMem(Result);
      raise;
    end;
  finally
    FreeMem(Sid);
  end;
end;

function CreateNullDacl: PSecurityDescriptor;
var
  sidLength: DWORD;
  sid: PSID;
  groupSID: PSID;
  ownerSID: PSID;
  sdSize: Integer;
begin
  sid := GetCurrentUserSID;
  try
    sidLength := GetLengthSid(sid);
    sdSize := SizeOf(TSecurityDescriptor) + (2 * sidLength);

    GetMem(Result, sdSize);
    try
      groupSID := PSID(Integer(Result) + SizeOf(TSecurityDescriptor));
      ownerSID := PSID(Integer(groupSID) + sidLength);
      if not InitializeSecurityDescriptor(Result, SECURITY_DESCRIPTOR_REVISION) then
        RaiseLastWin32Error;
      Move(sid^, groupSID^, sidLength);
      if not SetSecurityDescriptorGroup(Result, groupSID, False) then
        RaiseLastWin32Error;
      Move(sid^, ownerSID^, sidLength);
      if not SetSecurityDescriptorOwner(Result, ownerSID, False) then
        RaiseLastWin32Error;
      if not IsValidSecurityDescriptor(Result) then
        RaiseLastWin32Error;
    except
      FreeMem(Result);
      raise;
    end;
  finally
    FreeMem(Sid);
  end;
end;

procedure ListDefaultAccessACL(var S: String);
begin
  ListNamedValueSD(HKEY_LOCAL_MACHINE, REGSTR_KEY_OLE,
    REGSTR_VAL_DEFAULTACCESSPERMISSION, S);
end;

procedure ListDefaultLaunchACL(var S: String);
begin
  ListNamedValueSD(HKEY_LOCAL_MACHINE, REGSTR_KEY_OLE,
    REGSTR_VAL_DEFAULTLAUNCHPERMISSION, S);
end;

procedure ListAppIDAccessACL(AppID: PChar; var S: String);
var
  keyName: array [0..255] of Char;
begin
  MakeAppIDKeyName(PChar(@keyName), AppID);
  ListNamedValueSD(HKEY_CLASSES_ROOT, keyName, REGSTR_VAL_ACCESSPERMISSION, S);
end;

procedure ListAppIDLaunchACL(AppID: PChar; var S: String);
var
  keyName: array [0..255] of Char;
begin
  MakeAppIDKeyName(keyName, AppID);
  ListNamedValueSD(HKEY_CLASSES_ROOT, keyName, REGSTR_VAL_LAUNCHPERMISSION, S);
end;

procedure ListNamedValueSD(RootKey: HKEY; KeyName, ValueName: PChar;
  var S: String);
var
  sd: PSecurityDescriptor;
  resultValue: DWORD;
begin
  sd := nil;
  resultValue := GetNamedValueSD(RootKey, KeyName, ValueName, sd);
  if resultValue <> ERROR_SUCCESS then
  begin
    S := GetErrorMessage(resultValue);
    Exit;
  end;
  try
    ListSDACL(sd, S);
  finally
    FreeMem(sd);
  end;
end;

procedure ListSDACL(pSD: PSecurityDescriptor; var S: String);
var
  present: BOOL;
  defaultDACL: BOOL;
  dacl: PACL;
begin
  if not GetSecurityDescriptorDacl(pSD, present, dacl, defaultDACL) then
  begin
    S := MakeLastWin32ErrorMessage;
    Exit;
  end;
  if not present then
  begin
    S := 'Access is denied to everyone';
    Exit;
  end;
  ListACL(dacl^, S);
end;

procedure ListACL(const Acl: TACL; var S: String);
var
  aclSizeInfo: TAclSizeInformation;
  aclRevInfo: TAclRevisionInformation;
  I: Integer;
  ace: Pointer;
  aceHeader: PAceHeader;
  paaace:  PAccessAllowedAce;
  padace:  PAccessDeniedAce;
  domainName: array[0.. 255] of char;
  userName: array [0.. 255] of char;
  nameLength: DWORD;
  snu:  SID_NAME_USE;
begin
  if not GetAclInformation(Acl, @aclSizeInfo,
      sizeof(TAclSizeInformation), AclSizeInformation) then
  begin
    S := 'Could not get AclSizeInformation';
    Exit;
  end;

  if not GetAclInformation(Acl, @aclRevInfo,
     sizeof(TAclRevisionInformation), AclRevisionInformation) then
  begin
    S := 'Could not get AclRevisionInformation';
    Exit;
  end;

  for I := 0 to aclSizeInfo.AceCount - 1 do
  begin
    if not GetAce(Acl, I, ace) then
      Exit; // no ace information
    aceHeader := PAceHeader(ace);
    if aceHeader.AceType = ACCESS_ALLOWED_ACE_TYPE then
    begin
      paaace := PAccessAllowedAce(ace);
      nameLength := 255;
      LookupAccountSid(nil,
         @paaace.SidStart,
         userName,
         nameLength,
         domainName,
         nameLength,
         snu);
      if S <> '' then S := S + #13#10;
      S := S + Format('Access permitted to %s\%s.', [domainName, userName]);
    end
    else
    if aceHeader.AceType = ACCESS_DENIED_ACE_TYPE then
    begin
      padace := PAccessDeniedAce(ace);
      nameLength := 255;
      LookupAccountSid(nil,
        @padace.SidStart,
        userName,
        nameLength,
        domainName,
        nameLength,
        snu);
      if S <> '' then S := S + #13#10;
      S := S + Format('Access denied to %s\%s.', [domainName, userName]);
    end;
  end;
end;

procedure RemovePrincipalFromACL(Acl: PACL; Principal: PChar);
var
  aclSizeInfo: ACL_SIZE_INFORMATION;
  I:  Integer;
  ace: Pointer;
  accessAllowedAce: PAccessAllowedAce;
  accessDeniedAce: PAccessDeniedAce;
  systemAuditAce: PSystemAuditAce;
  principalSID: PSID;
  aceHeader: PAceHeader;
begin
  principalSID := GetPrincipalSID(Principal);
  try
    if not GetAclInformation(Acl^, @aclSizeInfo, SizeOf(ACL_SIZE_INFORMATION),
      AclSizeInformation) then RaiseLastWin32Error;
    for I := 0 to aclSizeInfo.AceCount - 1 do
    begin
      if not GetAce(Acl^, I, ace) then RaiseLastWin32Error;

      aceHeader := PAceHeader(ace);

      if aceHeader.AceType = ACCESS_ALLOWED_ACE_TYPE then
      begin
        accessAllowedAce := PAccessAllowedAce(ace);
        if EqualSid(principalSID, @accessAllowedAce.SidStart) then
        begin
          DeleteAce(Acl^, I);
          Exit;
        end
      end
      else
      if aceHeader.AceType = ACCESS_DENIED_ACE_TYPE then
      begin
        accessDeniedAce := PAccessDeniedAce(ace);
        if EqualSid(principalSID, @accessDeniedAce.SidStart) then
        begin
          DeleteAce(Acl^, I);
          Exit
        end
      end
      else
      if aceHeader.AceType = SYSTEM_AUDIT_ACE_TYPE then
      begin
        systemAuditAce := PSystemAuditAce(ace);
        if EqualSid(principalSID, @systemAuditAce.SidStart) then
        begin
          DeleteAce(Acl^, I);
          Exit;
        end
      end;
    end;
  finally
    FreeMem(principalSID);
  end;
end;

procedure AddPrincipalToNamedValueSD(RootKey: HKEY;
  KeyName, ValueName, Principal: PChar; Permit: BOOL);
var
  pSD: PSecurityDescriptor;
  sdSelfRelative: PSecurityDescriptor;
  sdAbsolute: PSecurityDescriptor;
  secDescSize: DWORD;
  present: BOOL;
  defaultDACL: BOOL;
  dacl: PACL;
  newSD: BOOL;
  newACL: PACL;
  saveACL: PACL;
begin
  newSD := False;
  pSD := nil;
  if GetNamedValueSD(RootKey, KeyName, ValueName, pSD) <> ERROR_SUCCESS then
  begin
    pSD := CreateNewSD;
    newSD := True;
  end;
  try
    if not GetSecurityDescriptorDacl(pSD, present, dacl, defaultDACL) then
      RaiseLastWin32Error;

    newACL := nil;
    if newSD then
    begin
      AddAccessAllowedACEToACL(dacl, newACL, COM_RIGHTS_EXECUTE, 'SYSTEM');
      saveACL := newACL;
      try
        AddAccessAllowedACEToACL(saveACL, newACL, COM_RIGHTS_EXECUTE, 'INTERACTIVE');
      finally
        FreeMem(saveACL);
      end;
    end;

    if Permit then
    begin
      if newACL <> nil then
      begin
        saveACL := newACL;
        try
          AddAccessAllowedACEToACL(saveACL, newACL, COM_RIGHTS_EXECUTE, Principal)
        finally
          FreeMem(saveACL);
        end;
      end
      else
        AddAccessAllowedACEToACL(dacl, newACL, COM_RIGHTS_EXECUTE, Principal)
    end
    else
    begin
      if newACL <> nil then
      begin
        saveACL := newACL;
        try
          AddAccessDeniedACEToACL(saveACL, newACL, GENERIC_ALL, Principal);
        finally
          FreeMem(saveACL)
        end;
      end
      else
        AddAccessDeniedACEToACL(dacl, newACL, GENERIC_ALL, Principal);
    end;

    try
      if not newSD then
         sdAbsolute := MakeSDAbsolute(pSD)
       else
         sdAbsolute := pSD;
      try
        if not SetSecurityDescriptorDacl(sdAbsolute, True, newACL, False) then
          RaiseLastWin32Error;

        secDescSize := 0;
        sdSelfRelative := nil;
        MakeSelfRelativeSD(sdAbsolute, sdSelfRelative, secDescSize);
        GetMem(sdSelfRelative, secDescSize);
        try
          if not MakeSelfRelativeSD(sdAbsolute, sdSelfRelative, secDescSize) then
            RaiseLastWin32Error;
          SetNamedValueSD(RootKey, KeyName, ValueName, sdSelfRelative);
        finally
          FreeMem(sdSelfRelative);
        end; 
      finally
        if pSD <> sdAbsolute then FreeMem(sdAbsolute);
      end;
    finally
      FreeMem(newACL);
    end;
  finally
    FreeMem(pSD);
  end;
end;

procedure RemovePrincipalFromNamedValueSD(RootKey: HKEY;
  KeyName, ValueName, Principal: PChar);
var
  pSD: PSecurityDescriptor;
  sdSelfRelative: PSecurityDescriptor;
  sdAbsolute: PSecurityDescriptor;
  secDescSize:  DWORD;
  present: BOOL;
  defaultDACL: BOOL;
  dacl:  PACL;
  newSD: BOOL;
begin
  newSD := False;
  pSD := nil;
  if GetNamedValueSD(RootKey, KeyName, ValueName, pSD) <> ERROR_SUCCESS then
  begin
    pSD := CreateNewSD;
    newSD := True;
  end;
  try
    if not GetSecurityDescriptorDacl(pSD, present, dacl, defaultDACL) then
      RaiseLastWin32Error;
      
    RemovePrincipalFromACL(dacl, Principal);

    if not newSD then
      sdAbsolute := MakeSDAbsolute(pSD)
    else
      sdAbsolute := pSD;
    try
      if not SetSecurityDescriptorDacl(sdAbsolute, True, dacl, False) then
        RaiseLastWin32Error;

      secDescSize := 0;
      sdSelfRelative := nil;
      if not MakeSelfRelativeSD(sdAbsolute, sdSelfRelative, secDescSize) then
      begin
        if GetLastError <> ERROR_INSUFFICIENT_BUFFER then
          RaiseLastWin32Error;
      end;
      GetMem(sdSelfRelative, secDescSize);
      try
        if not MakeSelfRelativeSD(sdAbsolute, sdSelfRelative, secDescSize) then
          RaiseLastWin32Error;
        SetNamedValueSD(RootKey, KeyName, ValueName, sdSelfRelative);
      finally
        FreeMem(sdSelfRelative);
      end;
    finally
      if sdAbsolute <> pSD then FreeMem(sdAbsolute);
    end; 
  finally
    FreeMem(pSD);
  end;
end;

function MakeSDAbsolute(OldSD: PSecurityDescriptor): PSecurityDescriptor;
var
  descriptorSize: DWORD;
  daclSize: DWORD;
  saclSize: DWORD;
  ownerSIDSize: DWORD;
  groupSIDSize: DWORD;
  dacl: PACL;
  sacl: PACL;
  ownerSID: PSID;
  groupSID: PSID;
  present: BOOL;
  systemDefault: BOOL;
begin
  if not GetSecurityDescriptorSacl(OldSD, present, sacl, systemDefault) then
    RaiseLastWin32Error;
  if present and (sacl <> nil) then
    saclSize := sacl.AclSize
  else
    saclSize := 0;

  if not GetSecurityDescriptorDacl(OldSD, present, dacl, systemDefault) then
    RaiseLastWin32Error;
  if present and (dacl <> nil) then
    daclSize := dacl.AclSize
  else
    daclSize := 0;

  if not GetSecurityDescriptorOwner(OldSD, ownerSID, systemDefault) then
    RaiseLastWin32Error;
  ownerSIDSize := GetLengthSid(ownerSID);

  if not GetSecurityDescriptorGroup(OldSD, groupSID, systemDefault) then
    RaiseLastWin32Error;
  groupSIDSize := GetLengthSid(groupSID);

  descriptorSize := 0;

  Result := nil;
  if not MakeAbsoluteSD(OldSD, Result, descriptorSize, dacl^, daclSize, sacl^,
     saclSize, ownerSID, ownerSIDSize, groupSID, groupSIDSize) then
  begin
    if GetLastError <> ERROR_INSUFFICIENT_BUFFER then
      RaiseLastWin32Error;
  end;

  GetMem(Result, SECURITY_DESCRIPTOR_MIN_LENGTH);
  try
    if not InitializeSecurityDescriptor(Result, SECURITY_DESCRIPTOR_REVISION) then
      RaiseLastWin32Error;

    if not MakeAbsoluteSD(OldSD, Result, descriptorSize, dacl^, daclSize, sacl^,
       saclSize, ownerSID, ownerSIDSize, groupSID, groupSIDSize) then
       RaiseLastWin32Error;
  except
    FreeMem(Result);
    raise;
  end;
end;

function GetNamedValueSD(RootKey: HKEY; KeyName, ValueName: PChar;
  var pSD: PSecurityDescriptor): DWORD;
var
  registryKey: HKEY;
  valueType: DWORD;
  valueSize: DWORD;
  newSD: PSecurityDescriptor;
begin
  Result := RegOpenKeyEx(RootKey, KeyName, 0, KEY_ALL_ACCESS, registryKey);
  if Result = ERROR_SUCCESS then
  try
    Result := RegQueryValueEx(registryKey, ValueName, nil, @valueType, nil, @valueSize);
    if Result = ERROR_SUCCESS then
    begin
      GetMem(newSD, valueSize);
      try
        Result := RegQueryValueEx(registryKey, ValueName, nil,
          @valueType, PByte(newSD), @valueSize);
        if Result = ERROR_SUCCESS then
          pSD := newSD
        else
          FreeMem(newSD);
      except
        FreeMem(newSD);
        raise;
      end;
    end
  finally
    RegCloseKey(registryKey);
  end;
end;

procedure SetNamedValueSD(RootKey: HKEY; KeyName, ValueName: PChar;
  pSD: PSecurityDescriptor);
var
  disposition: DWORD;
  registryKey: HKEY;
  Res: DWORD;
begin
  Res := RegCreateKeyEx(RootKey, KeyName, 0, '', 0, KEY_ALL_ACCESS, nil,
     registryKey, @disposition);
  if Res <> ERROR_SUCCESS then RaiseLastWin32Error;
  try
    Res := RegSetValueEx(registryKey, ValueName, 0, REG_BINARY, pSD,
        GetSecurityDescriptorLength(pSD));
    if Res <> ERROR_SUCCESS then RaiseLastWin32Error;
  finally
    RegCloseKey (registryKey);
  end;;
end;

procedure AddAccessDeniedACEToACL(OldACL: PACL; var NewAcl: PACL;
  PermissionMask: DWORD; Principal: PChar);
var
  aclSizeInfo: ACL_SIZE_INFORMATION;
  aclSize: Integer;
  principalSID: PSID;
begin
  principalSID := GetPrincipalSID(Principal);
  try
    if not GetAclInformation(oldACL^, @aclSizeInfo, SizeOf(ACL_SIZE_INFORMATION),
      AclSizeInformation) then RaiseLastWin32Error;
    aclSize := aclSizeInfo.AclBytesInUse +
               SizeOf(TACL) + SizeOf(ACCESS_DENIED_ACE) +
               GetLengthSid(principalSID) - SizeOf(DWORD);
    GetMem(newACL, aclSize);
    try
      if not InitializeAcl(newACL^, aclSize, ACL_REVISION) then
        RaiseLastWin32Error;
      if not AddAccessDeniedAce(newACL^, ACL_REVISION2, PermissionMask, principalSID) then
        RaiseLastWin32Error;
      CopyACL(oldACL, newACL);
    except
      FreeMem(newACL);
      raise;
    end;
  finally
    FreeMem(principalSID);
  end;
end;

procedure AddAccessAllowedACEToACL(OldAcl: PACL; var NewAcl: PACL; PermissionMask: DWORD;
  Principal: PChar);
var
  aclSizeInfo: ACL_SIZE_INFORMATION;
  aclSize: Integer;
  principalSID: PSID;
begin
  principalSID := GetPrincipalSID(Principal);
  try
    if not GetAclInformation(oldACL^, @aclSizeInfo, SizeOf(ACL_SIZE_INFORMATION),
      AclSizeInformation) then RaiseLastWin32Error;
    aclSize := aclSizeInfo.AclBytesInUse +
               SizeOf(TACL) + SizeOf(ACCESS_ALLOWED_ACE) +
               GetLengthSid(principalSID) - SizeOf(DWORD);
    GetMem(newACL, aclSize);
    try
      if not InitializeAcl(newACL^, aclSize, ACL_REVISION) then
        RaiseLastWin32Error;
      CopyACL(oldACL, newACL);
      if not AddAccessAllowedAce(newACL^, ACL_REVISION2, PermissionMask, principalSID) then
        RaiseLastWin32Error;
    except
      FreeMem(newACL);
      raise;
    end;
  finally
    FreeMem(principalSID);
  end;
end;

procedure CopyACL(OldACL, NewACL: PACL);
var
  aclSizeInfo: ACL_SIZE_INFORMATION;
  ace: Pointer;
  aceHeader: PAceHeader;
  I: Integer;
begin
  if not GetAclInformation(OldACL^, @aclSizeInfo,
    SizeOf(aclSizeInfo), AclSizeInformation) then RaiseLastWin32Error;
  for I := 0 to aclSizeInfo.AceCount - 1 do
  begin
    if not GetAce(OldACL^, I, ace) then RaiseLastWin32Error;
    aceHeader := PAceHeader(ace);
    if not AddAce(NewACL^, ACL_REVISION, $FFFFFFFF, ace, aceHeader.AceSize) then
      RaiseLastWin32Error;
  end;
end;

function IsGuidIn(const AGUID: TGUID; const AGUIDs: array of TGUID): Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := Low(AGUIDs) to High(AGUIDs) do
    if IsEqualGUID(AGUID, AGUIDs[I]) then Exit;
  Result := False;
end;

function IsDCOMOk: Boolean;
begin
  Result :=  Assigned(CoCreateInstanceEx);
end;

function IsInitializeSecurityOk: Boolean;
begin
  Result := Assigned(CoInitializeSecurity);
end;

{ function CreateNullDACL: PSecurityDescriptor;
begin
  GetMem(Result, SECURITY_DESCRIPTOR_MIN_LENGTH);
  try
    if not InitializeSecurityDescriptor(Result,
      SECURITY_DESCRIPTOR_REVISION) then
     RaiseLastWin32Error;

    // Add a null DACL to the security descriptor.
    if not SetSecurityDescriptorDacl(Result, True, nil, False) then
      RaiseLastWin32Error;
  except
    FreeMem(Result);
    raise;
  end;
end; }

procedure InitializeDefaultSecurity;
begin
  if Assigned(CoInitializeSecurity) then
  begin
    OleCheck(CoInitializeSecurity(
           nil,                        //Points to security descriptor
           -1,                          //Count of entries in asAuthSvc
           nil,                         //Array of names to register
           nil,                         //Reserved for future use
           RPC_C_AUTHN_LEVEL_NONE,      //Default authentication level
                                        // for proxies
           RPC_C_IMP_LEVEL_IMPERSONATE, //Default impersonation level
                                        // for proxies
           nil,                         //Reserved; must be set to NULL
           EOAC_NONE,                  //Additional client or
                                        // server-side capabilities
           nil));                       //Reserved for future use
  end;
end;

function IsEnabledDCOM: Boolean;
var
  Reg: TRegistry;
begin
  Result := False;
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    if not Reg.OpenKey(REGSTR_KEY_OLE, False) then Exit;

    if not Reg.ValueExists(REGSTR_VAL_ENABLEDCOM) then Exit;
    try
      if Reg.ReadString(REGSTR_VAL_ENABLEDCOM) <> 'Y' then Exit;
    except
      Exit;
    end;

    if Win32Platform = VER_PLATFORM_WIN32_WINDOWS then
    begin
      if not Reg.ValueExists(REGSTR_VAL_ENABLEREMOTECONNECT) then Exit;
      try
        if Reg.ReadString(REGSTR_VAL_ENABLEREMOTECONNECT) <> 'Y' then Exit;
      except
        Exit;
      end;
    end;
  finally
    Reg.Free;
  end;
  Result := True;
end;

procedure SetEnableDCOM(const Value: Boolean);
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;

    if Reg.OpenKey(REGSTR_KEY_OLE, False) then
    begin
      if not Reg.ValueExists(REGSTR_VAL_ENABLEDCOM)
        or (Reg.ReadString(REGSTR_VAL_ENABLEDCOM) <> YesNoToChar[Value]) then
      begin
        Reg.WriteString(REGSTR_VAL_ENABLEDCOM, YesNoToChar[Value]);
      end;
      if Win32Platform = VER_PLATFORM_WIN32_WINDOWS then
      begin
        if not Reg.ValueExists(REGSTR_VAL_ENABLEREMOTECONNECT)
          or (Reg.ReadString(REGSTR_VAL_ENABLEREMOTECONNECT) <> YesNoToChar[Value]) then
        begin
          Reg.WriteString(REGSTR_VAL_ENABLEREMOTECONNECT, YesNoToChar[Value]);
        end;
      end;
    end
  finally
    Reg.Free;
  end;
end;

function IsInteractiveUser(const ClassID: TGUID): Boolean;
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CLASSES_ROOT; // Не менять
    Result := Reg.OpenKey(REGSTR_KEY_APPID + '\' + GUIDToString(ClassID), False)
       and Reg.ValueExists(REGSTR_VAL_RUNAS)
       and (Reg.ReadString(REGSTR_VAL_RUNAS) = InteractiveUserValue);
  finally
    Reg.Free;
  end;
end;

function HInstanceToModuleName: String; 
var
  ModuleName: array[0..MAX_PATH] of Char;
begin
  SetString(Result, ModuleName,
    Windows.GetModuleFileName(HInstance, ModuleName, SizeOf(ModuleName)));
end;

procedure SetInteractiveUser(const ClassID: TGUID; const Value: Boolean);
var
  Reg: TRegistry;
  strClassID: String;
  keyAppID: String;
  keyClassID: String;
  keyModuleName: String;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CLASSES_ROOT;
    strClassID := GUIDToString(ClassID);
    keyAppID := REGSTR_KEY_APPID + '\' + strClassID;
    keyClassID := REGSTR_KEY_CLSID + '\' + strClassID;
    keyModuleName := REGSTR_KEY_APPID + '\' + ExtractFileName(HInstanceToModuleName);
    if Value then
    begin
      if Reg.OpenKey(keyAppID, True) then
      begin
        Reg.WriteString(REGSTR_VAL_RUNAS, InteractiveUserValue);
        Reg.CloseKey;
      end;
      if Reg.OpenKey(keyModuleName, True) then
      begin
        Reg.WriteString(REGSTR_VAL_APPID, strClassID);
        Reg.CloseKey;
      end;
      if Reg.OpenKey(keyClassID, False) then
      begin
        Reg.WriteString(REGSTR_VAL_APPID, strClassID);
        Reg.CloseKey;
      end;
    end
    else
    begin
      if Reg.OpenKey(keyAppID, False) then
      begin
        Reg.DeleteValue(REGSTR_VAL_RUNAS);
        Reg.CloseKey;
      end;
    end;
  finally
    Reg.Free;
  end;
end;

function IsDCOMProtocolsEnabled: Boolean;
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    Result := Reg.OpenKey(REGSTR_KEY_RPC, False)
       and Reg.ValueExists(REGSTR_VAL_DCOMPROTOCOLS)
       and (Reg.GetDataSize(REGSTR_VAL_DCOMPROTOCOLS) > 2);
  finally
    Reg.Free;
  end;
end;

procedure RemoveLegacySecureReferences;
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    if Reg.OpenKey(REGSTR_KEY_OLE, False) then
    begin
      if Reg.ValueExists(REGSTR_VAL_LEGACYSECUREREFERENCES)
         and (Reg.ReadString(REGSTR_VAL_LEGACYSECUREREFERENCES) <> YesNoToChar[False]) then
        Reg.DeleteValue(REGSTR_VAL_LEGACYSECUREREFERENCES);
    end;
  finally
    Reg.Free;
  end;
end;

procedure SetDefaultDCOMCommunicationProperties;
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;

    if Reg.OpenKey(REGSTR_KEY_OLE, False) then
    begin
      if not Reg.ValueExists(REGSTR_VAL_LEGACYAUTHENTICATIONLEVEL)
        or (Reg.ReadInteger(REGSTR_VAL_LEGACYAUTHENTICATIONLEVEL) <> RPC_C_AUTHN_LEVEL_NONE) then
      begin
        Reg.WriteInteger(REGSTR_VAL_LEGACYAUTHENTICATIONLEVEL,
          RPC_C_AUTHN_LEVEL_NONE);
      end;
      if not Reg.ValueExists(REGSTR_VAL_IMPERSONATIONLEVEL)
        or (Reg.ReadInteger(REGSTR_VAL_IMPERSONATIONLEVEL) <> RPC_C_IMP_LEVEL_IMPERSONATE) then
      begin
        Reg.WriteInteger(REGSTR_VAL_IMPERSONATIONLEVEL,
          RPC_C_IMP_LEVEL_IMPERSONATE);
      end;
    end;
  finally
    Reg.Free;
  end;
end;

function ExtractQuotedStr(const Src: String): String;
begin
  Result := Src;
  if Src[1] = '"' then Delete(Result, 1, 1);;
  if Result[Length(Result)] = '"' then SetLength(Result, Length(Result) - 1);
end;

function CLSIDToFileName(const CLSID: TGUID): String;
var
  Reg: TRegistry;
  strCLSID: String;
begin
  Result := '';
  Reg := TRegistry.Create;
  try
    Reg.RootKey:= HKEY_CLASSES_ROOT;
    strCLSID := GUIDToString(CLSID);
    if Reg.OpenKey(Format('CLSID\%s\InProcServer32', [strCLSID]), False)
       or Reg.OpenKey(Format('CLSID\%s\LocalServer32', [strCLSID]), False) then
    begin
      try
        Result := ExtractQuotedStr(Reg.ReadString(''));
      finally
        Reg.CloseKey;
      end;
    end;
  finally
    Reg.Free;
  end;
end;

function CreateRemoteComObjectEx(const MachineName: WideString;
  const ClassID: TGUID): IUnknown;
var
  MQI: TMultiQI;
  Ole32: HModule;
  ServerInfo: TCoServerInfo;
  AuthInfo: TCoAuthInfo;
  IID_IUnknown: TGuid;
begin
  Ole32 := GetModuleHandle('ole32.dll');
  Win32Check(Ole32 > HINSTANCE_ERROR);
  @CoCreateInstanceEx := GetProcAddress(Ole32, 'CoCreateInstanceEx');
  if @CoCreateInstanceEx = nil then
    raise Exception.Create('Не установлен DCOM');

  FillChar(AuthInfo, SizeOf(AuthInfo), 0);
  AuthInfo.dwAuthnSvc := RPC_C_AUTHN_NONE;
  AuthInfo.dwAuthzSvc := RPC_C_AUTHZ_NONE;
  AuthInfo.pwszServerPrincName := nil;
  AuthInfo.dwAuthnLevel := RPC_C_AUTHN_LEVEL_NONE;
  AuthInfo.dwImpersonationLevel := RPC_C_IMP_LEVEL_IMPERSONATE;
  AuthInfo.pAuthIdentityData := nil;
  AuthInfo.dwCapabilities := EOAC_NONE;

  FillChar(ServerInfo, sizeof(ServerInfo), 0);
  ServerInfo.pwszName := PWideChar(MachineName);
  ServerInfo.pAuthInfo := @AuthInfo;
  IID_IUnknown := IUnknown;
  MQI.IID := @IID_IUnknown;
  MQI.itf := nil;
  MQI.hr := 0;
  OleCheck(CoCreateInstanceEx(ClassID, nil,
    CLSCTX_LOCAL_SERVER,
    @ServerInfo, 1, @MQI));
  OleCheck(MQI.HR);
  Result := MQI.itf;
end;

end.
