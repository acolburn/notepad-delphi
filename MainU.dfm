object FormMain: TFormMain
  Left = 0
  Top = 0
  Caption = 'My Notepad'
  ClientHeight = 336
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 317
    Width = 635
    Height = 19
    Panels = <
      item
        Width = 50
      end>
  end
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 635
    Height = 317
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Source Code Pro Medium'
    Font.Style = []
    Lines.Strings = (
      'Memo1')
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 1
    OnChange = Memo1Change
  end
  object MainMenu1: TMainMenu
    Left = 32
    Top = 16
    object File1: TMenuItem
      Caption = '&File'
      object New1: TMenuItem
        Caption = 'New ...'
        ShortCut = 16462
        OnClick = FileNew1Execute
      end
      object Open1: TMenuItem
        Caption = '&Open...'
        Hint = 'Open|Opens an existing file'
        ImageIndex = 7
        ShortCut = 16463
        OnClick = FileOpen1Execute
      end
      object Save1: TMenuItem
        Caption = 'Save'
        OnClick = FileSave1Execute
      end
      object SaveAs1: TMenuItem
        Caption = 'Save &As...'
        Hint = 'Save As|Saves the active file with a new name'
        ImageIndex = 30
        OnClick = FileSaveAs1Execute
      end
      object N1: TMenuItem
        Caption = '&Open...'
        Hint = 'Open|Opens an existing file'
        ImageIndex = 7
        ShortCut = 16463
      end
      object PageSetup1: TMenuItem
        Caption = 'Page Set&up...'
      end
      object PrintSetup1: TMenuItem
        Caption = 'Print Set&up...'
        Hint = 'Print Setup'
      end
      object Exit1: TMenuItem
        Caption = 'E&xit'
        Hint = 'Exit|Quits the application'
        ImageIndex = 43
        OnClick = Exit1Click
      end
    end
    object Edit1: TMenuItem
      Caption = '&Edit'
      object Undo1: TMenuItem
        Caption = '&Undo'
        Hint = 'Undo|Reverts the last action'
        ImageIndex = 3
        ShortCut = 16474
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Cut1: TMenuItem
        Caption = 'Cu&t'
        Hint = 'Cut|Cuts the selection and puts it on the Clipboard'
        ImageIndex = 0
        ShortCut = 16472
      end
      object Copy1: TMenuItem
        Caption = '&Copy'
        Hint = 'Copy|Copies the selection and puts it on the Clipboard'
        ImageIndex = 1
        ShortCut = 16451
      end
      object Paste1: TMenuItem
        Caption = '&Paste'
        Hint = 'Paste|Inserts Clipboard contents'
        ImageIndex = 2
        ShortCut = 16470
      end
      object Delete1: TMenuItem
        Caption = '&Delete'
        Hint = 'Delete|Erases the selection'
        ImageIndex = 5
        ShortCut = 46
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object Find1: TMenuItem
        Caption = '&Find...'
        Hint = 'Find|Finds the specified text'
        ImageIndex = 34
        ShortCut = 16454
        OnClick = EditFind1Execute
      end
      object Replace1: TMenuItem
        Caption = '&Replace'
        Hint = 'Replace|Replaces specific text with different text'
        ImageIndex = 32
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object SelectAll1: TMenuItem
        Caption = 'Select &All'
        Hint = 'Select All|Selects the entire document'
        ShortCut = 16449
        OnClick = EditSelectAll1Execute
      end
    end
    object Format1: TMenuItem
      Caption = 'F&ormat'
      object WordWrap1: TMenuItem
        Caption = 'Word Wrap'
        OnClick = WordWrap1Click
      end
      object Font1: TMenuItem
        Caption = 'Select &Font...'
        Hint = 'Font Select'
        OnClick = Font1Click
      end
    end
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = 'txt'
    Left = 312
    Top = 184
  end
  object FindDialog1: TFindDialog
    Left = 368
    Top = 192
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Left = 224
    Top = 176
  end
  object SaveDialog1: TSaveDialog
    Left = 456
    Top = 200
  end
end
