unit UDISDHC;

interface

uses Variants,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  OoMisc, AdPort, StdCtrls, Buttons, ComCtrls, ExtCtrls, Menus,
  Mask, ImgList, Db, DBTables, Grids, ULibPrint, DBGrids, RXShell, Registry;
(*
CHARCOM:
B- ESTATUS DE BOMBAS     [170]
A- LEER DISPENSARIO      [180]
C- LEE MANG X DISP       [561]
D- CONFIG MANG X DISP    [560]
E- CONFIG MANG POS.CARGA [460]
F- LEER FLUJO            [571]
G- CAMBIO DE FLUJO       [570]

H- LEER MAX.VOLUMEN      [502]
I- CAMBIO MAX.VOLUMEN    [501]

S- AUTORIZACIONES        [100]
T- DESAUTORIZACIONES     [110]
J- FIN DE VENTA          [200]
N- LEE TOTALES           [625]
P- PREVENTA (TARJETAS)   [121]-VOLUMEN  [120]-IMPORTE
U- CAMBIA PRECIOS        [590]
V- LEE PRECIOS           [591]
M- CONFIG MAX VOLUMEN POR VENTA      [501]
*)

type
  TFDISDHC = class(TForm)
    ApdComPort1: TApdComPort;
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
    PopupMenu2: TPopupMenu;
    PopupMenu3: TPopupMenu;
    PopupMenu4: TPopupMenu;
    PopupMenu5: TPopupMenu;
    TabSheet1: TTabSheet;
    RadioGroup1: TRadioGroup;
    StaticText5: TStaticText;
    StaticText6: TStaticText;
    StaticText15: TStaticText;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label3: TLabel;
    MaskEdit1: TMaskEdit;
    MaskEdit2: TMaskEdit;
    BitBtn2: TBitBtn;
    Timer3: TTimer;
    ImageList1: TImageList;
    Memo2: TMemo;
    Memo4: TMemo;
    Panel2: TPanel;
    ListView1: TListView;
    Panel4: TPanel;
    PageControl2: TPageControl;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    Memo1: TMemo;
    StaticText16: TStaticText;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    NotificationIcon1: TRxTrayIcon;
    DBGrid3: TDBGrid;
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
    Label2: TLabel;
    Refrescar1: TMenuItem;
    Refrescar2: TMenuItem;
    Refrescar3: TMenuItem;
    Refrescar4: TMenuItem;
    SpeedButton1: TSpeedButton;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    StaticText7: TStaticText;
    Bevel1: TBevel;
    Label4x: TLabel;
    Timer2: TTimer;
    CheckBox1: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure ApdComPort1TriggerAvail(CP: TObject; Count: Word);
    procedure Timer1Timer(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure Restaurar1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RadioGroup1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure MaskEdit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MaskEdit2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ListBox1KeyPress(Sender: TObject; var Key: Char);
    procedure MaskEdit1Enter(Sender: TObject);
    procedure GroupBox1Enter(Sender: TObject);
    procedure MaskEdit1Exit(Sender: TObject);
    procedure NotificationIcon1DblClick(Sender: TObject);
    procedure ListView1DblClick(Sender: TObject);
    procedure ListBoxPC1DblClick(Sender: TObject);
    procedure Refrescar1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ListBoxPC2Click(Sender: TObject);
    procedure ListBoxPC3DblClick(Sender: TObject);
    procedure ListBoxPC4DblClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
  private
    { Private declarations }
    SwInicio:boolean;
    CharCom  :char;
    LineaBuff,
    LineaTimer,
    Linea:string;
    SwEspera,
    SwBcc,
    FinLinea:boolean;
    ContEspera,
    ContEsperaPaso2,
    StEsperaPaso3,
    ContEsperaPaso3,
    NumPaso,
    ContBuffLleno,
    errbcc,
    PosicionActual:integer;
    swprocesando,
    desplegada:boolean;
    SnPosCarga:integer;
    SnImporte:real;
    SwFlujo,
    SwFlujoAct,
    SwDespFlujo,
    SwReinicio,
    SwCmnd460,
    SwCmnd561:boolean;
    xposmaxvol:integer;
    EmularEstatus,
    UltimaLineaTimer,
    LineaEmular:string;
    ContadorAlarma:integer;
    contguardaval:integer;
    UltimoEstado,
    xtipoclb:string;
    ListaAux:TStrings;
  public
    { Public declarations }
    function StringCom(ss:string):string;
    function CalculaBCC(ss:string):char;
    procedure ComandoConsola(ss:string);
    procedure ProcesaLinea;
    procedure LimpiaConsola;
    procedure DespliegaPosCarga(xpos:integer;swdb:boolean);
    procedure IniciaBaseDeDatos;
    procedure IniciaEstacion;
    procedure PonTipoServicio(xtipo:string);
    procedure DespliegaPrecios;
    procedure registro(valor:integer;variable:string);
    procedure lee_registro;
    procedure DespliegaMemo4(lin:string);
    procedure DespliegaMemo4Code(lin:string);
    function descifra(ss:string):string;
    function XorChar(c1,c2:char):char;
    function TraduceEstatus(cc:char):byte;
    procedure RegistraPrecio(xpos,xmanguera:integer;xprecio:real);
    function DameTipoClb(xpos:integer):string;
    function PosicionConsola2(xpos:integer):boolean;
    Function EjecutaCorte:string;
  end;

type
     tiposcarga = record
       estatus  :integer;
       descestat:string[20];
       importe,
       volumen,
       precio   :real;
       Isla,
       PosActual:integer; // Posicion del combustible en proceso: 1..NoComb
       estatusant:integer;
       NoComb   :integer; // Cuantos combustibles hay en la posicion
       NoCombFis:integer; // Mangueras configuradas en DHC
       Estat_Cons:char;
       SwTarjeta:boolean;
       TComb    :array[1..2] of integer; // Claves de los combustibles
       TPos     :array[1..2] of integer;
       TMang     :array[1..2] of integer;
       TNombre  :array[1..2] of string[20];
       TotalLitros:array[1..2] of real;
       TPrecio  :array[1..2] of real;
       SwDesp:boolean;
       Horax:TDateTime;
       SwErrorPrecio,
       SwInicPrecios:boolean;
       ContErrorPrecio:integer;
       SwCargaPrecios:boolean;
       SwCargaLectura:boolean;
       SwCargaTotales,
       SwPreset,
       IniciaCarga,
       SwPrepago:boolean;
       ActualizarPrecio:Boolean;
       Mensaje:string[30];
       swactualizar,
       swcargando:boolean;
       SwActivo,
       SwDesHabilitado:boolean;
       Flujo,
       NuevoFlujo :real;
       MaxVol,
       NuevoMaxVol :real;
       SwCmnd501:boolean;
       SwRegresaFlujo:boolean;
       SwRegresaMaxVol:boolean;
       xFlujo:real;
       xMaxVol:real;
       SwMaxVol,
       SwMaxVolAct:boolean;
     end;

const idSTX = #2;
      idETX = #3;
      idACK = #6;
      idNAK = #21;
      MaxEspera2=10;
      MaxEspera31=5;
      MaxEspera3=5;


var
  FDISDHC: TFDISDHC;
  TPosCarga:array[1..32] of tiposcarga;
  MaxPosCarga:integer;
  MaxPosCargaActiva:integer;
  AvanceBar:integer;
  SwSolOk:boolean;
  //nPosIni,nPosFin:integer;
  //nPosIni2,nPosFin2:integer;
  StErrSol:integer;
  ruta_db:string;
  SwCerrar    :boolean;
  // especial
  swarmado:boolean;
  PosArmado:integer;
  ContDA:integer;

implementation

uses ULIBGRAL, ULIBLICENCIAS, DDMCONS, UAutoriza2, DDMCONS2, UDISMENU;

{$R *.DFM}

function TFDISDHC.PosicionConsola2(xpos:integer):boolean;
var i,xposini,xposfin,nn:integer;
    ss,xstr:string;
begin
  result:=false;
  if DMCONS.RangoPosiciones2<>'' then with DMCONS do begin
    nn:=NoElemStrSep(DMCONS.RangoPosiciones2,';');
    for i:=1 to nn do begin
      ss:=ExtraeElemStrSep(DMCONS.RangoPosiciones2,i,';');
      xstr:=ExtraeElemStrSep(ss,1,'-');
      xposini:=StrToIntDef(xstr,0);
      xstr:=ExtraeElemStrSep(ss,2,'-');
      xposfin:=StrToIntDef(xstr,0);
      if (xpos>=xposini)and(xpos<=xposfin) then
        result:=true;
    end;
  end;
end;



procedure TFDISDHC.DespliegaMemo4(lin:string);
begin
  if Memo4.Lines.Count>=80 then
    Memo4.Lines.Delete(0);
  Memo4.Lines.Add(lin);
end;

function TFDISDHC.descifra(ss:string):string;
var i:integer;
    xaux:string;
begin
  xaux:='';
  for i:=1 to length(ss) do
    xaux:=xaux+' '+inttohex(ord(ss[i]),2);
  result:=xaux;
end;

procedure TFDISDHC.DespliegaMemo4Code(lin:string);
begin
  if Memo4.Lines.Count>=80 then
    Memo4.Lines.Delete(0);
  Memo4.Lines.Add(lin+'  '+descifra(lin));
end;

procedure TFDISDHC.DespliegaPrecios;
var i:integer;
begin
  with DMCONS do begin
    Memo1.Lines.Clear;
    Memo1.Lines.Add('Precios Actuales: ');
    for i:=1 to MaxComb do with TabComb[i] do if Activo then
      Memo1.Lines.Add(IntToClaveNum(i,2)+' '+Nombre+' '+FormatoMoneda(precio));
  end;
end;

procedure TFDISDHC.PonTipoServicio(xtipo:string);
begin
  with DMCONS do begin
    if xtipo='Nocturno' then begin
      StaticText15.Caption:='Servicio Nocturno';
      StaticText15.Color:=clNavy;
      StaticText15.Font.Color:=clWhite;
      SwNocturno:=true;
    end
    else begin
      StaticText15.Caption:='Servicio Diurno';
      StaticText15.Color:=clYellow;
      StaticText15.Font.Color:=clBlack;
      SwNocturno:=false;
    end;
  end;
end;

procedure TFDISDHC.IniciaBaseDeDatos;
var i:integer;
begin
  with DMCONS do begin
    Screen.Cursor:=crHourGlass;
    try
      if not swemular then begin
        ApdComPort1.Open:=false;
        ApdComPort1.ComNumber:=ptPuerto;
        ApdComPort1.Baud:=ptBaudios;
        case ptParidad[1] of
          'N':ApdComPort1.Parity:=pNone;
          'E':ApdComPort1.Parity:=pEven;
          'O':ApdComPort1.Parity:=pOdd;
        end;
        ApdComPort1.DataBits:=ptBitsDatos;
        ApdComPort1.StopBits:=ptBitsParada;
        ApdComPort1.Open:=true;
      end;

      // Carga Pos. Carga
      Q_BombIb.Active:=false;
      Q_BombIb.Active:=true;

      if Q_BombIb.IsEmpty then
        raise Exception.Create('Estación no existe, o no tiene posiciones de carga configurados');

      // Carga Combustibles
      for i:=1 to MaxComb do with TabComb[i] do begin
        Activo:=false;
        Nombre:='';
        Precio:=0;
        AplicaPrecio:=true;
        ProductoPrecio:='';
        Agruparcon:=0;
      end;
      Q_CombIb.Active;
      Q_CombIb.First;
      while not Q_CombIb.Eof do begin
        if Q_CombIbClave.AsInteger in [1..MaxComb] then begin
          i:=Q_CombIbClave.AsInteger;
          with TabComb[i] do begin
            Activo:=true;
            Nombre:=Q_CombIbNombre.AsString;
            ProductoPrecio:=Q_CombIbCon_ProductoPrecio.AsString;
            AgruparCon:=Q_CombIbAgrupar_con.AsInteger;
          end;
        end;
        Q_CombIb.Next;
      end;
      Q_Fact1.Active:=false;Q_Fact1.Active:=true;
      Q_Fact2.Active:=false;Q_Fact2.Active:=true;
      CargaPreciosFH(Now,true); // guarda precio actual como físico
      DBGrid3.Refresh;
      DespliegaPrecios;
    finally
      Screen.Cursor:=crDefault;
    end;
  end;
end;

procedure TFDISDHC.IniciaEstacion;
var i,j,xisla,xpos,xcomb,xnum:integer;
    existe:boolean;
begin
  with DMCONS do begin
    ListView1.Items.Clear;
    MaxPosCarga:=0;
    for i:=1 to 32 do with TPosCarga[i] do begin
      SwMaxVol:=true;
      SwMaxVolAct:=true;
      estatus:=-1;
      estatusant:=-1;
      NoComb:=0;
      NoCombFis:=0;
      Estat_Cons:=' ';
      SwTarjeta:=false;
      SwCargaLectura:=true;
      SwCargaPrecios:=true;
      SwErrorPrecio:=false;
      SwInicPrecios:=true;
      SwActualizar:=false;
      IniciaCarga:=false;
      SwPrepago:=false;
      SwPreset:=false;
      ActualizarPrecio:=false;
      SwCmnd501:=true;
      Mensaje:='';
      importe:=0;
      volumen:=0;
      precio:=0;
      for j:=1 to 2 do begin
        TotalLitros[j]:=0;
        TPrecio[j]:=0;
      end;
      Flujo:=0;
      NuevoFlujo:=0;
      MaxVol:=0;
      NuevoMaxVol:=0;
      SwRegresaFlujo:=false;
      SwRegresaMaxVol:=false;
      SwCargando:=false;
      SwCargaTotales:=true;
      SwDeshabilitado:=false;
      SwActivo:=false;
    end;
    CargaAdicional;
    // CARGA DEFAULTS BENNETT
    TL_Bomb.Active:=true;
    while not TL_Bomb.Eof do begin
      TL_Bomb.Edit;
      if not (TL_BombCon_Posicion.AsInteger in [1,2]) then begin
        if (TL_BombCombustible.AsInteger in [1..2]) then
          TL_BombCon_Posicion.AsInteger:=TL_BombCombustible.AsInteger
        else
          TL_BombCon_Posicion.AsInteger:=1;
      end;
      TL_Bomb.Post;
      TL_Bomb.Next;
    end;
    TL_Tcmb.Active:=true;
    while not TL_Tcmb.Eof do begin
      TL_Tcmb.Edit;
      if (TL_TcmbCon_ProductoPrecio.AsString<>'1') and
         (TL_TcmbCon_ProductoPrecio.AsString<>'2') then
      begin
        if (TL_TcmbClave.AsInteger in [1..2]) then
          TL_TcmbCon_ProductoPrecio.AsInteger:=TL_TcmbClave.AsInteger
        else
          TL_TcmbCon_ProductoPrecio.AsInteger:=1;
      end;
      TL_Tcmb.Post;
      TL_Tcmb.Next;
    end;
    // FIN
    Q_BombIb.First;
    while not Q_BombIb.Eof do begin
      xisla:=Q_BombIbIsla.asinteger;
      xpos:=Q_BombIbPosCarga.AsInteger;
      xcomb:=Q_BombIbCombustible.AsInteger;
      if not PosicionConsola2(xpos) then begin
        if xpos>MaxPosCarga then begin
          MaxPosCarga:=xpos;
          while ListView1.Items.Count<MaxPosCarga do begin
            ListView1.Items.Add;
            ListView1.Items[ListView1.Items.Count-1].Caption:=IntToClaveNum(ListView1.Items.Count,2);
            ListView1.Items[ListView1.Items.Count-1].ImageIndex:=0;
          end;
          ListView1.Items[MaxPosCarga-1].Caption:=IntToClaveNum(xpos,2);
          ListView1.Items[MaxPosCarga-1].ImageIndex:=0;
          T_ConsIb.Active:=true;
          if not T_ConsIb.Locate('PosCarga',xpos,[]) then begin
            T_ConsIb.Insert;
            T_ConsIbPosCarga.AsInteger:=xpos;
            T_ConsIbMonVol.AsString:='M';
            T_ConsIbValor.AsFloat:=0;
            T_ConsIbEstatus.AsString:='F';
            T_ConsIbPosicion.AsInteger:=1;
            T_ConsIb.Post;
            T_ConsIb.active:=false;
          end;
        end;
      end;
      with TPosCarga[xpos] do begin
        Isla:=xisla;
        SwDesp:=false;
        existe:=false;
        for i:=1 to NoComb do
          if TComb[i]=xcomb then
            existe:=true;
        if not existe then begin
          inc(NoComb);
          TComb[NoComb]:=xcomb;
          if Q_BombIbCon_Posicion.AsInteger>0 then
            TPos[NoComb]:=Q_BombIbCon_Posicion.AsInteger
          else if NoComb<=2 then
            TPos[NoComb]:=NoComb
          else
            TPos[NoComb]:=1;
          TMang[NoComb]:=Q_BombIbManguera.AsInteger;
          TNombre[NoComb]:=Q_BombIbNombreComb.AsString;
        end;
      end;
      Q_BombIb.Next;
    end;
    T_ConsIb.Active:=true;
    try
      while not T_ConsIb.Eof do begin
        if T_ConsIbEstatus.AsString='P' then begin
          T_ConsIb.Edit;
          T_ConsIbEstatus.AsString:='F';
          T_ConsIb.post;
        end;
        T_ConsIb.Next;
      end;
    finally
      T_ConsIb.Active:=false;
    end;
  end;
  ListBox1.Items.Clear;
  xnum:=(MaxPosCarga)div(4);
  if (MaxPosCarga)mod(4)>0 then
    inc(xnum);
  for i:=1 to xnum do begin
    if i<xnum then
      ListBox1.Items.add('Posiciones '+IntToClaveNum(i*4-3,2)+' - '+IntToClaveNum(i*4,2))
    else
      ListBox1.Items.add('Posiciones '+IntToClaveNum(i*4-3,2)+' - '+IntToClaveNum(MaxPosCarga,2));
  end;
end;


procedure TFDISDHC.FormShow(Sender: TObject);
var xposini,xposfin:integer;
    xstr:string;
begin
  if SwInicio then begin
    try
      ContDA:=0;
      ErrorInic:=true;
      SwInicio:=false;
      IniciaBaseDeDatos;
      DMCONS.ChecaTablas;
      ListBox1.ItemIndex:=0;
      SwProcesando:=false;
      SwEspera:=false;
      SwFlujo:=true;
      SwCmnd561:=true;
      SwCmnd460:=true;
      SwReinicio:=false;
      SwFlujoAct:=true;
      SwDespFlujo:=false;
      StaticText6.Caption:='';
      ContEspera:=0;
      ContEsperaPaso2:=0;
      StEsperaPaso3:=0;
      ContEsperaPaso3:=0;
      ContBuffLleno:=0;
      NumPaso:=0;
      StaticText5.Caption:=IntToStr(NumPaso);
      Linea:='';
      LineaBuff:='';
      LineaTimer:='';
      errbcc:=0;
      SwBcc:=false;
      FinLinea:=false;
      IniciaEstacion;
      (*
      if DMCONS.RangoPosiciones<>'' then with DMCONS do begin
        xstr:=ExtraeElemStrSep(DMCONS.RangoPosiciones,1,'-');
        xposini:=StrToIntDef(xstr,0);
        if xposini>0 then
          nPosIni:=xposINI;
        xstr:=ExtraeElemStrSep(DMCONS.RangoPosiciones,2,'-');
        xposfin:=StrToIntDef(xstr,0);
        if xposfin>0 then
          nPosFin:=xposFin;
      end;
      if DMCONS.RangoPosiciones2<>'' then with DMCONS do begin
        xstr:=ExtraeElemStrSep(DMCONS.RangoPosiciones2,1,'-');
        xposini:=StrToIntDef(xstr,0);
        if xposini>0 then
          nPosIni2:=xposINI;
        xstr:=ExtraeElemStrSep(DMCONS.RangoPosiciones2,2,'-');
        xposfin:=StrToIntDef(xstr,0);
        if xposfin>0 then
          nPosFin2:=xposFin;
      end;*)
      ListBox1.SetFocus;
      Timer1.Enabled:=true;
      PonTipoServicio('Diurno');
      if DMCONS.SwEmular then begin
        LineaEmular:='';
        EmularEstatus:=LlenaStr('','N',MaxPosCarga,'0');
      end;
      Timer3.Enabled:=DMCONS.SwEmular;
      if DMCONS.SwEmular then
        Label4x.Visible:=true;
      ErrorInic:=false;
    finally
      Timer1.Enabled:=true;
      Timer3.Enabled:=DMCONS.SwEmular;
    end;
  end;
end;

function TFDISDHC.StringCom(ss:string):string;
var str:string;
    i:integer;
begin
  for i:=1 to length(ss) do begin
    case ss[i] of
      idACK: str:=str+'<ACK>';
      idNAK: str:=str+'<NAK>';
      idSTX: str:=str+'<STX>';
      idETX: str:=str+'<ETX>';
      else str:=str+ss[i];
    end;
  end;
  result:=str;
end;

function TFDISDHC.XorChar(c1,c2:char):char;
var bits1,bits2,bits3:array[0..7] of boolean;
    nn,n1,n2,i,nr:byte;
begin
  n1:=ord(c1);
  n2:=ord(c2);
  nr:=0;
  for i:=0 to 7 do begin
    nn:=n1 mod 2;
    bits1[i]:=(nn=1);
    n1:=n1 div 2;

    nn:=n2 mod 2;
    bits2[i]:=(nn=1);
    n2:=n2 div 2;

    bits3[i]:=bits1[i] xor bits2[i];
    if bits3[i] then
      case i of
        0:nr:=nr+1;
        1:nr:=nr+2;
        2:nr:=nr+4;
        3:nr:=nr+8;
        4:nr:=nr+16;
        5:nr:=nr+32;
        6:nr:=nr+64;
        7:nr:=nr+128;
      end;
  end;
  result:=char(nr);
end;

function TFDISDHC.CalculaBCC(ss:string):char;
var xc,cc:char;
    i:integer;
begin
  xc:=ss[1];
  for i:=2 to length(ss) do begin
    cc:=ss[i];
    xc:=XorChar(xc,cc);
  end;
  result:=xc;
end;

function TFDISDHC.TraduceEstatus(cc:char):byte;
var nn,d1,d2:integer;
begin
  nn:=ord(cc);
  d1:=(nn)div(32);
  d2:=(nn)mod(8);
  if (d1)mod(2)=0 then begin
    d1:=(nn)div(8);
    if (d1)mod(2)=0 then
      result:=d2
    else   // fin de venta
      result:=8;
  end
  else begin
    result:=9
  end;
end;

procedure TFDISDHC.LimpiaConsola;
begin
  StaticText1.Caption:='  ';
  StaticText2.Caption:='  ';
  StaticText3.Caption:='  ';
  StaticText4.Caption:='  ';
  ListBoxPC1.Items.Clear;
  ListBoxPC2.Items.Clear;
  ListBoxPC3.Items.Clear;
  ListBoxPC4.Items.Clear;
  panelPC1.color:=ClWhite;
  panelPC2.color:=ClWhite;
  panelPC3.color:=ClWhite;
  panelPC4.color:=ClWhite;
  panelPC1.Caption:='';
  panelPC2.Caption:='';
  panelPC3.Caption:='';
  panelPC4.Caption:='';
end;

procedure TFDISDHC.DespliegaPosCarga(xpos:integer;swdb:boolean);
var ip,j,xp,rango,posi,posf,xcomb,xc:integer;
    lin,xnombre:string;
begin
  try
    if PosicionConsola2(xpos) then
      exit;
    rango:=ListBox1.ItemIndex+1;
    if rango=0 then
      rango:=1;
    posi:=rango*4-3;
    posf:=rango*4;
    with TPosCarga[xpos] do begin
      if swdesp then
        DespliegaMemo4('2) Fin Vta Pos: '+inttostr(xpos));
      if PosActual in [1,2] then
        xnombre:=TNombre[Tpos[PosActual]];
      if xpos in [posi..posf] then begin
        ip:=xpos-posi+1;
        TStaticText(FindComponent('StaticText'+IntToStr(ip))).Caption:=IntToClaveNum(xpos,2);
        if not SwDesHabilitado then begin
          TPanel(FindComponent('panelPC'+IntToStr(ip))).Caption:=descestat+' - '+inttostr(estatus);
          case estatus of
            5:TPanel(FindComponent('panelPC'+IntToStr(ip))).color:=ClLime;
            0:if not SwPreset then
                TPanel(FindComponent('panelPC'+IntToStr(ip))).color:=ClRed
              else
                TPanel(FindComponent('panelPC'+IntToStr(ip))).color:=ClGray;
            2:TPanel(FindComponent('panelPC'+IntToStr(ip))).color:=ClGray;
            1,4:TPanel(FindComponent('panelPC'+IntToStr(ip))).color:=ClYellow;
            8:TPanel(FindComponent('panelPC'+IntToStr(ip))).color:=ClBlue;
            else TPanel(FindComponent('panelPC'+IntToStr(ip))).color:=ClWhite;
          end;
        end
        else begin
          TPanel(FindComponent('panelPC'+IntToStr(ip))).Caption:='Deshabilitado';
          TPanel(FindComponent('panelPC'+IntToStr(ip))).color:=ClWhite;
        end;
        TListBox(FindComponent('ListBoxPC'+IntToStr(ip))).Items.Clear;
        TListBox(FindComponent('ListBoxPC'+IntToStr(ip))).Items.Add(FormatFloat('###,##0.00',importe)+' Pesos');
        TListBox(FindComponent('ListBoxPC'+IntToStr(ip))).Items.Add(FormatFloat('##,##0.00',volumen)+' Litros');
        TListBox(FindComponent('ListBoxPC'+IntToStr(ip))).Items.Add(FormatFloat('##,##0.00',precio)+' $/Lts');
        TListBox(FindComponent('ListBoxPC'+IntToStr(ip))).Items.Add(xnombre);
        if swdespflujo then
          TListBox(FindComponent('ListBoxPC'+IntToStr(ip))).Items.
                   Add(FormatFloat('0.000',nuevoflujo)+' Flujo  ('+
                       FormatFloat('000',nuevomaxvol)+')')
        else
          TListBox(FindComponent('ListBoxPC'+IntToStr(ip))).Items.Add('');
        TListBox(FindComponent('ListBoxPC'+IntToStr(ip))).Items.Add(Mensaje);
        for xp:=1 to NoComb do
          TListBox(FindComponent('ListBoxPC'+IntToStr(ip))).Items.Add(
                     FormatFloat('##,###,##0.00',totallitros[xp])+
                     ' ['+FormatFloat('#0.00',tprecio[xp])+']'+
                     ' '+copy(TNombre[TPos[xp]],1,3)
                     );
      end;
    end;

    // Refresca Listas
    for ip:=1 to MaxPosCarga do with TPosCarga[ip] do begin
      if swdesp then
        DespliegaMemo4('3) Fin Vta Pos: '+inttostr(xpos));
      if not SwDesHabilitado then begin
        if not DMCONS.SwNocturno then begin
          case estatus of
            0,2:if not SwPreset then
                  ListView1.Items[ip-1].ImageIndex:=1
                else ListView1.Items[ip-1].ImageIndex:=7;
            5:ListView1.Items[ip-1].ImageIndex:=2;
            1,4:ListView1.Items[ip-1].ImageIndex:=3;
            else ListView1.Items[ip-1].ImageIndex:=0;
          end;
        end
        else begin
          case estatus of
            0,2:if not SwPreset then
                  ListView1.Items[ip-1].ImageIndex:=4
                else ListView1.Items[ip-1].ImageIndex:=8;
            5:ListView1.Items[ip-1].ImageIndex:=5;
            1,4:ListView1.Items[ip-1].ImageIndex:=6;
            else ListView1.Items[ip-1].ImageIndex:=0;
          end;
        end;
      end
      else begin
        ListView1.Items[ip-1].ImageIndex:=0;
      end;
      ListView1.Items[ip-1].Caption:=IntToClaveNum(ip,2)+
                    '  '+LlenaStr(FormatFloat('##,##0.00',importe),'D',10,' ');
      if SwDesp then with DMCONS do begin
        if swdesp then
          DespliegaMemo4('4) Fin Vta Pos: '+inttostr(xpos));
        SwDesp:=false;
        SwTarjeta:=false;
        SwPreset:=false;
        if (importe>0.01) then begin
          if not (PosActual in [1..2]) then
            PosActual:=1;
          SwCargaTotales:=true;
          try
            try
              if swdesp then
                DespliegaMemo4('5) Fin Vta Pos: '+inttostr(xpos));
              T_MoviIb.Active:=true;
              T_MoviIb.Insert;
              T_MoviIbFecha.AsDateTime:=date;
              T_MoviIbHora.AsDateTime:=now;
              T_MoviIbHoraStr.AsString:=HoraPaq(T_MoviIbHora.AsDateTime);
              T_MoviIbPosCarga.AsInteger:=ip;
              xcomb:=1;
              for j:=1 to 2 do
                if PosActual=TPos[j] then
                  xcomb:=TComb[j];
              if TabComb[xcomb].Agruparcon>0 then begin
                xc:=TabComb[xcomb].Agruparcon;
                if TabComb[xc].Activo then
                  xcomb:=xc;
              end;
              T_MoviIbCombustible.AsInteger:=xcomb;
              T_MoviIbVolumen.AsFloat:=AjustaFloat(Volumen,3);
              T_MoviIbImporte.AsFloat:=AjustaFloat(Importe,2);
              T_MoviIbTotal01.AsFloat:=AjustaFloat(TotalLitros[1],3);
              T_MoviIbTotal02.AsFloat:=AjustaFloat(TotalLitros[2],3);
              T_MoviIbTag.AsInteger:=0;
              T_MoviIbManguera.AsInteger:=TMang[PosActual];
              T_MoviIb.post;
              if swdesp then
                DespliegaMemo4('6) Fin Vta Pos: '+inttostr(xpos));
            finally
              xp:=Q_Fact1PosCarga.AsInteger;
              Q_Fact1.Active:=false;Q_Fact1.Active:=true;
              Q_Fact1.Locate('PosCarga',xp,[]);

              xp:=Q_Fact2PosCarga.AsInteger;
              Q_Fact2.Active:=false;Q_Fact2.Active:=true;
              Q_Fact2.Locate('PosCarga',xp,[]);
              T_MoviIb.Active:=false;
            end;
          except
            DespliegaMemo4('MOVI '+fechapaq(date)+' '+HoraPaq(time)+' '+lin);
            if (T_MoviIb.State=dsInsert)or(T_MoviIb.State=dsEdit) then
              T_MoviIb.Cancel;
          end;
          try
            T_ConsIb.Active:=true;
            try
              T_ConsIb.Refresh;
              if T_ConsIb.Locate('PosCarga',ip,[]) then begin
                T_ConsIb.Edit;
                // inicio
                T_ConsIbVolumen.AsFloat:=volumen;
                T_ConsIbImporte.AsFloat:=importe;
                T_ConsIbPrecio.AsFloat:=precio;
                T_ConsIbCombustible.AsString:=xnombre;
                case estatus of
                  9:T_ConsIbEstado.AsInteger:=0; // Sin Comunicación
                  0:T_ConsIbEstado.AsInteger:=1; // Inactivo (Idle)
                  5:T_ConsIbEstado.AsInteger:=2; // Cargando (In Use)
                  8:T_ConsIbEstado.AsInteger:=3; // Fin de Carga (Used)
                  2:T_ConsIbEstado.AsInteger:=5; // Llamando (Calling)
                  1:T_ConsIbEstado.AsInteger:=9; // Autorizado (Calling)
                  6,7:T_ConsIbEstado.AsInteger:=8; // Detenido (Stoped)
                  else T_ConsIbEstado.AsInteger:=0;
                end;
                T_ConsIbOtros.AsString:=FormatFloat('#######0.00',totallitros[1])+
                                        '|'+FormatFloat('#######0.00',totallitros[2]);
                // fin
                if SwTarjeta then
                  T_ConsIbEstatus.AsString:='F'
                else
                  T_ConsIbEstatus.AsString:='f';
                //lcActualiza:=true;
                T_ConsIb.Post;
              end;
            finally
              T_ConsIb.Active:=false;
            end;
          except
            DespliegaMemo4('CONS '+fechapaq(date)+' '+HoraPaq(time)+' '+lin);
            if (T_ConsIb.State=dsInsert)or(T_ConsIb.State=dsEdit) then
              T_ConsIb.Cancel;
          end;
        end;
      end;
    end;
  except
    with DMCONS do begin
      if (T_MoviIb.State in [dsInsert,dsEdit]) then
        T_MoviIb.Cancel;
      if (T_ConsIb.State in [dsInsert,dsEdit]) then
        T_ConsIb.Cancel;
    end;
  end;
end;

procedure TFDISDHC.RegistraPrecio(xpos,xmanguera:integer;xprecio:real);
var nc,cve:integer;
begin
  with DMCONS, TPosCarga[xpos] do begin
    try
      for nc:=1 to NoComb do begin
        if TPos[nc]=xmanguera then begin
          cve:=TComb[nc];
          if not TabComb[cve].AplicaPrecio then begin
            if (abs(TabComb[cve].precio-xprecio)>0.001)and(xprecio>0.01) then begin
              TabComb[cve].precio:=precio;
              T_Tcmb.Active:=true;
              try
                if T_Tcmb.Locate('Clave',cve,[]) then begin
                  T_Tcmb.Edit;
                  T_TcmbPrecioFisico.AsFloat:=precio;
                  T_Tcmb.Post;
                  Q_CombIb.Active:=false;
                  Q_CombIb.Active:=true;
                end;
              finally
                T_Tcmb.Active:=false;
              end;
            end;
          end;
        end;
      end;
    except
      if (T_Tcmb.State in [dsInsert,dsEdit]) then
        T_Tcmb.Cancel;
    end;
  end;
end;

Function TFDISDHC.EjecutaCorte:string;
var rsp,Descrsp:string;
    xpos,xpr,xcomb:integer;
begin
  with DMCONS do begin
    rsp:='OK';
    try
      SwCorteTurno:=false;
      SwCorteOk:=true;
      if not SwCorteParcial then begin
        for xpos:=1 to MaxPosCarga do if not PosicionConsola2(xpos) then
          if ((TPosCarga[xpos].isla=xIslaCorte)or(xIslaCorte=0))and(TPosCarga[xpos].swcargando) then begin
            SwCorteOk:=false;
            DescRsp:='Existen dispensarios cargando';
          end;
      end;
      if SwCorteOk then begin
        T_Corte.Active:=true;
        try
          for xpos:=1 to MaxPosCarga do if not PosicionConsola2(xpos) then with TPosCarga[xpos] do begin
            if (TPosCarga[xpos].isla=xIslaCorte)or(xIslaCorte=0) then begin
              for xpr:=1 to NoComb do begin
                xcomb:=0;
                if TPos[1]=xpr then
                  xcomb:=TComb[1]
                else if TPos[2]=xpr then
                  xcomb:=TComb[2];
                if xcomb>0 then begin
                  if T_Corte.Locate('Fecha;Turno;Isla;PosCarga;Combustible',
                     VarArrayOf([xFechaCorte,xTurnoCorte,TPosCarga[xpos].isla,xpos,xcomb]),[]) then
                    T_Corte.Delete;
                  T_Corte.Insert;
                  T_CorteFecha.AsDateTime:=xFechaCorte;
                  T_CorteTurno.AsInteger:=xTurnoCorte;
                  T_CorteIsla.AsInteger:=TPosCarga[xpos].isla;
                  T_CortePosCarga.AsInteger:=xpos;
                  T_CorteCombustible.AsInteger:=xcomb;
                  T_CorteContadorLitros.AsFloat:=AjustaFloat(Totallitros[xpr],3);
                  T_CorteContadorImporte.AsFloat:=0;
                  T_Corte.Post;
                end;
              end;
            end;
          end;
        finally
          T_Corte.Active:=false;
        end;
      end
      else begin
        rsp:='ERROR: '+DescRsp;
      end;
    except
      if T_Corte.State in [dsInsert,dsEdit] then
        T_Corte.Cancel;
      rsp:='ERROR: Al insertar registro de Corte';
    end;
  end;
  result:=rsp;
end;

function TFDISDHC.DameTipoClb(xpos:integer):string;
var xtp:string;
begin
  xtp:=DMCONS.TipoClb;
  if DMCONS.TAdic2[xpos]<>'' then
    xtp:=DMCONS.TAdic2[xpos];
  result:=xtp;
end;

(* TRADUCCION DE ESTATUS DE DHC A ESTATUS DE IGAS
64   @    0
65   A    1
66   B    2
67   C    3
68   D    4
69   E    5
70   F    6
71   G    7
72   H    8
*)

procedure TFDISDHC.ProcesaLinea;
label uno;
var lin,ss,rsp,descrsp,xestado:string;
    simp,spre,sval:string[20];
    ii,nposini,nposfin,
    i,xpos,xaux,j,npos:integer;
    xposition,xcomb,xp,xpr:integer;
    tprec:array[1..2] of real;
    xestatus:char;
    xNvoPrecio,
    ximporte:real;
    xLista:TStrings;
    xvol:real;
    swok:boolean;
    saux,ss2:string;
    te_pos:array[1..32] of string[30];
    xvalmin:real;
begin
  try
    saux:=LineaTimer;
    if length(LineaTimer)<5 then
      exit;
    lin:=LineaTimer;
    LineaTimer:='';
    lin:=copy(lin,3,length(lin)-4);
    case lin[2] of
     'B':begin // pide estatus de todas las bombas
           UltimaLineaTimer:=saux;
           ContEspera:=0;
           if lin[1] in ['@','H'] then begin
             delete(lin,1,2);
             ss:='';
             for i:=1 to length(lin) do
               if (i)mod(2)=1 then
                 ss:=ss+lin[i];
             MaxPosCargaActiva:=MaxPosCarga;
             for xpos:=1 to MaxPosCargaActiva do if not PosicionConsola2(xpos) then with TPosCarga[xpos] do begin
               estatusant:=estatus;
               if not DMCONS.SwEmular then
                 estatus:=TraduceEstatus(ss[xpos])
               else
                 estatus:=strtointdef(copy(EmularEstatus,xpos,1),9);
               if (EstatusAnt=9)and(Estatus=0) then begin
                 SwCargaPrecios:=true;
                 SwCargaLectura:=true;
                 SwCargaTotales:=true;
               end;
               if (estatus=9)and(SwActivo) then begin
                 if (estatusant in [0..8]) then
                   ContDA:=0
                 else
                   inc(ContDA);
                 if ContDA=5 then begin
                   DMCONS.RegistraBitacora2(1,'Desactivación de Dispensario '+inttostr(xpos));
                   SwActivo:=false;
                 end;
               end
               else if (estatus in [0..8])and(not SwActivo) then begin
                 if (estatusant=9) then
                   DMCONS.RegistraBitacora2(1,'Activación de Dispensario '+inttostr(xpos));
                 SwActivo:=true;
               end;
               case estatus of
                 9:descestat:='---';
                 0:begin
                     descestat:='Inactivo';
                     swtarjeta:=false;
                     if SwRegresaFlujo then begin
                       SwRegresaFlujo:=false;
                       NuevoFlujo:=xFlujo;
                     end;
                     if SwRegresaMaxVol then begin
                       SwRegresaMaxVol:=false;
                       NuevoMaxVol:=xMaxVol;
                     end;
                   end;
                 1:descestat:='Pre Autorizada';
                 2:descestat:='Pistola Levantada';
                 3:descestat:='Sin Autorización';
                 4:descestat:='Autorización Pend'; {3}
                 5:begin                 {5}
                     descestat:='Despachando';
                     IniciaCarga:=true;
                     SwCargando:=true;
                   end;
                 6:descestat:='Dispensario Detenido';
                 7:descestat:='Paro de Emergencia';
                 8:descestat:='Fin de Venta';
               end;
             end;
           end;
           // CHECA MAXIMO DE POS. CARGA
           if SwCmnd460 then begin
             CharCom:='E'; ComandoConsola('460'+charcom+inttostr(MaxPosCargaActiva)+'\');
             SwReinicio:=true;  // Nuevo
             exit;
           end;
           // CHECA CANTIDAD DE MANGUERAS POR DISPENSARIO
           if SwCmnd561 then begin
             CharCom:='C'; ComandoConsola('561'+charcom+'\');
             SwReinicio:=true;  // Nuevo
             exit;
           end;
           // PREFIJA MAXIMO POR DISPENSARIO
           for xpos:=1 to MaxPosCargaActiva do if not PosicionConsola2(xpos) then with TPosCarga[xpos] do begin
             if SwCmnd501 then begin
               PosicionActual:=xpos;
               xaux:=Trunc(10*DMCONS.TAdic3[xpos]);
               if not (xaux in [0..9]) then
                 xaux:=0;
               if DameTipoClb(xpos)='2' then begin
                 CharCom:='M'; ComandoConsola('501'+charcom+IntToStr(xpos)+
                                              '\99'+IntToStr(xaux)+
                                              '\');
               end
               else begin
                 CharCom:='M'; ComandoConsola('501'+charcom+IntToStr(xpos)+
                                              '\950'+
                                              '\');
               end;
               SwReinicio:=true;  // Nuevo
               exit;
             end;
           end;
           // VERIFICA Y CONFIG MANG X DISP
           for xpos:=1 to MaxPosCargaActiva do if not PosicionConsola2(xpos) then with TPosCarga[xpos] do begin
             //DespliegaMemo4('Pos '+inttostr(xpos)+'  NoComb '+inttostr(nocomb)+'  NoCombFis '+inttostr(nocombfis));
             if (NoComb<>NoCombFis)and(NoComb in [1..2]) then with DMCONS do begin
               PosicionActual:=xpos;
               CharCom:='D';
               ss:='560'+charcom+IntToStr(xpos)+'\'+IntToStr(NoComb)+'\';
               ComandoConsola(ss);
               SwReinicio:=true;  // Nuevo
               exit;
             end;
           end;
           // Actualiza Precios
           for xpos:=1 to MaxPosCargaActiva do if not PosicionConsola2(xpos) then with TPosCarga[xpos] do begin
             if ((ActualizarPrecio)or(SwInicPrecios))and(not SwErrorPrecio) then with DMCONS do begin
               PosicionActual:=xpos;
               CharCom:='U';
               ss:='590'+charcom+IntToStr(xpos)+'\';
               swok:=false;
               for i:=1 to NoComb do begin
                 xNvoPrecio:=TabComb[TComb[i]].precio;
                 if abs(xnvoprecio-TPosCarga[xpos].tprecio[i])>0.005 then
                   swok:=true;
                 tprec[tpos[i]]:=xnvoprecio;
               end;
               if (swok)or(SwInicPrecios) then begin
                 for i:=1 to NoComb do
                   ss:=ss+FormatFloat('#0.00',tprec[i])+'\';
                 for i:=NoComb+1 to 8 do
                   ss:=ss+'\';
                 ComandoConsola(ss);
                 SwReinicio:=true;  // Nuevo
                 exit;
               end
               else ActualizarPrecio:=false;
             end
             else if SwErrorPrecio then begin
               inc(ContErrorPrecio);
               if ContErrorPrecio>=10 then
                 SwErrorPrecio:=false;
             end;
           end;
           // AUTORIZACIONES Y DESAUTORIZACIONES
           for xpos:=1 to MaxPosCargaActiva do if not PosicionConsola2(xpos) then begin
             PosicionActual:=xpos;
             with TPosCarga[PosicionActual] do if Estatus=2 then begin
               if (not DMCONS.SwNocturno)and(not SwDesHabilitado) then begin
                 // AUTORIZA CARGA
                 CharCom:='S'; ComandoConsola('100'+charcom+IntToStr(PosicionActual)+'\');
                 exit;
               end;
             end
             else if (Estatus=1)and((now-horax)>tmMinuto)and(not swtarjeta)and(not swpreset)and(not DMCONS.swemular) then begin
               horax:=now;
               CharCom:='T'; ComandoConsola('110'+charcom+IntToStr(PosicionActual)+'\');
               exit;
             end;
           end;
           for xpos:=1 to MaxPosCargaActiva do if not PosicionConsola2(xpos) then begin // CAMBIOS DE FLUJO Y MAXVOL
             PosicionActual:=xpos;
             with TPosCarga[PosicionActual] do if not SwTarjeta then begin
               if (abs(nuevoflujo-flujo)>0.001)and(Nuevoflujo>0.01)and(NuevoFlujo<=1.01) then begin
                 SwFlujo:=true;
                 xaux:=Trunc(NuevoFlujo/0.05+0.001);
                 NuevoFlujo:=xaux*0.05;
                 Flujo:=NuevoFlujo;
                 CharCom:='G'; ComandoConsola('570'+charcom+IntToStr(PosicionActual)+'\'+inttostr(xaux)+'\');
                 SwReinicio:=true;  // Nuevo
                 exit;
               end
               else NuevoFlujo:=Flujo;
               if (abs(nuevomaxvol-maxvol)>0.001)and(Nuevomaxvol>0.01)and(Nuevomaxvol<=1000) then begin
                 SwMaxvol:=true;
                 xposmaxvol:=PosicionActual;
                 MaxVol:=NuevoMaxVol;
                 xaux:=Trunc(MaxVol+0.001);
                 if xaux<990 then
                   xaux:=990;
                 if DameTipoClb(PosicionActual)='2' then begin
                   CharCom:='I';
                   ComandoConsola('501'+charcom+IntToStr(PosicionActual)+'\'+inttostr(xaux)+'\');
                 end
                 else begin
                   CharCom:='I';
                   ComandoConsola('501'+charcom+IntToStr(PosicionActual)+'\950\');
                 end;
                 SwReinicio:=true;  // Nuevo
                 exit;
               end
               else NuevoMaxVol:=MaxVol;
             end;
           end;
           if SwFlujo then begin
             CharCom:='F'; ComandoConsola('571'+charcom+'\');
             SwReinicio:=true;  // Nuevo
             exit;
           end;
           for xpos:=1 to MaxPosCargaActiva do with TPosCarga[xpos] do  // LEE MAXVOL
             if SwMaxVol then begin
               xposmaxvol:=xpos;
               CharCom:='H'; ComandoConsola('502'+charcom+IntToStr(xposmaxvol)+'\');
               SwReinicio:=true;  // Nuevo
               exit;
             end;
           SwReinicio:=false;
           NumPaso:=2;
           StaticText5.Caption:=IntToStr(NumPaso);
           PosicionActual:=0;
         end;
     'A':begin // pide lectura de una bomba
           ContEsperaPaso2:=0;
           if lin[1] in ['@','H'] then begin
             xpos:=PosicionActual;
             with TPosCarga[xpos] do begin
               PosActual:=StrToIntDef(ExtraeElemStrSep(lin,2,'\'),0);
               if not(PosActual in [1,2]) then
                 PosActual:=1;
               try
                 swcargalectura:=false;
                 xposition:=PosActual;
                 volumen:=StrToFloat(ExtraeElemStrSep(lin,5,'\'));
                 precio:=StrToFloat(ExtraeElemStrSep(lin,3,'\'));
                 importe:=StrToFloat(ExtraeElemStrSep(lin,4,'\'));
                 if (Estatus=8)and(SwCargando) then begin
                   swdesp:=true;
                   SwCargando:=false;
                 end;
                 if (not (TPosCarga[xpos].Estatus in [5,8]))and(TPosCarga[xpos].SwCargando) then begin
                   swdesp:=true;
                   SwCargando:=false;
                 end;
                 if swdesp then
                   DespliegaMemo4('1) Fin Vta Pos: '+inttostr(xpos));
                 DespliegaPosCarga(xpos,true);
                 if Estatus=8 then begin// FIN DE VENTA
                   CharCom:='J'; ComandoConsola('200'+charcom+IntToStr(PosicionActual)+'\1\');
                   exit;
                 end;
               except
                 //Dec(PosicionActual);
               end;
             end;
           end;
         end;
     'S':begin // AUTORIZACION DE CARGA
           ContEspera:=100; // provoca el reinicio
           if lin[1] in ['@','H'] then
             if not DMCONS.SwEmular then
               TPosCarga[PosicionActual].Horax:=now;
         end;
     'T':begin // DESAUTORIZACION DE CARGA
           ContEspera:=100; // provoca el reinicio
           if lin[1] in ['@','H'] then ;
         end;
     'G':if NumPaso=1 then begin // CAMBIA FLUJO
           ContEspera:=100; // provoca el reinicio
           if lin[1] in ['@','H'] then ;
         end;
     'F':begin // LEE FLUJO
           ContEspera:=100; // provoca el reinicio
           if lin[1] in ['@','H'] then begin
             SwFlujo:=false;
             delete(lin,1,2);
             for xpos:=1 to MaxPosCargaActiva do with TPosCarga[xpos] do begin
               xaux:=StrToIntDef(ExtraeElemStrSep(lin,xpos,'\'),0);
               if xaux>0 then
                 Flujo:=xaux*0.05;
             end;
             // CARGA FLUJO
             if SwFlujoAct then with DMCONS do begin
               Q_Pcar.Active:=false;
               Q_Pcar.Active:=true;
               while not Q_Pcar.Eof do begin
                 xpos:=Q_PcarPosCarga.AsInteger;
                 if xpos in [1..MaxPosCarga] then
                   TPosCarga[xpos].NuevoFlujo:=Q_PcarSlowFlow.AsFloat;
                 Q_Pcar.Next;
               end;
             end;
           end;
         end;
     'I':if NumPaso=1 then begin // CAMBIA volmax
           ContEspera:=100; // provoca el reinicio
           if lin[1] in ['@','H'] then ;
         end;
     'H':begin // LEE VOLMAX
           ContEspera:=100; // provoca el reinicio
           if lin[1] in ['@','H'] then begin
             delete(lin,1,2);
             //xposmaxvol:=StrToIntDef(ExtraeElemStrSep(lin,1,'\'),0);
             with TPosCarga[xposmaxvol] do begin
               Swmaxvol:=false;
               xaux:=StrToIntDef(ExtraeElemStrSep(lin,2,'\'),0);
               if xaux>0 then
                 MaxVol:=xaux;
             end;
           end;
         end;
     'C':begin // LEE MANG X DISP
           ContEspera:=100; // provoca el reinicio
           if lin[1] in ['@','H'] then begin
             SwCmnd561:=false;
             delete(lin,1,2);
             for xpos:=1 to MaxPosCargaActiva do with TPosCarga[xpos] do
               NoCombFis:=StrToIntDef(ExtraeElemStrSep(lin,xpos,'\'),0);
           end;
         end;
     'M':begin // CONFIG MAX VOLUMEN
           ContEspera:=100; // provoca el reinicio
           if lin[1] in ['@','H'] then
             TPosCarga[PosicionActual].SwCmnd501:=false;
         end;
     'E':begin // MAX POS.CARGA CONFIGURADAS
           ContEspera:=100; // provoca el reinicio
           if lin[1] in ['@','H'] then
             SwCmnd460:=false;
         end;
     'D':if NumPaso=1 then begin // CAMBIA MANG X DISP
           ContEspera:=100; // provoca el reinicio
           if lin[1] in ['@','H'] then with TPosCarga[PosicionActual] do
             NoCombFis:=NoComb;
         end;
     'J':begin // pide lectura de una bomba
           ContEsperaPaso2:=0;
           if lin[1] in ['@','H'] then ;
           if DMCONS.swemular then with TPosCarga[PosicionActual] do begin
             EmularEstatus[PosicionActual]:='0';
             estatus:=0;
             DespliegaPosCarga(PosicionActual,true);
           end;
         end;
     'N':begin // totales de la bomba
           if lin[1] in ['@','H'] then begin
             xpos:=PosicionActual;
             with TPosCarga[xpos] do begin
               swcargatotales:=false;
               try
                 TotalLitros[TPos[1]]:=StrToFloat(ExtraeElemStrSep(lin,3,'\'));
               except
                 TotalLitros[TPos[1]]:=0;
               end;
               if NoComb>1 then begin
                 try
                   TotalLitros[TPos[2]]:=StrToFloat(ExtraeElemStrSep(lin,7,'\'));
                 except
                   TotalLitros[TPos[2]]:=0;
                 end;
               end;
               DMCONS.RegistraTotales_BD(xpos,TotalLitros[1],TotalLitros[2]);
               DespliegaPosCarga(xpos,true);
             end;
           end;
         end;
     'V':begin // lee precios de la bomba
           if lin[1] in ['@','H'] then begin
             delete(lin,1,2);
             xpos:=PosicionActual;
             with TPosCarga[xpos] do begin
               swcargaprecios:=false;
               try
                 TPrecio[1]:=StrToFloat(ExtraeElemStrSep(lin,1,'\'));
                 RegistraPrecio(xpos,1,TPrecio[1]);
               except
                 TPrecio[1]:=0;
               end;
               if NoComb>1 then begin
                 try
                   TPrecio[2]:=StrToFloat(ExtraeElemStrSep(lin,2,'\'));
                   RegistraPrecio(xpos,2,TPrecio[2]);
                 except
                   TPrecio[2]:=0;
                 end;
               end;
               DespliegaPrecios;
               DespliegaPosCarga(xpos,false);
             end;
           end;
         end;
     'U':begin // CAMBIO DE PRECIO
           if lin[1] in ['@','H'] then with TPosCarga[PosicionActual] do begin
             ContEspera:=100; // provoca el reinicio
             ActualizarPrecio:=false;
             SwInicPrecios:=false;
             for i:=1 to NoComb do
               TPosCarga[PosicionActual].tprecio[i]:=DMCONS.TabComb[TComb[TPos[i]]].precio;
             DespliegaPosCarga(PosicionActual,false);
             DMCONS.Q_CombIb.Active:=false;
             DMCONS.Q_CombIb.Active:=true;
           end
           else with TPosCarga[PosicionActual] do begin
             SwErrorPrecio:=true;
             ContErrorPrecio:=0;
           end;
         end;
     'P':with DMCONS do begin // PREVENTA TARJETA
           xpos:=PosicionActual;
           if lin[1] in ['@','H'] then begin // POSICION ACTIVADA
             if TPosCarga[xpos].SwTarjeta then begin
               xestatus:='P'
             end
             else begin
               xestatus:='p';
               TPosCarga[xpos].SwPreset:=true;
               BitBtn2.Enabled:=true;
               MaskEdit1.ReadOnly:=false;
               MaskEdit2.ReadOnly:=false;
               beep;
               StaticText16.Caption:='Procesada...';
               if Memo2.Lines.Count>=8 then
                 Memo2.Lines.Delete(0);
               Memo2.Lines.Add(IntToClaveNum(SnPosCarga,2)+'   '+LlenaStr(FormatoMoneda(SnImporte),'D',15,' '));
               MaskEdit1.SetFocus;
               NumPaso:=1;
             end;
             if swemular then begin
               if (EmularEstatus[xpos]='0') then begin
                 EmularEstatus[xpos]:='5';
                 TPosCarga[xpos].estatus:=5;
                 if SwNocturno then begin
                   TPosCarga[xpos].volumen:=SnImporte/5;
                   TPosCarga[xpos].importe:=SnImporte;
                   TPosCarga[xpos].precio:=5;
                 end
                 else begin
                   TPosCarga[xpos].volumen:=Q_ConsIbValor.AsFloat/5;
                   TPosCarga[xpos].importe:=Q_ConsIbValor.AsFloat;
                   TPosCarga[xpos].precio:=5;
                 end;
                 TPosCarga[xpos].posactual:=1;
                 TPosCarga[xpos].horax:=time;
                 TPosCarga[xpos].SwTarjeta:=false;
               end;
             end;
           end
           else begin // ERROR AL ACTIVAR
             if TPosCarga[xpos].SwTarjeta then
               xestatus:='E'
             else begin
               xestatus:='e';
               MensajeErr('Error al Activar Posición de Carga');
             end
           end;
           try
             T_ConsIb.Active:=true;
             try
               if T_ConsIb.Locate('PosCarga',xpos,[]) then begin
                 T_ConsIb.Edit;
                 T_ConsIbEstatus.AsString:=xestatus;
                 TPosCarga[xpos].EstaT_Cons:=StrToChar(T_ConsIbEstatus.AsString);
                 //lcActualiza:=true;
                 T_ConsIb.Post;
                 TPosCarga[xpos].SwPrepago:=true;
               end;
             finally
               T_ConsIb.Active:=false;
             end;
           except
             if (T_ConsIb.State=dsInsert)or(T_ConsIb.State=dsEdit) then
               T_ConsIb.Cancel;
           end;
         end;
    end;
    // checa lecturas de dispensarios
    if NumPaso=2 then begin
      if PosicionActual<MaxPosCargaActiva then begin
        repeat
          Inc(PosicionActual);
          with TPosCarga[PosicionActual] do begin
            if NoComb>0 then begin // LEE DISPENSARIO
              if (estatus<>estatusant)or(estatus in [5,8])or(swcargalectura)or(swcargando) then begin
                SwActualizar:=true;
                CharCom:='A'; ComandoConsola('180'+charcom+IntToStr(PosicionActual)+'\');
                exit;
              end
              else
                DespliegaPosCarga(PosicionActual,false);
            end;
          end;
        until (PosicionActual>=MaxPosCargaActiva);
        NumPaso:=3;
        StaticText5.Caption:=IntToStr(NumPaso);
        PosicionActual:=0;
      end
      else begin
        NumPaso:=3;
        StaticText5.Caption:=IntToStr(NumPaso);
        PosicionActual:=0;
      end;
    end;
    // Lee Totales Y Precios
    if NumPaso=3 then begin
      // GUARDA VALORES DE DISPENSARIOS CARGANDO
      inc(contguardaval);
      if (contguardaval>=3) then with DMCONS do begin
        // LEE ESTATUS ACTUAL
        try
          T_ConfIb.Active:=true;
          try
            if not T_ConfIb.IsEmpty then
              UltimoEstado:=T_ConfIbDispensarios.AsString;
          finally
            T_ConfIb.Active:=false;
          end;
        except
        end;
        // FIN
        for i:=1 to 32 do
          te_pos[i]:='';
        contguardaval:=0;
        lin:='';
        xestado:=ExtraeElemStrSep(UltimoEstado,1,'#');
        delete(xestado,1,1);
        xestado:=llenastr(xestado,'N',MaxPosCarga,'0');
        for xpos:=1 to MaxPosCarga do with TPosCarga[xpos] do begin
          if not PosicionConsola2(xpos) then begin
            case estatus of
              9:xestado[xpos]:='0'; // Sin Comunicación
              0:xestado[xpos]:='1'; // Inactivo (Idle)
              5:xestado[xpos]:='2'; // Cargando (In Use)
              8:xestado[xpos]:='3'; // Fin de Carga (Used)
              2:xestado[xpos]:='5'; // Llamando (Calling)
              1:xestado[xpos]:='9'; // Autorizado
              6,7:xestado[xpos]:='8'; // Detenido (Stoped)
              else xestado[xpos]:='0';
            end;
            if SwActualizar then begin
              xcomb:=1;
              for j:=1 to 2 do
                if PosActual=TPos[j] then
                  xcomb:=TComb[j];
              ss:=inttoclavenum(xpos,2)+'/'+inttostr(xcomb);
              ss:=ss+'/'+FormatFloat('#0.0#',volumen);
              ss:=ss+'/'+FormatFloat('#0.0#',precio);
              ss:=ss+'/'+FormatFloat('#0.0#',importe);
              te_pos[xpos]:=ss;
              //lin:=lin+'#'+ss;
            end;
          end;
        end;
        ii:=NoElemStrSep(UltimoEstado,'#');
        for i:=2 to ii do if i<>xpos then begin
          ss:=ExtraeElemStrSep(UltimoEstado,i,'#');
          ss2:=ExtraeElemStrSep(ss,1,'/');
          xp:=StrToIntDef(ss2,0);
          if PosicionConsola2(xp) then
            te_pos[xp]:=ss
        end;
        for i:=1 to 32 do
          TPosCarga[i].swactualizar:=false;
        for i:=1 to 32 do if te_pos[i]<>'' then begin
          if length(xestado+lin+'#'+te_pos[i])<=499 then
            lin:=lin+'#'+te_pos[i];
        end;
        if lin='' then
          lin:=xestado+'#'
        else
          lin:=xestado+lin;
        try
          T_ConfIb.Active:=true;
          try
            if not T_ConfIb.IsEmpty then begin
              T_ConfIb.Edit;
              ii:=length(lin)+1;
              if length(lin)>=500 then
                lin:=copy(lin,1,499);
              if swnocturno then
                T_ConfIbDispensarios.AsString:='A'+lin
              else
                T_ConfIbDispensarios.AsString:='D'+lin;
              T_ConfIb.Post;
            end;
          finally
            T_ConfIb.Active:=false;
          end;
        except
        end
      end;
      // FIN
      if PosicionActual<MaxPosCargaActiva then begin
        repeat
          Inc(PosicionActual);
          with TPosCarga[PosicionActual] do if NoComb>0 then begin
            if swcargatotales then begin
              CharCom:='N';ComandoConsola('625'+charcom+IntToStr(PosicionActual)+'\');
              exit;
            end
            else if SwCargaPrecios then begin
              CharCom:='V';ComandoConsola('591'+charcom+IntToStr(PosicionActual)+'\');
              exit;
            end
            else
              DespliegaPosCarga(PosicionActual,false);
          end;
        until (PosicionActual>=MaxPosCargaActiva);
        NumPaso:=4;
        StaticText5.Caption:=IntToStr(NumPaso);
      end
      else begin
        NumPaso:=4;
        StaticText5.Caption:=IntToStr(NumPaso);
      end;
    end;
    if (NumPaso=4) then with DMCONS do begin
      // Checa Ventas Concluidas
      try
        for xpos:=1 to MaxPosCargaActiva do with TPosCarga[xpos] do if (estatus=0)and(iniciacarga) then begin
          iniciacarga:=false;
          SwPrepago:=false;
          try
            T_ConsIb.Active:=true;
            try
              if T_ConsIb.Locate('PosCarga',xpos,[]) then begin
                if (StrToChar(T_ConsIbEstatus.AsString) in ['P','p'])or(SwPrepago) then begin
                  T_ConsIb.Edit;
                  T_ConsIbVolumen.AsFloat:=TPosCarga[xpos].volumen;
                  T_ConsIbPrecio.AsFloat:=TPosCarga[xpos].precio;
                  T_ConsIbImporte.AsFloat:=TPosCarga[xpos].importe;
                  T_ConsIbCombustible.AsString:=TPosCarga[xpos].TNombre[PosActual];
                  T_ConsIbFolio.AsInteger:=0;
                  T_ConsIb.Post;
                  T_ConsIb.Edit;
                  if SwTarjeta then
                    T_ConsIbEstatus.AsString:='F'
                  else
                    T_ConsIbEstatus.AsString:='f';
                  //lcActualiza:=true;
                  T_ConsIb.Post;
                end;
              end;
            finally
              T_ConsIb.Active:=false;
            end;
          except
            if (T_ConsIb.State=dsInsert)or(T_ConsIb.State=dsEdit) then
              T_ConsIb.Cancel;
          end;
        end;
      finally
        NumPaso:=5;
        PosicionActual:=0;
        StaticText5.Caption:=IntToStr(NumPaso);
      end;
    end;
    if NumPaso=5 then with DMCONS do begin
      // Checa peticiones de ventas con tarjeta
      Q_ConsIb.Active:=false;
      Q_ConsIb.ParamByName('pestatus').asstring:='S';
      Q_ConsIb.ParamByName('pestatus2').asstring:='s';
      Q_ConsIb.Active:=true;
      while not Q_ConsIb.Eof do begin
        xpos:=Q_ConsIbPosCarga.AsInteger;
        if xpos>PosicionActual then begin
          TPosCarga[xpos].SwTarjeta:=(Q_ConsIbEstatus.AsString<'a');
          if (Q_ConsIbValor2.AsFloat>=1)and(Q_ConsIbValor2.AsFloat<=10) then begin
            // validar maxvol
            xtipoclb:=DameTipoClb(xpos);
            (*
            xtipoclb:=TipoClb;
            if TAdic2[xpos]<>'' then
              xtipoclb:=TAdic2[xpos];
              *)
            if xTipoClb='1' then begin // FLUJO
              TPosCarga[xpos].NuevoFlujo:=Q_ConsIbValor2.AsFloat/10;
              if abs(TPosCarga[xpos].Flujo-TPosCarga[xpos].NuevoFlujo)>0.001 then begin
                TPosCarga[xpos].SwRegresaFlujo:=true;
                TPosCarga[xpos].xFlujo:=TPosCarga[xpos].Flujo;
                xaux:=Trunc(TPosCarga[xpos].NuevoFlujo/0.05+0.001);
                TPosCarga[xpos].NuevoFlujo:=xaux*0.05;
                TPosCarga[xpos].Flujo:=xaux*0.05;
                CharCom:='G'; ComandoConsola('570'+charcom+IntToStr(xpos)+'\'+inttostr(xaux)+'\');
                EsperaMiliSeg(500);
              end;
            end
            else if xTipoClb='2' then begin // maxvol
              TPosCarga[xpos].NuevoMaxVol:=990+Q_ConsIbValor2.AsFloat;
              if abs(TPosCarga[xpos].MaxVol-TPosCarga[xpos].NuevoMaxVol)>0.001 then begin
                TPosCarga[xpos].SwRegresaMaxVol:=true;
                TPosCarga[xpos].xMaxVol:=TPosCarga[xpos].MaxVol;
                xaux:=Trunc(TPosCarga[xpos].NuevoMaxVol+0.001);
                TPosCarga[xpos].NuevoMaxVol:=xaux;
                TPosCarga[xpos].MaxVol:=xaux;
                if xaux<990 then
                  xaux:=990;
                if DameTipoClb(xpos)='2' then begin
                  CharCom:='I';
                  ComandoConsola('501'+charcom+IntToStr(xpos)+'\'+inttostr(xaux)+'\');
                end
                else begin
                  CharCom:='I';
                  ComandoConsola('501'+charcom+IntToStr(xpos)+'\950\');
                end;
                EsperaMiliSeg(500);
              end;
            end;
          end;
          if Q_ConsIbMonVol.AsString='V' then begin // litros
            CharCom:='P';
            ss:='121'+charcom+IntToStr(xpos)+'\'+
                IntToStr(Q_ConsIbPosicion.asinteger)+'\1\'+FormatFloat('####0.00',Q_ConsIbValor.AsFloat)+'\';
          end
          else begin
            CharCom:='P';
            ss:='120'+charcom+IntToStr(xpos)+'\'+
                IntToStr(Q_ConsIbPosicion.asinteger)+'\1\'+FormatFloat('####0.00',Q_ConsIbValor.AsFloat)+'\';
          end;
          PosicionActual:=xpos;
          ComandoConsola(ss);
          exit;
        end
        else begin // PONER ERROR EN POSICION
          if TPosCarga[xpos].SwTarjeta then
            xestatus:='E'
          else
            xestatus:='e';
          try
            T_ConsIb.Active:=true;
            try
              if T_ConsIb.Locate('PosCarga',xpos,[]) then begin
                T_ConsIb.Edit;
                T_ConsIbEstatus.AsString:=xestatus;
                TPosCarga[xpos].EstaT_Cons:=StrToChar(T_ConsIbEstatus.AsString);
                //lcActualiza:=true;
                T_ConsIb.Post;
                TPosCarga[xpos].SwPrepago:=true;
              end;
            finally
              T_ConsIb.Active:=false;
            end;
          except
            if (T_ConsIb.State=dsInsert)or(T_ConsIb.State=dsEdit) then
              T_ConsIb.Cancel;
          end;
        end;
        Q_ConsIb.Next;
      end;
      NumPaso:=6;
      StaticText5.Caption:=IntToStr(NumPaso);
    end;
    if NumPaso=6 then begin
      // CHECA SI HAY SOLICITUD DE CORTE
      with DMCONS do if SwCorteTurno then begin
        xLista:=TStringList.Create;
        try
          rsp:=EjecutaCorte;
          xLista.Add(rsp);
        finally
          xLista.Free;
        end;
      end;

      // Checa Comandos
      with DMCONS do if (Now-FechaHoraComando)>5*tmSegundo then begin
        FechaHoraComando:=Now;
        Q_Cmnd.Active:=false;
        Q_Cmnd.ParamByName('pmodulo').AsString:='DISP';
        Q_Cmnd.Active:=true;
        while not Q_Cmnd.Eof do begin
          ss:=ExtraeElemStrSep(Q_CmndComando.AsString,1,' ');
          // CMND: CERRAR CONSOLA
          if ss='CERRAR' then begin
            rsp:='OK';
            SwCerrar:=true;
          end
          else if ss='DPC' then begin
            xpos:=strtointdef(ExtraeElemStrSep(Q_CmndComando.AsString,2,' '),0);
            if xpos in [1..MaxPosCarga] then
              TPosCarga[xpos].SwDesHabilitado:=true;
          end
          else if ss='HPC' then begin
            xpos:=strtointdef(ExtraeElemStrSep(Q_CmndComando.AsString,2,' '),0);
            if xpos in [1..MaxPosCarga] then
              TPosCarga[xpos].SwDesHabilitado:=false;
          end
          else if ss='FLUSTD' then begin  // FLUJO ESTANDAR
            rsp:='';
            for npos:=1 to MaxPosCarga do begin
              Q_Pcar.Active:=false;
              Q_Pcar.Active:=true;
              xtipoclb:=DameTipoClb(npos);
              if (xTipoClb='1')or(xTipoClb='3') then begin // FLUJO
                SwFlujoAct:=true;
                Q_Pcar.First;
                while not Q_Pcar.Eof do begin
                  xpos:=Q_PcarPosCarga.AsInteger;
                  if xpos=npos then begin
                    TPosCarga[xpos].Flujo:=-1;
                    TPosCarga[xpos].NuevoFlujo:=Q_PcarSlowFlow.AsFloat;
                    TAdic3[xpos]:=Q_PcarSlowFlow.AsFloat;
                    i:=Trunc(10*Q_PcarSlowFlow.AsFloat+0.5);
                    rsp:=rsp+IntToStr(xpos)+IntToStr(i)+'|';
                  end;
                  Q_Pcar.Next;
                end;
              end
              else if XTipoClb='2' then begin // MAXVOL
                TPosCarga[npos].SwMaxVolAct:=true;
                Q_Pcar.First;
                while not Q_Pcar.Eof do begin
                  xpos:=Q_PcarPosCarga.AsInteger;
                  if xpos=npos then begin
                    TPosCarga[xpos].MaxVol:=-1;
                    TAdic3[xpos]:=Q_PcarSlowFlow.AsFloat;
                    i:=Trunc(10*Q_PcarSlowFlow.AsFloat+0.5);
                    TPosCarga[xpos].NuevoMaxVol:=990+i;
                    rsp:=rsp+IntToStr(xpos)+IntToStr(i)+'|';
                  end;
                  Q_Pcar.Next;
                end;
              end;
            end;
            Timer2.Enabled:=true;
          end
          else if ss='FLUMIN' then begin // FLUJO MINIMO
            rsp:='';
            for npos:=1 to MaxPosCarga do begin
              Q_Pcar.Active:=false;
              Q_Pcar.Active:=true;
              xtipoclb:=DameTipoClb(npos);
              if xTipoClb='1' then begin
                SwFlujoAct:=false;
                xpos:=npos;
                if TAdic[xpos]='' then begin
                  TPosCarga[xpos].NuevoFlujo:=0.1;
                  TAdic3[xpos]:=0.1;
                end
                else begin
                  try
                    TAdic3[xpos]:=0.1;
                    TPosCarga[xpos].NuevoFlujo:=StrToFloat(TAdic[xpos]);
                  except
                    TPosCarga[xpos].NuevoFlujo:=0.1;
                  end;
                end;
                rsp:=rsp+IntToStr(xpos)+IntToStr(1)+'|';
              end
              else if xTipoClb='2' then begin
                TPosCarga[npos].SwMaxVolAct:=true;
                xpos:=npos;
                TPosCarga[xpos].NuevoMaxVol:=990;
                TAdic3[xpos]:=0;
                rsp:=rsp+IntToStr(xpos)+IntToStr(0)+'|';
              end
              else if xTipoClb='3' then begin
                SwFlujoAct:=false;
                xpos:=npos;
                xvalmin:=0.25;
                if TPosCarga[xpos].TComb[1]=3 then
                  xvalmin:=1.00;
                if TAdic[xpos]='' then begin
                  TPosCarga[xpos].NuevoFlujo:=xvalmin;
                  TAdic3[xpos]:=xvalmin;
                end
                else begin
                  try
                    TAdic3[xpos]:=xvalmin;
                    TPosCarga[xpos].NuevoFlujo:=StrToFloat(TAdic[xpos]);
                  except
                    TPosCarga[xpos].NuevoFlujo:=xvalmin;
                  end;
                end;
                rsp:=rsp+IntToStr(xpos)+IntToStr(1)+'|';
              end;
            end;
            Timer2.Enabled:=true;
          end
          else if ss='CORTE' then begin
            try
              xFechaCorte:=StrToFecha(ExtraeElemStrSep(Q_CmndComando.AsString,2,' '));
              xTurnoCorte:=StrToIntDef(ExtraeElemStrSep(Q_CmndComando.AsString,3,' '),0);
              xIslaCorte:=StrToIntDef(ExtraeElemStrSep(Q_CmndComando.AsString,4,' '),0);
              SwCorteParcial:=false;
              rsp:=EjecutaCorte;
            except
              rsp:='Comando Erroneo';
            end;
          end
          else if ss='CORTEPARCIAL' then begin
            try
              xFechaCorte:=StrToFecha(ExtraeElemStrSep(Q_CmndComando.AsString,2,' '));
              xTurnoCorte:=StrToIntDef(ExtraeElemStrSep(Q_CmndComando.AsString,3,' '),0);
              xIslaCorte:=StrToIntDef(ExtraeElemStrSep(Q_CmndComando.AsString,4,' '),0);
              SwCorteParcial:=true;
              rsp:=EjecutaCorte;
            except
              rsp:='Comando Erroneo';
            end;
          end;
          try
            T_Cmnd.Active:=true;
            if T_Cmnd.Locate('Folio',Q_CmndFolio.AsInteger,[]) then begin
              T_Cmnd.Edit;
              T_CmndAplicado.AsString:='Si';
              T_CmndResultado.AsString:=rsp;
              T_Cmnd.Post;
            end;
          except
          end;
          if SwCerrar then
            Close;
          Q_Cmnd.Next;
        end;
      end;
      NumPaso:=0;
    end;
  except
    with DMCONS do begin
      if T_ConsIb.State in [dsInsert,dsEdit] then
        T_ConsIb.Cancel;
      if T_Cmnd.State in [dsInsert,dsEdit] then
        T_Cmnd.Cancel;
    end;
  end;
end;

procedure TFDISDHC.ApdComPort1TriggerAvail(CP: TObject; Count: Word);
var I:Word;
    C:Char;
begin
  try
    ContadorAlarma:=0;
    Timer1.Enabled:=false;
    try
      for I := 1 to Count do begin
        C:=ApdComPort1.GetChar;
        LineaBuff:=LineaBuff+C;
      end;
      while (not FinLinea)and(Length(LineaBuff)>0) do begin
        c:=LineaBuff[1];
        delete(LineaBuff,1,1);
        Linea:=Linea+C;
        if SwBcc then begin
          FinLinea:=true;
        end;
        if C=idETX then begin
          SwBcc:=true;
        end;
        if (C=idACK)or(c=idNAK) then
          FinLinea:=true;
      end;
      if FinLinea then begin
        LineaTimer:=Linea;
        DMCONS.AgregaLog('R '+LineaTimer);
        Linea:='';
        SwBcc:=false;
        FinLinea:=false;
        ProcesaLinea;
        LineaTimer:='';
        SwEspera:=false;
      end
      else SwEspera:=true;
    finally
      Timer1.Enabled:=true;
    end;
  except
  end;
end;

procedure TFDISDHC.ComandoConsola(ss:string);
var s1:string;
    cc:char;
begin
  try
    if DMCONS.SwEmular then begin
      DMCONS.AgregaLog('E '+ss+' ');
      LineaEmular:=ss;
      exit;
    end;
    inc(ContadorAlarma);
    if not ApdComPort1.Open then begin
      MensajeErr('Puerto no esta abierto');
      Application.Terminate;
    end;
    Timer1.Enabled:=false;
    try
      LineaBuff:='';
      cc:=CalculaBCC(ss+idEtx);
      s1:=idStx+#127+ss+idEtx+CC;
      if ApdComPort1.OutBuffFree >= Length(S1) then begin
        DMCONS.AgregaLog('E '+s1);
        ApdComPort1.PutString(S1);
      end
      else begin
        inc(ContBuffLleno);
      end;
    finally
      Timer1.Enabled:=true;
    end;
  except
  end;
end;


procedure TFDISDHC.ListBox1Click(Sender: TObject);
begin
  LimpiaConsola;
end;

procedure TFDISDHC.Restaurar1Click(Sender: TObject);
begin
  Desplegada:=true;
  Visible:=true;
end;

procedure TFDISDHC.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if SwCerrar then begin
    CanClose:=true;
  end
  else if DMCONS.SwEmular then begin
    CanClose:=true;
  end
  else begin
    CanClose:=false;
  end;
end;

procedure TFDISDHC.FormCreate(Sender: TObject);
begin
  ListaAux:=TstringList.Create;
  SwCerrar:=false;
  SwInicio:=true;
  ContGuardaVal:=0;
  ContadorAlarma:=0;
end;

procedure TFDISDHC.BitBtn3Click(Sender: TObject);
begin
  Desplegada:=false;
  Visible:=false;
  NotificationIcon1.Show;
end;

procedure TFDISDHC.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ApdComPort1.Open:=false;
  Application.terminate;
end;

procedure TFDISDHC.Timer1Timer(Sender: TObject);
var i:integer;
begin
  try
    with DMCONS do begin
      inc(ContadorTot);
      if (ContadorTot>=100) then begin
        ContadorTot:=0;
        inc(ContadorTotPos);
        if ContadorTotPos in [1..MaxPosCarga] then begin
          TPosCarga[ContadorTotPos].SwCargaTotales:=true;
        end
        else ContadorTotPos:=0;
      end;
    end;
    if ContadorAlarma>=10 then begin
      if not StaticText17.Visible then
        Beep;
      StaticText17.Visible:=not StaticText17.Visible;
    end
    else StaticText17.Visible:=false;
    try
      lee_registro;
    except
    end;
    // Logs
    if (Now-DMCONS.FechaHoraRefLog)>tmMinuto then
      DMCONS.RefrescaConexion;

    // Checa por cambios de precios
    if ((Now-DMCONS.FechaHoraPrecio)>12*tmSegundo)and(not CheckBox1.checked) then begin
      DMCONS.FechaHoraPrecio:=Now;
      with DMCONS do if AplicarPrecios then begin
        for i:=1 to MaxComb do with TabComb[i] do if Activo then begin
          Q_AplicaPrecioF.ParamByName('pFolio').AsInteger:=Folio;
          Q_AplicaPrecioF.ParamByName('pCombustible').AsInteger:=i;
          Q_AplicaPrecioF.ParamByName('pError').AsString:='No';
          Q_AplicaPrecioF.ExecSQL;
        end;
        CargaPreciosFH(Now,true); // guarda precio actual como físico
        DespliegaPrecios;
        DBGrid3.Refresh;
        for i:=1 to MaxPosCarga do
          TPosCarga[i].ActualizarPrecio:=true;
      end;
    end;
    if NumPaso>1 then begin
      if NumPaso=2 then begin // si esta en espera de respuesta ACK
        StaticText6.Caption:='Espera2';
        inc(ContEsperaPaso2);     // espera hasta 5 ciclos
        if ContEsperaPaso2>MaxEspera2 then begin
          NumPaso:=1;
          exit;
        end;
      end;
      if NumPaso=3 then begin // si esta en espera de respuesta ACK
        StaticText6.Caption:='Espera3';
        inc(ContEsperaPaso3);     // espera hasta 5 ciclos
        if ContEsperaPaso3>MaxEspera3 then begin
          ContEsperaPaso3:=0;
          LineaTimer:='.N00..';  // de lo contrario provoca un NAK para que continue
          ProcesaLinea;       // el proceso con la siguiente solicitud
        end;
      end;
      exit;
    end;

    // Espera en el paso 0 hasta que reciba respuesta
    if NumPaso=1 then begin
      StaticText6.Caption:='Espera1';
      inc(ContEspera);
      if ContEspera>3 then begin
        NumPaso:=0;
      end
      else exit;
    end;
    NumPaso:=1;
    StaticText5.Caption:=IntToStr(NumPaso);
    ContEspera:=0;
    SwEspera:=true;
    StaticText6.Caption:='Esperando..';
    if not SwReinicio then begin
      CharCom:='B';
      ComandoConsola('170'+charcom+#127+'\');
    end
    else begin
      CharCom:='B';
      SwReinicio:=false;
      LineaTimer:=UltimaLineaTimer;
      ProcesaLinea;
    end;
    if NotificationIcon1.Tag=0 then begin
      if ErrorInic then begin
        EsperaMiliSeg(3000);
        Application.Terminate;
      end;
      NotificationIcon1.Tag:=1;
      FDISMENU.Visible:=false;
      FDISDHC.Visible:=false;
      NotificationIcon1.Show;
    end;
  except
  end;
end;




procedure TFDISDHC.RadioGroup1Click(Sender: TObject);
begin
  with DMCONS do begin
    case RadioGroup1.ItemIndex of
      0:if SwNocturno then begin
          FAutoriza2.PideAutorizacion('Servicio Nocturno');
          if StrMayuscIguales(FAutoriza2.EditP.Text,DMCONS.PasswordNocturno) then
            PonTipoServicio('Diurno')
          else MensajeErr('Clave Errónea');
        end;
      1:if not SwNocturno then begin
          FAutoriza2.PideAutorizacion('Servicio Nocturno');
          if StrMayuscIguales(FAutoriza2.EditP.Text,DMCONS.PasswordNocturno) then
            PonTipoServicio('Nocturno')
          else MensajeErr('Clave Errónea');
        end;
    end;
    if SwNocturno then begin
      RadioGroup1.ItemIndex:=1;
      GroupBox1.Visible:=true;
      MaskEdit1.SetFocus;
      Memo2.Visible:=true;
      DBGrid3.Visible:=false;
    end
    else begin
      RadioGroup1.ItemIndex:=0;
      GroupBox1.Visible:=false;
      Memo2.Visible:=false;
      DBGrid3.Visible:=true;
    end;
  end;
end;

procedure TFDISDHC.BitBtn2Click(Sender: TObject);
var xpos:Integer;
    ss:string;
begin
  StaticText16.Caption:='';
  try
    SnPosCarga:=StrToInt(MaskEdit1.text);
    if not (SnPosCarga in [1..MaxPosCarga]) then
      raise Exception.Create('Posición de Carga no Existe');
  except
    MaskEdit1.SetFocus;
    raise Exception.Create('Posición de Carga no Existe');
  end;
  try
    SnImporte:=StrToFloat(MaskEdit2.text);
    MaskEdit2.text:=FormatoMoneda(SnImporte);
  except
    MaskEdit2.SetFocus;
    raise Exception.Create('Valor Numérico Erroneo');
  end;
  xpos:=SnPosCarga;
  PosicionActual:=xpos;
  if not (TPosCarga[xpos].estatus in [0]) then
    raise Exception.Create('Error al Activar Posición de Carga');
  CharCom:='P';
  ss:='120'+charcom+IntToStr(xpos)+'\\1\'+FormatFloat('####0.00',SnImporte)+'\';
  ComandoConsola(ss);
end;



procedure TFDISDHC.Timer3Timer(Sender: TObject);
const timpo:array[0..4] of real = (50,100,150,200,30);
      tpos:array[0..2] of integer = (2,1,2);
var xpos,rr,nn,i:integer;
    lin:string;
begin
  if LineaEmular='' then
    exit;
  Randomize;
  Timer1.Enabled:=false;
  try
    if LineaEmular<>'' then begin
      Lin:=LineaEmular;
      LineaEmular:='';
      case CharCom of
        'B':with DMCONS do begin
              rr:=Random(8);
              if rr=1 then begin
                xpos:=Random(MaxPosCarga)+1;
                if not PosicionConsola2(xpos) then begin
                  if EmularEstatus[xpos]='9' then
                    EmularEstatus[xpos]:='0';
                  case EmularEstatus[xpos] of
                    '0':begin
                          EmularEstatus[xpos]:='5';
                          rr:=Random(5);
                          TPosCarga[xpos].volumen:=Timpo[rr]/5;
                          TPosCarga[xpos].importe:=timpo[rr];
                          TPosCarga[xpos].precio:=5;
                          TPosCarga[xpos].horax:=time;
                          rr:=Random(3);
                          nn:=tpos[rr];
                          if nn>TPosCarga[xpos].NoComb then
                            nn:=TPosCarga[xpos].NoComb;
                          if nn=0 then
                            nn:=1;
                          TPosCarga[xpos].posactual:=nn;
                          if TabComb[TPosCarga[xpos].TComb[nn]].precio>0.01 then begin
                            if (TPosCarga[xpos].ActualizarPrecio)and(not PrimeraCarga) then
                              TPosCarga[xpos].precio:=TabComb[TPosCarga[xpos].TComb[nn]].precioant
                            else
                              TPosCarga[xpos].precio:=TabComb[TPosCarga[xpos].TComb[nn]].precio;
                            TPosCarga[xpos].volumen:=DivideFloat(TPosCarga[xpos].importe,TPosCarga[xpos].precio);
                          end;
                        end;
                    '5':EmularEstatus[xpos]:='0';
                  end;
                end
                else EmularEstatus[xpos]:='9';
              end
              else begin
                for xpos:=1 to MaxPosCarga do with TPosCarga[xpos] do begin
                  if not PosicionConsola2(xpos) then begin
                    if (EmularEstatus[xpos]='5')and((Time-Horax)>20*tmsegundo)then
                      EmularEstatus[xpos]:='0';
                  end
                  else EmularEstatus[xpos]:='9';
                end;
              end;
              Linea:='xH'+charcom+EmularEstatus;
            end;
        'A':begin
              // HHA@\2\6.27\70\11.164\
              xpos:=PosicionActual; //StrToIntDef(copy(lin,2,2),1);
              Linea:='xH'+charcom+'\'+IntToStr(TPosCarga[xpos].posactual)+'\'+
                     FormatFloat('#0.00',TPosCarga[xpos].precio)+'\'+
                     FormatFloat('###0.00',TPosCarga[xpos].importe)+'\'+
                     FormatFloat('###0.00',TPosCarga[xpos].volumen)+'\';
            end;
        'F':begin
              //MHA8\8\8\8\8\8\8\8\8\8\8\8\6\8\6\6\2\2\2\2\
              Linea:='xH'+charcom;
              for xpos:=1 to MaxPosCarga do
                Linea:=Linea+IntToStr(Trunc(TPosCarga[xpos].Flujo/0.05+0.001))+'\';
            end;
        'H':begin
              //MHA01\990\
              Linea:='xH'+charcom;
              if TPosCarga[xposmaxvol].MaxVol=0 then
                TPosCarga[xposmaxvol].MaxVol:=990;
              Linea:=Linea+'0\'+IntToStr(Trunc(TPosCarga[xposmaxvol].MaxVol+0.001))+'\';
            end;
        'G','J','S','T','U','D','P':begin
              Linea:='xH'+charcom+'xxxx';
            end;
        'C':begin
              Linea:='xH'+charcom;
              for i:=1 to MaxPosCarga do with TPosCarga[i] do
                Linea:=Linea+IntToStr(NoComb)+'\';
            end;
        'M','I':Linea:='xH'+charcom+'\';
        'V':begin
              Linea:='xH'+charcom;
              with TPosCarga[PosicionActual] do with DMCONS do
                for i:=1 to NoComb do
                  Linea:=Linea+FloatToStr(TabComb[TComb[TPos[i]]].Precio)+'\';
            end;
        'N':begin
              Linea:='xH'+charcom+'\\';
              with TPosCarga[PosicionActual] do
                for i:=1 to NoComb do
                  Linea:=Linea+IntToStr(i*100000)+'\\\\';
            end;
        'E':Linea:='xH'+charcom+'\\';
        else exit;
      end;
      LineaTimer:=' '+Linea+'  ';
      DMCONS.AgregaLog('R '+LineaTimer);
      ProcesaLinea;
      SwEspera:=false;
    end;
  finally
    Timer1.Enabled:=true;
  end;
end;

procedure TFDISDHC.MaskEdit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=13 then
    MaskEdit2.SetFocus;
  if key in [48..57] then begin
    MaskEdit2.Text:='';
    StaticText16.Caption:='';
  end;
end;

procedure TFDISDHC.MaskEdit2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=13 then
    BitBtn2.SetFocus;
end;

procedure TFDISDHC.ListBox1KeyPress(Sender: TObject; var Key: Char);
begin
  if key='*' then
    MaskEdit1.SetFocus;
end;

procedure TFDISDHC.MaskEdit1Enter(Sender: TObject);
begin
  MaskEdit1.Text:='';
  MaskEdit2.Text:='';
end;

procedure TFDISDHC.GroupBox1Enter(Sender: TObject);
begin
  if SwProcesando then
    Memo2.SetFocus;
end;

procedure TFDISDHC.MaskEdit1Exit(Sender: TObject);
begin
  MaskEdit1.Text:=FiltraStrNum(MaskEdit1.Text);
end;

procedure TFDISDHC.registro(valor:integer;variable:string);
var
  Registry: TRegistry;
begin
  Registry := TRegistry.Create(KEY_WRITE);
  try
    Registry.RootKey := HKEY_LOCAL_MACHINE;
    if Registry.OpenKey('\SOFTWARE\IMAGEN\VOL\DISP', True) then
       Registry.WriteInteger(variable,Valor)
  finally
    Registry.CloseKey;
    Registry.Free;
  end;
end;


procedure TFDISDHC.NotificationIcon1DblClick(Sender: TObject);
begin
  Restaurar1Click(Sender);
end;

procedure TFDISDHC.ListView1DblClick(Sender: TObject);
var xpos,xind:integer;
begin
  xpos:=strtointdef(copy(ListView1.ItemFocused.Caption,1,2),0);
  xind:=(xpos)div(4);
  if (xpos)mod(4)>0 then
    inc(xind);
  ListBox1.ItemIndex:=xind-1;
  ListBox1Click(sender);
end;

procedure TFDISDHC.lee_registro;
var
  Registry: TRegistry;
  estado:integer;
begin
  Registry := TRegistry.Create(KEY_READ);
  try
    Registry.RootKey := HKEY_LOCAL_MACHINE;
    estado:=0;
    try
      if Registry.OpenKey('\SOFTWARE\IMAGEN\VOL\DISP', True) then
        Estado:=Registry.ReadInteger('Estado');
    except
    end;
    if Estado=1 then begin
      Self.Visible:=true;
      Self.WindowState:=wsMaximized;
      Self.BringToFront;
      registro(0,'Estado');
    end;
  finally
    Registry.CloseKey;
    Registry.Free;
    registro(0,'Estado');
  end;
end;


procedure TFDISDHC.ListBoxPC1DblClick(Sender: TObject);
begin
  SwDespFlujo:=not SwDespFlujo;
  if DMCONS.lcSerie=42 then begin
    ListBoxPC2.Color:=clWindow;
    ListBoxPC3.Color:=clWindow;
    ListBoxPC4.Color:=clWindow;
    if ListBoxPC1.Color=clWindow then begin
      ListBoxPC1.Color:=clAqua;
      SwArmado:=true;
      PosArmado:=StrToIntDef(StaticText1.Caption,0);
    end
    else begin
      ListBoxPC1.Color:=clWindow;
      SwArmado:=false;
    end;
    Button2.Visible:=SwArmado;
    Button2.Caption:='Armar '+IntToClaveNum(PosArmado,2);
    Button3.Visible:=SwArmado;
    Button3.Caption:='Desarmar '+IntToClaveNum(PosArmado,2);
    SwDespFlujo:=SwArmado;
  end;
end;

procedure TFDISDHC.Refrescar1Click(Sender: TObject);
var xpos:string;
    npos:integer;
begin
  if sender=Refrescar1 then
    xpos:=StaticText1.Caption;
  if sender=Refrescar2 then
    xpos:=StaticText2.Caption;
  if sender=Refrescar3 then
    xpos:=StaticText3.Caption;
  if sender=Refrescar4 then begin
    xpos:=StaticText4.Caption;
    if DMCONS.swemular then
      case EmularEstatus[4] of
        '9':EmularEstatus[4]:='0';
        else EmularEstatus[4]:='9';
      end;
  end;
  npos:=StrToIntDef(xpos,0);
  if npos in [1..MaxPosCargaActiva] then with TPosCarga[npos] do begin
    SwCargaPrecios:=true;
    SwCargaLectura:=true;
    SwCargaTotales:=true;
  end;
end;

procedure TFDISDHC.SpeedButton1Click(Sender: TObject);
var xpos:integer;
begin
  with DMCONS do begin
    SwFlujoAct:=not SwFlujoAct;
    if SwFlujoAct then begin
      SpeedButton1.Caption:='';
      Q_Pcar.Active:=false;
      Q_Pcar.Active:=true;
      while not Q_Pcar.Eof do begin
        xpos:=Q_PcarPosCarga.AsInteger;
        if xpos in [1..MaxPosCarga] then
          TPosCarga[xpos].NuevoFlujo:=Q_PcarSlowFlow.AsFloat;
        Q_Pcar.Next;
      end;
    end
    else begin
      SpeedButton1.Caption:='X';
      for xpos:=1 to MaxPosCarga do
        TPosCarga[xpos].NuevoFlujo:=0.1;
    end;
  end;
end;

procedure TFDISDHC.Button1Click(Sender: TObject);
begin
  DMCONS.ListaLog.SaveToFile('\ImagenCo\Log'+FiltraStrNum(FechaHoraToStr(Now))+'.Txt');
end;

procedure TFDISDHC.ListBoxPC2Click(Sender: TObject);
begin
  if DMCONS.lcSerie=42 then begin
    ListBoxPC1.Color:=clWindow;
    ListBoxPC3.Color:=clWindow;
    ListBoxPC4.Color:=clWindow;
    if ListBoxPC2.Color=clWindow then begin
      ListBoxPC2.Color:=clAqua;
      SwArmado:=true;
      PosArmado:=StrToIntDef(StaticText2.Caption,0);
    end
    else begin
      ListBoxPC2.Color:=clWindow;
      SwArmado:=false;
    end;
    Button2.Visible:=SwArmado;
    Button2.Caption:='Armar '+IntToClaveNum(PosArmado,2);
    Button3.Visible:=SwArmado;
    Button3.Caption:='Desarmar '+IntToClaveNum(PosArmado,2);
    SwDespFlujo:=SwArmado;
  end;

end;

procedure TFDISDHC.ListBoxPC3DblClick(Sender: TObject);
begin
  if DMCONS.lcSerie=42 then begin
    ListBoxPC1.Color:=clWindow;
    ListBoxPC2.Color:=clWindow;
    ListBoxPC4.Color:=clWindow;
    if ListBoxPC3.Color=clWindow then begin
      ListBoxPC3.Color:=clAqua;
      SwArmado:=true;
      PosArmado:=StrToIntDef(StaticText3.Caption,0);
    end
    else begin
      ListBoxPC3.Color:=clWindow;
      SwArmado:=false;
    end;
    Button2.Visible:=SwArmado;
    Button2.Caption:='Armar '+IntToClaveNum(PosArmado,2);
    Button3.Visible:=SwArmado;
    Button3.Caption:='Desarmar '+IntToClaveNum(PosArmado,2);
    SwDespFlujo:=SwArmado;
  end;
end;

procedure TFDISDHC.ListBoxPC4DblClick(Sender: TObject);
begin
  if DMCONS.lcSerie=42 then begin
    ListBoxPC1.Color:=clWindow;
    ListBoxPC3.Color:=clWindow;
    ListBoxPC2.Color:=clWindow;
    if ListBoxPC4.Color=clWindow then begin
      ListBoxPC4.Color:=clAqua;
      SwArmado:=true;
      PosArmado:=StrToIntDef(StaticText4.Caption,0);
    end
    else begin
      ListBoxPC4.Color:=clWindow;
      SwArmado:=false;
    end;
    Button2.Visible:=SwArmado;
    Button2.Caption:='Armar '+IntToClaveNum(PosArmado,2);
    Button3.Visible:=SwArmado;
    Button3.Caption:='Desarmar '+IntToClaveNum(PosArmado,2);
    SwDespFlujo:=SwArmado;
  end;
end;

procedure TFDISDHC.Button2Click(Sender: TObject);
begin
  if DMCONS.lcSerie=42 then begin
    CharCom:='G';
    if PosArmado in [1..2] then
      ComandoConsola('570'+charcom+IntToStr(PosArmado)+'\35\')
    else
      ComandoConsola('570'+charcom+IntToStr(PosArmado)+'\77\');
    EsperaMiliSeg(500);
    Button2.Caption:=IntToClaveNum(PosArmado,2)+' Armada';
  end;
end;

procedure TFDISDHC.Button3Click(Sender: TObject);
begin
  if DMCONS.lcSerie=42 then begin
    CharCom:='G';
    ComandoConsola('570'+charcom+IntToStr(PosArmado)+'\7\');
    EsperaMiliSeg(500);
    Button3.Caption:=IntToClaveNum(PosArmado,2)+' Desarmada';
  end;
end;

procedure TFDISDHC.Timer2Timer(Sender: TObject);
var xpos:integer;
begin
  with DMCONS do begin
    Timer2.Enabled:=false;
    ListaAux.Clear;
    ListaAux.Add(inttostr(stadic));
    for xpos:=1 to MaxPosCarga do 
      ListaAux.Add(floattostr(TAdic3[xpos]));
    ListaAux.SaveToFile(DirectorioWindows+'\AdicTmp.Txt');
  end;
end;

end.
