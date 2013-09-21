unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, JvComponentBase, JvAppStorage, JvAppRegistryStorage;

type
	TForm1 = class(TForm)
		UBtn: TButton;
		DBtn: TButton;
		LBtn: TButton;
		RBtn: TButton;
		CBtn: TButton;
		CtrlInfo: TLabel;
		AdvLbl: TLabel;
		Version: TLabel;
		Registry: TJvAppRegistryStorage;
		procedure AllMouseUp(Sender: TObject; Button: TMouseButton;
			Shift: TShiftState; X, Y: Integer);
		procedure AllButtonDown(Sender: TObject; Button: TMouseButton;
			Shift: TShiftState; X, Y: Integer);
		procedure CtrlInfoClick(Sender: TObject);
		procedure AdvLblClick(Sender: TObject);
		procedure AdvLblMouseEnter(Sender: TObject);
		procedure AdvLblMouseLeave(Sender: TObject);
		procedure CtrlInfoMouseEnter(Sender: TObject);
		procedure FormCreate(Sender: TObject);
		procedure FormClose(Sender: TObject; var Action: TCloseAction);
		procedure FormKeyDown(Sender: TObject; var Key: Word;
			Shift: TShiftState);
		procedure FormKeyUp(Sender: TObject; var Key: Word;
			Shift: TShiftState);
	private
		{ Private declarations }
	public
		{ Public declarations }
	end;

var
	Form1: TForm1;
	pAddr : word;
	USB : boolean;
	USBInt : boolean = false;
	DLLName : string;

implementation
{$R *.dfm}
uses
	DLLControl,
	ShellAPI,
	WinSpool,
	Settings;


//function Out32(wAddr:word;bOut:byte):byte; stdcall; external 'inpout32.dll';
{function Out32(wAddr:word;bOut:byte):byte;
begin
result:=0;
end;}

procedure SendUSB(Data : byte);
var
	hPrinter : THandle;
	docInfo : TDocInfo1;
	byteNumber : Dword;
begin
	OpenPrinter('TTL_OUTPUT', hPrinter, nil);
	// Fill the "document"
	docInfo.pDocName := 'My outputs';
	docInfo.pOutputFile := nil;
	docInfo.pDatatype := 'RAW';
	// start a document
	StartDocPrinter(hPrinter, 1, @docInfo);
	// start a page
	StartPagePrinter(hPrinter);
	// send a byte to the printer
	WritePrinter(hPrinter, @data, 1, byteNumber);
	// close the page
	EndPagePrinter(hPrinter);
	// close the document
	EndDocPrinter(hPrinter);
	// close the printer
	ClosePrinter(hPrinter);
end;

procedure Send(Data : byte);
begin
	if USB then
	begin
		if USBInt then SendUSB(Data)
		else Out32($0378, Data);
	end else
		Out32(pAddr, Data);
end;

procedure TForm1.AllMouseUp(Sender: TObject; Button: TMouseButton;
	Shift: TShiftState; X, Y: Integer);
begin
	Send(0);
end;

procedure TForm1.AllButtonDown(Sender: TObject; Button: TMouseButton;
	Shift: TShiftState; X, Y: Integer);

	function StringToCaseSelect(
		Selector : string;
		CaseList: array of string
	): Integer;
	var
		cnt: integer;
	begin
		Result:=-1;
		for cnt:=0 to Length(CaseList)-1 do
		begin
			if CompareText(Selector, CaseList[cnt]) = 0 then
			begin
				Result:=cnt;
				Break;
			end;
		end;
	end;

begin
	case StringToCaseSelect(TButton(Sender).Name,
			['UBtn','DBtn','LBtn','RBtn','CBtn']) of
	0 : Send(1);
	1 : Send(2);
	2 : Send(4);
	3 : Send(8);
	4 : Send(16);
	end;
end;

procedure TForm1.AdvLblClick(Sender: TObject);
begin
	Form2.ShowModal;
end;

procedure TForm1.CtrlInfoClick(Sender: TObject);
Var
	app : string;
begin
	app := 'res://'+Application.ExeName+'/HTML/Help';
	ShellExecute(
		Handle,
		'open',
		PAnsiChar(app),
		nil,nil, SW_SHOWNORMAL
	);
end;

procedure TForm1.AdvLblMouseEnter(Sender: TObject);
begin
	Form1.Cursor := crHandPoint;
end;

procedure TForm1.AdvLblMouseLeave(Sender: TObject);
begin
	Form1.Cursor := crDefault;
end;

procedure TForm1.CtrlInfoMouseEnter(Sender: TObject);
begin
	Form1.Cursor := crHelp;
end;

procedure TForm1.FormCreate(Sender: TObject);

	function GetTempFile: string;
	var
		Buffer: array[0..MAX_PATH] of Char;
	begin
			GetTempPath(SizeOf(Buffer) - 1, Buffer);
			GetTempFileName(Buffer, '~', 0, Buffer);
			result := StrPas(Buffer);
	end;

begin
	Registry.Path := 'Software\AuraSystems\CameraControl';
	Registry.AutoFlush := True;
	pAddr := Registry.ReadInteger('Port',$0378);
	USB := Registry.ReadBoolean('USBMode',False);
	DLLName := GetTempFile;
	Color := RGB(130,0,3);
	if not USB then LoadDLL(1) else LoadDLL(2);
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
	Registry.WriteInteger('Port',pAddr);
	Registry.WriteBoolean('USBMode',USB);
	Registry.Path := '';
	CloseDLL;
	DeleteFile(DLLName);
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
	case Key of
	VK_NUMPAD8: UBtn.Perform(WM_LButtonDown,0,0);
	VK_NUMPAD2: DBtn.Perform(WM_LButtonDown,0,0);
	VK_NUMPAD4: LBtn.Perform(WM_LButtonDown,0,0);
	VK_NUMPAD6: RBtn.Perform(WM_LButtonDown,0,0);
	VK_NUMPAD5: CBtn.Perform(WM_LButtonDown,0,0);
	end;
end;

procedure TForm1.FormKeyUp(Sender: TObject; var Key: Word;
	Shift: TShiftState);
begin
	case Key of
	VK_NUMPAD8: UBtn.Perform(WM_LButtonUp,0,0);
	VK_NUMPAD2: DBtn.Perform(WM_LButtonUp,0,0);
	VK_NUMPAD4: LBtn.Perform(WM_LButtonUp,0,0);
	VK_NUMPAD6: RBtn.Perform(WM_LButtonUp,0,0);
	VK_NUMPAD5: CBtn.Perform(WM_LButtonUp,0,0);
	end;
end;

end.
