object FormLittleC_Demo: TFormLittleC_Demo
  Left = 0
  Top = 0
  Caption = 'Little C Demos'
  ClientHeight = 412
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 184
    Top = 0
    Height = 412
    AutoSnap = False
    ExplicitLeft = 480
    ExplicitTop = 144
    ExplicitHeight = 100
  end
  object SynEdit: TSynEdit
    Left = 187
    Top = 0
    Width = 448
    Height = 412
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    TabOrder = 0
    Gutter.Font.Charset = DEFAULT_CHARSET
    Gutter.Font.Color = clWindowText
    Gutter.Font.Height = -11
    Gutter.Font.Name = 'Courier New'
    Gutter.Font.Style = []
    Highlighter = SynCppSyn
    Lines.Strings = (
      '')
  end
  object vleList: TValueListEditor
    Left = 0
    Top = 0
    Width = 184
    Height = 412
    Align = alLeft
    DefaultColWidth = 36
    FixedCols = 1
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goAlwaysShowEditor, goThumbTracking]
    Strings.Strings = (
      '')
    TabOrder = 1
    TitleCaptions.Strings = (
      'No.'
      'Demos')
    OnDblClick = vleListDblClick
    OnSelectCell = vleListSelectCell
    ColWidths = (
      36
      142)
  end
  object mmoDemos: TSynEdit
    Left = 224
    Top = 16
    Width = 209
    Height = 345
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    TabOrder = 2
    Visible = False
    Gutter.Font.Charset = DEFAULT_CHARSET
    Gutter.Font.Color = clWindowText
    Gutter.Font.Height = -11
    Gutter.Font.Name = 'Courier New'
    Gutter.Font.Style = []
  end
  object SynCppSyn: TSynCppSyn
    Left = 568
    Top = 48
  end
end
