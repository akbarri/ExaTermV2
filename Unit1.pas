unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ShellAPI, ExtCtrls;

type
    TForm1 = class(TForm)
    Memo1: TMemo;
    Edit1: TEdit;
    tmr1: TTimer;
    SU: TCheckBox;
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure tmr1Timer(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1 : TForm1;
  ifile : textfile;
  sh_bang, sh_cmd, sh_path, sh_term, sh_script, sh_exit : string;

implementation

{$R *.dfm}

procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if ord(Key) = VK_RETURN then
  begin
  ReWrite(ifile);
  sh_bang := '#!/bin/bash'+ AnsiChar(#10);
  if SU.Checked = True then
    begin
      sh_path:='export PATH'+ AnsiChar(#10);
      sh_term:='export TERM'+ AnsiChar(#10);
      sh_cmd:='fakeroot-tcp ' + Edit1.Text + ' &> of.log' + AnsiChar(#10);
      sh_exit:='exit 0'+ AnsiChar(#10);
      //sh_script:= sh_bang + sh_path + sh_term + sh_cmd + sh_exit;
      sh_script:= sh_bang + sh_path + sh_term + sh_cmd;
    end
    else
    begin
      sh_cmd:=Edit1.Text + ' &> of.log' + AnsiChar(#10);
      sh_exit:='exit 0'+ AnsiChar(#10);
      //sh_script := sh_bang + sh_cmd + sh_exit;
      sh_script := sh_bang + sh_cmd;
    end;
  if Trim(Edit1.Text) = '' then
    Edit1.Text:=''
  else
    begin
    Write(ifile, sh_script);
    CloseFile(ifile);
    Edit1.Text:='';
    //ShowMessage(sh_script);
    ShellExecute(0, nil, PChar('if.sh'), nil, nil, SW_SHOWNORMAL);
    ShellExecute(Handle, nil, PChar('ExaTerm.exe'), nil, nil, SW_SHOWNORMAL);
    Application.Terminate;
    DeleteFile('if.sh');
    end
  end;
end;

procedure TForm1.tmr1Timer(Sender: TObject);
begin
  if FileExists('of.log') then
  try
    Memo1.Lines.LoadFromFile('of.log');
  except
    on EFOpenError do
    ; //swallow this error
  end;
  if SU.Checked = True then
    Form1.Caption := 'ExaTerm - SU'
  else
    Form1.Caption := 'ExaTerm'
end;

procedure ScrollToLastLine(Memo: TMemo);
begin
  SendMessage(Memo.Handle, EM_LINESCROLL, 0,Memo.Lines.Count);
end;

procedure TForm1.Memo1Change(Sender: TObject);
begin
   ScrollToLastLine(Memo1);
end;

procedure TForm1.FormShow(Sender: TObject);
begin
    assignfile(ifile,'if.sh');
end;

end.
