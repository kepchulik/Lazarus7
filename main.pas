unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, EditBtn, FileUtil;

type

  { TfMain }

  TfMain = class(TForm)
    Button1: TButton;
    DE: TDirectoryEdit;
    FNE: TFileNameEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
  private

  public

  end;

var
  fMain: TfMain;

implementation

{$R *.lfm}

{ TfMain }


procedure TfMain.Button1Click(Sender: TObject);
var
  fIn, fOut : File;
  NumRead, NumWritten : Word;
  Buf : Array[1..2048] of byte;
begin
  if FNE.Text = '' then begin
    ShowMessage('Внимание! Требуется указать или выбрать копируемый файл.');
    FNE.SetFocus;
    Exit;
  end;
  if DE.Text = '' then begin
    ShowMessage('Внимание! Требуется указать или выбрать папку для копии.');
    DE.SetFocus;
    Exit;
  end;
  try
    AssignFile(fIn, FNE.FileName);
    AssignFile(fOut, DE.Directory + '\' + ExtractFileName(FNE.FileName));
    Reset (fIn,1);
    Rewrite (fOut,1);
    Screen.Cursor:= crHourGlass;
    Repeat
      BlockRead (fIn,buf,Sizeof(buf),NumRead);
      BlockWrite (fOut,Buf,NumRead,NumWritten);
    Until (NumRead=0) or (NumWritten<>NumRead);
  finally
    closeFile(fIn);
    closeFile(fOut);
    Screen.Cursor:= crDefault;
    ShowMessage('Копирование завершено!');
  end;
end;



end.

