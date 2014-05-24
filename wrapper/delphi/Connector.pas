unit Connector;

interface

uses windows;

type TVariableType=(vtByte=0, vtWord=1, vtDword=2, vtQword=3, vtSingle=4, vtDouble=5, vtString=6, vtUnicodeString=7, vtByteArray=8, vtBinary=9, vtAll=10, vtAutoAssembler=11, vtPointer=12, vtCustom=13, vtGrouped=14, vtByteArrays=15); //all ,grouped and MultiByteArray are special types

type
  TGetProcessList = procedure(out processes : WideString); stdcall;
  TOpenProcess = procedure(pid: WideString); stdcall;
  TResetScripts = procedure(); stdcall;
  TAddScript = procedure(name: WideString; script: WideString); stdcall;
  TRemoveScript = procedure(id: integer); stdcall;
  TActivateScript = procedure(id: integer; activate: boolean); stdcall;

  TProcessAddress = procedure(address : WideString ; vartype : TVariableType ; showashexadecimal: Boolean=false;
  showAsSigned: boolean=false; bytesize: Integer = 1; out res_address : WideString);stdcall;
  TAddAddressManually = procedure (initialaddress: WideString=''; vartype: TVariableType=vtDword);stdcall;
  TGetValue = procedure (id : integer ; out value : WideString);stdcall;

var
  IGetProcessList: TGetProcessList;
  IOpenProcess: TOpenProcess;
  IResetScripts: TResetScripts;
  IAddScript: TAddScript;
  IRemoveScript: TRemoveScript;
  IActivateScript: TActivateScript;

  IProcessAddress : TProcessAddress;
  IAddAddressManually : TAddAddressManually;
  IGetValue : TGetValue;

procedure loadFunctions(handle: THandle);

implementation

procedure loadFunctions(handle: THandle);
begin
  @IGetProcessList := GetProcAddress(handle, 'IGetProcessList');
  @IOpenProcess := GetProcAddress(handle, 'IOpenProcess');
  @IResetScripts := GetProcAddress(handle, 'IResetScripts');
  @IAddScript := GetProcAddress(handle, 'IAddScript');
  @IRemoveScript := GetProcAddress(handle, 'IRemoveScript');
  @IActivateScript := GetProcAddress(handle, 'IActivateScript');

  @IProcessAddress := GetProcAddress(handle, 'IProcessAddress');
  @IAddAddressManually := GetProcAddress(handle, 'IAddAddressManually');
  @IGetValue := GetProcAddress(handle, 'IGetValue');
end;

end.
