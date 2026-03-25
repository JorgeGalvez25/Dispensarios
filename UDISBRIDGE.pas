unit UDISBRIDGE;
{==============================================================================
  UDISBRIDGE V2 - Comunicacion directa con servicio de dispensarios
  =============================================================================
  ELIMINADO:  ogcvgateway (OpenGas), UIGASBRIDGE, Socket1/Socket2 (TClientSocket)
  NUEVO:      SSocketPDisp (TServerSocket) - JSON polling inverso con servicio de dispensarios
  PROTOCOLO:
    - El servicio de dispensarios se conecta como cliente a SSocketPDisp
    - Envia su estado en JSON (o "PING" si aun no esta inicializado)
    - Este servidor responde con el siguiente comando pendiente
      en formato  folio|DISPENSERS|COMANDO|parametros
      o bien  0|NOTHING  si no hay comandos
  =============================================================================}

interface

uses Variants,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  OoMisc, AdPort, StdCtrls, Buttons, ComCtrls, ExtCtrls, Menus,
  Mask, ImgList, Db, DBTables, Grids, ULibPrint, DBGrids, RXShell, Registry,
  dxGDIPlusClasses, ShellApi, DateUtils, ScktComp, jpeg,
  SyncObjs, uLkJSON;

const
  MCxP = 4;

type
  { ---- TPeticion: comando encolado para servicio de dispensarios ---- }
  TPeticion = class
    Folio    : Integer;
    Comando  : string;   // AUTHORIZE, PRICES, STOP, etc.
    Peticion : string;   // String completo: DISPENSERS|COMANDO|parametros
    Tries    : Integer;
  end;

  { ---- TPeticionQueue: cola thread-safe ---- }
  TPeticionQueue = class
  private
    FList : TList;
    FCS   : TRTLCriticalSection;
  public
    constructor Create;
    destructor  Destroy; override;
    procedure Push(APeticion: TPeticion);
    function  TryPeek(out APeticion: TPeticion; MaxTries: Integer = 5): Boolean;
    function  TryLocateByFolio(AFol: Integer; out APet: TPeticion): Boolean;
    function  TryLocateByTipo(ATipo: string; out APet: TPeticion): Boolean;
    procedure Remove(APeticion: TPeticion; AFree: Boolean = True);
    procedure Clear;
    function  Count: Integer;
  end;

type
  TFDISBRIDGE = class(TForm)
    Panel1: TPanel;
    TabSheet2: TTabSheet;
    Panel3: TPanel;
    ListBoxPC1: TListBox;
    ListBoxPC2: TListBox;
    ListBoxPC3: TListBox;
    ListBoxPC4: TListBox;
    PanelPC1: TPanel;
    PanelPC2: TPanel;
    PanelPC3: TPanel;
    PanelPC4: TPanel;
    Timer1: TTimer;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    StaticText4: TStaticText;
    ListBox1: TListBox;
    PopupMenu1: TPopupMenu;
    Restaurar1: TMenuItem;
    BitBtn3: TBitBtn;
    TabSheet1: TTabSheet;
    StaticText5: TStaticText;
    StaticText6: TStaticText;
    ImageList1: TImageList;
    CheckBox2: TCheckBox;
    Panel2: TPanel;
    Memo1: TMemo;
    TL_Bomb: TTable;
    TL_BombMANGUERA: TIntegerField;
    TL_BombPOSCARGA: TIntegerField;
    TL_BombCOMBUSTIBLE: TIntegerField;
    TL_BombISLA: TIntegerField;
    TL_BombCON_PRECIO: TIntegerField;
    TL_BombCON_POSICION: TIntegerField;
    TL_BombCON_DIGITOAJUSTE: TIntegerField;
    TL_BombIMPRESORA: TIntegerField;
    TL_Tcmb: TTable;
    TL_TcmbCLAVE: TIntegerField;
    TL_TcmbNOMBRE: TStringField;
    TL_TcmbCLAVEPEMEX: TStringField;
    TL_TcmbCON_PRODUCTOPRECIO: TStringField;
    TL_TcmbPRECIOFISICO: TFloatField;
    StaticText17: TStaticText;
    StaticText18: TStaticText;
    Button1: TButton;
    PageControl1: TPageControl;
    Label4x: TLabel;
    StaticText9: TStaticText;
    Button3: TButton;
    StaticText7: TStaticText;
    DBGrid3: TDBGrid;
    ListView1: TListView;
    Image1: TImage;
    NotificationIcon1: TRxTrayIcon;
    StaticText8: TStaticText;
    TL_TcmbIDPRODUCTOOG: TIntegerField;
    CheckBox1: TCheckBox;
    Label1: TLabel;
    Memo2: TMemo;
    { Nuevo: ServerSocket para servicio de dispensarios }
    SSocketPDisp: TServerSocket;
    Button2: TButton;
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure Restaurar1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure NotificationIcon1DblClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    { Nuevo: eventos del ServerSocket }
    procedure SSocketPDispClientConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure SSocketPDispClientDisconnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure SSocketPDispClientRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure SSocketPDispClientError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure Button2Click(Sender: TObject);
  private
    ContReset       : integer;
    SwReset,
    SwAplicaCmnd,
    SwInicio        : boolean;
    Swcierrabd      : boolean;
    PrecioCombActual,
    SnPosCarga      : integer;
    SnImporte,
    SnLitros        : real;
    SnFlujo         : string;
    ContadorAlarma  : integer;
    { Nuevo: cola de peticiones y JSON }
    ListaPeticiones : TPeticionQueue;
    FolioSecuencia  : Integer;
    rootJSON        : TlkJSONobject;
    horaActJSON     : TDateTime;
    SrvConectado    : Boolean;
    SrvInicializado : Boolean;
    SrvEnEjecucion  : Boolean;
    HoraInicializado: TDateTime;
    PuertoSrv       : Integer;
  public
    procedure DespliegaPosCarga(xpos: integer; swforza: boolean);
    procedure IniciaBaseDeDatos;
    procedure IniciaEstacion;
    procedure DespliegaPrecios;
    procedure registro(valor: integer; variable: string);
    procedure lee_registro;
    function CombustibleEnPosicion(xpos, xposcarga: integer): integer;
    function PosicionDeCombustible(xpos, xcomb: integer): integer;
    procedure EnviaPreset3(var rsp: string; xcomb: integer);
    procedure EnviaPreset(var rsp: string; xcomb: integer);
    { Nuevo: comunicacion con servicio de dispensarios }
    procedure EnviaComandoSrv(const Comando, Parametros: string);
    procedure ProcesaRespuestasJSON(const ATexto: string);
    procedure ActualizaDesdeJSON;
    procedure ProcesaRespuestaPeticion(const AComando, AResultado: string);
    procedure InicializaSrv;
    procedure EnviarPreciosIniciales;
    procedure ProcesaComandosBD;
    procedure ActualizaEstadoDispensarios;
  end;

type
  tiposcarga = record
    estatus  : integer;
    descestat: string[20];
    importe,
    importeant,
    volumen,
    precio   : real;
    Isla,
    PosActual: integer;
    estatusant: integer;
    NoComb   : integer;
    TComb    : array[1..MCxP] of integer;
    TCombx   : array[1..MCxP] of integer;
    TPosx    : array[1..MCxP] of integer;
    TDiga    : array[1..MCxP] of integer;
    TDigvol  : array[1..MCxP] of integer;
    TDigit   : integer;
    TMapa    : array[1..MCxP] of string[6];
    TMang    : array[1..MCxP] of integer;
    SwMapea  : array[1..MCxP] of boolean;
    TotalLitrosAnt: array[1..MCxP] of real;
    TotalLitros: array[1..MCxP] of real;
    SwTotales: array[1..MCxP] of boolean;
    SwDesp, swprec: boolean;
    Hora: TDateTime;
    SwInicio: boolean;
    SwInicio2: boolean;
    SwPreset,
    IniciaCarga: boolean;
    MontoPreset: string;
    ImportePreset: real;
    Mensaje: string[30];
    swnivelprec,
    swautorizada,
    swautorizando,
    swcargando: boolean;
    swAvanzoVenta: boolean;
    swSinGuardar: Boolean;
    SwActivo,
    SwOCC, SwCmndB,
    SwDesHabilitado: boolean;
    ModoOpera: string[8];
    TipoPago: integer;
    ContOcc,
    FinVenta: integer;
    HoraOcc: TDateTime;
    HoraFinv: TDateTime;
    UltimoCmnd: TDateTime;
    CmndOcc: string[25];
    folioOG: Integer;
    TotsFinv: Boolean;
    swarosmag: boolean;
    aros_cont,
    aros_mang,
    aros_cte,
    aros_vehi: integer;
    swarosmag_stop: boolean;
    esDiesel: Boolean;
    swFlujoVehic: Boolean;
  end;

const
  MaxEspera2 = 20;
  MaxEspera3 = 10;

var
  FDISBRIDGE: TFDISBRIDGE;
  TPosCarga: array[1..32] of tiposcarga;
  MaxPosCarga: integer;
  MaxPosCargaActiva: integer;
  ContDA     : integer;
  SwCerrar   : boolean;
  TAdicf     : array[1..32, 1..3] of integer;
  Txp        : array[1..32] of integer;
  HoraLog    : TDateTime;

implementation

uses ULIBGRAL, ULIBLICENCIAS, DDMCONS, UDISMENU, StrUtils, Math;

{$R *.DFM}

{ Forward declaration }
function EjecutaCorte: string; forward;

{==============================================================================
  TPeticionQueue - Cola thread-safe (basada en UIGASBRIDGE)
==============================================================================}

constructor TPeticionQueue.Create;
begin
  inherited Create;
  FList := TList.Create;
  InitializeCriticalSection(FCS);
end;

destructor TPeticionQueue.Destroy;
begin
  Clear;
  DeleteCriticalSection(FCS);
  FList.Free;
  inherited;
end;

procedure TPeticionQueue.Push(APeticion: TPeticion);
begin
  EnterCriticalSection(FCS);
  try
    FList.Add(APeticion);
  finally
    LeaveCriticalSection(FCS);
  end;
end;

function TPeticionQueue.TryPeek(out APeticion: TPeticion; MaxTries: Integer): Boolean;
var
  Tmp: TPeticion;
begin
  APeticion := nil;
  EnterCriticalSection(FCS);
  try
    while FList.Count > 0 do begin
      Tmp := TPeticion(FList[0]);
      Inc(Tmp.Tries);
      if Tmp.Tries >= MaxTries then begin
        FList.Delete(0);
        Tmp.Free;
        Continue;
      end;
      APeticion := Tmp;
      Result := True;
      Exit;
    end;
    Result := False;
  finally
    LeaveCriticalSection(FCS);
  end;
end;

function TPeticionQueue.TryLocateByFolio(AFol: Integer; out APet: TPeticion): Boolean;
var
  i: Integer;
begin
  APet := nil;
  EnterCriticalSection(FCS);
  try
    for i := 0 to FList.Count - 1 do
      if TPeticion(FList[i]).Folio = AFol then begin
        APet := TPeticion(FList[i]);
        Result := True;
        Exit;
      end;
    Result := False;
  finally
    LeaveCriticalSection(FCS);
  end;
end;

function TPeticionQueue.TryLocateByTipo(ATipo: string; out APet: TPeticion): Boolean;
var
  i: Integer;
begin
  APet := nil;
  EnterCriticalSection(FCS);
  try
    for i := 0 to FList.Count - 1 do
      if (TPeticion(FList[i]).Comando = ATipo) and (TPeticion(FList[i]).Tries > 0) then begin
        APet := TPeticion(FList[i]);
        Result := True;
        Exit;
      end;
    Result := False;
  finally
    LeaveCriticalSection(FCS);
  end;
end;

procedure TPeticionQueue.Remove(APeticion: TPeticion; AFree: Boolean);
var
  Idx: Integer;
begin
  if APeticion = nil then Exit;
  EnterCriticalSection(FCS);
  try
    Idx := FList.IndexOf(APeticion);
    if Idx <> -1 then begin
      FList.Delete(Idx);
      if AFree then
        APeticion.Free;
    end;
  finally
    LeaveCriticalSection(FCS);
  end;
end;

procedure TPeticionQueue.Clear;
var
  i: Integer;
begin
  EnterCriticalSection(FCS);
  try
    for i := 0 to FList.Count - 1 do
      TPeticion(FList[i]).Free;
    FList.Clear;
  finally
    LeaveCriticalSection(FCS);
  end;
end;

function TPeticionQueue.Count: Integer;
begin
  EnterCriticalSection(FCS);
  try
    Result := FList.Count;
  finally
    LeaveCriticalSection(FCS);
  end;
end;

{==============================================================================
  Funciones conservadas tal cual del original
==============================================================================}

procedure TFDISBRIDGE.DespliegaPrecios;
var i: integer;
begin
  with DMCONS do begin
    Memo1.Lines.Clear;
    Memo1.Lines.Add('Precios Actuales: ');
    for i := 1 to MaxComb do with TabComb[i] do
      if Activo then
        Memo1.Lines.Add(IntToClaveNum(i, 2) + ' ' + Nombre + ' ' + FormatoMoneda(precio));
  end;
end;

procedure TFDISBRIDGE.IniciaBaseDeDatos;
var i: integer;
begin
  with DMCONS do begin
    Screen.Cursor := crHourGlass;
    try
      if UpperCase(OrdenMangueras) = 'CONPOS' then
        Q_BombIb.SQL[6] := 'order by poscarga,con_posicion';
      Q_BombIb.Active := false;
      Q_BombIb.Active := true;
      if Q_BombIb.IsEmpty then
        raise Exception.Create('Estacion no existe, o no tiene posiciones de carga configurados');
      for i := 1 to MaxComb do with TabComb[i] do begin
        Activo := false;
        Nombre := '';
        Precio := 0;
        AplicaPrecio := false;
        ProductoPrecio := '';
        DigitoPrec := 0;
        Agruparcon := 0;
      end;
      Q_CombIb.Active := true;
      Q_CombIb.First;
      while not Q_CombIb.Eof do begin
        if Q_CombIbClave.AsInteger in [1..MaxComb] then begin
          i := Q_CombIbClave.AsInteger;
          with TabComb[i] do begin
            Activo := true;
            Nombre := Q_CombIbNombre.AsString;
            ClavePemex := Q_CombIbClavePemex.AsString;
            ProductoPrecio := inttostr(i);
            DigitoPrec := Q_CombIbDigitoAjustePrecio.AsInteger;
            AgruparCon := Q_CombIbAgrupar_con.AsInteger;
          end;
        end;
        Q_CombIb.Next;
      end;
      CargaPreciosFH(Now, true);
      DBGrid3.Refresh;
      DespliegaPrecios;
    finally
      Screen.Cursor := crDefault;
    end;
  end;
end;

procedure TFDISBRIDGE.IniciaEstacion;
var i, j, xisla, xpos, xcomb, xnum: integer;
    existe: boolean;
begin
  with DMCONS do begin
    MaxPosCarga := 0;
    for i := 1 to 32 do with TPosCarga[i] do begin
      txp[i] := 1;
      for j := 1 to 3 do
        TAdicf[i, j] := 0;
      estatus := -1;
      estatusant := -1;
      NoComb := 0;
      SwInicio := true;
      SwInicio2 := true;
      IniciaCarga := false;
      SwPreset := false;
      Mensaje := '';
      importe := 0;
      volumen := 0;
      precio := 0;
      tipopago := 0;
      finventa := 0;
      Swnivelprec := false;
      if DMCONS.SwMapOff then
        Swnivelprec := true;
      SwCargando := false;
      SwAutorizada := false;
      SwAutorizando := false;
      swSinGuardar := False;
      for j := 1 to MCxP do begin
        SwTotales[j] := true;
        TotalLitrosAnt[j] := 0;
        TotalLitros[j] := 0;
        swmapea[j] := false;
        TMapa[j] := '';
        TComb[j] := 0;
        TPosx[j] := 0;
      end;
      SwActivo := false;
      SwDeshabilitado := false;
      SwArosMag := false;
      SwArosMag_stop := false;
      SwOCC := false;
      ContOcc := 0;
    end;
    TL_Bomb.Active := true;
    while not TL_Bomb.Eof do begin
      TL_Bomb.Edit;
      if not (TL_BombCon_Posicion.AsInteger in [1, 2, 3]) then
        TL_BombCon_Posicion.AsInteger := TL_BombCombustible.AsInteger;
      if (TL_BombCon_DigitoAjuste.IsNull) or (not (TL_BombCon_DigitoAjuste.AsInteger in [0, 1, 22])) then
        TL_BombCon_DigitoAjuste.AsInteger := 0;
      TL_Bomb.Post;
      TL_Bomb.Next;
    end;
    TL_Tcmb.Active := True;
    Q_BombIb.First;
    while not Q_BombIb.Eof do begin
      xisla := Q_BombIbIsla.asinteger;
      xpos := Q_BombIbPosCarga.AsInteger;
      if (xpos in [1..32]) then begin
        xcomb := Q_BombIbCOMBUSTIBLE.AsInteger;
        if (xpos > MaxPosCarga) then begin
          MaxPosCarga := xpos;
          ListView1.Items.Add;
          ListView1.Items[MaxPosCarga - 1].Caption := IntToClaveNum(xpos, 2);
          ListView1.Items[MaxPosCarga - 1].ImageIndex := 0;
        end;
        with TPosCarga[xpos] do begin
          Isla := xisla;
          SwDesp := false;
          SwPrec := false;
          existe := false;
          ModoOpera := Q_BombIbModoOperacion.AsString;
          esDiesel := False;
          HoraFinv := now;
          for i := 1 to NoComb do
            if TComb[i] = xcomb then
              existe := true;
          if not existe then begin
            TL_Tcmb.Locate('CLAVE', xcomb, []);
            if TL_TcmbIDPRODUCTOOG.AsInteger <= 0 then begin
              Q_BombIb.Next;
              Continue;
            end;
            inc(NoComb);
            TComb[NoComb] := xcomb;
            TL_Tcmb.Locate('CLAVE', xcomb, []);
            if TL_TcmbIDPRODUCTOOG.AsInteger > 0 then
              TCombx[NoComb] := TL_TcmbIDPRODUCTOOG.AsInteger
            else
              TCombx[NoComb] := xcomb;
            if (xcomb = 3) then
              esDiesel := True;
            if Q_BombIbCon_Posicion.AsInteger > 0 then
              TPosx[NoComb] := Q_BombIbCon_Posicion.AsInteger
            else if NoComb <= 2 then
              TPosx[NoComb] := NoComb
            else
              TPosx[NoComb] := 1;
            TMang[NoComb] := Q_BombIbManguera.AsInteger;
            TDiga[1] := Q_BombIbCon_DigitoAjuste.AsInteger;
            TDigvol[1] := Q_BombIbDigitoAjusteVol.AsInteger;
            TDigit := Q_BombIbDigitosGilbarco.AsInteger;
          end;
        end;
      end;
      Q_BombIb.Next;
    end;
  end;
  ListBox1.Items.Clear;
  xnum := (MaxPosCarga) div (4);
  if (MaxPosCarga) mod (4) > 0 then
    inc(xnum);
  for i := 1 to xnum do begin
    if i < xnum then
      ListBox1.Items.add('Posiciones ' + IntToClaveNum(i * 4 - 3, 2) + ' - ' + IntToClaveNum(i * 4, 2))
    else
      ListBox1.Items.add('Posiciones ' + IntToClaveNum(i * 4 - 3, 2) + ' - ' + IntToClaveNum(MaxPosCarga, 2));
  end;
end;

{==============================================================================
  FormCreate - Inicializacion
==============================================================================}

procedure TFDISBRIDGE.FormCreate(Sender: TObject);
begin
  SwReset := false;
  SwCerrar := false;
  SwInicio := true;
  ContadorAlarma := 0;

  { Nuevo: crear cola de peticiones }
  ListaPeticiones := TPeticionQueue.Create;
  FolioSecuencia := 0;
  rootJSON := nil;
  horaActJSON := 0;
  SrvConectado := False;
  SrvInicializado := False;
  SrvEnEjecucion := False;
  HoraInicializado := 0;

  { Leer puerto del servicio de dispensarios (default 1004) }
  PuertoSrv := 1004; // Se puede cargar de INI/BD

  StaticText7.Caption := ' Bridge V2 ';
end;

{==============================================================================
  FormShow - Arranque del sistema
==============================================================================}

procedure TFDISBRIDGE.FormShow(Sender: TObject);
begin
  if SwInicio then begin
    try
      HoraLog := Now;
      ContDA := 0;
      SwInicio := false;
      IniciaBaseDeDatos;
      ListBox1.ItemIndex := 0;
      IniciaEstacion;
      ListBox1.SetFocus;

      { Configurar ServerSocket para servicio de dispensarios }
      SSocketPDisp.Port := PuertoSrv;
        SSocketPDisp.ServerType := stNonBlocking;
        SSocketPDisp.OnClientConnect := SSocketPDispClientConnect;
        SSocketPDisp.OnClientDisconnect := SSocketPDispClientDisconnect;
        SSocketPDisp.OnClientRead := SSocketPDispClientRead;
        SSocketPDisp.OnClientError := SSocketPDispClientError;
        try
          SSocketPDisp.Active := True;
          DMCONS.AgregaLog('ServerSocket Srv activo en puerto ' + IntToStr(PuertoSrv));
        except
          on E: Exception do
            DMCONS.AgregaLog('ERROR al activar ServerSocket Srv: ' + E.Message);
        end;

      if DMCONS.TimerDisp > 0 then
        Timer1.Interval := DMCONS.TimerDisp;
      Timer1.Enabled := true;

      DMCONS.T_ConfIb.Active := true;
      if DMCONS.SwMapOff then begin
        Label4x.Visible := true;
        Label4x.Caption := 'MapOff';
      end;
    finally
      Timer1.Enabled := true;
    end;
  end;
end;

{==============================================================================
  FormClose / FormCloseQuery
==============================================================================}

procedure TFDISBRIDGE.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if SwCerrar then
    CanClose := true
  else
    CanClose := false;
end;

procedure TFDISBRIDGE.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Timer1.Enabled := false;

  { Enviar HALT y SHUTDOWN al servicio de dispensarios }
  if SrvConectado then begin
    try
      EnviaComandoSrv('HALT', '');
      EnviaComandoSrv('SHUTDOWN', '');
      Sleep(500);
    except end;
  end;

  try SSocketPDisp.Active := false; except end;

  { Liberar }
  if Assigned(ListaPeticiones) then begin
    ListaPeticiones.Clear;
    FreeAndNil(ListaPeticiones);
  end;
  if Assigned(rootJSON) then
    FreeAndNil(rootJSON);

  DMCONS.AgregaLog('Termino Aplicacion');
  Button1.click;
  Application.Terminate;
end;

{==============================================================================
  Eventos del ServerSocket - Conexion con servicio de dispensarios
==============================================================================}

procedure TFDISBRIDGE.SSocketPDispClientConnect(Sender: TObject; Socket: TCustomWinSocket);
begin
  SrvConectado := True;
  ContadorAlarma := 0;
  DMCONS.AgregaLog('Srv dispensarios conectado desde ' + Socket.RemoteAddress);
  StaticText7.Caption := ' Srv: ' + Socket.RemoteAddress;
  Label4x.Caption := 'On';
  Label4x.Visible := true;
end;

procedure TFDISBRIDGE.SSocketPDispClientDisconnect(Sender: TObject; Socket: TCustomWinSocket);
begin
  SrvConectado := False;
  SrvInicializado := False;
  SrvEnEjecucion := False;
  HoraInicializado := 0;
  DMCONS.AgregaLog('Srv dispensarios desconectado');
  StaticText7.Caption := ' Srv: Desconectado ';
  Label4x.Caption := 'Off';
  if Assigned(ListaPeticiones) then begin
    ListaPeticiones.Clear;
    FolioSecuencia := 0;
  end;
end;

procedure TFDISBRIDGE.SSocketPDispClientError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
  DMCONS.AgregaLog('Error Socket Srv: Codigo=' + IntToStr(ErrorCode));
  ErrorCode := 0;
end;

{==============================================================================
  SSocketPDispClientRead - Recepcion de datos del servicio de dispensarios
  =============================================================================
  El servicio de dispensarios envia:
    - "PING"    si aun no esta inicializado
    - JSON      con estado completo si ya esta corriendo
  Este servidor responde con:
    - "folio|DISPENSERS|COMANDO|parametros"  si hay peticion pendiente
    - "0|NOTHING"                            si no hay comandos
==============================================================================}

procedure TFDISBRIDGE.SSocketPDispClientRead(Sender: TObject; Socket: TCustomWinSocket);
var
  respTxt: string;
  p: TPeticion;
begin
  try
    horaActJSON := Now;
    respTxt := Socket.ReceiveText;
    if Trim(respTxt) = '' then Exit;

    { Si NO es PING, procesar JSON }
    if not AnsiContainsText(respTxt, 'PING') then
      ProcesaRespuestasJSON(respTxt)
    else begin
      { En el primer PING enviamos INITIALIZE si aun no se ha hecho }
      if not SrvInicializado then begin
        DMCONS.AgregaLog('PING recibido - Enviando INITIALIZE');
        InicializaSrv;
      end;
    end;

    { Responder con la siguiente peticion pendiente }
    if ListaPeticiones.TryPeek(p) then begin
      DMCONS.AgregaLog('>> CMD [' + IntToStr(p.Folio) + ']: ' + p.Peticion);
      Socket.SendText(IntToStr(p.Folio) + '|' + p.Peticion);
      Exit;
    end;

    Socket.SendText('0|NOTHING');
  except
    on e: Exception do
      DMCONS.AgregaLog('Error SSocketPDispClientRead: ' + e.Message);
  end;
end;

{==============================================================================
  ProcesaRespuestasJSON - Parsea JSON de servicio de dispensarios y actualiza estados
==============================================================================}

procedure TFDISBRIDGE.ProcesaRespuestasJSON(const ATexto: string);
var
  jArray, jItem: TlkJSONbase;
  idx, folioResp: Integer;
  Resultado: string;
  p: TPeticion;
begin
  try
    { 1. Parsear JSON y almacenar referencia global }
    if Assigned(rootJSON) then begin
      rootJSON.Free;
      rootJSON := nil;
    end;
    rootJSON := TlkJSONobject(TlkJSON.ParseText(ATexto));
    if rootJSON = nil then begin
      DMCONS.AgregaLog('Error: JSON invalido recibido');
      Exit;
    end;

    { Verificar estado del servicio }
    if rootJSON.Field['Estado'] <> nil then begin
      if Integer(rootJSON.Field['Estado'].Value) >= 1 then begin
        SrvInicializado := True;
        { Estado >= 1 significa que RUN ya se ejecuto (reconexion) }
        if not SrvEnEjecucion then begin
          SrvEnEjecucion := True;
          DMCONS.AgregaLog('Srv Estado >= 1 detectado - Servicio ya en ejecucion');
        end;
      end;
    end;

    { 2. Actualizar estados de posiciones desde JSON }
    { Solo procesar logica de negocio si el servicio ya esta en ejecucion
      (despues de RUN). Antes de RUN los datos son ceros y causarian
      falsas alarmas de desconexion en bitacora }
    if SrvEnEjecucion and (rootJSON.Field['PosCarga'] <> nil) then
      ActualizaDesdeJSON;

    { 3. Procesar respuestas a peticiones previas }
    jArray := rootJSON.Field['Peticiones'];
    if (jArray <> nil) and (jArray is TlkJSONlist) then begin
      for idx := 0 to TlkJSONlist(jArray).Count - 1 do begin
        jItem := TlkJSONlist(jArray).Child[idx];
        if jItem = nil then Continue;

        folioResp := Integer(TlkJSONobject(jItem).Field['Folio'].Value);
        Resultado := VarToStr(TlkJSONobject(jItem).Field['Resultado'].Value);

        if ListaPeticiones.TryLocateByFolio(folioResp, p) then begin
          ProcesaRespuestaPeticion(p.Comando, Resultado);
          ListaPeticiones.Remove(p);
        end;
      end;

      { Limpiar peticiones respondidas implicitamente }
      if ListaPeticiones.TryLocateByTipo('PRICES', p) then
        ListaPeticiones.Remove(p);
      if ListaPeticiones.TryLocateByTipo('AUTHORIZE', p) then
        ListaPeticiones.Remove(p);
      if ListaPeticiones.TryLocateByTipo('PAYMENT', p) then
        ListaPeticiones.Remove(p);
    end;
  except
    on e: Exception do
      DMCONS.AgregaLog('Error ProcesaRespuestasJSON: ' + e.Message);
  end;
end;

{==============================================================================
  ActualizaDesdeJSON - Logica de negocio (reemplaza ProcesaLinea)
  =============================================================================
  Lee el JSON con el estado completo de servicio de dispensarios y ejecuta toda la
  logica de negocio que antes hacian los comandos B, A, @, C del gateway.
==============================================================================}

procedure TFDISBRIDGE.ActualizaDesdeJSON;
var
  posList: TlkJSONlist;
  posObj: TlkJSONobject;
  hosesArr: TlkJSONlist;
  hoseObj: TlkJSONobject;
  i, j, xpos, xestatus, xcomb, xmang, xc, xp, ii: Integer;
  ximporte, xvolumen, xprecio, xdiflts: Real;
  ss, xestado, xmodo: string;
begin
  try
    posList := rootJSON.Field['PosCarga'] as TlkJSONlist;
    if posList = nil then Exit;
    MaxPosCargaActiva := posList.Count;
    if MaxPosCargaActiva > MaxPosCarga then
      MaxPosCargaActiva := MaxPosCarga;

    if DMCONS.PreciosInicio then
      DMCONS.AplicarUltimosPrecios;

    { ---- PASO 1: Actualizar estatus (equivalente al comando 'B') ---- }
    for i := 0 to posList.Count - 1 do begin
      posObj := TlkJSONobject(posList.Child[i]);
      if posObj = nil then Continue;
      xpos := Integer(posObj.Field['DispenserId'].Value);
      if not (xpos in [1..MaxPosCarga]) then Continue;

      with TPosCarga[xpos] do begin
        SwAutorizando := false;
        SwCmndB := true;
        estatusant := estatus;
        xestatus := Integer(posObj.Field['Estatus'].Value);
        estatus := xestatus;

        { Deteccion de conexion/desconexion }
        if (estatus = 0) and (SwActivo) then begin
          if (estatusant in [1..10]) then
            ContDA := 0
          else
            inc(ContDA);
          if ContDA = 5 then
            SwActivo := false;
        end
        else if (estatus in [1..10]) and (not SwActivo) then
          SwActivo := true;

        if not (estatus in [2, 8]) then
          swarosmag_stop := false;

        case estatus of
          0: begin
               descestat := '---';
               swautorizada := false;
               if estatusant <> 0 then
                 for xcomb := 1 to nocomb do
                   DMCONS.RegistraBitacora3(1, 'Desconexion de Manguera',
                     'Pos Carga ' + inttostr(xpos) + ' / Combustible ' + DMCONS.TabComb[TComb[xcomb]].Nombre, 'U');
             end;
          1, 7: begin
               if (SecondsBetween(Now, HoraFinv) > DMCONS.SegundosFINV) and (TotsFinv) then begin
                 for j := 1 to MCxP do SwTotales[j] := true;
                 TotsFinv := False;
                 { Solicitar totalizadores }
                 EnviaComandoSrv('TOTALS', IntToStr(xpos));
               end;
               if swprec then swprec := false;
               if estatusant = 0 then
                 for xcomb := 1 to nocomb do
                   DMCONS.RegistraBitacora3(1, 'Reconexion de Manguera',
                     'Pos Carga ' + inttostr(xpos) + ' / Combustible ' + DMCONS.TabComb[TComb[xcomb]].Nombre, 'U');
               swautorizada := false;
               descestat := 'Inactivo';
               if (estatusant <> estatus) then begin
                 FinVenta := 0;
                 SwArosMag := false;
                 SwOcc := false;
                 ContOcc := 0;
                 if not swAvanzoVenta then
                   SwCargando := False;
               end;
             end;
          2: begin
               descestat := 'Despachando';
               IniciaCarga := true;
               SwCargando := true;
               { Control aros magneticos }
               if SwArosMag then begin
                 if not DMCONS.ConexionArosActiva(xpos) then begin
                   EnviaComandoSrv('STOP', IntToStr(xpos));
                   SwArosMag_Stop := true;
                 end;
               end;
             end;
          3: begin
               descestat := 'Fin de Venta';
               TPosCarga[xpos].HoraOcc := now - 1000 * (1/86400);
             end;
          4, 5: begin
               descestat := 'Pistola Levantada';
             end;
          6: begin
               descestat := 'Cerrada';
               EnviaComandoSrv('UNBLOCK', IntToStr(xpos));
             end;
          8: begin
               descestat := 'Detenida';
               if SwArosMag_Stop then begin
                 if DMCONS.ControlArosMagneticosRecon(xpos, xmang, xcomb, xc) then begin
                   if (xmang = aros_mang) and (xcomb = aros_cte) and (xc = aros_vehi) and (aros_cont < DMCONS.ReconexionesAros) then begin
                     EnviaComandoSrv('START', IntToStr(xpos));
                     SwArosMag_Stop := false;
                     inc(aros_cont);
                   end;
                 end;
               end;
             end;
          9: begin
               descestat := 'Autorizada';
               swautorizada := true;
               if SwArosMag then begin
                 if not DMCONS.ConexionArosActiva(xpos) then begin
                   EnviaComandoSrv('STOP', IntToStr(xpos));
                 end;
               end;
             end;
        end; { case estatus }
      end; { with TPosCarga }
    end; { for i - estatus }

    { ---- PASO 1b: Auto-autorizacion en pistola levantada (modo Normal) ---- }
    for xpos := 1 to MaxPosCargaActiva do begin
      with TPosCarga[xpos] do begin
        case estatus of
          6: if SwInicio then begin
               EnviaComandoSrv('UNBLOCK', IntToStr(xpos));
               SwInicio := false;
             end;
          4, 5: if (not SwDesHabilitado) and (not swautorizada) and ((now - HoraOcc) > ((1/86400) * 5)) then begin
               if (SecondsBetween(UltimoCmnd, Now) > 3) and (ModoOpera = 'Normal') and (not swarosmag) then begin
                 SnImporte := 0.00;
                 SnLitros := 0;
                 SnPosCarga := xpos;
                 TipoPago := 0;
                 FinVenta := 0;
                 EnviaPreset3(ss, 0);
                 UltimoCmnd := Now;
                 HoraOcc := now;
                 SwInicio := false;
               end;
             end;
        end;
      end;
    end;

    { ---- PASO 2: Lectura de bomba (equivalente al comando 'A') ---- }
    for i := 0 to posList.Count - 1 do begin
      posObj := TlkJSONobject(posList.Child[i]);
      if posObj = nil then Continue;
      xpos := Integer(posObj.Field['DispenserId'].Value);
      if not (xpos in [1..MaxPosCarga]) then Continue;

      ximporte := 0; xvolumen := 0; xprecio := 0;
      if posObj.Field['Importe'] <> nil then ximporte := Double(posObj.Field['Importe'].Value);
      if posObj.Field['Volumen'] <> nil then xvolumen := Double(posObj.Field['Volumen'].Value);
      if posObj.Field['Precio'] <> nil then  xprecio := Double(posObj.Field['Precio'].Value);

      with TPosCarga[xpos] do begin
        if posObj.Field['Manguera'] <> nil then begin
          j := Integer(posObj.Field['Manguera'].Value);
          for xc := 1 to NoComb do
            if TMang[xc] = j then
              PosActual := TPosx[xc];
        end;
        if posObj.Field['Combustible'] <> nil then begin
          xc := Integer(posObj.Field['Combustible'].Value);
          for j := 1 to NoComb do
            if TComb[j] = xc then
              PosActual := TPosx[j];
        end;

        Mensaje := '';
        swinicio2 := false;

        if estatus = 2 then begin
          { Despachando - actualizar importe en curso }
          importeant := importe;
          importe := ximporte;
          volumen := 0;
          precio := 0;
          if not swAvanzoVenta then
            swAvanzoVenta := importe > 0;
          { Control aros magneticos al inicio de despacho }
          if (DMCONS.ControlAros = 'Si') and (importe < 0.01) and (not swarosmag) and (ModoOpera = 'Normal') then begin
            swarosmag := DMCONS.ControlArosMagneticos2(xpos, aros_mang, aros_cte, aros_vehi);
            if swarosmag then
              EnviaComandoSrv('STOP', IntToStr(xpos));
          end;
          DespliegaPosCarga(xpos, true);
        end
        else if (estatus in [1, 3, 5, 7, 9]) and (xvolumen > 0) then begin
          { Venta concluida - procesar lectura final }
          volumen := xvolumen;
          importeant := importe;
          importe := ximporte;
          precio := xprecio;
          xcomb := CombustibleEnPosicion(xpos, PosActual);

          if (not swAvanzoVenta) and (SwCargando) then begin
            swAvanzoVenta := (importe <> importeant) and (importe > 0) and
                             ((importeant > 0) or (importe - importeant < IfThen(xcomb = 3, 80, 40)));
          end;

          if (SwCargando) and (estatus in [1, 3, 5, 9]) and (volumen > 0) and (importe > 0) then begin
            swSinGuardar := True;
            SwCargando := False;
            if (swAvanzoVenta) then begin
              swAvanzoVenta := False;
              swSinGuardar := False;
              swdesp := true;
              if UpperCase(DMCONS.TotalCalculado) = 'SI' then begin
                if PosActual in [1..MCxP] then
                  TotalLitros[PosActual] := TotalLitros[PosActual] + volumen;
                DMCONS.RegistraTotales_BD4(xpos, TotalLitros[1], TotalLitros[2], TotalLitros[3], TotalLitros[4]);
              end;
            end;
          end;

          { Fin de venta automatico en estatus 3 }
          if (SecondsBetween(UltimoCmnd, Now) > 3) and (finventa = 0) and (estatus = 3) then begin
            finventa := 0;
            TipoPago := 0;
            EnviaComandoSrv('PAYMENT', IntToStr(xpos) + '|0');
            UltimoCmnd := Now;
          end;

          DespliegaPosCarga(xpos, true);
        end
        else
          DespliegaPosCarga(xpos, false);

        { Leer totalizadores de Hoses }
        if posObj.Field['Hoses'] <> nil then begin
          hosesArr := posObj.Field['Hoses'] as TlkJSONlist;
          if hosesArr <> nil then begin
            for j := 0 to hosesArr.Count - 1 do begin
              hoseObj := TlkJSONobject(hosesArr.Child[j]);
              if (hoseObj <> nil) and (j < MCxP) then begin
                if hoseObj.Field['Total'] <> nil then begin
                  { Detectar ventas no guardadas por cambio en totalizadores }
                  xprecio := Double(hoseObj.Field['Total'].Value);
                  if (swSinGuardar) and (Abs(xprecio - TotalLitros[j + 1]) > 0.5) then begin
                    DMCONS.AgregaLog('Venta posterior guardada Poscarga: ' + IntToStr(xpos));
                    SwDesp := True;
                    swSinGuardar := False;
                  end;
                  TotalLitros[j + 1] := xprecio;
                  SwTotales[j + 1] := false;
                end;
              end;
            end;
            DMCONS.RegistraTotales_BD4(xpos, TotalLitros[1], TotalLitros[2], TotalLitros[3], TotalLitros[4]);
            swSinGuardar := False;
          end;
        end;
      end; { with TPosCarga }
    end; { for i - lectura de bomba }

    { ---- PASO 3: Actualizar dispensarios en BD ---- }
    ActualizaEstadoDispensarios;

    { ---- PASO 4: Cambio de precios ---- }
    { Se maneja en Timer1Timer }

    { ---- PASO 5: Procesar comandos pendientes de BD ---- }
    ProcesaComandosBD;

  except
    on e: Exception do begin
      DMCONS.AgregaLog('ERROR ActualizaDesdeJSON: ' + e.Message);
      if (DMCONS.T_Tcmb.State in [dsInsert, dsEdit]) then
        DMCONS.T_Tcmb.Cancel;
    end;
  end;
end;

{==============================================================================
  ActualizaEstadoDispensarios - Escribe estado en T_ConsIb (paso 3 original)
==============================================================================}

procedure TFDISBRIDGE.ActualizaEstadoDispensarios;
var xpos, xcomb: integer;
    lin, xestado, xmodo, ss: string;
begin
  with DMCONS do begin
    lin := ''; xestado := ''; xmodo := '';
    for xpos := 1 to MaxPosCarga do with TPosCarga[xpos] do begin
      xmodo := xmodo + ModoOpera[1];
      if not SwDesHabilitado then begin
        case estatus of
          0: xestado := xestado + '0';
          1: xestado := xestado + '1';
          2: xestado := xestado + '2';
          3: xestado := xestado + '3';
          4, 5: xestado := xestado + '5';
          9: xestado := xestado + '9';
          8: xestado := xestado + '8';
          else xestado := xestado + '0';
        end;
      end
      else xestado := xestado + '7';
      if (estatus = 0) or (PosActual = 0) then
        xcomb := TComb[1]
      else
        xcomb := CombustibleEnPosicion(xpos, PosActual);
      ss := inttoclavenum(xpos, 2) + '/' + inttostr(xcomb);
      ss := ss + '/' + FormatFloat('###0.##', volumen);
      ss := ss + '/' + FormatFloat('#0.##', precio);
      ss := ss + '/' + FormatFloat('####0.##', importe);
      lin := lin + '#' + ss;
    end;
    if lin = '' then
      lin := xestado + '#'
    else
      lin := xestado + lin;
    lin := lin + '&' + xmodo;
    DMCONS.ActualizaDispensarios('D' + lin);
  end;
end;

{==============================================================================
  EnviaComandoSrv - Encola un comando para servicio de dispensarios
==============================================================================}

procedure TFDISBRIDGE.EnviaComandoSrv(const Comando, Parametros: string);
var
  p: TPeticion;
begin
  Inc(FolioSecuencia);
  if FolioSecuencia > 999 then
    FolioSecuencia := 1;

  p := TPeticion.Create;
  p.Folio := FolioSecuencia;
  p.Comando := Comando;
  if Parametros <> '' then
    p.Peticion := 'DISPENSERS|' + Comando + '|' + Parametros
  else
    p.Peticion := 'DISPENSERS|' + Comando;
  p.Tries := 0;
  ListaPeticiones.Push(p);

  DMCONS.AgregaLog('CMD Srv [' + IntToStr(p.Folio) + ']: ' + p.Peticion);
end;

{==============================================================================
  ProcesaRespuestaPeticion - Maneja resultados de comandos asincronos
==============================================================================}

procedure TFDISBRIDGE.ProcesaRespuestaPeticion(const AComando, AResultado: string);
var
  exito: Boolean;
begin
  exito := AnsiStartsText('True', AResultado);
  DMCONS.AgregaLog('Resp ' + AComando + ': ' + AResultado);

  if SameText(AComando, 'INITIALIZE') then begin
    if exito then begin
      SrvInicializado := True;
      HoraInicializado := Now;
      DMCONS.AgregaLog('Srv Inicializado OK - Enviando RUN');
      EnviaComandoSrv('RUN', '');
      EnviarPreciosIniciales;
    end
    else begin
      SrvInicializado := False;
      DMCONS.AgregaLog('ERROR: Srv INITIALIZE fallo: ' + AResultado);
    end;
  end
  else if SameText(AComando, 'RUN') then begin
    if exito then begin
      SrvEnEjecucion := True;
      DMCONS.AgregaLog('Srv RUN exitoso - Servicio en ejecucion');
    end
    else
      DMCONS.AgregaLog('ERROR: Srv RUN fallo: ' + AResultado);
  end
  else if SameText(AComando, 'PRICES') then begin
    if exito then begin
      { Marcar precio como aplicado en BD }
      with DMCONS do begin
        if (PrecioCombActual in [1..MaxComb]) then begin
          with TabComb[PrecioCombActual] do begin
            AplicaPrecio := false;
            PreciosInicio := False;
            try
              Q_AplicaPrecioF.ParamByName('pFolio').AsInteger := Folio;
              Q_AplicaPrecioF.ParamByName('pCombustible').AsInteger := PrecioCombActual;
              Q_AplicaPrecioF.ParamByName('pError').AsString := 'No';
              Q_AplicaPrecioF.ExecSQL;
            except
              on e: Exception do
                DMCONS.AgregaLog('Error AplicaPrecioF: ' + e.Message);
            end;
            try
              T_Tcmb.Active := true;
              try
                if T_Tcmb.Locate('Clave', PrecioCombActual, []) then begin
                  T_Tcmb.Edit;
                  T_TcmbPrecioFisico.AsFloat := Precio;
                  T_Tcmb.Post;
                  Q_CombIb.Active := false;
                  Q_CombIb.Active := true;
                end;
              finally
                T_Tcmb.Active := false;
              end;
            except
              on e: Exception do
                DMCONS.AgregaLog('Error PrecioFisico: ' + e.Message);
            end;
          end;
        end;
      end;
    end;
  end;
end;

{==============================================================================
  InicializaSrv - Construye y envia el JSON de INITIALIZE
==============================================================================}

procedure TFDISBRIDGE.InicializaSrv;
var
  jsConfig: TlkJSONobject;
  jsConsoles, jsDisps, jsProds, jsMangueras: TlkJSONlist;
  jsConsole, jsDisp, jsProd, jsManguera: TlkJSONobject;
  listaVars: TStringList;
  i, j: Integer;
  sConnection, variables: string;
begin
  try
    jsConfig := TlkJSONobject.Create;
    try
      { ----------------------------------------------------------------
        Consoles (puerto serial)
        El servicio de dispensarios lee: js.Field['Consoles']
        Cada consola debe tener un campo 'Connection' con string
        formato CSV: "ConsolaId,COMx,BaudRate,Paridad,DataBits,StopBits"
        que IniciaPSerial parsea con ExtraeElemStrSep(datosPuerto,N,',')
        ---------------------------------------------------------------- }
      jsConsoles := TlkJSONlist.Create;
      jsConsole := TlkJSONobject.Create;
      with DMCONS do
        sConnection := '1'                              // Elemento 1: ConsolaId
                     + ',COM' + IntToStr(PtPuerto)      // Elemento 2: Puerto
                     + ',' + IntToStr(PtBaudios)        // Elemento 3: BaudRate
                     + ',' + string(PtParidad)          // Elemento 4: Paridad (N/E/O)
                     + ',' + IntToStr(PtBitsDatos)      // Elemento 5: DataBits
                     + ',' + IntToStr(PtBitsParada);    // Elemento 6: StopBits
      jsConsole.Add('Connection', sConnection);
      jsConsoles.Add(jsConsole);
      jsConfig.Add('Consoles', jsConsoles);

      { ----------------------------------------------------------------
        Dispensers
        El servicio de dispensarios lee: js.Field['Dispensers']
        Cada dispensario: DispenserId, Hoses[] con HoseId y ProductId
        ---------------------------------------------------------------- }
      jsDisps := TlkJSONlist.Create;
      for i := 1 to MaxPosCarga do begin
        if TPosCarga[i].NoComb = 0 then Continue;
        jsDisp := TlkJSONobject.Create;
        jsDisp.Add('DispenserId', i);
        jsMangueras := TlkJSONlist.Create;
        for j := 1 to TPosCarga[i].NoComb do begin
          jsManguera := TlkJSONobject.Create;
          jsManguera.Add('HoseId', TPosCarga[i].TMang[j]);
          jsManguera.Add('ProductId', TPosCarga[i].TCombx[j]);
          jsMangueras.Add(jsManguera);
        end;
        jsDisp.Add('Hoses', jsMangueras);
        jsDisps.Add(jsDisp);
      end;
      jsConfig.Add('Dispensers', jsDisps);

      { ----------------------------------------------------------------
        Products
        El servicio de dispensarios lee: js.Field['Products']
        Cada producto: ProductId y Price (NO 'Precio')
        ---------------------------------------------------------------- }
      jsProds := TlkJSONlist.Create;
      for i := 1 to MaxComb do begin
        if not DMCONS.TabComb[i].Activo then Continue;
        jsProd := TlkJSONobject.Create;
        jsProd.Add('ProductId', i);
        jsProd.Add('Nombre', string(DMCONS.TabComb[i].Nombre));
        jsProd.Add('Price', DMCONS.TabComb[i].Precio);
        jsProds.Add(jsProd);
      end;
      jsConfig.Add('Products', jsProds);

      { ----------------------------------------------------------------
        Variables de configuracion
        Lee todas las variables de T_EstsIbConsola (campo memo) y
        las envia al servicio de dispensarios. Asi se soportan
        diferentes marcas sin tener que hardcodear variables aqui.
        El servicio de dispensarios las recibe con ExtraeElemStrSep
        y las parsea con NoElemStrEnter / ExtraeElemStrEnter
        usando #13#10 como separador entre cada variable=valor.
        ---------------------------------------------------------------- }
      variables := '';
      listaVars := TStringList.Create;
      try
        listaVars.Assign(DMCONS.T_EstsIbConsola);
        for i := 0 to listaVars.Count - 1 do begin
          if Trim(listaVars[i]) = '' then Continue;
          if variables <> '' then
            variables := variables + #13#10;
          variables := variables + listaVars[i];
        end;
      finally
        listaVars.Free;
      end;

      { Si SwEmular esta activo, agregar variable ModoEmulacion=Si
        para que el servicio de dispensarios trabaje sin puerto serial }
      if DMCONS.SwEmular then begin
        if variables <> '' then
          variables := variables + #13#10;
        variables := variables + 'ModoEmulacion=Si';
      end;

      EnviaComandoSrv('INITIALIZE', TlkJSON.GenerateText(jsConfig) + '|' + variables);
      DMCONS.AgregaLog('INITIALIZE encolado - Puerto: ' + sConnection);
    finally
      jsConfig.Free;
    end;
  except
    on E: Exception do
      DMCONS.AgregaLog('ERROR InicializaSrv: ' + E.Message);
  end;
end;

{==============================================================================
  EnviarPreciosIniciales
==============================================================================}

procedure TFDISBRIDGE.EnviarPreciosIniciales;
var i: Integer;
begin
  with DMCONS do begin
    for i := 1 to MaxComb do with TabComb[i] do
      if Activo and (Precio > 0) then
        EnviaComandoSrv('PRICES', IntToStr(i) + '|' + FormatFloat('0.00', Precio));
  end;
end;

{==============================================================================
  ProcesaComandosBD - Procesa comandos de BD (paso 5 original de ProcesaLinea)
==============================================================================}

procedure TFDISBRIDGE.ProcesaComandosBD;
var xcmnd, xpos, xcomb, xp, xfolio: integer;
    ss, rsp: string;
begin
  try
    with DMCONS do begin
      if swcierrabd then begin
        DBGASCON.Connected := false;
        Esperamiliseg(300);
        DBGASCON.Connected := true;
        swcierrabd := false;
        Q_CombIb.Active := true;
      end;

      for xcmnd := 1 to 40 do if (TabCmnd[xcmnd].SwActivo) and (not TabCmnd[xcmnd].SwResp) then begin
        SwAplicaCmnd := true;
        ss := Mayusculas(ExtraeElemStrSep(TabCmnd[xcmnd].Comando, 1, ' '));
        DMCONS.AgregaLog(TabCmnd[xcmnd].Comando);

        { PAROTOTAL }
        if ss = 'PAROTOTAL' then begin
          rsp := 'OK';
          EnviaComandoSrv('HALT', '');
        end
        { CERRAR }
        else if ss = 'CERRAR' then begin
          rsp := 'OK';
          SwCerrar := true;
        end
        { GLOG }
        else if ss = 'GLOG' then begin
          rsp := 'OK';
          Button1.Click;
        end
        { AMP - Activa Modo Prepago }
        else if ss = 'AMP' then begin
          xpos := StrToIntDef(ExtraeElemStrSep(TabCmnd[xcmnd].Comando, 2, ' '), 0);
          if xpos = 0 then begin
            for xpos := 1 to MaxPosCarga do
              TPosCarga[xpos].ModoOpera := 'Prepago';
            ActivaModoPrepago(0);
            EnviaComandoSrv('SELFSERVICE', '0');
            rsp := 'OK';
          end
          else if (xpos in [1..maxposcarga]) then begin
            TPosCarga[xpos].ModoOpera := 'Prepago';
            ActivaModoPrepago(xpos);
            EnviaComandoSrv('SELFSERVICE', IntToStr(xpos));
            rsp := 'OK';
          end;
        end
        { DMP - Desactiva Modo Prepago }
        else if ss = 'DMP' then begin
          xpos := StrToIntDef(ExtraeElemStrSep(TabCmnd[xcmnd].Comando, 2, ' '), 0);
          if xpos = 0 then begin
            for xpos := 1 to MaxPosCarga do
              TPosCarga[xpos].ModoOpera := 'Normal';
            DesActivaModoPrepago(0);
            EnviaComandoSrv('FULLSERVICE', '0');
            rsp := 'OK';
          end
          else if (xpos in [1..maxposcarga]) then begin
            TPosCarga[xpos].ModoOpera := 'Normal';
            DesActivaModoPrepago(xpos);
            EnviaComandoSrv('FULLSERVICE', IntToStr(xpos));
            rsp := 'OK';
          end;
        end
        { OCC - Ordena Carga de Combustible (importe) }
        else if ss = 'OCC' then begin
          SnPosCarga := StrToIntDef(ExtraeElemStrSep(TabCmnd[xcmnd].Comando, 2, ' '), 0);
          xpos := SnPosCarga;
          rsp := 'OK';
          if (SnPosCarga in [1..MaxPosCarga]) then begin
            if (TPosCarga[SnPosCarga].estatus in [1, 5, 7]) then begin
              try
                SnImporte := StrToFloat(ExtraeElemStrSep(TabCmnd[xcmnd].Comando, 3, ' '));
                SnLitros := 0;
                rsp := ValidaCifra(SnImporte, 5, 2);
              except
                rsp := 'Error en Importe';
              end;
              if rsp = 'OK' then begin
                TPosCarga[SnPosCarga].tipopago := StrToIntDef(ExtraeElemStrSep(TabCmnd[xcmnd].Comando, 5, ' '), 0);
                TPosCarga[SnPosCarga].swarosmag := false;
                if (TPosCarga[SnPosCarga].tipopago in [4, 5]) then with TPosCarga[SnPosCarga] do begin
                  swarosmag := DMCONS.ControlArosMagneticos(SnPosCarga, aros_mang, aros_cte, aros_vehi);
                  aros_cont := 0;
                  if not swarosmag then rsp := 'Aro se encuentra desconectado';
                end;
                if rsp = 'OK' then begin
                  xcomb := StrToIntDef(ExtraeElemStrSep(TabCmnd[xcmnd].Comando, 4, ' '), 0);
                  xp := PosicionDeCombustible(SnPosCarga, xcomb);
                  if xp > 0 then begin
                    TPosCarga[SnPosCarga].finventa := StrToIntDef(ExtraeElemStrSep(TabCmnd[xcmnd].Comando, 6, ' '), 0);
                    EnviaPreset3(rsp, xcomb);
                  end
                  else rsp := 'Combustible no existe en esta posicion';
                end;
              end;
            end
            else rsp := 'Posicion de Carga no Disponible';
          end
          else rsp := 'Posicion de Carga no Existe';
        end
        { OCL - Ordena Carga en Litros }
        else if ss = 'OCL' then begin
          SnPosCarga := StrToIntDef(ExtraeElemStrSep(TabCmnd[xcmnd].Comando, 2, ' '), 0);
          xpos := SnPosCarga;
          rsp := 'OK';
          if (SnPosCarga in [1..MaxPosCarga]) then begin
            if (TPosCarga[SnPosCarga].estatus in [1, 5, 7]) then begin
              try
                SnImporte := 0;
                SnLitros := StrToFloat(ExtraeElemStrSep(TabCmnd[xcmnd].Comando, 3, ' '));
                rsp := ValidaCifra(SnLitros, 4, 2);
                if rsp = 'OK' then
                  if (SnLitros < 0.10) then rsp := 'Minimo permitido: 0.10 lts';
              except
                rsp := 'Error en Litros';
              end;
              if rsp = 'OK' then begin
                TPosCarga[SnPosCarga].tipopago := StrToIntDef(ExtraeElemStrSep(TabCmnd[xcmnd].Comando, 5, ' '), 0);
                TPosCarga[SnPosCarga].swarosmag := false;
                if (TPosCarga[SnPosCarga].tipopago in [4, 5]) then with TPosCarga[SnPosCarga] do begin
                  swarosmag := DMCONS.ControlArosMagneticos(SnPosCarga, aros_mang, aros_cte, aros_vehi);
                  aros_cont := 0;
                  if not swarosmag then rsp := 'Aro se encuentra desconectado';
                end;
                if rsp = 'OK' then begin
                  xcomb := StrToIntDef(ExtraeElemStrSep(TabCmnd[xcmnd].Comando, 4, ' '), 0);
                  xp := PosicionDeCombustible(SnPosCarga, xcomb);
                  if xp > 0 then begin
                    if FlujoPorVehiculo then begin
                      ss := ExtraeElemStrSep(TabCmnd[xcmnd].Comando, 8, ' ');
                      if ss <> '' then begin
                        ss := FiltraStrNum(FormatFloat('0.00', StrToFloat(ss)));
                        SnFlujo := ss;
                        SnImporte := SnLitros * TabComb[xcomb].Precio;
                        SnLitros := 0;
                        SnImporte := StrToFloat(FormatFloat('0000.00', SnImporte));
                        TPosCarga[SnPosCarga].swFlujoVehic := True;
                      end;
                    end;
                    TPosCarga[SnPosCarga].finventa := StrToIntDef(ExtraeElemStrSep(TabCmnd[xcmnd].Comando, 6, ' '), 0);
                    EnviaPreset3(rsp, xcomb);
                  end
                  else rsp := 'Combustible no existe en esta posicion';
                end;
              end;
            end
            else rsp := 'Posicion de Carga no Disponible';
          end
          else rsp := 'Posicion de Carga no Existe';
        end
        { FINV - Fin de Venta }
        else if ss = 'FINV' then begin
          xpos := StrToIntDef(ExtraeElemStrSep(TabCmnd[xcmnd].Comando, 2, ' '), 0);
          if not TPosCarga[xpos].swcargando then begin
            rsp := 'OK';
            if (xpos in [1..MaxPosCarga]) then begin
              TPosCarga[xpos].tipopago := StrToIntDef(ExtraeElemStrSep(TabCmnd[xcmnd].Comando, 3, ' '), 0);
              if (TPosCarga[xpos].Estatus in [1, 3]) then begin
                TPosCarga[xpos].finventa := 0;
                EnviaComandoSrv('PAYMENT', IntToStr(xpos) + '|' + IntToStr(TPosCarga[xpos].tipopago));
                { Actualizar tipo de pago de ultima venta }
                try
                  try
                    if not DBGASCON.Connected then DBGASCON.Connected := true;
                    Q_Auxi.Active := false;
                    Q_AuxiEntero1.FieldKind := fkInternalCalc;
                    Q_Auxi.SQL.Clear;
                    Q_Auxi.SQL.Add('Select Max(Folio) as Entero1 from DPVGMOVI');
                    Q_Auxi.SQL.Add('Where PosCarga=' + inttostr(xpos));
                    Q_Auxi.Active := true;
                    if Q_AuxiEntero1.AsInteger > 0 then begin
                      xfolio := Q_AuxiEntero1.AsInteger;
                      Q_Auxi.Active := false;
                      Q_Auxi.SQL.Clear;
                      Q_Auxi.SQL.Add('Update DPVGMOVI set tipopago=' + inttostr(TPosCarga[xpos].tipopago));
                      Q_Auxi.SQL.Add('Where Folio=' + inttostr(xfolio));
                      Q_Auxi.ExecSQL;
                      TPosCarga[xpos].tipopago := 0;
                    end;
                  finally
                    Q_Auxi.Active := false;
                  end;
                except
                  on e: exception do AgregaLog('Error tipo pago FINV: ' + e.Message);
                end;
                DespliegaPosCarga(xpos, true);
              end
              else rsp := 'Posicion aun no esta en fin de venta';
            end
            else rsp := 'Posicion de Carga no Existe';
          end
          else SwAplicaCmnd := False;
        end
        { EFV - Espera Fin de Venta }
        else if ss = 'EFV' then begin
          xpos := StrToIntDef(ExtraeElemStrSep(TabCmnd[xcmnd].Comando, 2, ' '), 0);
          rsp := 'OK';
          if (xpos in [1..MaxPosCarga]) then
            if (TPosCarga[xpos].Estatus = 2) then
              TPosCarga[xpos].finventa := 1
            else rsp := 'Posicion debe estar Despachando'
          else rsp := 'Posicion de Carga no Existe';
        end
        { DPC - Deshabilita Posicion }
        else if ss = 'DPC' then begin
          rsp := 'OK';
          xpos := strtointdef(ExtraeElemStrSep(TabCmnd[xcmnd].Comando, 2, ' '), 0);
          if xpos in [1..MaxPosCarga] then begin
            TPosCarga[xpos].SwDesHabilitado := true;
            EnviaComandoSrv('BLOCK', IntToStr(xpos));
          end;
        end
        { HPC - Habilita Posicion }
        else if ss = 'HPC' then begin
          rsp := 'OK';
          xpos := strtointdef(ExtraeElemStrSep(TabCmnd[xcmnd].Comando, 2, ' '), 0);
          if xpos in [1..MaxPosCarga] then begin
            TPosCarga[xpos].SwDesHabilitado := false;
            EnviaComandoSrv('UNBLOCK', IntToStr(xpos));
          end;
        end
        { DVC / PARAR }
        else if (ss = 'DVC') or (ss = 'PARAR') then begin
          rsp := 'OK';
          xpos := strtointdef(ExtraeElemStrSep(TabCmnd[xcmnd].Comando, 2, ' '), 0);
          if xpos in [1..MaxPosCarga] then begin
            if (TPosCarga[xpos].estatus in [2, 9]) then begin
              EnviaComandoSrv('STOP', IntToStr(xpos));
              if TPosCarga[xpos].estatus = 9 then
                TPosCarga[xpos].tipopago := 0;
            end;
          end;
        end
        { REANUDAR }
        else if (ss = 'REANUDAR') then begin
          rsp := 'OK';
          xpos := strtointdef(ExtraeElemStrSep(TabCmnd[xcmnd].Comando, 2, ' '), 0);
          if xpos in [1..MaxPosCarga] then
            if (TPosCarga[xpos].estatus in [2, 8]) then
              EnviaComandoSrv('START', IntToStr(xpos));
        end
        { CORTE }
        else if ss = 'CORTE' then begin
          try
            xFechaCorte := StrToFecha(ExtraeElemStrSep(TabCmnd[xcmnd].Comando, 2, ' '));
            xTurnoCorte := StrToIntDef(ExtraeElemStrSep(TabCmnd[xcmnd].Comando, 3, ' '), 0);
            xIslaCorte := StrToIntDef(ExtraeElemStrSep(TabCmnd[xcmnd].Comando, 4, ' '), 0);
            SwCorteParcial := false;
            rsp := EjecutaCorte;
          except
            rsp := 'Comando Erroneo';
          end;
        end
        { REFRESCACORTE }
        else if ss = 'REFRESCACORTE' then begin
          try
            xFechaCorte := StrToFecha(ExtraeElemStrSep(TabCmnd[xcmnd].Comando, 2, ' '));
            xTurnoCorte := StrToIntDef(ExtraeElemStrSep(TabCmnd[xcmnd].Comando, 3, ' '), 0);
            xIslaCorte := StrToIntDef(ExtraeElemStrSep(TabCmnd[xcmnd].Comando, 4, ' '), 0);
            SwCorteParcial := false;
            rsp := 'OK';
            T_Corte.Active := true;
            try
              if not T_Corte.Locate('Fecha;Turno', VarArrayOf([xFechaCorte, xTurnoCorte]), []) then
                rsp := 'Corte no existe'
              else
                rsp := EjecutaCorte;
            finally
              T_Corte.Active := false;
            end;
          except
            rsp := 'Comando Erroneo';
          end;
        end
        { CORTEPARCIAL }
        else if ss = 'CORTEPARCIAL' then begin
          try
            xFechaCorte := StrToFecha(ExtraeElemStrSep(TabCmnd[xcmnd].Comando, 2, ' '));
            xTurnoCorte := StrToIntDef(ExtraeElemStrSep(TabCmnd[xcmnd].Comando, 3, ' '), 0);
            xIslaCorte := StrToIntDef(ExtraeElemStrSep(TabCmnd[xcmnd].Comando, 4, ' '), 0);
            SwCorteParcial := true;
            rsp := EjecutaCorte;
          except
            rsp := 'Comando Erroneo';
          end;
        end
        else rsp := 'Comando no Soportado o no Existe';

        TabCmnd[xcmnd].SwNuevo := false;
        if SwAplicaCmnd then begin
          if rsp = '' then rsp := 'OK';
          TabCmnd[xcmnd].SwResp := true;
          TabCmnd[xcmnd].Respuesta := rsp;
          DMCONS.AgregaLogCmnd(LlenaStr(TabCmnd[xcmnd].Comando, 'I', 40, ' ') + ' Respuesta: ' + TabCmnd[xcmnd].Respuesta);
        end;
        if SwCerrar then Close;
      end; { for xcmnd }
    end; { with DMCONS }
  except
    on e: Exception do
      DMCONS.AgregaLog('ERROR ProcesaComandosBD: ' + ss + ' ' + e.Message);
  end;
end;

{==============================================================================
  EnviaPreset3 - Autorizacion de carga
  Ahora usa EnviaComandoSrv('AUTHORIZE',...) en lugar de ComandoConsolaBuff
==============================================================================}

procedure TFDISBRIDGE.EnviaPreset3(var rsp: string; xcomb: integer);
var xpos, xc, xp: integer;
    ss, xprodauto, efv: string;
    swlitros: boolean;
begin
  try
    swlitros := SnLitros > 0.01;
    rsp := 'OK';
    xpos := SnPosCarga;

    if TPosCarga[xpos].SwDesHabilitado then begin
      rsp := 'Posicion Deshabilitada';
      exit;
    end;

    if not (TPosCarga[xpos].estatus in [1, 5, 7, 9]) then begin
      rsp := 'Posicion no Disponible';
      exit;
    end;

    if TPosCarga[xpos].estatus = 9 then
      EnviaComandoSrv('STOP', IntToStr(xpos));

    if TPosCarga[xpos].FinVenta = 1 then
      efv := '2'
    else
      efv := '1';

    { Determinar combustible para el preset }
    xprodauto := '';

    if xcomb > 0 then
      xprodauto := IntToStr(xcomb)
    else
      xprodauto := '0';

    if not swlitros then begin
      { PRESET EN IMPORTE }
      if TPosCarga[xpos].swFlujoVehic then
        xprodauto := xprodauto; // mantener

      if SnImporte > 99999 then SnImporte := 99999;

      EnviaComandoSrv('AUTHORIZE',
        IntToStr(xpos) + '|' +                   // 1: posCarga
        xprodauto + '|' +                        // 2: comb
        FormatFloat('0.00', SnImporte) + '|' +   // 3: cantidad (OCC - Importe)
        '0|' +                                   // 4: cantidad (OCL - empty/0)
        efv);                                    // 5: finv

      TPosCarga[xpos].swFlujoVehic := False;
      TPosCarga[xpos].ImportePreset := SnImporte;
      TPosCarga[xpos].MontoPreset := '$ ' + FormatoMoneda(SnImporte);

    end
    else begin
      { PRESET EN LITROS }
      EnviaComandoSrv('AUTHORIZE',
        IntToStr(xpos) + '|' +                   // 1: posCarga
        xprodauto + '|' +                        // 2: comb
        '0|' +                                   // 3: cantidad (OCC - empty/0)
        FormatFloat('0.000', SnLitros) + '|' +   // 4: cantidad (OCL - Litros)
        efv);                                    // 5: finv

      TPosCarga[xpos].ImportePreset := SnLitros;
      TPosCarga[xpos].MontoPreset := FormatoMoneda(SnLitros) + ' lts';
    end;

    TPosCarga[xpos].HoraOcc := now;
    TPosCarga[xpos].SwPreset := true;

    if not swlitros then
      DMCONS.AgregaLog('Importe Preset: ' + Floattostr(SnImporte));

  except
    on e: Exception do
      DMCONS.AgregaLog('ERROR PRESET 3: ' + e.Message);
  end;
end;

procedure TFDISBRIDGE.EnviaPreset(var rsp: string; xcomb: integer);
begin
  EnviaPreset3(rsp, xcomb);
end;

{==============================================================================
  Timer1Timer - Timer principal simplificado
  =============================================================================
  Ya NO hace polling activo. servicio de dispensarios inicia la comunicacion.
  Solo monitorea la conexion y ejecuta tareas periodicas.
==============================================================================}

procedure TFDISBRIDGE.Timer1Timer(Sender: TObject);
var i: integer;
const tmSegundo = 1 / 86400;
      tmMinuto = 60 / 86400;
begin
  try
    { 1. Verificar ServerSocket activo }
    if not SSocketPDisp.Active then begin
      try
        SSocketPDisp.Port := PuertoSrv;
        SSocketPDisp.Active := True;
        DMCONS.AgregaLog('ServerSocket Srv reactivado');
      except
        on E: Exception do begin
          StaticText17.Caption := 'Error ServerSocket: ' + E.Message;
          StaticText17.Visible := True;
        end;
      end;
    end;

    { 1b. Seguridad: si INITIALIZE fue exitoso pero RUN no responde
      en 15 segundos, reiniciar el proceso completo }
    if SrvConectado and SrvInicializado and (not SrvEnEjecucion)
       and (HoraInicializado > 0)
       and (SecondsBetween(Now, HoraInicializado) > 15) then begin
      DMCONS.AgregaLog('ALERTA: RUN no respondio en 15s - Reiniciando INITIALIZE');
      SrvInicializado := False;
      SrvEnEjecucion := False;
      HoraInicializado := 0;
      ListaPeticiones.Clear;
      FolioSecuencia := 0;
    end;

    { 2. Detectar perdida de comunicacion }
    if (horaActJSON > 0) and (SecondsBetween(Now, horaActJSON) > 5) then begin
      inc(ContadorAlarma);
      if ContadorAlarma = 3 then
        Memo2.Lines.Add('Perdida de comunicacion el: ' + FechaHoraPaq(Now));
      if ContadorAlarma >= 10 then begin
        if not StaticText17.Visible then Beep;
        StaticText17.Visible := not StaticText17.Visible;
        if ContadorAlarma = 10 then
          DMCONS.RegistraBitacora3(1, 'Desconexion de Dispositivo', 'Error Comunicacion Dispensarios', 'U');
      end
      else StaticText17.Visible := false;
    end
    else begin
      ContadorAlarma := 0;
      StaticText17.Visible := false;
    end;

    { 3. Auto-guardado de logs }
    if CheckBox1.Checked then begin
      if (Now - HoraLog) > 10 * tmMinuto then begin
        HoraLog := Now;
        Button1.Click;
        Button3.Click;
      end;
    end;

    if not StaticText9.Visible then begin
      StaticText9.Caption := 'Puerto Srv: ' + IntToStr(PuertoSrv);
      StaticText9.Visible := true;
    end;

    { 4. Cierre programado }
    if SwReset then begin
      inc(ContReset);
      if ContReset = 90 then begin
        DMCONS.DBGASCON.Connected := false;
        swcerrar := true;
        FDISBRIDGE.Close;
      end;
    end;
    if SwCerrar then Close;

    { 5. Lectura de registro }
    try lee_registro; except end;

    { 6. Refrescar conexion BD }
    if (Now - DMCONS.FechaHoraRefLog) > tmMinuto then
      DMCONS.RefrescaConexion;

    { 7. Chequeo de cambio de precios }
    if (not swreset) and ((Now - DMCONS.FechaHoraPrecio) > 12 * tmSegundo) then begin
      DMCONS.FechaHoraPrecio := Now;
      with DMCONS do if AplicarPrecios then begin
        for i := 1 to MaxComb do with TabComb[i] do if Activo then begin
          if AplicaPrecio then begin
            PrecioCombActual := i;
            EnviaComandoSrv('PRICES', IntToStr(i) + '|' + FormatFloat('0.00', Precio));
          end;
        end;
        CargaPreciosFH(Now, true);
        DespliegaPrecios;
        DBGrid3.Refresh;
      end;
    end;
  finally
    if NotificationIcon1.Tag = 0 then begin
      NotificationIcon1.Tag := 1;
      FDISMENU.Visible := false;
      FDISBRIDGE.Visible := false;
      NotificationIcon1.Show;
    end;
  end;
end;

{==============================================================================
  DespliegaPosCarga - Visualizacion (conservada del original)
==============================================================================}

procedure TFDISBRIDGE.DespliegaPosCarga(xpos: integer; swforza: boolean);
var i, ii, xp, rango, posi, posf, xcomb, xc, apunt, xmang: integer;
    xnombre: string;
    xdiflts: real;
begin
  apunt := 1;
  try
    rango := ListBox1.ItemIndex + 1;
    if rango = 0 then rango := 1;
    posi := rango * 4 - 3;
    posf := rango * 4;
    with TPosCarga[xpos], FDISBRIDGE do begin
      xcomb := CombustibleEnPosicion(xpos, PosActual);
      if xcomb in [1..MaxComb] then
        xnombre := DMCONS.TabComb[xcomb].Nombre;
      if xpos in [posi..posf] then begin
        ii := xpos - posi + 1;
        TStaticText(FindComponent('StaticText' + IntToStr(ii))).Caption := IntToClaveNum(xpos, 2);
        if not SwDesHabilitado then begin
          case ii of
            1: panelPC1.Caption := TPosCarga[xpos].descestat;
            2: panelPC2.Caption := TPosCarga[xpos].descestat;
            3: panelPC3.Caption := TPosCarga[xpos].descestat;
            4: panelPC4.Caption := TPosCarga[xpos].descestat;
          end;
          case estatus of
            1, 7: TPanel(FindComponent('panelPC' + IntToStr(ii))).color := ClRed;
            4, 5, 9: TPanel(FindComponent('panelPC' + IntToStr(ii))).color := ClYellow;
            2: TPanel(FindComponent('panelPC' + IntToStr(ii))).color := ClLime;
            3: TPanel(FindComponent('panelPC' + IntToStr(ii))).color := ClBlue;
            8: TPanel(FindComponent('panelPC' + IntToStr(ii))).color := clPurple;
            else TPanel(FindComponent('panelPC' + IntToStr(ii))).color := ClWhite;
          end;
        end
        else begin
          TPanel(FindComponent('panelPC' + IntToStr(ii))).Caption := 'Deshabilitado';
          TPanel(FindComponent('panelPC' + IntToStr(ii))).color := ClWhite;
        end;
        if (not swforza) and (TListBox(FindComponent('ListBoxPC' + IntToStr(ii))).Items.Count > 0) then exit;
        TListBox(FindComponent('ListBoxPC' + IntToStr(ii))).Items.Clear;
        TListBox(FindComponent('ListBoxPC' + IntToStr(ii))).Items.Add('$ ' + FormatFloat('###,##0.00', importe) + ' Pesos');
        if precio > 0 then begin
          TListBox(FindComponent('ListBoxPC' + IntToStr(ii))).Items.Add(FormatFloat('##,##0.00', precio) + ' $/Lts');
          TListBox(FindComponent('ListBoxPC' + IntToStr(ii))).Items.Add('');
          TListBox(FindComponent('ListBoxPC' + IntToStr(ii))).Items.Add(FormatFloat('##,##0.000', volumen) + ' Litros');
          TListBox(FindComponent('ListBoxPC' + IntToStr(ii))).Items.Add(xnombre);
          TListBox(FindComponent('ListBoxPC' + IntToStr(ii))).Items.Add(Mensaje);
        end
        else begin
          for xp := 1 to 5 do
            TListBox(FindComponent('ListBoxPC' + IntToStr(ii))).Items.Add('');
        end;
        for xp := 1 to NoComb do
          TListBox(FindComponent('ListBoxPC' + IntToStr(ii))).Items.Add(
            FormatFloat('##,###,##0.00', totallitros[xp]) + ' ' + copy(DMCONS.TabComb[TComb[xp]].Nombre, 1, 3));
        if SwPreset then
          TListBox(FindComponent('ListBoxPC' + IntToStr(ii))).Items.Add('PRESET ' + MontoPreset + ' >>' + inttostr(finventa));
      end;
    end;
    apunt := 2;
    { Refrescar ListView }
    for i := 1 to MaxPosCarga do with TPosCarga[i] do begin
      if ModoOpera = 'Normal' then begin
        case estatus of
          1, 7: ListView1.Items[i - 1].ImageIndex := 1;
          2: ListView1.Items[i - 1].ImageIndex := 2;
          3: ListView1.Items[i - 1].ImageIndex := 9;
          5, 9: ListView1.Items[i - 1].ImageIndex := 3;
          else ListView1.Items[i - 1].ImageIndex := 0;
        end;
      end
      else begin
        case estatus of
          1, 7: ListView1.Items[i - 1].ImageIndex := 4;
          2: ListView1.Items[i - 1].ImageIndex := 5;
          3: ListView1.Items[i - 1].ImageIndex := 10;
          5, 9: ListView1.Items[i - 1].ImageIndex := 6;
          else ListView1.Items[i - 1].ImageIndex := 0;
        end;
      end;
      apunt := 3;
      ListView1.Items[i - 1].Caption := IntToClaveNum(i, 2) + '  ' + LlenaStr(FormatFloat('##,##0.00', importe), 'D', 10, ' ');
      { Registro de venta al detectar SwDesp }
      if SwDesp then with DMCONS do begin
        SwDesp := false;
        if (volumen > 0.01) and (PosActual in [1..MCxP]) then begin
          SwAutorizada := false;
          HoraFinv := Now;
          TotsFinv := True;
          try
            try
              swcierrabd := true;
              T_MoviIb.Active := true;
              T_MoviIb.Insert;
              T_MoviIbFecha.AsDateTime := date;
              T_MoviIbHora.AsDateTime := now;
              T_MoviIbHoraStr.AsString := HoraPaq(T_MoviIbHora.AsDateTime);
              T_MoviIbPosCarga.AsInteger := i;
              xcomb := CombustibleEnPosicion(i, PosActual);
              xmang := TMang[PosActual];
              if TabComb[xcomb].Agruparcon > 0 then begin
                T_MoviIbKilometraje.asinteger := xmang;
                xc := TabComb[xcomb].Agruparcon;
                if TabComb[xc].Activo then xcomb := xc;
              end;
              T_MoviIbCombustible.AsInteger := xcomb;
              T_MoviIbVolumen.AsFloat := AjustaFloat(Volumen, 3);
              T_MoviIbImporte.AsFloat := AjustaFloat(Importe, 2);
              T_MoviIbPrecio.AsFloat := Ajustafloat(Precio, 2);
              T_MoviIbTotal01.AsFloat := AjustaFloat(TotalLitros[1], 3);
              T_MoviIbTotal02.AsFloat := AjustaFloat(TotalLitros[2], 3);
              T_MoviIbTotal03.AsFloat := AjustaFloat(TotalLitros[3], 3);
              T_MoviIbTotal04.AsFloat := AjustaFloat(TotalLitros[4], 3);
              xdiflts := 0;
              for ii := 1 to 4 do begin
                xdiflts := xdiflts + (TotalLitros[ii] - TotalLitrosAnt[ii]);
                TotalLitrosAnt[ii] := TotalLitros[ii];
              end;
              if xdiflts = 0 then begin
                Button1Click(nil);
                Button3Click(nil);
              end;
              T_MoviIbTag.AsInteger := 0;
              T_MoviIbManguera.AsInteger := xmang;
              T_MoviIbTipoPago.asinteger := TipoPago;
              T_MoviIbBoucher.Asstring := '';
              T_MoviIbCuponImpreso.AsString := 'No';
              T_MoviIbReferenciaBitacora.AsInteger := 0;
              T_MoviIbGasId.AsInteger := Random(1000000);
              TipoPago := 0;
              if swprec then begin
                for xp := 1 to NoComb do if TComb[xp] = xcomb then
                  dmcons.ActualizaTotalesPrecio(i, xp, volumen);
                swprec := false;
              end;
              T_MoviIb.post;
              if ModoOpera = 'Normal' then SwPreset := false;
              if (lcLicTemporal) and (date > lcLicVence) then begin
                MensajeErr('Licencia vencida. Llame a su distribuidor');
                swcerrar := true;
                FDISBRIDGE.Close;
              end;
            except
              on e: Exception do AgregaLog('Error al guardar venta: ' + e.Message);
            end;
          finally
            T_MoviIb.Active := false;
          end;
        end;
      end;
    end;
  except
    with DMCONS do begin
      if (T_MoviIb.State in [dsInsert, dsEdit]) then T_MoviIb.Cancel;
    end;
  end;
end;

{==============================================================================
  EjecutaCorte (funcion libre conservada del original)
==============================================================================}

function EjecutaCorte: string;
var rsp, Descrsp: string;
    xpos, xpr, xcomb: integer;
begin
  with DMCONS do begin
    rsp := 'OK';
    try
      SwCorteOk := true;
      if not SwCorteParcial then begin
        for xpos := 1 to MaxPosCarga do
          if ((TPosCarga[xpos].isla = xIslaCorte) or (xIslaCorte = 0)) and (TPosCarga[xpos].estatus in [2, 3]) then begin
            SwCorteOk := false;
            DescRsp := 'Existen dispensarios cargando';
          end;
      end;
      if SwCorteOk then begin
        T_Corte.Active := true;
        try
          for xpos := 1 to MaxPosCarga do with TPosCarga[xpos] do begin
            if (TPosCarga[xpos].isla = xIslaCorte) or (xIslaCorte = 0) then begin
              for xpr := 1 to NoComb do begin
                xcomb := TComb[xpr];
                if xcomb > 0 then begin
                  if T_Corte.Locate('Fecha;Turno;Isla;PosCarga;Combustible',
                     VarArrayOf([xFechaCorte, xTurnoCorte, TPosCarga[xpos].isla, xpos, xcomb]), []) then
                    T_Corte.Delete;
                  T_Corte.Insert;
                  T_CorteFecha.AsDateTime := xFechaCorte;
                  T_CorteTurno.AsInteger := xTurnoCorte;
                  T_CorteIsla.AsInteger := TPosCarga[xpos].isla;
                  T_CortePosCarga.AsInteger := xpos;
                  T_CorteCombustible.AsInteger := xcomb;
                  T_CorteContadorLitros.AsFloat := AjustaFloat(TotalLitros[xpr], 3);
                  T_CorteContadorImporte.AsFloat := 0;
                  T_Corte.Post;
                end;
              end;
            end;
          end;
        finally
          T_Corte.Active := false;
        end;
      end;
    except
      on e: Exception do begin
        rsp := 'Error Corte: ' + e.Message;
        AgregaLog(rsp);
      end;
    end;
    Result := rsp;
  end;
end;

{==============================================================================
  Funciones de utilidad conservadas del original
==============================================================================}

function TFDISBRIDGE.CombustibleEnPosicion(xpos, xposcarga: integer): integer;
var i: integer;
begin
  with TPosCarga[xpos] do begin
    result := 0;
    for i := 1 to NoComb do
      if TPosx[i] = xposcarga then result := TComb[i];
  end;
end;

function TFDISBRIDGE.PosicionDeCombustible(xpos, xcomb: integer): integer;
var i: integer;
begin
  with TPosCarga[xpos] do begin
    result := 0;
    if xcomb > 0 then begin
      for i := 1 to NoComb do
        if TComb[i] = xcomb then result := TPosx[i];
    end
    else result := 1;
  end;
end;

procedure TFDISBRIDGE.registro(valor: integer; variable: string);
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create(KEY_WRITE);
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    if Reg.OpenKey('\SOFTWARE\IMAGEN\VOL\DISP', True) then
      Reg.WriteInteger(variable, Valor);
  finally
    Reg.CloseKey;
    Reg.Free;
  end;
end;

procedure TFDISBRIDGE.lee_registro;
var
  Reg: TRegistry;
  estado: integer;
begin
  with DMCONS do begin
    Reg := TRegistry.Create(KEY_READ);
    try
      Reg.RootKey := HKEY_LOCAL_MACHINE;
      estado := 0;
      try
        if Reg.OpenKey('\SOFTWARE\IMAGEN\VOL\DISP', True) then
          Estado := Reg.ReadInteger('Estado');
      except end;
      if Estado = 1 then begin
        Self.Visible := true;
        Self.WindowState := wsMaximized;
        Self.BringToFront;
        registro(0, 'Estado');
      end;
    finally
      Reg.CloseKey;
      Reg.Free;
      registro(0, 'Estado');
    end;
  end;
end;

procedure TFDISBRIDGE.ListBox1Click(Sender: TObject);
var xp: integer;
begin
  { Limpiar consola visual }
  StaticText1.Caption := '  ';
  StaticText2.Caption := '  ';
  StaticText3.Caption := '  ';
  StaticText4.Caption := '  ';
  ListBoxPC1.Items.Clear;
  ListBoxPC2.Items.Clear;
  ListBoxPC3.Items.Clear;
  ListBoxPC4.Items.Clear;
  panelPC1.color := ClWhite; panelPC2.color := ClWhite;
  panelPC3.color := ClWhite; panelPC4.color := ClWhite;
  panelPC1.Caption := ''; panelPC2.Caption := '';
  panelPC3.Caption := ''; panelPC4.Caption := '';
  for xp := 1 to MaxPosCarga do
    DespliegaPosCarga(xp, true);
end;

procedure TFDISBRIDGE.Restaurar1Click(Sender: TObject);
begin
  FDISBRIDGE.Visible := true;
end;

procedure TFDISBRIDGE.NotificationIcon1DblClick(Sender: TObject);
begin
  Restaurar1Click(Sender);
end;

procedure TFDISBRIDGE.BitBtn3Click(Sender: TObject);
begin
  Visible := false;
  NotificationIcon1.Show;
end;

procedure TFDISBRIDGE.Button1Click(Sender: TObject);
begin
  DMCONS.AgregaLog('Version: UDISBRIDGE_V2_Direct');
  DMCONS.ListaLog.SaveToFile('\ImagenCo\Log' + FiltraStrNum(FechaHoraToStr(Now)) + '.Txt');
end;

procedure TFDISBRIDGE.Button3Click(Sender: TObject);
begin
  DMCONS.ListaLogCmnd.SaveToFile('\ImagenCo\LogCmnd' + FiltraStrNum(FechaHoraToStr(Now)) + '.Txt');
end;


procedure TFDISBRIDGE.Button2Click(Sender: TObject);
begin
  EnviaComandoSrv('TRACE', '');
end;

end.
