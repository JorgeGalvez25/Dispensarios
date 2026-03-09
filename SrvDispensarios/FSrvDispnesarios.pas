unit FSrvDispnesarios;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uROClient, uROServer, uROIndyTCPServer, uROIndyHTTPServer,
  uROBinMessage;

type
  TForm1 = class(TForm)
    ROBinMessage1: TROBinMessage;
    ROIndyHTTPServer1: TROIndyHTTPServer;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses DDMCONS;

{$R *.dfm}

end.
