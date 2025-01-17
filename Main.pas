unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Menus, inifiles, About, AAL;

type
  TForm1 = class(TForm)
    Label1: AAL.TLabel;
    Timer1: TTimer;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    TrayIcon1: TTrayIcon;
    FontDialog1: TFontDialog;
    N9: TMenuItem;
    PopupMenu2: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    ColorDialog1: TColorDialog;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Label1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure FormSize(w:integer; h:integer);
    procedure FormDestroy(Sender: TObject);
    procedure TrayIcon1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure TrayIcon1Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

//��� ���������� ����� ���������� ���������
procedure TForm1.FormDestroy(Sender: TObject);
var
  ini:TiniFile;
begin
  ini:=TiniFile.Create(ExtractFilePath(GetEnvironmentVariable('localappdata'))+'Local\ClockW10\config.ini');    //paramStr(0))+'%localappdata%\ClockW10\config.ini'
  ini.WriteInteger('FontStyle','Size',Label1.Font.Size);
  ini.WriteString('FontStyle','Color',ColorToString(Label1.Font.Color));
  ini.WriteString('FontStyle','Name',Label1.Font.Name);
  //ini.WriteString('Program','Version',); - � �������, �������� � ���� ������� ������ ��� ����������
  ini.WriteInteger('Position','X',Form1.Left);
  ini.WriteInteger('Position','Y',Form1.Top);
  ini.WriteBool('Position','AlwaysOnTop',Form1.FormStyle=fsStayOnTop);
  ini.Free;
end;


procedure TForm1.FormShow(Sender: TObject);
begin
  //�������� �� ������ �����
  ShowWindow(Application.Handle,SW_HIDE);
end;

Procedure TForm1.FormSize(w: Integer; h: Integer); //������ ������ �����
begin
  Form1.Width:=w+10;
  Form1.Height:=h+10;
end;

//��� �������� �����
procedure TForm1.FormCreate(Sender: TObject);
var
  ini:TiniFile;
begin
  Label1.Caption:=FormatDateTime('hh:mm',Now);

  CreateDir(ExtractFilePath(GetEnvironmentVariable('appdata'))+'Local\ClockW10\');
  //�������� �������� �� ini �����
  ini:=TiniFile.Create(ExtractFilePath(GetEnvironmentVariable('localappdata'))+'Local\ClockW10\config.ini');
  Label1.Font.Size:=ini.ReadInteger('FontStyle','Size',35);//������ ������
  Label1.Font.Color:=StringToColor(ini.ReadString('FontStyle','Color','clBlack'));//���� ������
  Form1.Left:=ini.ReadInteger('Position','X',0);//������������ �����
  Form1.Top:=ini.ReadInteger('Position','Y',0);
  Label1.Font.Name:=ini.ReadString('FontStyle','Name','Arial');//�����
  if ini.ReadBool('Position','AlwaysOnTop',True) then//������ ���� ����
    begin
      Form1.FormStyle:=fsStayOnTop;
      N2.Caption:=WideChar($2713)+' ������ ���� ����';
    end;
  ini.Free;
  //������� ����� �� ������� Label
  FormSize(Label1.Width, Label1.Height);
  FontDialog1.MinFontSize:=12;
end;

//���������� ���� �������
procedure GetColor();
var
  Dc : HDC;
  Pix : Cardinal;
begin
  Dc:=GetDC(0);
  Pix:=GetPixel(Dc, Form1.Left, form1.Top);
  Form1.Color:=Pix;
  Form1.TransparentColorValue:=Pix;
  ReleaseDC(0, Dc);
end;

//�������������� ����� �� Label
procedure TForm1.Label1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
const
  SC_DragMove = $F012;
begin
  ReleaseCapture;
  perform(WM_SysCommand, SC_DragMove, 0);
  GetColor;
end;

procedure TForm1.N10Click(Sender: TObject);//������� ���� ������
begin
  if ColorDialog1.Execute() then
  Label1.Font.Color:=ColorDialog1.Color;
end;

//���������� ����� "� ���������"
procedure TForm1.N12Click(Sender: TObject);
begin
  Form2.Show();
end;

//������� ���������
procedure TForm1.N1Click(Sender: TObject);
begin
  Application.Terminate;
end;

//������ ���� ����
procedure TForm1.N2Click(Sender: TObject);
begin
  if Form1.FormStyle=fsNormal then
    begin
        Form1.FormStyle:=fsStayOnTop;
        N2.Caption:=WideChar($2713)+' ������ ���� ����';
    end
  else
    Begin
        Form1.FormStyle:=fsNormal;
        N2.Caption:='������ ���� ����';
    End;

end;

//��������� �����
procedure TForm1.N4Click(Sender: TObject);
begin
  Label1.Font.Color:=ClWhite;
end;

//��������� �����
procedure TForm1.N5Click(Sender: TObject);
begin
  Label1.Font.Color:=ClBlack;
end;

//������ "������"
procedure TForm1.N7Click(Sender: TObject);
begin
  Label1.Font.Size:=Label1.Font.Size+2;
  //������� ����� �� ������� Label
  FormSize(Label1.Width, Label1.Height);
end;

//������ "������"
procedure TForm1.N8Click(Sender: TObject);
begin
  Label1.Font.Size:=Label1.Font.Size-2;
  //������� ����� �� ������� Label
  FormSize(Label1.Width, Label1.Height);
end;

//����� ������
procedure TForm1.N9Click(Sender: TObject);
begin
  //��� �������� FontDialog ����� ����������� �����, ��������� ��� Label1
  FontDialog1.Font:=Label1.Font;
  If FontDialog1.Execute() then
  begin
    Label1.Font:=FontDialog1.Font;
  end;
  FormSize(Label1.Width,Label1.Height);
end;

//������ ��� ������� ������ �����
procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Label1.Caption:=FormatDateTime('hh:mm',Now);
  FormSize(Label1.Width,Label1.Height);
  GetColor;//������ ���� �����, ��� ���������� ��������� �����������
end;

//���� �� ������ � ����
procedure TForm1.TrayIcon1Click(Sender: TObject);
begin
  SetForegroundWindow(Application.MainForm.Handle);
end;

procedure TForm1.TrayIcon1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
//��� ��������� �� ������ � ���� ���������� ���������
var
  rnd:byte;
  hint:String;
begin
  Randomize();
  rnd:=Random(10);
  case rnd of
  0:hint:='� �� ��������!';
  1:hint:='����� �� ��� �������?';
  2:hint:='����� ������?';
  3:hint:='������� �������';
  4:hint:='����� �� ��� ������� - 48';
  5:hint:='���������� ����� �� ��������';
  6:hint:='��� ������� ������ �������';
  7:hint:='��� ������ ����';
  8:hint:='����� ������� ���� � ������ ������';
  9:hint:='����� ����� ���������';
  end;
  TrayIcon1.Hint:=hint;
end;

end.
