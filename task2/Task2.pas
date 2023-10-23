unit Task2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TForm1 = class(TForm)
    RadioGroup1: TRadioGroup;
    RadioButtonFile: TRadioButton;
    RadioButtonGenerate: TRadioButton;
    Button1: TButton;
    Bevel1: TBevel;
    ListView1: TListView;
    OpenDialog1: TOpenDialog;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure ListView1Compare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
  private
    Text: String;
    function GenerateRandomLine(len: Integer): String;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


function FindConsecutiveDigitSequences(const Text: string): TStringList;
var
  i, j, k, startIdx, endIdx, count: Integer;
  currentSeq: string;
  resultStr: TStringList;
  countArray: TArray<Integer>;
begin
  resultStr := TStringList.Create;
  count := 0;
  i := 1;
  while i <= Length(Text) do
  begin
    if CharInSet(Text[i], ['0'..'9']) then
    begin
      startIdx := i;
      endIdx := i;
      currentSeq := Text[i];

      for j := i + 1 to Length(Text) do
      begin
        if (CharInSet(Text[j], ['0'..'9'])) and (StrToInt(Text[j]) = StrToInt(Text[endIdx]) + 1) then
        begin
          endIdx := j;
          currentSeq := currentSeq + Text[j];
        end
        else
          Break;
      end;

      if Length(currentSeq) >= 2 then
      begin
        k := 0;
        for k := 0 to resultStr.Count - 1 do
        begin
          if resultStr[k] = currentSeq then
          begin
            Inc(countArray[k]);
            Break;
          end;
        end;

        if k = resultStr.Count then
        begin
          resultStr.Add(currentSeq);

          SetLength(countArray, count + 1);
          countArray[count] := 1;
          Inc(count);
        end;

        i := endIdx + 1;
      end
      else
        Inc(i);
    end
    else
      Inc(i);
  end;

  for i := 0 to count - 1 do
    resultStr.Objects[i] := TObject(countArray[i]);

  Result := resultStr;
end;

procedure DisplayInListView(list: TStringList; listView: TListView);
var
  i: Integer;
  listItem: TListItem;
begin
  listView.Items.Clear;
  listView.Items.BeginUpdate;
  for i := 0 to list.Count - 1 do
  begin
    listItem := listView.Items.Add;
    listItem.Caption := list[i];
    listItem.SubItems.Add(IntToStr(Integer(list.Objects[i])));
  end;
  listView.Items.EndUpdate;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  SelectedFileName: string;
  FileContents: string;
  FileStream: TFileStream;
  StreamReader: TStreamReader;
  SList: TStringList;
begin
  if RadioButtonFile.Checked then
  begin
    if OpenDialog1.Execute then
    begin
      SelectedFileName := OpenDialog1.FileName;
      try
        FileStream := TFileStream.Create(SelectedFileName, fmOpenRead);
        try
          StreamReader := TStreamReader.Create(FileStream, TEncoding.UTF8);
          FileContents := StreamReader.ReadToEnd;
        finally
          StreamReader.Free;
          FileStream.Free;
        end;
        Text := FileContents;
      except
        on E: Exception do
        begin
          ShowMessage('Error reading the file: ' + E.Message);
        end;
      end;
    end;
  end
  else
    Text := GenerateRandomLine(250);
  Memo1.Lines.Text := Text;
  SList := FindConsecutiveDigitSequences(Text);
  DisplayInListView(SList, ListView1);
end;

function TForm1.GenerateRandomLine(len: Integer): string;
const
  Letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
  Digits = '0123456789';
var
  i: Integer;
begin
  Randomize;
  Result := '';
  for i := 1 to len do
  begin
    if Random(2) = 0 then
      Result := Result + Letters[Random(Length(Letters)) + 1]
    else
      Result := Result + Digits[Random(Length(Digits)) + 1];
  end;
  GenerateRandomLine := Result;
end;

procedure TForm1.ListView1Compare(Sender: TObject; Item1, Item2: TListItem;
  Data: Integer; var Compare: Integer);
var
  Obj1: Integer;
  Obj2: Integer;
begin
  Obj1 := StrToInt(Item1.SubItems[0]);
  Obj2 := StrToInt(Item2.SubItems[0]);
  Compare := Obj2 - Obj1;
end;

end.
