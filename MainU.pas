unit MainU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.Menus, Vcl.StdCtrls,
  Vcl.StdActns, Vcl.ActnList, System.Actions, IniFiles,
  Vcl.ActnMan, Vcl.PlatformDefaultStyleActnCtrls, DragDrop, DropTarget,
  DragDropFile;

type
  TMode = (insert, command);

  TFormMain = class(TForm)
    StatusBar1: TStatusBar;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Edit1: TMenuItem;
    Format1: TMenuItem;
    New1: TMenuItem;
    Open1: TMenuItem;
    Save1: TMenuItem;
    SaveAs1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    Undo1: TMenuItem;
    N2: TMenuItem;
    Cut1: TMenuItem;
    Copy1: TMenuItem;
    Paste1: TMenuItem;
    Delete1: TMenuItem;
    N3: TMenuItem;
    Find1: TMenuItem;
    Replace1: TMenuItem;
    N4: TMenuItem;
    SelectAll1: TMenuItem;
    WordWrap1: TMenuItem;
    Font1: TMenuItem;
    OpenDialog1: TOpenDialog;
    Memo1: TMemo;
    FindDialog1: TFindDialog;
    FontDialog1: TFontDialog;
    SaveDialog1: TSaveDialog;
    ActionList1: TActionList;
    ExitAction: TAction;
    EditCut1: TEditCut;
    EditCopy1: TEditCopy;
    EditPaste1: TEditPaste;
    EditSelectAll1: TEditSelectAll;
    EditUndo1: TEditUndo;
    EditDelete1: TEditDelete;
    OpenAction: TAction;
    WordWrapAction: TAction;
    NewAction: TAction;
    SaveAction: TAction;
    SaveAsAction: TAction;
    FilePageSetup1: TFilePageSetup;
    FilePrintSetup1: TFilePrintSetup;
    FontSelectAction: TAction;
    FindAction: TAction;
    ReplaceDialog1: TReplaceDialog;
    DropFileTarget1: TDropFileTarget;
    procedure ExitActionExecute(Sender: TObject);
    procedure OpenActionExecute(Sender: TObject);
    procedure NewActionExecute(Sender: TObject);
    procedure SaveActionExecute(Sender: TObject);
    procedure SaveAsActionExecute(Sender: TObject);
    procedure WordWrapActionExecute(Sender: TObject);
    procedure FontSelectActionExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
    procedure FindActionExecute(Sender: TObject);
    procedure FindDialog1Find(Sender: TObject);
    procedure Replace1Click(Sender: TObject);
    procedure ReplaceDialog1Replace(Sender: TObject);
    procedure Memo1KeyPress(Sender: TObject; var Key: Char);
    procedure EditDelete1Execute(Sender: TObject);
    procedure DropFileTarget1Drop(Sender: TObject; ShiftState: TShiftState;
      APoint: TPoint; var Effect: Integer);
    procedure Memo1Click(Sender: TObject);
    procedure Memo1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    FOpenedFile: string;
    FSelPos: Integer;
    FMode: TMode; // insert mode or command mode
    FWordCount: Integer;
    function DocumentChanged: Boolean;
    procedure UpdateDisplay;
    procedure LoadIni;
    procedure CloseIni;
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

uses System.UITypes;

{$R *.dfm}
{ TFormMain }

function TFormMain.DocumentChanged: Boolean;
var
  s: string;
begin
  if FOpenedFile <> '' then
    s := FOpenedFile
  else
    s := 'this file';
  Result := True;
  if Memo1.Modified and not(Memo1.Text = '') then
  begin
    case MessageDlg('Do you want to save the changes to ' + s + '?', mtWarning,
      mbYesNoCancel, 0) of
      mrYes:
      begin
        SaveActionExecute(self);
        Result := False;
      end;
      mrCancel:
        Result := False;
    end;
  end;
end;

procedure TFormMain.DropFileTarget1Drop(Sender: TObject;
  ShiftState: TShiftState; APoint: TPoint; var Effect: Integer);
// https://github.com/landrix/The-Drag-and-Drop-Component-Suite-for-Delphi/blob/master/Demos/TargetDemo/Main.pas
begin
  if FileExists(DropFileTarget1.Files[0]) then
  begin
    Memo1.Lines.LoadFromFile(DropFileTarget1.Files[0]);
    FOpenedFile := DropFileTarget1.Files[0];
  end;

end;

procedure TFormMain.EditDelete1Execute(Sender: TObject);
begin
  // if you're just pressing the delete key, want to delete character
  // to the right of the cursor
  if Memo1.SelLength = 0 then
    Memo1.SelLength := 1;
  // delete whatever's highlighted, replace it with blank
  Memo1.SelText := '';
end;

procedure TFormMain.ExitActionExecute(Sender: TObject);
begin
  self.Close;
end;

procedure TFormMain.FindActionExecute(Sender: TObject);
begin
  FSelPos := 0;
  FindDialog1.Execute;
end;

procedure TFormMain.FindDialog1Find(Sender: TObject);
// http://www.delphigroups.info/2/09/310962.html
var
  s: string;
  startpos: Integer;
begin
  with TFindDialog(Sender) do
  begin
    { If the stored position is 0 this cannot be a find next. }
    if FSelPos = 0 then
      Options := Options - [frFindNext];

    { Figure out where to start the search and get the corresponding
      text from the memo. }
    if frFindNext in Options then
    begin
      { This is a find next, start after the end of the last found word. }
      startpos := FSelPos + Length(Findtext);
      s := Copy(Memo1.Lines.Text, startpos, MaxInt);
    end
    else
    begin
      { This is a find first, start at the, well, start. }
      s := Memo1.Lines.Text;
      startpos := 1;
    end;
    { Perform a global case-sensitive search for FindText in S }
    FSelPos := Pos(Findtext, s);
    if FSelPos > 0 then
    begin
      { Found something, correct position for the location of the start
        of search. }
      FSelPos := FSelPos + startpos - 1;
      Memo1.SelStart := FSelPos - 1;
      Memo1.SelLength := Length(Findtext);
      Memo1.SetFocus;
    end
    else
    begin
      { No joy, show a message. }
      if frFindNext in Options then
        s := Concat('There are no further occurences of “', Findtext,
          '” in Memo1.')
      else
        s := Concat('Could not find “', Findtext, '” in Memo1.');
      MessageDlg(s, mtError, [mbOK], 0);
    end;
  end;
end;

procedure TFormMain.FontSelectActionExecute(Sender: TObject);
begin
  FontDialog1.Font.Name := Memo1.Font.Name;
  FontDialog1.Font.Size := Memo1.Font.Size;
  FontDialog1.Font.Style := Memo1.Font.Style;
  FontDialog1.Font.Color := Memo1.Font.Color;
  if FontDialog1.Execute then
    Memo1.Font := FontDialog1.Font;
end;

procedure TFormMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseIni;
end;

procedure TFormMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := DocumentChanged;
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  LoadIni;
  // Make sure WordWrap menu item properly checked
  WordWrap1.Checked := Memo1.WordWrap;
  // Start in normal, insert mode
  FMode := TMode.insert;
end;

procedure TFormMain.LoadIni;
var
  AIniFile: TIniFile;
begin
  try
    AIniFile := TIniFile.Create(ExtractFilePath(Application.EXEName) +
      'config.ini');
    with AIniFile do
    begin
      FormMain.Left := AIniFile.ReadInteger('Form', 'Left', 10);
      FormMain.Top := AIniFile.ReadInteger('Form', 'Top', 10);
      FormMain.Width := AIniFile.ReadInteger('form', 'Width', 613);
      FormMain.Height := AIniFile.ReadInteger('Form', 'Height', 496);
      Memo1.Font.Size := AIniFile.ReadInteger('Font', 'Size', 12);
      Memo1.Font.Name := AIniFile.ReadString('Font', 'Name', 'Consolas');
      Memo1.Font.Color := TColor(AIniFile.ReadInteger('Font', 'Color', Memo1.Font.Color));
      Memo1.Font.Style := TFontStyles(Byte(AIniFile.ReadInteger('Font', 'Style', Byte(Memo1.Font.Style))));
    end;
  finally
    AIniFile.Free;
  end;
end;

procedure TFormMain.Memo1Change(Sender: TObject);
// https://stackoverflow.com/questions/64669235/how-to-accurately-count-words-in-a-memo
var
  // wordSeparatorSet: Set of Char;
  count: Integer;
  i: Integer;
  s: string;
  inWord: Boolean;
begin
  // wordSeparatorSet := [#13, #10, #32]; // CR, LF, space
  count := 0;
  s := Memo1.Text;
  inWord := False;

  for i := 1 to Length(s) do
  begin
    if inWord = True then
    begin
      // if s[i] in wordSeparatorSet then
      if CharInSet(s[i], [#13, #10, #32]) then

        inWord := False;
    end
    else
    begin
      if not(CharInSet(s[i], [#13, #10, #32])) then
      begin
        inWord := True;
        Inc(count);
      end;
    end;

  end;

  FWordCount := count;
  UpdateDisplay;

end;

procedure TFormMain.Memo1Click(Sender: TObject);
begin
  if FMode = command then
  begin
    FMode := insert;
    UpdateDisplay;
  end;
end;

procedure TFormMain.Memo1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  //https://stackoverflow.com/questions/65113295/how-to-recognize-virtual-key-codes-in-keypress-event
  //KeyDown recognizes *any* key being pressed, KeyPress recognizes character keys
begin
  if Key=VK_F5 then
  begin
    //Memo1.Lines.Add(FormatDateTime('h:nn',now));...includes unwanted CRLF after entering time
    Memo1.Text:=Memo1.Text+FormatDateTime('h:nn',now); //adds time to end of doc, cursor goes to start
    Memo1.SelStart:=Memo1.GetTextLen;  //cursor goes to end
  end;
end;

procedure TFormMain.Memo1KeyPress(Sender: TObject; var Key: Char);
begin
  // https://www.thoughtco.com/understanding-keyboard-events-in-delphi-1058213
  if Key = Chr(VK_ESCAPE) then
  begin
    if FMode = insert then
      FMode := command
    else if FMode = command then
      FMode := insert;
    UpdateDisplay;
  end;

  if FMode = command then
  begin
    if Key = 'i' then
    begin
      FMode := insert;
      UpdateDisplay;
    end;
    if Key = 'j' then
    begin
      keybd_event(VK_DOWN, 0, 0, 0); // KEYEVENTF_KEYDOWN=0
      keybd_event(VK_DOWN, 0, KEYEVENTF_KEYUP, 0);
    end;
    if Key = 'k' then
    begin
      keybd_event(VK_UP, 0, 0, 0); // KEYEVENTF_KEYDOWN=0
      keybd_event(VK_UP, 0, KEYEVENTF_KEYUP, 0);
    end;
    if Key = 'l' then
    begin
      keybd_event(VK_RIGHT, 0, 0, 0); // KEYEVENTF_KEYDOWN=0
      keybd_event(VK_RIGHT, 0, KEYEVENTF_KEYUP, 0);
    end;
    if Key = 'h' then
    begin
      keybd_event(VK_LEFT, 0, 0, 0); // KEYEVENTF_KEYDOWN=0
      keybd_event(VK_LEFT, 0, KEYEVENTF_KEYUP, 0);
    end;
    Key := #0; // So the j, k, l, etc. isn't printed
  end;

end;

procedure TFormMain.NewActionExecute(Sender: TObject);
begin
  if Memo1.Text <> '' then
    case MessageDlg('Do you want to save the changes to this file?', mtWarning,
      mbYesNoCancel, 0) of
      mrYes:
        SaveAsActionExecute(self);
    end;

  Memo1.Lines.Clear;
  FOpenedFile := '';
end;

procedure TFormMain.OpenActionExecute(Sender: TObject);
begin
  self.DocumentChanged;
  OpenDialog1.Execute;
  if OpenDialog1.FileName <> '' then
  begin
    Memo1.Lines.LoadFromFile(OpenDialog1.FileName);
    FOpenedFile := OpenDialog1.FileName;
  end;
end;

procedure TFormMain.Replace1Click(Sender: TObject);
begin
  FSelPos := 0;
  ReplaceDialog1.Execute;
end;

procedure TFormMain.ReplaceDialog1Replace(Sender: TObject);
// http://docs.embarcadero.com/products/rad_studio/delphiAndcpp2009/HelpUpdate2/EN/html/delphivclwin32/Dialogs_TReplaceDialog_OnReplace.html
{
  The following event handler searches a TMemo object called
  Memo1 and replaces FindText with ReplaceText. It uses
  TMemo’s SelStart, SelLength, and SelText properties.
}
var
  SelPos: Integer;
begin
  with TReplaceDialog(Sender) do
  begin
    { Perform a global case-sensitive search for FindText in Memo1 }
    while SelPos < Memo1.Lines.Text.Length - 1 do
    begin
      SelPos := Pos(Findtext, Memo1.Lines.Text);
      if SelPos > 0 then
      begin
        Memo1.SelStart := SelPos - 1;
        Memo1.SelLength := Length(ReplaceDialog1.Findtext);
        { Replace selected text with ReplaceText }
        Memo1.SelText := ReplaceDialog1.ReplaceText;
      end
      else
      begin
        MessageDlg(Concat('Could not find "', Findtext, '" in Memo1.'), mtError,
          [mbOK], 0);
        SelPos := Memo1.Lines.Text.Length;
      end;
    end;
  end;
end;

procedure TFormMain.SaveActionExecute(Sender: TObject);
begin
  if FOpenedFile <> '' then
    Memo1.Lines.SaveToFile(FOpenedFile)
  else
    self.SaveAsActionExecute(Sender);
  Memo1.Modified:=false;

end;

procedure TFormMain.SaveAsActionExecute(Sender: TObject);
begin
  SaveDialog1.Execute;
  if SaveDialog1.FileName <> '' then // checking to assure user selected a file
    Memo1.Lines.SaveToFile(SaveDialog1.FileName);
end;

procedure TFormMain.UpdateDisplay;
begin
  // What the status bar panels should say
  StatusBar1.Panels[0].Text := 'Words: ' + IntToStr(FWordCount);
  if FMode = insert then
    StatusBar1.Panels[1].Text := 'INS';
  if FMode = command then
    StatusBar1.Panels[1].Text := 'COMMAND';
  // Whether the word wrap menu entry should be checked
  WordWrap1.Checked := Memo1.WordWrap;

end;

procedure TFormMain.WordWrapActionExecute(Sender: TObject);
begin
  Memo1.WordWrap := not Memo1.WordWrap;
  UpdateDisplay;
end;

procedure TFormMain.CloseIni;
var
  AIniFile: TIniFile;
begin
  try
    AIniFile := TIniFile.Create(ExtractFilePath(Application.EXEName) +
      'config.ini');
    with AIniFile do
    begin
      WriteInteger('Form', 'Left', Left);
      WriteInteger('Form', 'Top', Top);
      WriteInteger('Form', 'Width', Width);
      WriteInteger('Form', 'Height', Height);
      WriteInteger('Font', 'Size', Memo1.Font.Size);
      WriteString('Font', 'Name', Memo1.Font.Name);
      WriteInteger('Font', 'Color', Memo1.Font.Color);
      WriteInteger('Font', 'Style', Byte(Memo1.Font.Style));
    end;
  finally
    AIniFile.Free;
  end;
end;

end.



