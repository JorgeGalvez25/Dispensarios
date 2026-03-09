object Form1: TForm1
  Left = 192
  Top = 114
  Width = 928
  Height = 480
  Caption = 'SrvDispensarios'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object ROBinMessage1: TROBinMessage
    Left = 72
    Top = 32
  end
  object ROIndyHTTPServer1: TROIndyHTTPServer
    Active = True
    Dispatchers = <
      item
        Name = 'ROBinMessage1'
        Message = ROBinMessage1
        Enabled = True
        PathInfo = 'Bin'
      end>
    IndyServer.Bindings = <>
    IndyServer.CommandHandlers = <>
    IndyServer.DefaultPort = 8099
    IndyServer.Greeting.NumericCode = 0
    IndyServer.MaxConnectionReply.NumericCode = 0
    IndyServer.ReplyExceptionCode = 0
    IndyServer.ReplyTexts = <>
    IndyServer.ReplyUnknownCommand.NumericCode = 0
    Port = 8099
    Left = 128
    Top = 32
  end
end
