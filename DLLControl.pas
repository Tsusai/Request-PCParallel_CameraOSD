unit DLLControl;

interface

procedure LoadDLL(Mode : byte);
procedure CloseDLL;

var
	Out32 : function(wAddr:word;bOut:byte):byte; stdcall = nil;

implementation
uses
	Windows, Main, Classes;

var
	HookLib: THandle = 0;

function LoadLibraryFromResource(const aResourceName: String): THandle;
var
	rs: TResourceStream;
begin
	rs := TResourceStream.Create(HInstance, aResourceName, RT_RCDATA);
	try
		rs.Position := 0;
		rs.SaveToFile(DLLName);
	finally
		rs.Free;
	end;

	Result := LoadLibraryA(PAnsiChar(DLLName));
end;

procedure LoadDLL(Mode : byte);
begin
	CloseDLL;
	case Mode of
	1: HookLib := LoadLibraryFromResource('X86');//32bit
	2: HookLib := LoadLibraryFromResource('USB');//USB Printing Support
	end;
	if HookLib <> 0 then
	@Out32 := GetProcAddress(HookLib, 'Out32');
end;

procedure CloseDLL;
begin
	if HookLib <> 0 then FreeLibrary(HookLib);
end;


end.
