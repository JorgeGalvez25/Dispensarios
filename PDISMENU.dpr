program PDISMENU;

uses
  uROCOMInit,
  Forms,
  Windows,
  UDISMENU in 'UDISMENU.pas' {FDISMENU},
  DDMCONS in 'DDMCONS.pas' {DMCONS: TDataModule},
  ULIBPRINT in '..\..\Imagen Ib Libs\Libs\ULibPrint.pas',
  ULIBDATABASE in '..\..\Imagen Ib Libs\Libs\ULibDataBase.pas',
  ULIBLICENCIAS in '..\..\Imagen Ib Libs\Libs\ULibLicencias.pas',
  ULIBGRAL in 'ULIBGRAL.pas',
  DmSrv_Intf in 'DmSrv_Intf.pas',
  DmSrv_Invk in 'DmSrv_Invk.pas',
  SrvDispensarios_Impl in 'SrvDispensarios_Impl.pas' {SrvDispensarios: TRORemoteDataModule},
  Hashes in 'Hashes.pas',
  UDISGATEWAY in 'UDISGATEWAY.pas' {FDISGATEWAY};

{#ROGEN:PDISMENU.rodl} // RemObjects: Careful, do not remove!
{$R RODLFile.res}


var
  Mutex : THandle;


{$R *.RES}

begin
  if not StrMayuscIguales(Paramstr(2),'Cliente') then begin
    Mutex := CreateMutex(nil, True, 'Consola de Dispensarios');
    if (Mutex = 0) or (GetLastError <> 0) then
      exit;
  end;
  Application.Initialize;
  Application.Title := 'Consola de Dispensarios';
  Application.CreateForm(TFDISMENU, FDISMENU);
  Application.CreateForm(TDMCONS, DMCONS);
  Application.Run;
end.


