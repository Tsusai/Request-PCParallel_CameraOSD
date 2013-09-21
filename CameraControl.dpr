program CameraControl;

uses
  Forms,
  Main in 'Main.pas' {Form1},
  Settings in 'Settings.pas' {Form2},
  DLLControl in 'DLLControl.pas';

{$R *.res}
{$R 'Win7UAC.res'}
{$R 'Data.RES'}

begin
	Application.Initialize;
	Application.Title := 'Camera Control';
	Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
