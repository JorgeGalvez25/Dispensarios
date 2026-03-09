unit FSrvDisp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uROClient, uROServer, uROIndyTCPServer, uROIndyHTTPServer,
  uROBinMessage;

type
  TFSrvDispensarios = class(TForm)
    ROBinMessage1: TROBinMessage;
    ROIndyHTTPServer1: TROIndyHTTPServer;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FSrvDispensarios: TFSrvDispensarios;

implementation

uses DDMCONS;

{$R *.dfm}

end.
