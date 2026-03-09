unit ULIBGRAL;

interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, DBCtrls, ComCtrls, ExtCtrls, Grids, DBGrids, Menus,
  Mask, db, dbTables, Printers, Math, DateUtils;

Type   Str2  =string[2];
       Str3  =string[3];
       Str4  =string[4];
       Str5  =string[5];
       Str6  =string[6];
       Str7  =string[7];
       Str8  =string[8];
       Str9  =string[9];
       Str10 =string[10];
       Str15 =string[15];
       Str20 =string[20];

       TMes  =string[6];


const
       idF1 = 112; idF2 = 113; idF3 = 114; idF4 = 115; idF5 = 116;
       idF6 = 117; idF7 = 118; idF8 = 119; idF9 = 120; idF10= 121;
       idEnter= 13; idEsc=27;

       MaskMoneda='###,###,##0.00';
       MaskFloat4='#,###,##0.0000';
       FormatFecha='dd/mm/yyyy';
       MaskMes='!99/0000;0;_';
       MaskFecha1='!99/99/0000;0;_';
       MaskFecha2='!99/99/0000;1;_';

       mbNumerico='Numérico';
       mbAlfabetico='Alfabético';
       tmMinuto=1/1440;
       tmHora=1/24;
       tmSegundo=1/86400;


       TMeses:array[1..12] of string[10] =
             ('Enero','Febrero','Marzo','Abril','Mayo','Junio','Julio',
              'Agosto','Septiembre','Octubre','Noviembre','Diciembre');

       TMesesIngles:array[1..12] of string[10] =
             ('January','February','March','April','May','June','July',
              'August','September','October','November','December');

       TMesesb:array[1..12] of string[3] =
             ('Ene','Feb','Mar','Abr','May','Jun','Jul','Ago','Sep','Oct','Nov','Dic');

       TDias :array[1..7] of string =
             ('Domingo','Lunes','Martes','Miércoles','Jueves','Viernes','Sábado');


type
  TGlobalExHandler = class
  public
    procedure HandlerProc(Sender:TObject; E:Exception);
  end;

var GlobalExHandler :TGlobalExHandler;
    ErrorMsg :string;
    ErrorInic:boolean=true;

// SECCIONES
//  1.- FECHAS
//  2.- STRINGS
//  3.- MENSAJES
//  4.- NUMEROS
//  5.- FUENTES
//  6.- Componentes VCL
//  7.- Varios


// FECHAS
function FechaInicialSist:TDateTime;
function FechaToMes(xdate:TDateTime):Tmes;
function FechaToStr(xdate:TDateTime):String; (* AAAAMMDD *)
function FechaToStrSQL(xdate:TDateTime):String; (* AAAAMMDD *)
FUNCTION FechaHoraToStrSQL(xdate:TDateTime):String;
function StrToFecha(xfec:string):TDateTime; (* AAAAMMDD*)
function StrToHora(xhor:string):TDateTime; (* HHMM*)
function StrToFechaHora(xfechor:string):TDateTime; (* AAAAMMDDHHMM*)
procedure FechaHoraToSystem(xFechaHora:TDateTime);
function MesDiaToFecha(xmes:string;xdia:word):TDateTime;
function FecOldToFecha(xfec:string):TDateTime;
function FecOldToMes(xfec:string):string;
function MesOldToMes(xmes:string):string;
function MesDiaMaxToFecha(xmes:string):TDateTime;
function MesToVmes(xmes:Tmes):string;
function VmesToMes(xmes:string):Tmes;
function MesActual:Tmes;
function MesToInt(xmes:Tmes):longint;
function IntToMes(nmes:longint):Tmes;
function IncMes(xmes:Tmes;n:longint):Tmes;
procedure SetDiaToFecha(dia:word;var fecha:Tdatetime);
procedure SetMesToFecha(mes:word;var fecha:Tdatetime);
procedure SetAnoToFecha(ano:word;var fecha:Tdatetime);
function GetAnoFromFecha(fecha:Tdatetime):word;
function GetAnoFromMes(xmes:Tmes):word;
function GetMesFromMes(xmes:Tmes):word;
function GetDiaFromFecha(fecha:Tdatetime):word;
function GetMesFromFecha(fecha:Tdatetime):word;
function GetHoraFromHora(hora:Tdatetime):word;
function GetMinFromHora(hora:Tdatetime):word;
function GetSegFromHora(hora:Tdatetime):word;
function GetDiasDelMes(fecha:Tdatetime):word;
function GetDiasDelMesStr(xmes:Tmes):word;
function DiaPrimero(xfecha:TDateTime):TDateTime;
function DiaUltimo(xfecha:TDateTime):TDateTime;
function FechaToFormato(xfecha:TDateTime):string; // DD/MM/AAAA
function FechaAlf(xfecha:TDateTime):string;
function FechaAlfIngles(xfecha:TDateTime):string;
function MesFechaAlf(xfecha:TDateTime):string;
function MesAlf(xmes:string):string;
function MesPaq(xmes:string):string;
function UnPaqMes(xmes:string):string;
function FechaPaq(xfecha:TDateTime):string;
function HoraPaq(xfechor:TDateTime):string;
function FechaHoraPaq(xfecha:TDateTime):string;
function RangoFecha(xfeci,xfecf:TDateTime):string;
function DiaSemana(xfecha:TDateTime):string;
function IncFecha(xfecha:TDateTime;n:integer):TDateTime;
function DiasEntre(xfec1,xfec2:TDateTime):longint;
function FecHorActualToStr:String;
function FechaHoraToStr(FechaHora:TDateTime):String;
function FechaHoraExtToStr(FechaHora:TDateTime):String;
function MesIntermedio(xmesi,xmesf:string):string;
function SetFechaHora(xstr:string):string;
function HoraToStr24(xhora:TDateTime):string;
procedure AvanzaFechaDelSistema(ndias:integer);

// STRINGS
function EspacioStr(n:byte):string;
function CadenaStr(n:byte;ch:char):string;
function LimpiaStr(str1:string):string;
function FormatoStr(ss:string;just:char;long:integer):string;
function LlenaStr(ss:string;just:char;long:integer;cc:char):string;
function IncStr(ss:string):string;
function IntToClaveNum(ii,long:longint):string;
function ByteToBin(num:longint):string;
function StateToStr(xstate:TDataSetState):string;
function StrToChar(xstr:string):char;
function EncriptaStr(xstr:string):string;
function DesencriptaStr(xstr:string):string;
function Mayusculas(xstr:string):string;
function ExtraeElemStr(xstr:string;ind:word):string;
procedure InsertaElemStr(xstri:string;ind:word;var xstr:string);
function CreaListaElemStr(const valores:variant;cant:word):string;
function NoElemStr(xstr:string):word;
function ExtraeElemStrSep(xstr:string;ind:word;xsep:char):string;
procedure InsertaElemStrSep(xstri:string;ind:word;xsep:char;var xstr:string);
function NoElemStrSep(xstr:string;xsep:char):word;
function ExisteElemStrSep(xelem,xstr:string;xsep:char):boolean;
function StrMayuscIguales(ss1,ss2:string):boolean;
function ContieneChar(xstr:string;xch:char):boolean;
function LimpiaCaracter(str1:string;caracter:char):string;
function SetEspacios(importe:double):string;
function FiltraStrNum(str1:string):string;
function FiltraStrFloat(str1:string):string;
function FiltraStrLetras(str1:string):string;
function FiltraStrAlfaNum(str1:string):string;
function DameAlineaStr(var xstr:string):char;
procedure PegaStrPosLong(var xstr:string;substr:string;xpos,xlon:byte;xalign:string);
function FormatoRfc(xrfc:string):string;
function ExtraeLineaDeParrafo(xstr:string;xLongMax,xIndice:word):string;
function StrToHex(xstr:string):string;
function HexToStr(xstr:string):string;
function HexToInt(xstr:string):integer;
function HexToBinary(xcar:char):string;
function StrToHexSep(ss:string):string;
function HexSepToStr(ss:string):string;
function HexLongToBinary(xss:string):string;
function BinaryToInt(xbin:string):integer;
function IntToBinary(xint,xlon:integer):string;
function IeeeToFloat(xstr:string):real;

// MENSAJES
Procedure MensajeErr(msg:string);
Procedure MensajeWarn(msg:string);
Function MensajeConf(msg:string):word;
Procedure MensajeInfo(msg:string);

// NUMEROS
function  EsCero(xnum:double):boolean;
function  DivideFloat(n1,n2:double):double;
function  AjustaFloat(n:double;d:byte):double;
procedure IncFloat(var xnum:double; xvalor:double);
procedure DecFloat(var xnum:double; xvalor:double);
function  FormatoMoneda(xvalor:double):string;
function  FormatoNumero(xvalor:double;xlong,xdec:byte):string;
function  FormatoNumeroSinComas(xvalor:double;xlong,xdec:byte):string;
function  FloatToInt(xnum:double):longint;
function  NumeroToLetras(imp:double;var let2:str4;var swde:boolean):string;
function  NumeroToLetrasIngles(imp:double;var let2:str4):string;
function  ImporteToLetras(xvalor:double;DescMoneda,AbrMoneda:string):string;
function  ImporteToLetrasIngles(xvalor:double;DescMoneda,AbrMoneda:string):string;
function  ImporteToSonLetras(xvalor:double;DescMoneda,AbrMoneda:string):string;
function  DiferentesDeCero(v1,v2,v3,v4:double):boolean;
function  DiferentesDeCero6(v1,v2,v3,v4,v5,v6:double):boolean;

// FUENTES
function StrToAlignment(xstr:string):TAlignment;
function AlignmentToStr(xalignment:TAlignment):String;
function StrToFontStyles(xstr:string):TFontStyles;

// Componentes VCL
procedure IniciaMesBox
(xMesBox:TComboBox;mesini,mesfin,mesdef:string;swtodos:boolean);
function ElementoActualMesBox(xMesBox:TComboBox):string;

// Varios
function DirectorioWindows:string;
procedure EsperaMiliSeg(xMSeg:word);
procedure CopiarArchivo(NomOrigen,NomDestino:string);
function VariableDeMemo(xmemo:TMemoField;xvar:string):string;
function VariableDeLista(xlista:TStrings;xvar:string):string;
function CalculaBCC(ss:string):char;
function XorChar(c1,c2:char):char;

implementation

procedure TGlobalExHandler.HandlerProc(Sender:TObject; E:Exception);
var codigo:word;
begin
  if (E is EDBEngineError) then with (E as EDBEngineError) do begin
    codigo:=0;
    if ErrorMsg='' then begin
      codigo:=errors[0].ErrorCode;
      case codigo of
        9729:Message:='Registro ya existe';
        9732:Message:='Campo Requerido: Captura Incompleta';
        9733:Message:='No existe Registro Maestro';
        9734:Message:='Tiene Movimientos Detalle y no se puede borrar';
      end;
    end
    else Message:=ErrorMsg;
    MensajeErr(E.message+' (Codigo '+IntToStr(codigo)+')');
    ErrorMsg:='';
  end
  else MensajeErr(E.message);
end;

function XorChar(c1,c2:char):char;
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

function CalculaBCC(ss:string):char;
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

function StrToHexSep(ss:string):string;
var i:integer;
    xaux:string;
begin
  xaux:=inttohex(ord(ss[1]),2);
  for i:=2 to length(ss) do
    xaux:=xaux+' '+inttohex(ord(ss[i]),2);
  result:=xaux;
end;

function HexSepToStr(ss:string):string;
var i,ne:integer;
    st,xaux:string;
begin
  xaux:='';
  ne:=NoElemStrSep(ss,' ');
  for i:=1 to ne do begin
    st:=ExtraeElemStrSep(ss,i,' ');
    xaux:=xaux+HexToStr(st);
  end;
  result:=xaux;
end;

(*  FECHAS Y HORAS  *)

function FechaInicialSist:TDateTime;
begin
  Result:=StrToDate('01/01/1900');
end;

FUNCTION FechaToMes(xdate:TDateTime):Tmes;
begin
  result:=FormatDateTime('yyyymm',xdate);
end;

FUNCTION FechaToStr(xdate:TDateTime):String;
begin
  result:=FormatDateTime('yyyymmdd',xdate);
end;

FUNCTION FechaHoraToStrSQL(xdate:TDateTime):String;
begin
  result:=FormatDateTime('mm/dd/yyyy hh:nn',xdate);
end;

FUNCTION FechaToStrSQL(xdate:TDateTime):String;
begin
  result:=FormatDateTime('mm/dd/yyyy',xdate);
end;

function StrToFecha(xfec:string):TDateTime; (* AAAAMMDD*)
begin
  result:=StrToDate(copy(xfec,7,2)+'/'+copy(xfec,5,2)+'/'+copy(xfec,1,4));
end;

function StrToHora(xhor:string):TDateTime; (* HHMM / HHMMSS*)
begin
  if length(xhor)=4 then
    result:=StrToTime(copy(xhor,1,2)+':'+copy(xhor,3,2))
  else if length(xhor)=6 then
    result:=StrToTime(copy(xhor,1,2)+':'+copy(xhor,3,2)+':'+copy(xhor,5,2));
end;

function StrToFechaHora(xfechor:string):TDateTime; (* AAAAMMDDHHMM*)
var xfec,xhor:string;
begin
  xfec:=copy(xfechor,1,8);
  delete(xfechor,1,8);
  xhor:=xfechor;
  result:=StrToFecha(xfec)+StrToHora(xhor);
end;

procedure FechaHoraToSystem(xFechaHora:TDateTime);
var MyNewTime: TSystemTime;
begin
  MyNewTime.wYear := GetAnoFromFecha(xFechaHora);
  MyNewTime.wMonth := GetMesFromFecha(xFechaHora);
  MyNewTime.wDay := GetDiaFromFecha(xFechaHora);
  MyNewTime.wHour := GetHoraFromHora(xFechaHora);
  MyNewTime.wMinute := GetMinFromHora(xFechaHora);
  MyNewTime.wSecond := GetSegFromHora(xFechaHora);
  MyNewTime.wMilliseconds:= 00; // milisegundos
  SetLocalTime(MyNewTime);
end;

function MesDiaToFecha(xmes:string;xdia:word):TDateTime;
begin
  result:=StrToDate(IntToStr(xdia)+'/'+copy(xmes,5,2)+'/'+copy(xmes,1,4));
end;

function FecOldToFecha(xfec:string):TDateTime;
var dia:word;
    mes:string;
begin
  case xfec[1] of
    '5'..'9':mes:='19'+copy(xfec,1,4);
    'A':mes:='200'+copy(xfec,2,3);
    'B':mes:='201'+copy(xfec,2,3);
    'C':mes:='202'+copy(xfec,2,3);
    'D':mes:='203'+copy(xfec,2,3);
  end;
  dia:=StrToInt(copy(xfec,5,2));
  result:=MesDiaToFecha(mes,dia);
end;

function FecOldToMes(xfec:string):string;
var mes:string;
begin
  case xfec[1] of
    '5'..'9':mes:='19'+copy(xfec,1,4);
    'A':mes:='200'+copy(xfec,2,3);
    'B':mes:='201'+copy(xfec,2,3);
    'C':mes:='202'+copy(xfec,2,3);
    'D':mes:='203'+copy(xfec,2,3);
  end;
  result:=mes;
end;

function MesOldToMes(xmes:string):string;
begin
  result:=FecOldToMes(xmes+'01');
end;

function MesDiaMaxToFecha(xmes:string):TDateTime;
begin
  result:=MesDiaToFecha(xmes,GetDiasDelMesStr(xmes));
end;

FUNCTION MesToVmes(xmes:Tmes):string;
begin
  result:=copy(xmes,5,2)+copy(xmes,1,4);
end;

FUNCTION VmesToMes(xmes:string):Tmes;
begin
  result:=copy(xmes,3,4)+copy(xmes,1,2);
end;

FUNCTION MesActual:Tmes;
begin
  result:=FechaToMes(date);
end;

function MesToInt(xmes:Tmes):longint;
var mes,ano:integer;
begin
  ano:=strtoint(copy(xmes,1,4))-1900;
  mes:=strtoint(copy(xmes,5,2));
  result:=ano*12+mes;
end;

function IntToMes(nmes:longint):Tmes;
var mes,ano:integer;
begin
  ano:=(nmes)div(12);
  mes:=(nmes)mod(12);
  if mes=0 then begin
    dec(ano);
    mes:=12;
  end;
  result:=IntToClaveNum(ano+1900,4)+IntToClaveNum(mes,2);
end;

function IncMes(xmes:Tmes;n:longint):Tmes;
begin
  result:=IntToMes(MesToInt(xmes)+n);
end;

procedure SetDiaToFecha(dia:word;var fecha:Tdatetime);
var diax,mes,ano:word;
begin
  DecodeDate(fecha,ano,mes,diax);
  try
    Fecha:=EncodeDate(ano,mes,dia);
  except
    raise Exception.Create('Día fuera de rango');
  end;
end;

procedure SetMesToFecha(mes:word;var fecha:Tdatetime);
var dia,mesx,ano:word;
begin
  DecodeDate(fecha,ano,mesx,dia);
  try
    Fecha:=EncodeDate(ano,mes,dia);
  except
    raise Exception.Create('Mes fuera de rango');
  end;
end;

procedure SetAnoToFecha(ano:word;var fecha:Tdatetime);
var dia,mes,anox:word;
begin
  DecodeDate(fecha,anox,mes,dia);
  try
    Fecha:=EncodeDate(ano,mes,dia);
  except
    raise Exception.Create('Año fuera de rango');
  end;
end;

function GetAnoFromFecha(fecha:Tdatetime):word;
var dia,mes,ano:word;
begin
  DecodeDate(fecha,ano,mes,dia);
  result:=ano;
end;

function GetAnoFromMes(xmes:Tmes):word;
begin
  result:=GetAnoFromFecha(MesDiaMaxToFecha(xmes));
end;

function GetMesFromMes(xmes:Tmes):word;
begin
  result:=GetMesFromFecha(MesDiaMaxToFecha(xmes));
end;

function GetDiaFromFecha(fecha:Tdatetime):word;
var dia,mes,ano:word;
begin
  DecodeDate(fecha,ano,mes,dia);
  result:=dia;
end;

function GetMesFromFecha(fecha:Tdatetime):word;
var dia,mes,ano:word;
begin
  DecodeDate(fecha,ano,mes,dia);
  result:=mes;
end;

function GetHoraFromHora(hora:Tdatetime):word;
var xhr,xmin,xseg,xmseg:word;
begin
  DecodeTime(hora,xhr,xmin,xseg,xmseg);
  result:=xhr;
end;

function GetMinFromHora(hora:Tdatetime):word;
var xhr,xmin,xseg,xmseg:word;
begin
  DecodeTime(hora,xhr,xmin,xseg,xmseg);
  result:=xmin;
end;

function GetSegFromHora(hora:Tdatetime):word;
var xhr,xmin,xseg,xmseg:word;
begin
  DecodeTime(hora,xhr,xmin,xseg,xmseg);
  result:=xseg;
end;

function GetDiasDelMes(fecha:Tdatetime):word;
var dia,mes,ano:word;
    xfecha:TDateTime;
begin
  xfecha:=fecha;
  DecodeDate(xfecha,ano,mes,dia);
  dia:=28;
  repeat
    result:=dia;
    inc(dia);
    try
      xfecha:=EncodeDate(ano,mes,dia);
    except
      dia:=32;
    end;
  until dia>31;
  DecodeDate(xfecha,ano,mes,dia);
end;

function GetDiasDelMesStr(xmes:Tmes):word;
var xfecha:TDateTime;
begin
  xfecha:=MesDiaToFecha(xmes,1);
  result:=GetDiasDelMes(xfecha);
end;

function DiaPrimero(xfecha:TDateTime):TDateTime;
begin
  SetDiaToFecha(1,xfecha);
  result:=xfecha;
end;

function DiaUltimo(xfecha:TDateTime):TDateTime;
begin
  SetDiaToFecha(GetDiasDelMes(xfecha),xfecha);
  result:=xfecha;
end;

function FechaToFormato(xfecha:TDateTime):string;
begin
  result:=FormatDateTime(FormatFecha,xfecha);
end;

function FechaAlf(xfecha:TDateTime):string;
var dia,mes,ano:word;
begin
  DecodeDate(xfecha,ano,mes,dia);
  result:=IntToClaveNum(dia,2)+' de '+TMeses[mes]+' de '+IntToStr(ano);
end;

function FechaAlfIngles(xfecha:TDateTime):string;
var dia,mes,ano:word;
begin
  DecodeDate(xfecha,ano,mes,dia);
  result:=TMesesIngles[mes]+' '+IntToClaveNum(dia,2)+', '+IntToStr(ano);
end;

function MesFechaAlf(xfecha:TDateTime):string;
var dia,mes,ano:word;
begin
  DecodeDate(xfecha,ano,mes,dia);
  result:=TMeses[mes]+' de '+IntToStr(ano);
end;

function MesAlf(xmes:string):string;
begin
  result:=MesFechaAlf(MesDiaMaxToFecha(xmes));
end;

function MesPaq(xmes:string):string;
begin
  result:=copy(FechaPaq(MesDiaMaxToFecha(xmes)),4,8);
end;

function UnPaqMes(xmes:string):string;
var mes,ano:string[4];
    i:word;
begin
  mes:=copy(xmes,1,3);
  ano:=copy(xmes,5,4);
  for i:=1 to 12 do
    if mes=TMesesB[i] then
      result:=ano+IntToClaveNum(i,2);
end;

function FechaPaq(xfecha:TDateTime):string;
var dia,mes,ano:word;
begin
  DecodeDate(xfecha,ano,mes,dia);
  result:=IntToClaveNum(dia,2)+'/'+TMesesB[mes]+'/'+IntToClaveNum(ano,4);
end;

function HoraPaq(xfechor:TDateTime):string;
var hora,min,seg,mseg:word;
begin
  DecodeTime(xfechor,hora,min,seg,mseg);
  result:=IntToClaveNum(hora,2)+':'+IntToClaveNum(min,2)+':'+IntToClaveNum(seg,2);
end;

function FechaHoraPaq(xfecha:TDateTime):string;
begin
  result:=FechaPaq(xfecha)+' '+horapaq(xfecha);
end;

function RangoFecha(xfeci,xfecf:TDateTime):string;
var diai,mesi,anoi,
    diaf,mesf,anof :word;
begin
  DecodeDate(xfeci,anoi,mesi,diai);
  DecodeDate(xfecf,anof,mesf,diaf);
  if xfeci=xfecf then begin
    result:=FechaAlf(xfecf);
  end
  else if (mesi=mesf)and(anoi=anof) then begin
    result:='Del '+IntToClaveNum(diai,2)+
            ' al '+FechaAlf(xfecf);
  end
  else if (anoi=anof) then begin
    result:='Del '+IntToClaveNum(diai,2)+' de '+TMeses[mesi]+
            ' al '+FechaAlf(xfecf);
  end
  else begin
    result:='Del '+FechaAlf(xfeci)+' al '+FechaAlf(xfecf);
  end;
end;

function DiaSemana(xfecha:TDateTime):string;
begin
  result:=TDias[DayOfWeek(xfecha)];
end;

function IncFecha(xfecha:TDateTime;n:integer):TDateTime;
begin
  result:=xfecha+n;
end;

function DiasEntre(xfec1,xfec2:TDateTime):longint;
begin
  result:=trunc(xfec2)-trunc(xfec1);
end;

function MesIntermedio(xmesi,xmesf:string):string;
var mesi,mesf,mesint,nmes:word;
begin
  mesi:=MesToInt(xmesi);
  mesf:=MesToInt(xmesf);
  nmes:=mesf-mesi+1;
  mesint:=(nmes)div(2);
  result:=IntToMes(mesi+mesint-1);
end;


(* STRINGS *)

FUNCTION EspacioStr(n:byte):string;
Begin
  espaciostr:=cadenastr(n,' ');
end;


FUNCTION CadenaStr(n:byte;ch:char):string;
var ss:string;
Begin
  ss:='';
  while length(ss)<n do
    ss:=ss+ch;
  cadenastr:=ss;
end;


FUNCTION LimpiaStr(str1:string):string;
Begin
  While (length(str1)>0)and(str1[1] in [#0..#32]) do
    delete(str1,1,1);
  While (length(str1)>0)and(str1[length(str1)] in [#0..#32]) do
    delete(str1,length(str1),1);
  limpiaStr:=str1;
end;

Function FormatoStr(ss:string;just:char;long:integer):string;
begin
  ss:=limpiastr(ss);
  if length(ss)>long then
    ss:=copy(ss,1,long);
  case just of
    'I':ss:=ss+espaciostr(long-length(ss));
    'D':ss:=espaciostr(long-length(ss))+ss;
    'C':begin
          while length(ss)<long do
            ss:=' '+ss+' ';
          if length(ss)>long then
            delete(ss,1,1);
        end;
  end;
  formatostr:=ss;
end;

Function LlenaStr(ss:string;just:char;long:integer;cc:char):string;
begin
  if just<>'N' then
    ss:=limpiastr(ss);
  case just of
    'N',
    'I':begin
          while length(ss)<long do
            ss:=ss+cc;
        end;
    'D':begin
          while length(ss)<long do
            ss:=cc+ss;
        end;
    'C':begin
          while length(ss)<long do
            ss:=cc+ss+cc;
          if length(ss)>long then
            delete(ss,1,1);
        end;
  end;
  llenastr:=copy(ss,1,long);
end;

Function IncStr(ss:string):string;
var long,nn:integer;
begin
  try
    ss:=limpiastr(ss);
    long:=length(ss);
    nn:=strtoint(ss);inc(nn);
    ss:=inttostr(nn);
    result:=llenastr(ss,'D',long,'0');
  except
    raise;
  end;
end;

Function IntToClaveNum(ii,long:longint):string;
var ss:string;
begin
  ss:=inttostr(ii);
  while length(ss)>long do
    delete(ss,1,1);
  result:=llenastr(ss,'D',long,'0');
end;

function ByteToBin(num:longint):string;
var i,nn,xnum:integer;
    ss:string;
begin
  ss:='';xnum:=num;
  for i:=1 to 8 do begin
    nn:=(xnum)mod(2);
    ss:=inttostr(nn)+ss;
    xnum:=(xnum)div(2);
  end;
  result:=ss;
end;

Function StateToStr(xstate:TDataSetState):string;
begin
  case xstate of
    dsEdit:result:='Modificando';
    dsInsert:result:='Insertando';
    dsBrowse:result:='Consultando';
    dsInactive:result:='Inactivo';
    dsSetKey:result:='SetKey';
    dsCalcFields:result:='CalcFields';
    else result:='Otros';
  end;
end;

function StrToChar(xstr:string):char;
begin
  if length(xstr)>=1 then
    result:=xstr[1]
  else result:=' ';
end;

function EncriptaStr(xstr:string):string;
var i:word;
    c:char;
    base,nn:word;
begin
  base:=31;
  for i:=1 to length(xstr) do begin
    c:=xstr[i];
    nn:=ord(c);
    if nn in [base+1..base+20] then
      nn:=nn+60
    else if nn in [base+21..base+40] then
      nn:=nn+20
    else if nn in [base+41..base+60] then
      nn:=nn-20
    else if nn in [base+61..base+80] then
      nn:=nn-60;
    xstr[i]:=char(nn);
  end;
  result:=xstr;
end;

function DesencriptaStr(xstr:string):string;
begin
  result:=EncriptaStr(xstr);
end;

function Mayusculas(xstr:string):string;
var i:word;
begin
  xstr:=UpperCase(xstr);
  for i:=1 to length(xstr) do
    case xstr[i] of
      'ñ':xstr[i]:='Ñ';
      'á':xstr[i]:='Á';
      'é':xstr[i]:='É';
      'í':xstr[i]:='Í';
      'ó':xstr[i]:='Ó';
      'ú':xstr[i]:='Ú';
    end;
  result:=xstr;
end;

function ExtraeElemStr(xstr:string;ind:word):string;
var i,cont,nc:word;
    ss:string;
begin
  xstr:=xstr+' ';
  cont:=1;ss:='';
  i:=1;nc:=length(xstr);
  while (cont<ind)and(i<nc) do begin
    if (xstr[i]='/')and(xstr[i+1]='/') then begin
      inc(i);
      inc(cont);
    end;
    inc(i);
  end;
  while (i<nc) do begin
    if (xstr[i]='/')and(xstr[i+1]='/') then
      i:=nc
    else ss:=ss+xstr[i];
    inc(i);
  end;
  result:=limpiastr(ss);
end;

procedure InsertaElemStr(xstri:string;ind:word;var xstr:string);
var i,nn:word;
    ss:string;
begin
  if (limpiastr(xstr)='')and(ind=1) then begin
    xstr:=xstri;
    exit;
  end;
  nn:=NoElemStr(xstr);
  if ind>nn then begin
    while ind>nn do begin
      xstr:=xstr+' //';
      nn:=NoElemStr(xstr);
    end;
    xstr:=xstr+' '+xstri;
  end
  else begin
    ss:=ExtraeElemStr(xstr,1);
    for i:=2 to nn do begin
      if i=ind then
        ss:=ss+' // '+xstri
      else ss:=ss+' // '+ExtraeElemStr(xstr,i);
    end;
    xstr:=ss;
  end;
end;

function CreaListaElemStr(const valores:variant;cant:word):string;
var i,n:integer;
    xstr,ss:string;
begin
  xstr:='';
  for i:=0 to cant-1 do begin
    ss:=valores[i];
    n:=0;
    while n<length(ss)-1 do begin
      if copy(ss,n,2)='//' then
        delete(ss,n,1)
      else inc(n);
    end;
    xstr:=xstr+limpiastr(ss);
    if i<cant-1 then
      xstr:=xstr+' // ';
  end;
  result:=xstr;
end;

function NoElemStr(xstr:string):word;
var i,cont,nc:word;
begin
  xstr:=xstr+' ';
  cont:=1;
  i:=1;nc:=length(xstr);
  while (i<nc) do begin
    if (xstr[i]='/')and(xstr[i+1]='/') then begin
      inc(i);
      inc(cont);
    end;
    inc(i);
  end;
  result:=cont;
end;


function ExtraeElemStrSep(xstr:string;ind:word;xsep:char):string;
var i,cont,nc:word;
    ss:string;
begin
  xstr:=xstr+' ';
  cont:=1;ss:='';
  i:=1;nc:=length(xstr);
  while (cont<ind)and(i<nc) do begin
    if xstr[i]=xsep then
      inc(cont);
    inc(i);
  end;
  while (i<nc) do begin
    if xstr[i]=xsep then
      i:=nc
    else ss:=ss+xstr[i];
    inc(i);
  end;
  result:=limpiastr(ss);
end;

procedure InsertaElemStrSep(xstri:string;ind:word;xsep:char;var xstr:string);
var i,nn:word;
    ss:string;
begin
  if (limpiastr(xstr)='')and(ind=1) then begin
    xstr:=xstri;
    exit;
  end;
  nn:=NoElemStrSep(xstr,xsep);
  if ind>nn then begin
    while ind>nn do begin
      xstr:=xstr+' '+xsep;
      nn:=NoElemStrSep(xstr,xsep);
    end;
    xstr:=xstr+' '+xstri;
  end
  else begin
    ss:=ExtraeElemStrSep(xstr,1,xsep);
    for i:=2 to nn do begin
      if i=ind then
        ss:=ss+' '+xsep+' '+xstri
      else ss:=ss+' '+xsep+' '+ExtraeElemStrSep(xstr,i,xsep);
    end;
    xstr:=ss;
  end;
end;

function NoElemStrSep(xstr:string;xsep:char):word;
var i,cont,nc:word;
begin
  xstr:=xstr+' ';
  cont:=1;
  i:=1;nc:=length(xstr);
  while i<nc do begin
    if xstr[i]=xsep then
      inc(cont);
    inc(i);
  end;
  result:=cont;
end;

function ExisteElemStrSep(xelem,xstr:string;xsep:char):boolean;
var i,noelem:word;
    swexiste:boolean;
    ss:string;
begin
  swexiste:=false;
  noelem:=NoElemStrSep(xstr,xsep);
  for i:=1 to NoElem do begin
    ss:=ExtraeElemStrSep(xstr,i,xsep);
    if ss=xelem then
      swexiste:=true;
  end;
  result:=swexiste;
end;

function StrMayuscIguales(ss1,ss2:string):boolean;
begin
  result:=(Mayusculas(ss1)=Mayusculas(ss2));
end;

function ContieneChar(xstr:string;xch:char):boolean;
var i:word;
begin
  result:=false;
  for i:=1 to length(xstr) do
    if xstr[i]=xch then begin
      result:=true;
      exit;
    end;
end;

function SetEspacios(importe:double):string;
begin
  setespacios:='';
  if importe<>0 then
    setespacios:=FormatoMoneda(importe);
end;

function DameAlineaStr(var xstr:string):char;
var Alinea:char;
begin
  Alinea:='I';
  if xstr[1] in ['[','<'] then begin
    if xstr[1]='<' then
      Alinea:='D';
    delete(xstr,1,1);
  end;
  if xstr[length(xstr)] in [']','>'] then begin
    if xstr[length(xstr)]='>' then begin
      if Alinea<>'D' then
        Alinea:='C';
    end;
    delete(xstr,length(xstr),1);
  end;
  result:=Alinea;
end;

procedure PegaStrPosLong(var xstr:string;substr:string;xpos,xlon:byte;xalign:string);
var xal:char;
    lon,lont,i:word;
begin
  xal:='I';
  case xalign[1] of
    'L':xal:='I';
    'C':xal:='C';
    'R':xal:='D';
  end;
  substr:=llenastr(substr,xal,xlon,' ');
  lon:=xpos+xlon-1;
  if lon>255 then
    lon:=255;
  lont:=length(xstr);
  if lont<lon then
    xstr:=xstr+espaciostr(lon-lont);
  for i:=1 to xlon do
    if substr[i]<>' ' then
      xstr[xpos+i-1]:=substr[i];
end;

function FormatoRfc(xrfc:string):string;
begin
  xrfc:=llenastr(xrfc,'N',13,' ');
  insert('-',xrfc,5);
  insert('-',xrfc,12);
  result:=xrfc;
end;

function ExtraeLineaDeParrafo(xstr:string;xLongMax,xIndice:word):string;
var i,n:word;
    ss:string;
begin
  n:=0;ss:='';
  while n<xindice do begin
    i:=xLongMax+1;
    //while (length(xstr)>1)and(xstr[1]=' ') do
      //delete(xstr,1,1);
    xstr:=LlenaStr(xstr,'I',1000,' ');
    while (not (xstr[i] in [' ',',','.',';','-']))and (i>0) do
      dec(i);
    if i=0 then
      i:=xLongMax;
    if (i=xLongMax+1)and(xstr[i]=' ') then
      i:=xLongMax;
    ss:=copy(xstr,1,i);
    delete(xstr,1,i);
    inc(n);
  end;
  result:=ss;
end;

function StrToHex(xstr:string):string;
var ss:string;
    i:integer;
begin
  ss:='';
  for i:=1 to length(xstr) do
    ss:=ss+IntToHex(ord(xstr[i]),2);
  result:=ss;
end;

function HexToStr(xstr:string):string;
var ss,s1:string;
    i,d1,d2:integer;
begin
  ss:='';
  for i:=1 to length(xstr) do
    if (i)mod(2)=0 then begin
      s1:=copy(xstr,i-1,2);
      case s1[1] of
        '0'..'9':d1:=ord(s1[1])-48;
        'A'..'F':d1:=ord(s1[1])-55;
        else d1:=0;
      end;
      case s1[2] of
        '0'..'9':d2:=ord(s1[2])-48;
        'A'..'F':d2:=ord(s1[2])-55;
        else d2:=0;
      end;
      ss:=ss+char(d1*16+d2);
    end;
  result:=ss;
end;

function HexToInt(xstr:string):integer;
var ss,s1:string;
    i,d1,d2:integer;
begin
  ss:='';
  for i:=1 to length(xstr) do
    if (i)mod(2)=0 then begin
      s1:=copy(xstr,i-1,2);
      case s1[1] of
        '0'..'9':d1:=ord(s1[1])-48;
        'A'..'F':d1:=ord(s1[1])-55;
        else d1:=0;
      end;
      case s1[2] of
        '0'..'9':d2:=ord(s1[2])-48;
        'A'..'F':d2:=ord(s1[2])-55;
        else d2:=0;
      end;
      ss:=ss+char(d1*16+d2);
    end;
  result:=d1*16+d2;
end;

function HexToBinary(xcar:char):string;
begin
  case xcar of
    '0':result:='0000';
    '1':result:='0001';
    '2':result:='0010';
    '3':result:='0011';
    '4':result:='0100';
    '5':result:='0101';
    '6':result:='0110';
    '7':result:='0111';
    '8':result:='1000';
    '9':result:='1001';
    'A':result:='1010';
    'B':result:='1011';
    'C':result:='1100';
    'D':result:='1101';
    'E':result:='1110';
    'F':result:='1111';
  end;
end;

function HexLongToBinary(xss:string):string;
var i:integer;
    ss:string;
begin
  ss:='';
  for i:=1 to length(xss) do
    ss:=ss+HexToBinary(xss[i]);
  result:=ss;
end;

function BinaryToInt(xbin:string):integer;
var num,cont:integer;
    c:char;
begin
  cont:=0;num:=0;
  while (length(xbin)>0) do begin
    c:=xbin[length(xbin)];
    if c='1' then
      num:=num+Trunc(IntPower(2,cont));
    inc(cont);
    delete(xbin,length(xbin),1);
  end;
  result:=num;
end;

function IntToBinary(xint,xlon:integer):string;
var    ss:string;
begin
  ss:='';
  while xint>0 do begin
    ss:=inttostr((xint)mod(2))+ss;
    xint:=(xint)div(2);
  end;
  while length(ss)<xlon do
    ss:='0'+ss;
  while length(ss)>xlon do
    delete(ss,1,1);
  result:=ss;
end;

function IeeeToFloat(xstr:string):real;
var i,signo,expo:integer;
    mantisa:real;
    ss,xexp,xman:string;
begin
  result:=0;
  if (length(xstr)<>8) then
    exit;
  for i:=1 to 8 do begin
    if not (xstr[i] in ['0'..'9','A'..'F']) then
      exit;
    ss:=ss+HexToBinary(xstr[i]);
  end;
  if ss[1]='0' then
    signo:=1
  else signo:=-1;
  xexp:=copy(ss,2,8);
  xman:=copy(ss,10,23);
  expo:=BinaryToInt(xexp)-127;
  mantisa:=0;
  for i:=1 to length(xman) do
    if xman[i]='1' then
      mantisa:=mantisa+1/IntPower(2,i);
  mantisa:=mantisa+1;
  result:=signo*mantisa*Power(2,expo);
end;

{ MENSAJES }

Procedure MensajeErr(msg:string);
begin
  MessageDlg(msg,mtError,[mbOk],0);
end;

Procedure MensajeWarn(msg:string);
begin
  MessageDlg(msg,mtWarning,[mbOk],0);
end;

Procedure MensajeInfo(msg:string);
begin
  MessageDlg(msg,mtInformation,[mbOk],0);
end;

Function MensajeConf(msg:string):word;
begin
  result:=MessageDlg(msg,mtConfirmation,[mbYes,mbNo],0);
end;

{ NUMEROS }

Function EsCero(xnum:double):boolean;
begin
  result:=abs(xnum)<0.0001;
end;

function DivideFloat(n1,n2:double):double;
begin
  try
    if n2<>0 then
      result:=n1/n2
    else result:=0;
  except
    result:=0;
  end;
end;

function AjustaFloat(n:double;d:byte):double;
var ss:string;
begin
  ss:=formatfloat('0.'+IntToClaveNum(0,d),n);
  result:=StrToFloat(ss);
end;

procedure IncFloat(var xnum:double;xvalor:double);
begin
  xnum:=xnum+xvalor;
end;

procedure DecFloat(var xnum:double; xvalor:double);
begin
  xnum:=xnum-xvalor;
end;

function FormatoMoneda(xvalor:double):string;
begin
  result:=FormatFloat(MaskMoneda,xvalor);
end;

function FormatoNumero(xvalor:double;xlong,xdec:byte):string;
var xmask:string;
begin
  xmask:='###,###,##0';
  if xdec>0 then
    xmask:=xmask+'.'+LlenaStr('','I',xdec,'0');
  result:=LlenaStr(FormatFloat(xmask,xvalor),'D',xlong,' ');
end;

function FormatoNumeroSinComas(xvalor:double;xlong,xdec:byte):string;
var xmask:string;
begin
  xmask:='##########0';
  if xdec>0 then
    xmask:=xmask+'.'+LlenaStr('','I',xdec,'0');
  result:=LlenaStr(FormatFloat(xmask,xvalor),'D',xlong,' ');
end;

function  FloatToInt(xnum:double):longint;
begin
  result:=trunc(xnum+0.00001);
end;

Function NumeroToLetras(imp:double;var let2:str4;var swde:boolean):string;
  var let:string;
      p1,p2:double;
  Function FLet(imp:double):string;
    const cent:array[1..10] of string[13] = 
('Cien','Doscientos','Trescientos','Cuatrocientos','Quinientos',
                                             'Seiscientos','Setecientos','Ochocientos','Novecientos','Ciento');
    const dece:array[1..9] of string[13] = ('','','Treinta','Cuarenta','Cincuenta','Sesenta','Setenta',
                                             'Ochenta','Noventa');
    const unid:array[1..29] of string[13] = 
('Un','Dos','Tres','Cuatro','Cinco','Seis','Siete','Ocho','Nueve','Diez',
                                             
'Once','Doce','Trece','Catorce','Quince','Dieciseis','Diecisiete','Dieciocho',
                                             
'Diecinueve','Veinte','Veintiuno','Veintidos','Veintitres','Veinticuatro',
                                             'Veinticinco','Veintiseis','Veintisiete','Veintiocho','Veintinueve');
    var let:string;
        p1,p2:integer;
  begin
    if imp=0 then begin
      FLET:='';
      EXIT;
    end;
    let:='';
    p1:=trunc(imp/100);
    P2:=trunc(imp-P1*100);
    if p1>0 then begin
      if (p1=1)and(p2>0) then
        let:=' '+cent[10]
      else
        let:=' '+cent[p1];
    end;
    imp:=imp-p1*100;
    if imp>0 then begin
      if imp<30 then begin
        p1:=trunc(imp);
        let:=let+' '+unid[p1];
      end
      else begin
        p1:=trunc(imp/10);
        if p1>0 then
          let:=let+' '+dece[p1];
        imp:=imp-p1*10;
        p2:=trunc(imp);
        if p2>0 then begin
          if p1>0 then
            let:=let+' y '+unid[p2]
          else
            let:=let+' '+unid[p2];
        end;
      end;
    end;
    flet:=let;
  end;
Begin
  swde:=true;
  imp:=imp*100;
  p1:=int(imp/100+0.0001)*100;
  p2:=imp-p1+0.0001;
  let2:=IntToClaveNum(FloatToInt(p2),2);
  let2:=limpiastr(let2);
  imp:=int(imp/100+0.0001);
  if imp<1 then begin
    result:='Cero';
    swde:=false;
    exit;
  end;
  let:='';
  p1:=int(imp/1000+0.0001)*1000;
  p2:=imp-p1;
  if p2>0 then begin
    let:=flet(p2)+let;
    swde:=false;
  end;
  imp:=int(imp/1000+0.0001);
  if imp>0 then begin
    p1:=int(imp/1000+0.0001)*1000;
    p2:=imp-p1;
    if p2>0 then begin
      let:=flet(p2)+' Mil'+let;
      swde:=false;
    end;
    imp:=int(imp/1000+0.0001);
    if imp>0 then begin
      p1:=int(imp/1000+0.0001)*1000;
      p2:=imp-p1;
      if p2>0 then
        if P2>1 then
          let:=flet(p2)+' Millones'+let
        else
          let:=flet(p2)+' Millon'+let
      else if imp>0 then
        let:=' Millones'+let;
      imp:=int(imp/1000+0.0001);
      if imp>0 then begin
        p1:=int(imp/1000+0.0001)*1000;
        p2:=imp-p1;
        if p2>0 then
          LET:=flet(p2)+' Mil'+let;
        imp:=int(imp/1000+0.0001);
        if imp>0 then begin
          p1:=int(imp/1000+0.0001)*1000;
          p2:=imp-p1;
          if p2>0 then
            if P2>1 then
              let:=flet(p2)+' Billones'+let
            else
              let:=flet(p2)+' Billon'+let;
        end;
      end;
    end;
  end;
  result:=let;
end;

Function NumeroToLetrasIngles(imp:double;var let2:str4):string;
  var let:string;
      p1,p2:double;
  Function FLet(imp:double):string;
    const dece:array[1..9] of string[13] = ('Ten','Twenty','Thirty','Fourty','Fifty','Sixty','Seventy',
                                             'Eighty','Ninety');
    const unid:array[1..19] of string[13] = 
('One','Two','Three','Four','Five','Six','Seven','Eight','Nine','Ten',
                    
'Eleven','Twelve','Thirteen','Fourteen','Fifteen','Sixteen','Seventeen','Eighteen','Nineteen');
    var let:string;
        p1,p2:integer;
  begin
    if imp=0 then begin
      flet:='';
      exit;
    end;
    let:='';
    p1:=trunc(imp/100);
    //P2:=trunc(imp-P1*100);
    if p1>0 then
      let:=' '+unid[p1]+' Hundred';
    imp:=imp-p1*100;
    if imp>0 then begin
      if imp<20 then begin
        p1:=trunc(imp);
        let:=let+' '+unid[p1];
      end
      else begin
        p1:=trunc(imp/10);
        if p1>0 then
          let:=let+' '+dece[p1];
        imp:=imp-p1*10;
        p2:=trunc(imp);
        if p2>0 then
          let:=let+' '+unid[p2];
      end;
    end;
    flet:=let;
  end;
Begin
  imp:=imp*100;
  p1:=int(imp/100+0.0001)*100;
  p2:=imp-p1+0.0001;
  let2:=IntToClaveNum(FloatToInt(p2),2);
  let2:=limpiastr(let2);
  imp:=int(imp/100+0.0001);
  if imp<1 then begin
    result:='Zero';
    exit;
  end;
  let:='';
  p1:=int(imp/1000+0.0001)*1000;
  p2:=imp-p1;
  if p2>0 then begin
    let:=flet(p2)+let;
  end;
  imp:=int(imp/1000+0.0001);
  if imp>0 then begin
    p1:=int(imp/1000+0.0001)*1000;
    p2:=imp-p1;
    if p2>0 then begin
      let:=flet(p2)+' Thousand'+let;
    end;
    imp:=int(imp/1000+0.0001);
    if imp>0 then begin
      p1:=int(imp/1000+0.0001)*1000;
      p2:=imp-p1;
      if p2>0 then
        if P2>1 then
          let:=flet(p2)+' Millions'+let
        else
          let:=flet(p2)+' Million'+let
      else if imp>0 then
        let:=' Millions'+let;
      imp:=int(imp/1000+0.0001);
      if imp>0 then begin
        p1:=int(imp/1000+0.0001)*1000;
        p2:=imp-p1;
        if p2>0 then
          LET:=flet(p2)+' Thousand'+let;
        // imp:=int(imp/1000+0.0001);
      end;
    end;
  end;
  result:=let;
end;

function  ImporteToLetras(xvalor:double;DescMoneda,AbrMoneda:string):string;
var xx:string;
    cc:str4;
    menos,
    swde:boolean;
begin
  menos:=false;
  if xvalor<-0.001 then begin
    xvalor:=abs(xvalor);
    menos:=true;
  end;
  xx:=NumeroToLetras(xvalor,cc,swde);
  if menos then
    xx:='menos '+xx;
  if swde then
    result:='('+xx+' DE '+DescMoneda+' '+cc+'/100 '+AbrMoneda+')'
  else
    result:='('+xx+' '+DescMoneda+' '+cc+'/100 '+AbrMoneda+')';
end;

function ImporteToSonLetras(xvalor:double;DescMoneda,AbrMoneda:string):string;
begin
  result:='Son:'+ImporteToLetras(xvalor,DescMoneda,AbrMoneda);
end;

function  ImporteToLetrasIngles(xvalor:double;DescMoneda,AbrMoneda:string):string;
var xx:string;
    cc:str4;
    menos:boolean;
begin
  menos:=false;
  if xvalor<-0.001 then begin
    xvalor:=abs(xvalor);
    menos:=true;
  end;
  xx:=NumeroToLetrasIngles(xvalor,cc);
  if menos then
    xx:='menos '+xx;
  result:='('+xx+' '+DescMoneda+' '+cc+'/100 '+AbrMoneda+')';
end;


// FUENTES

function StrToAlignment(xstr:string):TAlignment;
begin
  result :=taLeftJustify;
  if xstr='Right' then
    result:=taRightJustify
  else if xstr='Center' then
    result:=taCenter;
end;

function AlignmentToStr(xalignment:TAlignment):String;
begin
  result:='Left';
  if xAlignment=taRightJustify then
    result:='Right'
  else if xAlignment=taCenter then
    result:='Center';
end;

function StrToFontStyles(xstr:string):TFontStyles;
var i:word;
    fs:array[1..3] of word;
begin
  for i:=1 to 3 do begin
    fs[i]:=0;
    if xstr[i]<>'X' then
      fs[i]:=1;
  end;
  i:=4*fs[1]+2*fs[2]+fs[3];
  case i of                           // B I U
    0:result:=[];                     // 0 0 0
    1:result:=[fsUnderline];          // 0 0 1
    2:result:=[fsItalic];             // 0 1 0
    3:result:=[fsItalic,fsUnderline]; // 0 1 1
    4:result:=[fsBold];               // 1 0 0
    5:result:=[fsBold,fsUnderline];   // 1 0 1
    6:result:=[fsBold,fsItalic];      // 1 1 0
    7:result:=[fsBold,fsItalic,fsUnderline]; // 1 1 1
  end;
end;

function LimpiaCaracter(str1:string;caracter:char):string;
var ind:integer;
begin
  for ind:=1 to length(str1) do
    if str1[ind]=caracter then delete(str1,ind,1);
  result:=str1;
end;

function  DiferentesDeCero(v1,v2,v3,v4:double):boolean;
begin
  result:=(abs(v1)>0.001)or(abs(v2)>0.001)or(abs(v3)>0.001)or(abs(v4)>0.001);
end;

function  DiferentesDeCero6(v1,v2,v3,v4,v5,v6:double):boolean;
begin
  result:=(abs(v1)>0.001)or(abs(v2)>0.001)or(abs(v3)>0.001)or(abs(v4)>0.001)or(abs(v5)>
0.001)or(abs(v6)>0.001);
end;

function FiltraStrNum(str1:string):string;
var ind:integer;
begin
  ind:=1;
  while ind<=length(str1) do begin
    if not (str1[ind] in ['0'..'9']) then
      delete(str1,ind,1)
    else inc(ind);
  end;
  result:=str1;
end;

function FiltraStrFloat(str1:string):string;
var ind:integer;
begin
  ind:=1;
  while ind<=length(str1) do begin
    if not (str1[ind] in ['0'..'9','.']) then
      delete(str1,ind,1)
    else inc(ind);
  end;
  result:=str1;
end;

function FiltraStrLetras(str1:string):string;
var ind:integer;
begin
  ind:=1;
  while ind<=length(str1) do begin
    if not (str1[ind] in ['A'..'Z','a'..'z','Ñ','ñ']) then
      delete(str1,ind,1)
    else inc(ind);
  end;
  result:=str1;
end;

function FiltraStrAlfaNum(str1:string):string;
var ind:integer;
begin
  ind:=1;
  while ind<=length(str1) do begin
    if not (str1[ind] in ['A'..'Z','a'..'z','0'..'9']) then
      delete(str1,ind,1)
    else inc(ind);
  end;
  result:=str1;
end;

function FechaHoraToStr(FechaHora:TDateTime):String;
begin
  result:=FechaPaq(FechaHora)+' '+FormatDatetime('hh:mm am/pm',FechaHora);
end;

function FechaHoraExtToStr(FechaHora:TDateTime):String;
begin
  result:=FechaPaq(FechaHora)+' '+FormatDatetime('hh:mm:ss.zzz',FechaHora);
end;

function FecHorActualToStr:String;
begin
  result:=FechaPaq(date)+'   '+FormatDatetime('hh:mm am/pm',time);
end;

function SetFechaHora(xstr:string):String;
begin
  if mayusculas(xstr)='SI' then result:=FecHorActualToStr
  else result:='';
end;

function HoraToStr24(xhora:TDateTime):string; // hh:mm
var nhor,nmin:integer;
begin
  nhor:=GetHoraFromHora(xhora);
  nmin:=GetMinFromHora(xhora);
  result:=IntToClaveNum(nhor,2)+':'+IntToClaveNum(nmin,2);
end;

// Componentes VCL
procedure IniciaMesBox
(xMesBox:TComboBox;mesini,mesfin,mesdef:string;swtodos:boolean);
var ind:word;
    i:longint;
begin
  xMesBox.Items.Clear;
  if mesfin<mesini then
    mesfin:=mesini;
  ind:=0;
  for i:=MesToInt(mesini) to MesToInt(mesfin) do begin
    xMesBox.Items.Add(MesPaq(IntToMes(i)));
    if IntToMes(i)=mesdef then
      ind:=xMesBox.Items.Count-1;
  end;
  xMesBox.ItemIndex:=ind;
  if swtodos then
    xMesBox.Items.Add('** Todos');
end;

function ElementoActualMesBox(xMesBox:TComboBox):string;
begin
  if xMesBox.Items[xMesBox.itemindex]='** Todos' then
    result:='*'
  else
    result:=UnPaqMes(xMesBox.Items[xMesBox.itemindex]);
end;

// Varios
function DirectorioWindows:string;
var ruta:Pchar;
begin
  result:='';
  ruta:=StrAlloc(255);
  try
    GetWindowsDirectory(ruta,255);
    result:=StrPas(ruta);
  finally
    StrDispose(ruta);
  end;
end;

procedure EsperaMiliSeg(xMSeg:word);
var hora,horai,espera,monto:longint;
    Hor,Min,Seg,Mseg:word;
begin
  espera:=xMseg;
  DecodeTime(Time,Hor,Min,Seg,MSeg);
  horai:=hor*3600000 + min*60000 + seg*1000 + Mseg;
  repeat
    DecodeTime(Time,Hor,Min,Seg,MSeg);
    hora:=hor*3600000 + min*60000 + seg*1000 + Mseg;
    monto:=hora-horai;
    if monto<0 then
      monto:=espera;
  until monto>=espera;
end;

procedure CopiarArchivo(NomOrigen,NomDestino:string);
var FOrigen:File;
    NumRead: Integer;
    Buf: array[1..1024] of Char;
    ArchivoTxt:Text;
    i:integer;
    lin:string;
    sw13:boolean;
    //c:char;
begin
  sw13:=false;
  AssignFile(ArchivoTxt,NomDestino);
  {$i-} rewrite(ArchivoTxt); {$i+}
  if ioresult<>0 then
    raise Exception.Create('No puedo crear archivo: '+NomDestino);
  try
    AssignFile(FOrigen, NomOrigen);
    {$i-} Reset(FOrigen, 1); {$i+}	{ Record size = 1 }
    if ioresult<>0 then
      raise Exception.Create('No existe archivo Origen');
    try
      write(ArchivoTxt,#27#64);
      lin:='';
      repeat
        BlockRead(FOrigen, Buf, SizeOf(Buf), NumRead);
        if NumRead>0 then begin
          for i:=1 to NumRead do begin
            //c:=buf[i];
            if buf[i]>=#32 then begin
              lin:=lin+buf[i];
              if length(lin)>=255 then begin
                write(ArchivoTxt,lin);
                lin:='';
              end;
            end
            else begin
              if lin<>'' then begin
                write(ArchivoTxt,lin);
                lin:='';
              end;
              if Buf[i]=#13 then
                sw13:=true
              else begin
                if (sw13)and(Buf[i]=#10) then begin
                  writeln(ArchivoTxt);
                  sw13:=false;
                end
                else begin
                  write(ArchivoTxt,#13+Buf[i]);
                  sw13:=false;
                end;
              end;
            end;
          end;
        end;
      until (NumRead = 0);
      if lin<>'' then begin
        write(ArchivoTxt,lin);
        lin:='';
      end;
      write(ArchivoTxt,#27#64);
    finally
      CloseFile(FOrigen);
    end;
  finally
    CloseFile(ArchivoTxt);
  end;
end;

function VariableDeMemo(xmemo:TMemoField;xvar:string):string;
var lista:TStrings;
begin
  if TMemo<>nil then begin
    lista:=TStringList.Create;
    try
      lista.Assign(xMemo);
      result:=VariabledeLista(lista,xvar);
    finally
      lista.Free;
    end;
  end;
end;

function VariableDeLista(xlista:TStrings;xvar:string):string;
var ss:string;
    i:integer;
begin
  result:='';
  for i:=0 to xlista.Count-1 do begin
    ss:=xlista[i];
    if StrMayuscIguales(ExtraeElemStrSep(ss,1,'='),xvar) then
      result:=ExtraeElemStrSep(ss,2,'=')
  end;
end;

procedure AvanzaFechaDelSistema(ndias:integer);
var FecSys:TSystemTime;
    FechaHora:TDateTime;
    nA,nMes,nDia,nHor,nMin,nSeg,nMilSeg:Word;
begin
  FechaHora:=now+ndias;
  DecodeDateTime(FechaHora,nA,nMes,nDia,nHor,nMin,nSeg,nMilSeg);
  GetLocalTime(FecSys);
  FecSys.wYear:=nA;
  FecSys.wMonth:=nMes;
  FecSys.wDay:=nDia;
  FecSys.wHour:=nHor;
  Fecsys.wMinute:=nMin;
  FecSys.wSecond:=nSeg;
  FecSys.wMilliseconds:=nMilSeg;
  SetLocalTime(FecSys);
end;



end.







