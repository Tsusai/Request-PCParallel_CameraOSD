unit Settings;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm2 = class(TForm)
    Label2: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation
uses Main, DLLControl;

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
begin
	pAddr := StrToIntDef(Form2.Edit1.Text,$0378);
	Form2.Edit1.Text := '$' + IntToHex(pAddr,4);
	if USB then
	begin
		if RadioButton1.Checked then
		begin
			USB := false;
			USBInt := false;
			LoadDll(1);
		end;
	end else
	begin
		if RadioButton2.Checked or RadioButton3.Checked then
		begin
			USB := true;
			LoadDll(2);
			if RadioButton3.Checked then USBInt := true;
		end;
	end;
	Form2.Close;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
	Color := RGB(130,0,3);
	Left := Form1.Left;
	Top := Form1.Top;
	if not USB then
		Form2.RadioButton1.Checked := true
	else
	begin
		if not USBInt then
			Form2.RadioButton2.Checked := true
		else
			Form2.RadioButton2.Checked := true;
	end;
end;

procedure TForm2.FormShow(Sender: TObject);
begin
	Edit1.Text := '$' + IntToHex(pAddr,4);
end;

end.
