unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ShellAPI, ExtCtrls, XPMan;

type
    TForm1 = class(TForm)
    Memo1: TMemo;
    Tmr1: TTimer;
    CheckBox: TCheckBox;
    ComboBox: TComboBox;
    procedure Tmr1Timer(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ComboBoxKeyPress(Sender: TObject; var Key: Char);
    procedure CheckBoxClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1 : TForm1;
  ifile,ofile : textfile;
  sh_bang, sh_cmd, sh_path, sh_term, sh_script, sh_exit : string;
implementation

{$R *.dfm}

const
MaxHistory=200;//max number of items

procedure TForm1.FormCreate(Sender: TObject);
var
 FileHistory, SU  : string;
begin
   FileHistory:=ExtractFilePath(ParamStr(0))+'ExaTerm.ini';
   SU:=ExtractFilePath(ParamStr(0))+'.su';
   if FileExists(FileHistory) then
   ComboBox.Items.LoadFromFile(FileHistory);
   if FileExists(SU) then
   CheckBox.Checked := True else CheckBox.Checked := False;
end;

procedure TForm1.CheckBoxClick(Sender: TObject);
begin
  if CheckBox.Checked = False then
    begin
      Form1.Caption := 'ExaTermV2';
      DeleteFile('.su');
    end
  else
  if CheckBox.Checked = True then
    begin
      Form1.Caption := 'ExaTermV2 - SU';
      ComboBox.Items.SaveToFile(ExtractFilePath(ParamStr(0))+'.su');
    end
end;

procedure TForm1.FormShow(Sender: TObject);
begin
    assignfile(ifile,'if.sh');
end;

procedure TForm1.ComboBoxKeyPress(Sender: TObject; var Key: Char);
begin
  ReWrite(ifile);
  sh_bang := '#!/bin/bash'+ AnsiChar(#10);
  if CheckBox.Checked = True then
    begin
      sh_path:='export PATH'+ AnsiChar(#10);
      sh_term:='export TERM'+ AnsiChar(#10);
      sh_cmd:='fakeroot-tcp ' + ComboBox.Text + ' &> of.log' + AnsiChar(#10);
      sh_exit:='exit 0'+ AnsiChar(#10);
      //sh_script:= sh_bang + sh_path + sh_term + sh_cmd + sh_exit;
      sh_script:= sh_bang + sh_path + sh_term + sh_cmd;

    end;
    if CheckBox.Checked = False then
    begin
      sh_cmd:=ComboBox.Text + ' &> of.log' + AnsiChar(#10);
      sh_exit:='exit 0'+ AnsiChar(#10);
      //sh_script := sh_bang + sh_cmd + sh_exit;
      sh_script := sh_bang + sh_cmd;
    end;
  if ord(Key) = VK_RETURN then
  //check if the text entered exist in the list, if not add to the list
  if (Trim(ComboBox.Text)<>'') and (ComboBox.Items.IndexOf(ComboBox.Text)=-1) then
    begin
       if ComboBox.Items.Count=MaxHistory then
       ComboBox.Items.Delete(ComboBox.Items.Count-1);
       ComboBox.Items.Insert(0,ComboBox.Text);
       //ShowMessage(sh_script);
       ComboBox.Items.SaveToFile(ExtractFilePath(ParamStr(0))+'ExaTerm.ini');
       Write(ifile, sh_script);
       CloseFile(ifile);
       ShellExecute(0, nil, PChar('if.sh'), nil, nil, SW_SHOWNORMAL);
       ShellExecute(Handle, nil, PChar('ExaTerm.exe'), nil, nil, SW_SHOWNORMAL);
       Application.Terminate;
       DeleteFile('if.sh');
    end
  else
  if (Trim(ComboBox.Text)<>'') then
    begin
       //ShowMessage(sh_script);
       ComboBox.Items.SaveToFile(ExtractFilePath(ParamStr(0))+'ExaTerm.ini');
       Write(ifile, sh_script);
       CloseFile(ifile);
       ShellExecute(0, nil, PChar('if.sh'), nil, nil, SW_SHOWNORMAL);
       ShellExecute(Handle, nil, PChar('ExaTerm.exe'), nil, nil, SW_SHOWNORMAL);
       Application.Terminate;
       DeleteFile('if.sh');
    end;
end;

procedure TForm1.Tmr1Timer(Sender: TObject);
begin
  if FileExists('of.log') then
  try
    Memo1.Lines.LoadFromFile('of.log');
  except
    on EFOpenError do
    ; //swallow this error
  end;
end;

procedure ScrollToLastLine(Memo: TMemo);
begin
  SendMessage(Memo.Handle, EM_LINESCROLL, 0,Memo.Lines.Count);
end;

procedure TForm1.Memo1Change(Sender: TObject);
begin
   ScrollToLastLine(Memo1);
end;

end.
