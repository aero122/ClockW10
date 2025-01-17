unit AAL;

interface

uses
  Windows, Messages, SysUtils, Controls, StdCtrls, Graphics;

type
  TLabel = class(StdCtrls.TLabel)
  private
    fFontChanged: boolean;
  public
    procedure Paint; override;
end;

implementation

procedure TLabel.Paint;
var
  LF: TLogFont;
begin
  if not fFontChanged then begin
    Win32Check(GetObject(Font.Handle, SizeOf(TLogFont), @LF) <> 0);
    LF.lfQuality := DEFAULT_QUALITY; // CLEARTYPE_QUALITY ANTIALIASED_QUALITY
    Font.Handle := CreateFontIndirect(LF);
    fFontChanged := TRUE;
  end;
  inherited;
end;

end.
