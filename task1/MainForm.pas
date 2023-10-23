unit MainForm;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  SyncObjs,
  DateUtils;

type
  TMyThread = class(TThread)
  private
    FPaused: Boolean;
    Name: String;
    Counted: Integer;
  public
    property ThreadName : String read Name write Name;
    constructor Create(CreateSuspended: Boolean);
    procedure Execute; override;
    procedure Pause;
    procedure Continue;
    property Paused: Boolean read FPaused;
  end;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Memo2: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    ThreadList: TList;
    procedure StartStopThread(AThread: TMyThread);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

//-----------------------------------------------------------

procedure TForm1.StartStopThread(AThread: TMyThread);
begin
  if AThread.Paused then
    AThread.Continue
  else
    AThread.Pause;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Memo2.Lines.Add('Toggling thread 1.');
  StartStopThread(ThreadList[0]);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Memo2.Lines.Add('Toggling thread 2.');
  StartStopThread(ThreadList[1]);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Memo2.Lines.Add('Toggling thread 3.');
  StartStopThread(ThreadList[2]);
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  Memo2.Lines.Add('Toggling thread 4.');
  StartStopThread(ThreadList[3]);
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  Memo2.Lines.Add('Toggling thread 5.');
  StartStopThread(ThreadList[4]);
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  I: Integer;
begin
  ThreadList := TList.Create;

  for I := 1 to 5 do
  begin
    var NewThread := TMyThread.Create(True);
    NewThread.ThreadName := 'Thread' + IntToStr(I);
    NewThread.FreeOnTerminate := False;
    ThreadList.Add(NewThread);
  end;

  for I := 0 to ThreadList.Count - 1 do
  begin
    TMyThread(ThreadList[I]).Start;
  end;
end;

//-----------------------------------------------------------

constructor TMyThread.Create(CreateSuspended: Boolean);
begin
  inherited Create(CreateSuspended);
  FPaused := False;
  Counted := 0;
end;

procedure TMyThread.Pause;
begin
  FPaused := True;
end;

procedure TMyThread.Continue;
begin
  FPaused := False;
end;

procedure TMyThread.Execute;
begin
  while not Terminated do
  begin
    Sleep(1000);

    if not FPaused then
    begin
      Counted := Counted + 1;
      TThread.Synchronize(nil,
        procedure
        begin
          Form1.Memo1.Lines.Add(Format('%s: %d seconds', [Self.ThreadName, Counted]));
        end
      );
    end;
  end;
end;

end.
