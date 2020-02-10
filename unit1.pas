unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Spin, ComCtrls, IdTCPClient, IdAntiFreeze, IdWhois;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button3: TButton;
    Button4: TButton;
    Button2: TButton;
    Edit1: TEdit;
    IdAntiFreeze1: TIdAntiFreeze;
    IdTCPClient1: TIdTCPClient;
    IdWhois1: TIdWhois;
    Memo1: TMemo;
    Panel1: TPanel;
    SaveDialog1: TSaveDialog;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
var
  i: integer;
begin
  IdTCPClient1.Host := Edit1.Text;
  for i := SpinEdit1.Value to SpinEdit2.Value do
  begin
    IdTCPClient1.Port := i;
    try
      IdTCPClient1.Connect;
      if IdTCPClient1.Connected then
        Memo1.Lines.Add(Edit1.Text + ':' + IntToStr(i) + ' [TCP] open');
    except
      IdTCPClient1.Disconnect;
    end;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  Line, FindResult: string;
  iPos: integer;
begin
  FindResult := IdWhois1.Whois(Edit1.Text);
  while Length(FindResult) > 0 do
  begin
    iPos := Pos(#10, FindResult);
    Line := Copy(FindResult, 1, iPos - 1);
    Memo1.Lines.Add(Line);
    Delete(FindResult, 1, Length(Line) + 1);
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Memo1.Clear;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
    Memo1.Lines.SaveToFile(SaveDialog1.FileName);
end;

end.
