unit ULIBDATABASE;


interface
uses Variants,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, DBCtrls, ComCtrls, ExtCtrls, Grids, DBGrids, Menus,
  Mask,db,dbtables, ULibGral, ULibLicencias, Printers;

const
       idSuper = 'Administrador';

       MonedaNac ='MN';

type   TDerecho  =(drAccesar,drNuevo,drEliminar,drModificar,drImprimir,drDepurar,drEspecial);
       TDerechos = set of TDerecho;

       TDocAccion =(accAccesar,accNuevo,accEliminar,accModificar,accImprimir,accNada,accDepurar,accEspecial);
       TDocAcciones = set of TDocAccion;

       TTipoDere = (tdTabla,tdCatalogo,tdDocumento,tdOtros);
       TTipoDeres= set of TTipoDere;

       TEstadoFormaDocum = (efInactiva,efAlta,efModifica,efError);

       TModoCargaVar = (cvTodas,cvNinguna,cvSistemaActual);

type TSaldoCnt = record
       SaldoIni,
       CargosPer,
       AbonosPer,
       SaldoFin    :double;
       TipoCuenta  :char;
     end;

      TSaldoBnc = record
       SaldoIni,
       CargosPer,
       AbonosPer,
       SaldoFin    :double;
     end;

     TSaldoCxp = record
       SaldoIni,
       CargosPer,
       AbonosPer,
       SaldoFin    :double;
     end;

     TSaldoRgs = record
       SaldoIni,
       CargosPer,
       AbonosPer,
       SaldoFin    :double;
     end;

     TSaldoCxc = record
       SaldoIni,
       CargosPer,
       AbonosPer,
       SaldoFin    :double;
     end;

     TSaldoAcf = record
       SaldoIni,
       AbonosPer,
       SaldoFin    :double;
     end;

     TSaldoInv = record
       SaldoIniUni,
       SaldoIniImp,
       EntradasUni,
       EntradasImp,
       SalidasUni,
       SalidasImp,
       SaldoFinUni,
       SaldoFinImp :double;
     end;


var drTiempo           :String[10];
    SwEstadoError,
    SwDocumActivo,
    SwCalcFields,
    SwEnlaceActivo     :boolean;
    SwDocumActivoR,
    SwCalcFieldsR,
    SwEnlaceActivoR    :array[1..10] of boolean;
    SwApunt            :byte;
    UsuarioActivoLib,
    PasswordSuper      :string;
    EjercicioActivo    :LongInt;
    ConexionActiva     :longint;
    LstSistx,
    LstDocu,
    LstCata            :TStrings;
    DcAccion    :TDocAccion;
    IdSist,
    IdSubSist,
    IdCata,
    IdDocu       :string[4];
    idDocuName   :string[30];
    IdSistNombre :string;
    AuCont       :word;
    // Variables Iniciales IMAGENCO.INI
    VsFechaEnRep,
    VsLocalDir,
    VsDirPlantillas,
    VSUtilDir,
    VsDataBaseDir,
    VsHoraRespaldo,
    VsDataBaseUsu,
    VsDataBaseClave,
    VsUsuarioDef,
    VsAliasDef,
    VsPCName      :string;
    VsPermiteModoRespaldo,
    VsAccesoRemoto:boolean;
    VsImagenCo    :string;
    VsImpreTexto  :string;
    // Variables Globales
    VgBitacoraActiva:boolean;
    VgFecha      :TDateTime;
    VgFechaIni   :TDateTime;
    VgFechaFin   :TDateTime;
    VgMes        :TMes;
    VgMesIni     :TMes;
    VgMesFin     :TMes;
    VgClaveCtsb  :longint;
    VgOk,
    VgSwAvance   :boolean;
    VgString,
    VgString3,
    VgString2    :string;
    VgLongInt    :Longint;
    VgChar       :char;

    // Variables de Sistemas
    VarGenIdSucursal     :string[40];
    VarGenAbrirMesSiguiente:string[2];
    VarGenFechaHoraRepos :string[2];
    VarGenCambiaPolizaAutom :string[2];
    VarAcfConceDeprec    :string[40];
    VarAcfConceGasto     :string[40];
    VarAcfControlVehiculos:string[2];
    VarAcfTipoGastoVehiculos:string[2];
    VarAcfDepreciarMesBaja:string[2];
    VarCntReviso         :string[30];
    VarCntAutorizo       :string[30];
    VarCntConceptoVacio  :string[2];
    VarCntAutoDepuraPoli :string[2];
    VarCntDocsModiPoli   :string;
    VarCntCuentaPerdidaCambiaria:string[16];
    VarCntCuentaGananciaCambiaria:string[16];
    VarCntConceptoDetallePoli:string[2];
    VarBncAbonoCuenta    :string[2];
    VarBncImpoAbonoCuenta:longint;
    VarBncConceptoBenef  :string[2];
    VarBncFolioPolizaACheque:String[2];
    VarBncOtroBenef      :string[2];
    VarBncEntregadoDefault:string[2];
    VarBncFechaIvaPagado :TDateTime;
    VarBncCuentaDefault  :longint;
    VarBncManejaFlujo    :string[2];
    VarBncIngresoFlujoDefault :string[3];
    VarBncEgresoFlujoDefault  :string[3];
    VarBncIngresoFlujoTraspaso :string[3];
    VarBncEgresoFlujoTraspaso  :string[3];
    VarBncTipoChequeEnPoliza    :string[2];
    VarBncRevisoCncl         :string[30];
    VarBncAutorizoCncl       :string[30];
    VarCxpPlazo1         :word;
    VarCxpPlazo2         :word;
    VarCxpPlazo3         :word;
    VarCxpMayorProveed   :string[40];
    VarCxpMayorAnticipos :string[40];
    VarCxpEysCarProv     :string[3];
    VarCxpEysAboProv     :string[3];
    VarCxpEysAboBanco    :string[3];
    VarCxpEysIva         :string[3];
    VarCxpPagoMayorDeuda :string[2];
    VarCxpIvaCeroEnRecepcion:string[2];
    VarCxpDiaPagoFacturas :string[10];
    VarCxpDiaRecibeFacturas :string[10];
    VarIvaClaveBanco     :string[3];
    VarIvaSucursalBanco  :string[5];
    VarIvaCuentaBanco    :string[18];
    VarIvaLocalidadBanco :string[20];
    VarIvaClaveImporta   :string[2];
    VarIvaValidaFolio    :string[2];
    VarIvaPolizaIvaReten :string[2];
    VarIvaNuevoCalculoIva:string[2];
    VarRgsAutomatizarRgs     :string[2];
    VarRgsAutomatizarPagoCxp :string[2];
    VarRgsClaveEntradaDefault:string[3];
    VarRgsClaveSalidaDefault :string[3];
    VarPreTipoPresupuesto:string[12];
    VarCxcCuentaClientes :string[20];
    VarCxcModoContabilizar:string[10];
    VarCxcDestinoDefault :string[5];
    VarCxcPlazo1         :word;
    VarCxcPlazo2         :word;
    VarCxcPlazo3         :word;
    VarCxcTipoPolizaCobranza:string[2];
    VarCxcDiasSinPago    :word;
    VarCxcDiasVencido    :word;
    ImgDemo              :boolean;
    ListPrinter          :TStrings;
    PredPrinter1         :integer;
    NomPredPrinter       :string;
    PrinterActiva        :boolean;
    MesActivo            :Tmes;
    MaxLicFree : word = 100;


procedure IniciaUpdates(DBGEN:TDataBase;T_Master:TDBDataSet);

procedure AplicaUpdates(DBGEN:TDataBase;T_Master:TDBDataSet);
procedure CancelaUpdates(DBGEN:TDataBase;T_Master:TDBDataSet);
procedure RefrescaDataBase(DBGEN:TDataBase);
procedure SetEditOrInsert(T_Para:TDBDataSet);
function AccionToStr(xacc:TDocAccion):string;
procedure InicializaTemp(var T_Temp:TTable);
procedure EliminaTemp(var T_Temp:TTable);
procedure ApagaSwitchs(xstr:string);
procedure RecuperaSwitchs;
function ClaveEysValida(xclave:string):boolean;
function ClaveFlujoValida(xclave:string):boolean;
function LocalizaTabla(var Tabla:TTable;const CamposLlave:string;const 
ValorCampos:Variant):boolean;
function Locate2(var Tabla:TTable;const KeyFields: string; const KeyValues: Variant; 
Options: TLocateOptions): Boolean;
function Locate2Q(var Query:TQuery;const KeyFields: string; const KeyValues: Variant; 
Options: TLocateOptions): Boolean;
function LocalizaQuery(var Query:TQuery;const KeyFields: string; const KeyValues: Variant): 
Boolean;
procedure AbreQuery(var Query:TQuery);
procedure RefrescaQuery(var Query:TQuery);
function BuscaQuery(var Query:TQuery;const CamposLlave:string;const 
ValorCampos:Variant):boolean;
function MesIniEjercicio(MesMin:Tmes):TMes;
function MesFinEjercicio:TMes;
procedure PonEjercicioActivo(xano:longint);
procedure PonFechaTrabajo(xfecha:TDateTime);
function FechaTrabajo:TDateTime;
function FechaTrabajoActiva:Boolean;
function MesTrabajo:TMes;
function AnoTrabajo:LongInt;
procedure IniciaAmbiente; // Inicia Impresoras, Nombre de PC etc.
function LClaveDocu(idDocu:string):word;
function LClaveCata(idCata:string):word;

implementation

procedure ValidaLicenciaDia;
begin
  if ExisteMDogId(idMdogActivo) then begin
    if SerieKeyMdog<>0 then begin
      if SerieMdog(idMdogActivo)<>SerieKeyMdog then begin
        MensajeErr('Error L-04: Llave '+IntToClaveNum(SerieKeyMdog,5)+' fué cambiada.');
        Application.Terminate;
      end;
    end;
    exit;
  end;
  if MaxLicFree>0 then
    dec(MaxLicFree)
  else begin
    if not LicenciaDiaOk(idClaveDia) then begin
      MensajeErr('Error L-02: Licencia erronea: Llame a su Distribuidor.');
      MensajeErr('Empresa: '+idEmpresa+'   Clave Dia: '+idClaveDia+'   Fecha de Trabajo: '+FechaPaq(FechaTrabajoAct));
      Application.Terminate;
    end;
    if UsuarioActivoLib='' then begin
      MensajeErr('Error L-05: No se a registrado el Usuario.');
      Application.Terminate;
    end;
  end;
end;

procedure RefrescaQuery(var Query:TQuery);
begin
  ValidaLicenciaDia;
  if Query.Active then
    Query.Close;
  Query.Prepare;
  Query.Active:=true;
end;

procedure AbreQuery(var Query:TQuery);
begin
  ValidaLicenciaDia;
  if not Query.Active then begin
    Query.Prepare;
    Query.Active:=true;
  end;
end;

function LocalizaQuery(var Query:TQuery;const KeyFields: string; const KeyValues: Variant): 
Boolean;
begin
  ValidaLicenciaDia;
  if not Query.Active then begin
    Query.prepare;
    Query.Active:=true;
  end;
  result:=Query.Locate(KeyFields,KeyValues,[]);
end;

function Locate2(var Tabla:TTable;const KeyFields: string; const KeyValues: Variant; 
Options: TLocateOptions): Boolean;
begin
  ValidaLicenciaDia;
  if not Tabla.Active then
    Tabla.Active:=true;
  result:=Tabla.Locate(KeyFields,KeyValues,Options);
end;

function Locate2Q(var Query:TQuery;const KeyFields: string; const KeyValues: Variant; 
Options: TLocateOptions): Boolean;
begin
  ValidaLicenciaDia;
  if not Query.Active then begin
    Query.Prepare;
    Query.Active:=true;
  end;
  result:=Query.Locate(KeyFields,KeyValues,Options);
end;

function LocalizaTabla(var Tabla:TTable;const CamposLlave:string;const 
ValorCampos:Variant):boolean;
var tcampo       :array[1..6] of string;
    nc,i         :word;
begin
  ValidaLicenciaDia;
  result:=false;
  if Tabla.MasterFields<>'' then begin
    result:=Locate2(Tabla,CamposLlave,ValorCampos,[]);
    exit;
  end;
  nc:=0;
  for i:=1 to 6 do begin
    tcampo[i]:=ExtraeElemStrSep(CamposLlave,i,';');
    if tcampo[i]<>'' then
      nc:=i;
  end;
  if not Tabla.Active then
    Tabla.Active:=true;
  try
    Tabla.SetKey;
    for i:=1 to nc do begin
      if nc=1 then begin
        if (VarType(ValorCampos)=varOleStr) or (VarType(ValorCampos)=varString) then
          Tabla.FieldByName(tcampo[i]).asstring:=ValorCampos
        else if VarType(ValorCampos)=varDate then
          Tabla.FieldByName(tcampo[i]).asdatetime:=ValorCampos
        else
          Tabla.FieldByName(tcampo[i]).asinteger:=ValorCampos;
      end
      else begin
        if (VarType(ValorCampos[i-1])=varOleStr) or (VarType(ValorCampos[i-1])=varString) then
          Tabla.FieldByName(tcampo[i]).asstring:=ValorCampos[i-1]
        else if VarType(ValorCampos[i-1])=varDate then
          Tabla.FieldByName(tcampo[i]).asdatetime:=ValorCampos[i-1]
        else
          Tabla.FieldByName(tcampo[i]).asinteger:=ValorCampos[i-1];
      end;
    end;
    result:=Tabla.gotokey;
  except
    result:=Locate2(Tabla,CamposLlave,ValorCampos,[]);
  end;
end;

function BuscaQuery(var Query:TQuery;const CamposLlave:string;const 
ValorCampos:Variant):boolean;
var tcampo       :array[1..6] of string;
    nc,i         :word;
begin
  ValidaLicenciaDia;
  result:=false;
  nc:=0;
  for i:=1 to 6 do begin
    tcampo[i]:=ExtraeElemStrSep(CamposLlave,i,';');
    if tcampo[i]<>'' then
      nc:=i;
  end;
  Query.close;
  for i:=1 to nc do begin
    if nc=1 then begin
      if (VarType(ValorCampos)=varOleStr) or (VarType(ValorCampos)=varString) then
        Query.ParamByName(tcampo[i]).asstring:=ValorCampos
      else if VarType(ValorCampos)=varDate then
        Query.ParamByName(tcampo[i]).asdatetime:=ValorCampos
      else
        Query.ParamByName(tcampo[i]).asinteger:=ValorCampos;
    end
    else begin
      if (VarType(ValorCampos[i-1])=varOleStr) or (VarType(ValorCampos[i-1])=varString) then
        Query.ParamByName(tcampo[i]).asstring:=ValorCampos[i-1]
      else if VarType(ValorCampos[i-1])=varDate then
        Query.ParamByName(tcampo[i]).asdatetime:=ValorCampos[i-1]
      else
        Query.ParamByName(tcampo[i]).asinteger:=ValorCampos[i-1];
    end;
  end;
  Query.Prepare;
  Query.open;
  result:=(not Query.IsEmpty);
end;

procedure IniciaUpdates(DBGEN:TDataBase;T_Master:TDBDataSet);
begin
  ValidaLicenciaDia;
  if not T_Master.CachedUpdates then begin
    if not DBGEN.InTransaction then
      DBGEN.StartTransaction;
  end
  else
    CancelaUpdates(DBGEN,T_Master);
end;

procedure AplicaUpdates(DBGEN:TDataBase;T_Master:TDBDataSet);
var i:word;
begin
  ValidaLicenciaDia;
  if not T_Master.CachedUpdates then begin
    if DBGEN.InTransaction then
      DBGEN.Commit;
  end
  else with DBGEN do begin
    ApagaSwitchs('SwCalcFields');
    try
      StartTransaction;
      try
        // Aplico demas tablas
        for i:=0 to DataSetCount-1 do begin
          if DataSets[i]<>T_Master then
            if DataSets[i].CachedUpdates then
              if DataSets[i].UpdatesPending then
                DataSets[i].ApplyUpdates;
        end;

        if T_Master<>nil then begin
          //if T_Master.State in [dsInsert,dsEdit] then
            //T_Master.Post;
          if T_Master.UpdatesPending then
            T_Master.ApplyUpdates;
        end;

        Commit;

        // CommitUpdates a todas las tablas
        try
          for i:=0 to DataSetCount-1 do
            if DataSets[i].CachedUpdates then
              DataSets[i].CommitUpdates;
        except
        end;
      except
        Rollback;
        CancelaUpdates(DBGEN,T_Master);
        raise;
      end;
    finally
      RecuperaSwitchs;
    end;
  end;
end;

procedure CancelaUpdates(DBGEN:TDataBase;T_Master:TDBDataSet);
var i:word;
begin
  ValidaLicenciaDia;
  if not T_Master.CachedUpdates then begin
    if DBGEN.InTransaction then
      DBGEN.Rollback;
  end
  else with DBGEN do begin
    for i:=0 to DataSetCount-1 do
      if DataSets[i].CachedUpdates then
        if DataSets[i].UpdatesPending then
          DataSets[i].CancelUpdates;
  end;
end;

procedure RefrescaDataBase(DBGEN:TDataBase);
var i:integer;
begin
  ValidaLicenciaDia;
  with DBGEN do begin
    if DataSetCount=0 then
      exit;
    for i:=0 to DataSetCount-1 do begin
      if DataSets[i].Active then begin
        try
          if DataSets[i].CanModify then
            DataSets[i].Refresh;
        except
        end;
      end;
    end;
  end;
end;

procedure SetEditOrInsert(T_Para:TDBDataSet);
begin
  ValidaLicenciaDia;
  if not (T_Para.state in [dsEdit,dsInsert]) then begin
    try
      T_Para.Edit;
    except
      T_Para.Insert;
    end;
  end;
end;

function AccionToStr(xacc:TDocAccion):string;
begin
  case xacc of
    accAccesar   :result:='Accesar';
    accNuevo     :result:='Nuevo';
    accEliminar  :result:='Cancelar';
    accDepurar   :result:='Depurar';
    accModificar :result:='Modificar';
    accImprimir  :result:='Imprimir';
    accEspecial  :result:='Especial';
    accNada      :result:='Nada';
  end;
end;

procedure InicializaTemp(var T_Temp:TTable);
begin
  ValidaLicenciaDia;
  T_Temp.DatabaseName :=VsLocalDir;
  T_Temp.TableType := ttParadox;
  T_Temp.TableName := 'TMP'+IntToClaveNum(ConexionActiva,6);
  T_Temp.Active:=false;
end;

procedure EliminaTemp(var T_Temp:TTable);
begin
  if T_Temp.Exists then begin
    T_Temp.Active:=false;
    T_Temp.DeleteTable;
  end;
end;

procedure ApagaSwitchs(xstr:string);
var i,max:word;
    ss:string;
begin
  if swapunt<10 then
    inc(swapunt)
  else swapunt:=1;
  SwDocumActivoR[swapunt]:=SwDocumActivo;
  SwCalcFieldsR[swapunt]:=SwCalcFields;
  SwEnlaceActivoR[swapunt]:=SwEnlaceActivo;
  max:=NoElemStrSep(xstr,';');
  for i:=1 to max do begin
    ss:=ExtraeElemStrSep(xstr,i,';');
    if StrMayuscIguales(ss,'SwDocumActivo') then
      SwDocumActivo:=false
    else if StrMayuscIguales(ss,'SwCalcFields') then
      SwCalcFields:=false
    else if StrMayuscIguales(ss,'SwEnlaceActivo') then
      SwEnlaceActivo:=false
    else if ss<>'' then
      raise Exception.Create('Switch Desconocido: '+ss);
  end;
end;

procedure RecuperaSwitchs;
begin
  if swapunt=0 then
    exit;
  SwDocumActivo    :=SwDocumActivoR[swapunt];
  SwCalcFields     :=SwCalcFieldsR[swapunt];
  SwEnlaceActivo   :=SwEnlaceActivoR[swapunt];
  dec(swapunt);
end;

function ClaveEysValida(xclave:string):boolean;
begin
  result:=(length(xclave)=3) and
        (xclave[1] in ['E','S'])and
        (xclave[2] in ['0'..'9'])and
        (xclave[3] in ['0'..'9']);
end;

function ClaveFlujoValida(xclave:string):boolean;
begin
  result:=(length(xclave)=3) and
        (xclave[1] in ['I','E'])and
        (xclave[2] in ['0'..'9'])and
        (xclave[3] in ['0'..'9']);
end;

function MesIniEjercicio(MesMin:Tmes):TMes;
var xmesi,xmesf:tmes;
begin
  xmesi:=IntToClaveNum(EjercicioActivo,4)+'01';
  xmesf:=IntToClaveNum(EjercicioActivo,4)+'12';
  if MesMin>xmesf then
    raise Exception.Create('No hay acceso a este ejercicio');
  if MesMin>xmesi then
    result:=MesMin
  else result:=xmesi;
end;

function MesFinEjercicio:TMes;
var xano,nmes:longint;
    xmes:tmes;
begin
  xano:=GetAnoFromFecha(FechaTrabajo);
  if EjercicioActivo<xano then
    xmes:=IntToClaveNum(EjercicioActivo,4)+'12'
  else begin
    nmes:=GetMesFromMes(mesactual);
    if VarGenAbrirMesSiguiente='Si' then
      if nmes<12 then
        inc(nmes);
    xmes:=IntToClaveNum(EjercicioActivo,4)+IntToClaveNum(nmes,2);
  end;
  result:=xmes;
end;

procedure PonEjercicioActivo(xano:longint);
begin
  ValidaLicenciaDia;
  if xano<>EjercicioActivo then begin
    EjercicioActivo:=xano;
    VgMesIni:=MesFinEjercicio;
    VgMesFin:=MesFinEjercicio;
    VgFechaIni:=MesDiaToFecha(VgMesIni,1);
    VgFechaFin:=MesDiaMaxToFecha(VgMesFin);
  end;
end;

procedure PonFechaTrabajo(xfecha:TDateTime);
begin
  if FechaTrabajoActiva then
    exit;
  FechaTrabajoAct:=xfecha;
  MaxLicFree:=0;
end;

function FechaTrabajo:TDateTime;
begin
  result:=FechaTrabajoAct;
end;

function FechaTrabajoActiva:Boolean;
begin
  result:=FechaTrabajoAct>0.01;
end;

function MesTrabajo:TMes;
begin
  result:=FechaToMes(FechaTrabajo);
end;

function AnoTrabajo:LongInt;
begin
  result:=GetAnoFromFecha(FechaTrabajo);
end;

procedure IniciaAmbiente; // Inicia Impresoras, Nombre de PC etc.
var lista:TStrings;
    ss,ss1,ss2,xalias:string;
    i:word;
begin
  xalias:=Mayusculas(ParamStr(1));
  if copy(xalias,1,4)='DEMO' then begin
    ModoDemo:=true;
    idDemo:=copy(xalias,1,7);
    VsLocalDir:='C:\ImagenCo'+idDemo+'\Tmp';
    VsUtilDir:='C:\ImagenCo'+idDemo+'\Util';
    VsDirPlantillas:='C:\ImagenCo'+idDemo+'\Plantillas';
    VsDataBaseDir:='C:\ImagenCo'+idDemo+'\Dbi';
  end
  else idDemo:='';
  // Variables Globales
  VgSwAvance:=true;
  VgFecha:=date;
  VgFechaIni:=date;
  SetDiaToFecha(1,VgFechaIni);
  VgFechaFin:=date;
  VgMesIni:=FechaToMes(VgFechaIni);
  VgMesFin:=FechaToMes(VgFechaFin);
  VgMes:=FechaToMes(VgFechaFin);

  // Otros
  ImgDemo:=false;
  //ListaStrTemp:=TStringList.Create;

  // Impresoras
  ListPrinter:=TStringList.Create;
  if printer.Printers.Count>0 then begin
    ListPrinter.Assign(Printer.Printers);
    PredPrinter1:=Printer.PrinterIndex;
    PrinterActiva:=true;
    NomPredPrinter:=ListPrinter[PredPrinter1];
  end
  else begin
    ListPrinter.Add('Impresora no Configurada');
    PredPrinter1:=0;
    PrinterActiva:=false;
  end;

  // Carga ImagenCo.Ini
  Lista:=TStringList.Create;
  try
    ss:=ExtraeElemStrSep(ParamStr(1),2,';');
    if ss='' then
      VsImagenCo:=DirectorioWindows+'\ImagenCo'+idDemo+'.Ini'
    else
      VsImagenCo:=ss+'\ImagenCo'+idDemo+'.Ini';
    if not FileExists(VsImagenCo) then begin
      Lista.Add('Computadora = ');
      Lista.Add('Usuario = Administrador');
      Lista.Add('LocalDir = '+VsImagenCo[1]+':\ImagenCo'+idDemo+'\Tmp');
      Lista.Add('DirPlantillas = '+VsImagenCo[1]+':\ImagenCo'+idDemo+'\Plantillas');
      Lista.Add('AliasDef = ');
      Lista.SaveToFile(VsImagenCo);
    end
    else Lista.LoadFromFile(VsImagenCo);
    VsPCName:='';
    VsUsuarioDef:='';
    for i:=0 to Lista.Count-1 do begin
      ss:=Lista.Strings[i];
      if NoElemStrSep(ss,'=')>=2 then begin
        ss1:=ExtraeElemStrSep(ss,1,'=');
        ss2:=ExtraeElemStrSep(ss,2,'=');
        if StrMayuscIguales(ss1,'Computadora['+idSist+']') then begin
          VsPCName:=ss2;
          (*
          if length(VsPcName)>20 then
            VsPcName:=copy(VsPcName,1,20);*)
        end;
        if StrMayuscIguales(ss1,'Computadora') then
          if VsPCName='' then
            VsPCName:=ss2;
        if StrMayuscIguales(ss1,'Usuario['+idSist+']') then
          VsUsuarioDef:=ss2;
        if StrMayuscIguales(ss1,'Usuario') then
          if VsUsuarioDef='' then
            VsUsuarioDef:=ss2;
        if StrMayuscIguales(ss1,'AliasDef') then
          VsAliasDef:=ss2;
        if StrMayuscIguales(ss1,'AccesoRemoto') then
          VsAccesoRemoto:=(ss2='Si');
        if StrMayuscIguales(ss1,'PermiteModoRespaldo') then
          VsPermiteModoRespaldo:=StrMayuscIguales(ss2,'Si');
        if StrMayuscIguales(ss1,'LocalDir') then
          VsLocalDir:=ss2;
        if StrMayuscIguales(ss1,'DirPlantillas') then
          VsDirPlantillas:=ss2;
        if StrMayuscIguales(ss1,'UtilDir') then
          VsUtilDir:=ss2;
        if StrMayuscIguales(ss1,'DataBaseDir') then
          VsDataBaseDir:=ss2;
        if StrMayuscIguales(ss1,'HoraRespaldo') then
          VsHoraRespaldo:=FiltraStrNum(ss2);
        if StrMayuscIguales(ss1,'DataBaseUsu') then
          VsDataBaseUsu:=ss2;
        if StrMayuscIguales(ss1,'DataBaseClave') then
          VsDataBaseClave:=ss2;
          (*
        if StrMayuscIguales(ss1,'ValorAux1') then
          VsValorAux1:=ss2;
        if StrMayuscIguales(ss1,'ValorAux2') then
          VsValorAux2:=ss2;
          *)
        if StrMayuscIguales(ss1,'ImpreTexto') then
          VsImpreTexto:=ss2;
      end;
    end;
  finally
    Lista.free;
  end;
end;

function LClaveDocu(idDocu:string):word;
var i:integer;
begin
  for i:=0 to LstDocu.Count-1 do begin
    if idDocu=ExtraeElemStr(LstDocu.strings[i],1) then begin
      result:=StrToInt(ExtraeElemStr(LstDocu.strings[i],3));
      exit;
    end;
  end;
  result:=0;
end;

function LClaveCata(idCata:string):word;
var i:word;
begin
  for i:=0 to LstCata.Count-1 do begin
    if idCata=ExtraeElemStr(LstCata.strings[i],1) then begin
      result:=StrToInt(ExtraeElemStr(LstCata.strings[i],3));
      exit;
    end;
  end;
  result:=0;
end;

begin
  // Valores Default
  VsPCName:='PcDefault';
  VsUsuarioDef:=idSuper;
  VsLocalDir:='C:\ImagenCo\Tmp';
  VsDirPlantillas:='C:\ImagenCo\Plantillas';
  VsUtilDir:='C:\ImagenCo\Util';
  VsDataBaseDir:='C:\ImagenCo\Dbi';
  VsHoraRespaldo:='0000';
  VsDataBaseUsu:='SYSDBA';
  VsDataBaseClave:='masterkey';
  VsAliasDef:='';
  VsAccesoRemoto:=false;
  VgBitacoraActiva:=true;
  VsPermiteModoRespaldo:=false;
  VsImpreTexto:='';
  EjercicioActivo:=0;
  SwApunt:=0;
  SwEstadoError:=false;
  FechaTrabajoAct:=0;
  UsuarioActivoLib:='';
  idSist:='';
  idSubSist:='';
end.
