unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, registry;

type

  { TForm1 }

  TForm1 = class(TForm)
    btnStartModify: TButton;
    edtSuffixName: TEdit;
    edtCommand: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    lblInfo: TLabel;
    procedure btnStartModifyClick(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.btnStartModifyClick(Sender: TObject);
var
  Registry: TRegistry;
  suffixname: String;
  regpathkey: String;
  suffix2handler: String;
begin
  Registry := TRegistry.Create;
  try
    if (self.edtSuffixName.Text = '') or (self.edtCommand.Text = '') then
    begin
      self.lblInfo.Caption := '后缀名或命令不能为空';
      exit;
    end;

    // get suffix name whitout '.'
    if self.edtSuffixName.Text[1] = '.' then
      suffixname := Copy(self.edtSuffixName.Text, 2, 32)
    else
      suffixname := self.edtSuffixName.Text;
    regpathkey := '\.' + suffixname;

    // registry operator
    Registry.RootKey := HKEY_CLASSES_ROOT;
    if Registry.OpenKey(regpathkey, true) then
    begin
      if Registry.ReadString('') = '' then
        Registry.WriteString('', suffixname + '_auto_file');
      suffix2handler := Registry.ReadString('');
    end;
    if Registry.OpenKey('\'+suffix2handler+'\shell\open\command', true) then
    begin
      Registry.WriteString('', self.edtCommand.Text);
    end;

    self.lblInfo.Caption := '修改成功';

  finally
    Registry.Free;
  end;

end;

end.

