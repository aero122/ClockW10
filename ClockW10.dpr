program ClockW10;



{$R *.dres}

uses
  Vcl.Forms,
  Main in 'Main.pas' {Form1},
  About in 'About.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  //Application.MainFormOnTaskbar := False;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
