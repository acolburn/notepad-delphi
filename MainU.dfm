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
        Width = 200
      end
      item
        Text = 'INS'
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
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 1
    OnChange = Memo1Change
    OnClick = Memo1Click
    OnKeyPress = Memo1KeyPress
  end
  object MainMenu1: TMainMenu
    Left = 32
    Top = 16
    object File1: TMenuItem
      Caption = '&File'
      object New1: TMenuItem
        Action = NewAction
      end
      object Open1: TMenuItem
        Action = OpenAction
      end
      object Save1: TMenuItem
        Action = SaveAction
      end
      object SaveAs1: TMenuItem
        Action = SaveAsAction
      end
      object N1: TMenuItem
        Action = OpenAction
      end
      object Exit1: TMenuItem
        Action = ExitAction
        ShortCut = 16465
      end
    end
    object Edit1: TMenuItem
      Caption = '&Edit'
      object Undo1: TMenuItem
        Action = EditUndo1
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Cut1: TMenuItem
        Action = EditCut1
      end
      object Copy1: TMenuItem
        Action = EditCopy1
      end
      object Paste1: TMenuItem
        Action = EditPaste1
      end
      object Delete1: TMenuItem
        Caption = '&Delete'
        Hint = 'Delete|Erases the selection'
        ImageIndex = 5
        ShortCut = 46
        OnClick = EditDelete1Execute
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object Find1: TMenuItem
        Action = FindAction
      end
      object Replace1: TMenuItem
        Caption = '&Replace'
        Hint = 'Replace|Replaces specific text with different text'
        ImageIndex = 32
        OnClick = Replace1Click
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object SelectAll1: TMenuItem
        Action = EditSelectAll1
      end
    end
    object Format1: TMenuItem
      Caption = 'F&ormat'
      object WordWrap1: TMenuItem
        Action = WordWrapAction
      end
      object Font1: TMenuItem
        Action = FontSelectAction
      end
    end
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = 'txt'
    Left = 312
    Top = 184
  end
  object FindDialog1: TFindDialog
    OnFind = FindDialog1Find
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
    DefaultExt = 'txt'
    Left = 456
    Top = 200
  end
  object ActionList1: TActionList
    Left = 144
    Top = 24
    object ExitAction: TAction
      Category = 'File'
      Caption = 'E&xit'
      Hint = 'Exit the application'
      ShortCut = 16472
      OnExecute = ExitActionExecute
    end
    object EditCut1: TEditCut
      Category = 'Edit'
      Caption = 'Cu&t'
      Hint = 'Cut|Cuts the selection and puts it on the Clipboard'
      ImageIndex = 0
      ShortCut = 16472
    end
    object EditCopy1: TEditCopy
      Category = 'Edit'
      Caption = '&Copy'
      Hint = 'Copy|Copies the selection and puts it on the Clipboard'
      ImageIndex = 1
      ShortCut = 16451
    end
    object EditPaste1: TEditPaste
      Category = 'Edit'
      Caption = '&Paste'
      Hint = 'Paste|Inserts Clipboard contents'
      ImageIndex = 2
      ShortCut = 16470
    end
    object EditSelectAll1: TEditSelectAll
      Category = 'Edit'
      Caption = 'Select &All'
      Hint = 'Select All|Selects the entire document'
      ShortCut = 16449
    end
    object EditUndo1: TEditUndo
      Category = 'Edit'
      Caption = '&Undo'
      Hint = 'Undo|Reverts the last action'
      ImageIndex = 3
      ShortCut = 16474
    end
    object EditDelete1: TEditDelete
      Category = 'Edit'
      Caption = '&Delete'
      Hint = 'Delete|Erases the selection'
      ImageIndex = 5
      ShortCut = 46
      OnExecute = EditDelete1Execute
    end
    object OpenAction: TAction
      Category = 'File'
      Caption = '&Open ...'
      Hint = 'Opens a file'
      ShortCut = 16463
      OnExecute = OpenActionExecute
    end
    object WordWrapAction: TAction
      Caption = 'Word Wrap'
      OnExecute = WordWrapActionExecute
    end
    object NewAction: TAction
      Category = 'File'
      Caption = 'New'
      ShortCut = 16462
      OnExecute = NewActionExecute
    end
    object SaveAction: TAction
      Category = 'File'
      Caption = '&Save'
      ShortCut = 16467
      OnExecute = SaveActionExecute
    end
    object SaveAsAction: TAction
      Category = 'File'
      Caption = 'S&ave As ...'
      Hint = 'Choose name and save file'
      OnExecute = SaveAsActionExecute
    end
    object FilePageSetup1: TFilePageSetup
      Category = 'File'
      Caption = 'Page Set&up...'
      Dialog.MinMarginLeft = 0
      Dialog.MinMarginTop = 0
      Dialog.MinMarginRight = 0
      Dialog.MinMarginBottom = 0
      Dialog.MarginLeft = 1000
      Dialog.MarginTop = 1000
      Dialog.MarginRight = 1000
      Dialog.MarginBottom = 1000
      Dialog.PageWidth = 8500
      Dialog.PageHeight = 11000
    end
    object FilePrintSetup1: TFilePrintSetup
      Category = 'File'
      Caption = 'Print Set&up...'
      Hint = 'Print Setup'
    end
    object FontSelectAction: TAction
      Category = 'Format'
      Caption = 'Select Font'
      Hint = 'Select font'
      OnExecute = FontSelectActionExecute
    end
    object FindAction: TAction
      Category = 'Edit'
      Caption = '&Find...'
      ShortCut = 16454
      OnExecute = FindActionExecute
    end
  end
  object ReplaceDialog1: TReplaceDialog
    Options = [frDown, frFindNext, frReplace, frReplaceAll]
    OnReplace = ReplaceDialog1Replace
    Left = 320
    Top = 232
  end
  object DropFileTarget1: TDropFileTarget
    DragTypes = [dtCopy, dtLink]
    OnDrop = DropFileTarget1Drop
    Target = Memo1
    WinTarget = 0
    OptimizedMove = True
    Left = 544
    Top = 40
  end
end
