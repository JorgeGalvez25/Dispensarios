unit ULIBLICENCIAS;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, dbTables,
  ULIBGRAL;

const
  AcercaDeDerechos = 'Derechos Reservados: Imagen Computación';
  AcercaDeComentario = 'Tels: (668) 818-1023 y 818-1026';

var
   DogAddr: integer;
   DogBytes: integer;
   DogPassword: longint;
   DogResult: longint;
   DogData: ^byte;
   DogCascade:integer;
   NewPassword:longint;

   DogError:longint;

var LlaveLicencia  :string;
    ConexionModoRespaldo,
    MDogVence,
    MDogExistio    :boolean;
    MDogFechaVence :TDateTime;
    idEmpresa      :string;
    idClaveDia     :string;
    idMdogActivo   :byte;
    SerieKeyMdog   :longint;
    UltTiempoMDog,
    TiempoIniAplic :TDateTime;
    TablaSistImg   :TTable;
    DemoRestante   :word;
    FechaTrabajoAct    :TDateTime;
    Sw1234         :boolean=true;
    ChecaExisteMDog:boolean=true;
    ModoDemo       :boolean=false;
    idDemo          :string='';
    //FechaDemo       :TDateTime;
    DiasDemo        :integer=0;
    lvCodigoErr     :integer;
    lvWarning       :boolean;

const  MDogId='1718291197';

function LicenciaDiaSCRT(xfecha:tdatetime):string;
function LicenciaDiaOk(xlicencia:string):boolean;
function LicenciaValida(xEmpresa,xSistema,xVersion,xTipoLicencia,xlicencia:string;xUsuarios:integer):boolean;
function LicenciaValida2(xEmpresa,xSistema,xVersion,xTipoLicencia,xlicencia:string;xUsuarios:integer;xLimitada:boolean;xFechaVence:TDateTime):boolean;
function DameLicencia(xEmpresa,xSistema,xVersion,xTipoLicencia:string;xLimitada:boolean;xFechaVence:TDateTime):string;
function EnDemostracion:boolean;

function ExisteMDogId(xid:byte):boolean;
function ValorMDog(xid:byte;xpos,xlon:word):string;
procedure EscribeMDog(xid:byte;xpos:word;xvalor:string);
function ValorMDogOk(xid:byte;xpos:word;xvalor:string):boolean;
function SerieMDog(xid:word):word;
procedure PlanMDog_Ver31_Interbase(xSerie:word);
procedure PlanMDog_Ver31_CVOL(xSerie:word);
procedure PlanMDog_Ver31_RYBA(xSerie:word);
procedure PlanMDog_Ver31_HOTA(xSerie:word);
procedure PonModoRespaldo;
function EnModoRespaldo:boolean;
procedure ValidaLlave(xClave:string);

implementation

  { The type of these six functions are longint }
     function DogCheck: longint; external;
     function ReadDog: longint; external;
     function WriteDog: longint; external;
     function DogConvert: longint; external;
     function GetCurrentNo: longint; external;
     function DisableShare: longint; external;
     function SetPassword: longint; external;  // new
     function SetDogCascade: longint; external; // new
     {$L MHDELPHI.OBJ }
     (*
  function DogCheck: longint; external;
  function DogConvert: longint; external;
  function WriteDog: longint; external;
  function ReadDog: longint; external;
  function DisableShare: longint; external;
  function GetCurrentNo: longint; external;
  {$L mhdelphi.obj}
  *)


var LicenciaDemo :boolean;

function LicenciaSist(xEmpresa,xSistema,xVersion,xTipoLicencia:string;xLicenciaTemporal:boolean;xFechaVence:TDateTime):string;
const vocales='IOAEU';
      numv=5;
      consona='QVRWPSDFKLZXCTYBNMGHJ';
      numc=21;
      digitos='8903451267';
      numd=10;

var sem_c,sem_d,sem_v:longint;
    xtipo:string;

  function SumaOrd(ss:string):longint;
  var i:longint;
  begin
    result:=0;
    for i:=1 to length(ss) do
      if ord(ss[i]) in [32..122] then
        result:=result+ord(ss[i]);
  end;

  function Char_c:char;
  var i:byte;
  begin
    i:=(sem_c+sem_v+sem_d)mod(numc)+1;
    result:=consona[i];
    sem_c:=sem_c+sem_v
  end;

  function Char_v:char;
  var i:byte;
  begin
    i:=(sem_c+sem_v+sem_d)mod(numv)+1;
    result:=vocales[i];
    sem_v:=sem_v+sem_d;
  end;

  function Char_d:char;
  var i:byte;
  begin
    i:=(sem_c+sem_v+sem_d)mod(numd)+1;
    result:=digitos[i];
    sem_d:=sem_d+sem_c
  end;

begin
  if xLicenciaTemporal then
    xempresa:=xempresa+FechaPaq(xFechaVence);
  xtipo:=FiltraStrNum(xTipoLicencia);
  xempresa:=LimpiaStr(xEmpresa);
  sem_c:=sumaord(Mayusculas(xempresa)+xtipo);
  sem_d:=sumaord(Mayusculas(xempresa+xsistema)+xtipo);
  sem_v:=sumaord(Mayusculas(xempresa+xsistema+xversion)+xtipo);
  result:=char_c + char_v + char_c + char_v + char_c +
          char_d + char_d + char_d;
end;

function LicenciaDiaSCRT(xfecha:tdatetime):string;
begin
  result:=LicenciaSist(FechaToStr(xfecha)+idEmpresa,'GEN','0.0','',false,date);
end;

function LicenciaDiaOk(xlicencia:string):boolean;
var ok:boolean;
begin
  if not EnModoRespaldo then begin
    ok:=LicenciaDiaSCRT(Date)=xLicencia;
    if (not ok)and(time<0.4) then
      ok:=LicenciaDiaSCRT(Date-1)=xLicencia;
  end
  else if (FechaTrabajoAct<Date) then
    ok:=LicenciaDiaSCRT(FechaTrabajoAct)=xLicencia
  else ok:=false;
  result:=ok;
end;

function LicenciaValida(xEmpresa,xSistema,xVersion,xTipoLicencia,xlicencia:string;xUsuarios:integer):boolean;
var xlic,ss:string;
    Lista:TStrings;
    i:word;
begin
  result:=false;
  if xUsuarios>0 then
    xTipoLicencia:=IntToStr(xUsuarios);
  xempresa:=LimpiaStr(xEmpresa);
  if xlicencia<>'DEMO' then begin
    LicenciaDemo:=false;
    xlic:=LicenciaSist(xEmpresa,xSistema,xVersion,FiltraStrNum(xTipoLicencia),false,date);
    result:=StrMayuscIguales(xlic,xlicencia);
  end
  else begin
    if sw1234 then begin
      Lista:=TStringList.Create;
      try
        Lista.Assign(TablaSistImg.FieldByName('Tablas'));
        if Lista.Count=0 then begin
          i:=51;
        end
        else begin
          try
            ss:=DesEncriptaStr(Lista.strings[0]);
            i:=StrToInt(ss);
          except
            i:=51;
          end;
          if i=0 then
            raise exception.Create('Demo esta Vencido');
          dec(i);
        end;
        ss:=EncriptaStr(inttostr(i));
        Lista.Clear;
        Lista.Add(ss);
        DemoRestante:=i;
        TablaSistImg.Edit;
        TablaSistImg.FieldByName('Tablas').assign(lista);
        TablaSistImg.Post;
        LicenciaDemo:=true;
        result:=true;
      finally
        Lista.Free;
      end;
    end
    else begin
      LicenciaDemo:=true;
      result:=true;
    end;
  end;
end;

function LicenciaValida2(xEmpresa,xSistema,xVersion,xTipoLicencia,xlicencia:string;xUsuarios:integer;xLimitada:boolean;xFechaVence:TDateTime):boolean;
var xlic,ss:string;
    Lista:TStrings;
    i:word;
begin
  lvCodigoErr:=0;
  if (xlimitada)and(date>xFechaVence) then begin
    raise Exception.Create('Licencia Vencida: '+FechaPaq(xfechaVence));
    lvCodigoErr:=1;
  end;
  if lvWarning then
    if (xlimitada)and(date>=xFechaVence-7) then
      MensajeWarn('Advertencia: Licencia vence el '+FechaPaq(xfechaVence));
  result:=false;
  if xUsuarios>0 then
    xTipoLicencia:=IntToStr(xUsuarios);
  xempresa:=LimpiaStr(xEmpresa);
  if xlicencia<>'DEMO' then begin
    LicenciaDemo:=false;
    xlic:=LicenciaSist(xEmpresa,xSistema,xVersion,FiltraStrNum(xTipoLicencia),xLimitada,xFechaVence);
    result:=StrMayuscIguales(xlic,xlicencia);
  end
  else if length(xsistema)>=5 then begin
    lvCodigoErr:=2;
    raise Exception.Create('Submodulos no pueden instalarse como DEMO');
  end
  else begin
    if sw1234 then begin
      Lista:=TStringList.Create;
      try
        Lista.Assign(TablaSistImg.FieldByName('Tablas'));
        if Lista.Count=0 then begin
          i:=51;
        end
        else begin
          try
            ss:=DesEncriptaStr(Lista.strings[0]);
            i:=StrToInt(ss);
          except
            i:=51;
          end;
          if i=0 then begin
            lvCodigoErr:=3;
            raise exception.Create('Demo esta Vencido');
          end;
          dec(i);
        end;
        ss:=EncriptaStr(inttostr(i));
        Lista.Clear;
        Lista.Add(ss);
        DemoRestante:=i;
        TablaSistImg.Edit;
        TablaSistImg.FieldByName('Tablas').assign(lista);
        TablaSistImg.Post;
        LicenciaDemo:=true;
        result:=true;
      finally
        Lista.Free;
      end;
    end
    else begin
      LicenciaDemo:=true;
      result:=true;
    end;
  end;
end;

function DameLicencia(xEmpresa,xSistema,xVersion,xTipoLicencia:string;xLimitada:boolean;xFechaVence:TDateTime):string;
begin
  result:='';
  xempresa:=LimpiaStr(xEmpresa);
  PlanMDog_Ver31_Interbase(SerieKeyMdog);
  if LicenciaValida('Imagen Computacion','Windows','3.1','',LlaveLicencia,0) then
    result:=LicenciaSist(xEmpresa,xSistema,xVersion,FiltraStrNum(xTipoLicencia),xLimitada,xFechaVence);
end;

function EnDemostracion:boolean;
begin
  result:=LicenciaDemo;
end;

function ExisteMDogId(xid:byte):boolean;
var dwRetCode: longint;
    Tiempo :TDateTime;
begin
  result:=false;
  if not ChecaExisteMdog then
    exit;
  Tiempo:=Now;
  if Tiempo-UltTiempoMDog<1/(24*60) then begin
    UltTiempoMDog:=Tiempo;
    result:=true;
    exit;
  end;
  DogCascade := xid;
  dwRetCode := DogCheck;
  if not MDogExistio then
    MDogExistio:=(dwRetCode=0);
  if ChecaExisteMdog then
    ChecaExisteMdog:=(dwRetCode=0);
  UltTiempoMDog:=Tiempo;
  result:=(dwRetCode=0);
end;

function ValorMDog(xid:byte;xpos,xlon:word):string;
var
   dwRetCode: longint;
   //longData:Longint;
   //intData:Integer;
   strData:string[20];
begin
  result:='';
  DogCascade := xid;
  DogPassword := StrToInt(MDogId);
  DogData := @strData[1];
  DogBytes := xlon;
  strData[0] := Char(DogBytes);
  DogAddr := xpos;
  dwRetCode := ReadDog();
  if dwRetCode=0 then
    result:=strdata;
end;

procedure EscribeMDog(xid:byte;xpos:word;xvalor:string);
var
   //dwRetCode: longint;
   //longData,
   xlon:Longint;
   //intData:Integer;
   strData:string[20];
begin
  strData:=xvalor;
  xlon:=length(xvalor);
  DogCascade := xid;
  DogPassword := StrToInt(MDogId);
  DogData := @strData[1];
  DogBytes := xlon;
  //strData[0] := Char(DogBytes);
  DogAddr := xpos;
  WriteDog();
end;

function ValorMDogOk(xid:byte;xpos:word;xvalor:string):boolean;
var xstr:string[20];
begin
  result:=false;
  xstr:=ValorMdog(xid,xpos,length(xvalor));
  result:=(xvalor=xstr);
end;

function SerieMDog(xid:word):word;
var xstr:string[20];
    xnum:longint;
begin
  xstr:=ValorMdog(xid,180,11);
  xstr:=copy(xstr,7,5);
  try
    xnum:=strtoint(xstr);
    result:=xnum;
  except
    result:=0;
  end;
end;

procedure PlanMDog_Ver31_Interbase(xSerie:word);
const tvalores : array[1..5] of string[20]
       = ('Imagen Computacion',
          'ISC-970403-C24',
          'Sistemas Windows',
          'Version 3.1',
          'Interbase'
          );
       tdir : array[1..5] of byte = (0,20,40,60,80);
      QryMdogCve:array[0..6] of string[20] =
        ('IMAGEN','PAOLA1',
         '970403','JORGE1',
         '344524','ESTHER',
         '019283'
        );
      QryMdogRes:array[0..6] of longint =
        (506142342,1329450405,
         -168286520,971673818,
         -1558601762,-642714814,
         -54000306
        );
var i,nd:byte;
    swexiste,
    swok:boolean;
    ss,
    ConvertData: string[20];
    dwRetCode: longint;
    ii:word;
    xres:longint;
begin
  dogerror:=0;
  MDogExistio:=false;
  idMdogActivo:=0;
  SerieKeyMdog:=0;
  nd:=0;
  //swexiste:=false;
  swok:=false;
  repeat
    swexiste:=ExisteMDogId(nd);
    if swexiste then begin
      if SerieMDog(nd)=xserie then
        swok:=true;
      if not swok then
        inc(nd);
    end;
  until (swok)or(not swexiste)or(nd>10);
  if not swok then begin
    if nd=0 then begin
      dogerror:=1;
      raise Exception.Create('No existe llave instalada');
    end
    else begin
      dogerror:=2;
      raise Exception.Create('No existe llave con serie '+inttoclavenum(xserie,5));
    end;
  end;
  idMdogActivo:=nd;
  SerieKeyMdog:=xserie;
  for i:=1 to 5 do begin
    if not ValorMDogOk(idMdogActivo,tdir[i],tvalores[i]) then begin
      dogerror:=3;
      raise Exception.Create('Llave no es válida');
    end;
  end;
  ss:=ValorMdog(idMdogActivo,100,13);
  if StrMayuscIguales(copy(ss,1,5),'VENCE') then begin
    MDogVence:=true;
    ss:=copy(ss,6,8);
    MDogFechaVence:=StrToFecha(ss);
  end;

  randomize;
  ii:=random(7);
  ConvertData:=QryMdogCve[ii];
  xres:=QryMdogRes[ii];
  DogBytes:=6;
  DogData := @ ConvertData[1];
  dwRetCode := DogConvert();
  if dwRetCode<>0 then begin
    dogerror:=3;
    raise Exception.Create('Llave no es válida');
  end;
end;

procedure PlanMDog_Ver31_CVOL(xSerie:word);
const tvalores : array[1..6] of string[20]
       = ('Imagen Computacion',
          'ISC-970403-C24',
          'Sistemas Windows',
          'Version 3.1',
          'Interbase',
          'CVOL'
          );
       tdir : array[1..6] of byte = (0,20,40,60,80,170);
      QryMdogCve:array[0..6] of string[20] =
        ('IMAGEN','PAOLA1',
         '970403','JORGE1',
         '344524','ESTHER',
         '019283'
        );
      QryMdogRes:array[0..6] of longint =
        (506142342,1329450405,
         -168286520,971673818,
         -1558601762,-642714814,
         -54000306
        );
var i,nd:byte;
    swexiste,
    swok:boolean;
    ss,
    ConvertData: string[20];
    dwRetCode: longint;
    ii:word;
    xres:longint;
begin
  dogerror:=0;
  MDogExistio:=false;
  idMdogActivo:=0;
  SerieKeyMdog:=0;
  nd:=0;
  //swexiste:=false;
  swok:=false;
  repeat
    swexiste:=ExisteMDogId(nd);
    if swexiste then begin
      if SerieMDog(nd)=xserie then
        swok:=true;
      if not swok then
        inc(nd);
    end;
  until (swok)or(not swexiste)or(nd>10);
  if not swok then begin
    if nd=0 then begin
      dogerror:=1;
      raise Exception.Create('No existe llave instalada');
    end
    else begin
      dogerror:=2;
      raise Exception.Create('No existe llave con serie '+inttoclavenum(xserie,5));
    end;
  end;
  idMdogActivo:=nd;
  SerieKeyMdog:=xserie;
  for i:=1 to 6 do begin
    if not ValorMDogOk(idMdogActivo,tdir[i],tvalores[i]) then begin
      dogerror:=3;
      raise Exception.Create('Llave no es válida');
    end;
  end;
  ss:=ValorMdog(idMdogActivo,100,13);
  if StrMayuscIguales(copy(ss,1,5),'VENCE') then begin
    MDogVence:=true;
    ss:=copy(ss,6,8);
    MDogFechaVence:=StrToFecha(ss);
  end;

  randomize;
  ii:=random(7);
  ConvertData:=QryMdogCve[ii];
  xres:=QryMdogRes[ii];
  DogBytes:=6;
  DogData := @ ConvertData[1];
  dwRetCode := DogConvert();
  if dwRetCode<>0 then begin
    dogerror:=3;
    raise Exception.Create('Llave no es válida');
  end;
end;

procedure PlanMDog_Ver31_RYBA(xSerie:word);
const tvalores : array[1..6] of string[20]
       = ('Imagen Computacion',
          'ISC-970403-C24',
          'Sistemas Windows',
          'Version 3.1',
          'Interbase',
          'RYBA'
          );
       tdir : array[1..6] of byte = (0,20,40,60,80,170);
      QryMdogCve:array[0..6] of string[20] =
        ('IMAGEN','PAOLA1',
         '970403','JORGE1',
         '344524','ESTHER',
         '019283'
        );
      QryMdogRes:array[0..6] of longint =
        (506142342,1329450405,
         -168286520,971673818,
         -1558601762,-642714814,
         -54000306
        );
var i,nd:byte;
    swexiste,
    swok:boolean;
    ss,
    ConvertData: string[20];
    dwRetCode: longint;
    ii:word;
    xres:longint;
begin
  dogerror:=0;
  MDogExistio:=false;
  idMdogActivo:=0;
  SerieKeyMdog:=0;
  nd:=0;

  //swexiste:=false;
  swok:=false;
  repeat
    swexiste:=ExisteMDogId(nd);
    if swexiste then begin
      if SerieMDog(nd)=xserie then
        swok:=true;
      if not swok then
        inc(nd);
    end;
  until (swok)or(not swexiste)or(nd>10);
  if not swok then begin
    if nd=0 then begin
      dogerror:=1;
      raise Exception.Create('No existe llave instalada');
    end
    else begin
      dogerror:=2;
      raise Exception.Create('No existe llave con serie '+inttoclavenum(xserie,5));
    end;
  end;
  idMdogActivo:=nd;
  SerieKeyMdog:=xserie;
  for i:=1 to 6 do begin
    if not ValorMDogOk(idMdogActivo,tdir[i],tvalores[i]) then begin
      dogerror:=3;
      raise Exception.Create('Llave no es válida');
    end;
  end;
  ss:=ValorMdog(idMdogActivo,100,13);
  if StrMayuscIguales(copy(ss,1,5),'VENCE') then begin
    MDogVence:=true;
    ss:=copy(ss,6,8);
    MDogFechaVence:=StrToFecha(ss);
  end;

  randomize;
  ii:=random(7);
  ConvertData:=QryMdogCve[ii];
  xres:=QryMdogRes[ii];
  DogBytes:=6;
  DogData := @ ConvertData[1];
  dwRetCode := DogConvert();
  if dwRetCode<>0 then begin
    dogerror:=3;
    raise Exception.Create('Llave no es válida');
  end;
end;

procedure PlanMDog_Ver31_HOTA(xSerie:word);
const tvalores : array[1..6] of string[20]
       = ('Imagen Computacion',
          'ISC-970403-C24',
          'Sistemas Windows',
          'Version 3.1',
          'Interbase',
          'HOTA'
          );
       tdir : array[1..6] of byte = (0,20,40,60,80,170);
      QryMdogCve:array[0..6] of string[20] =
        ('IMAGEN','PAOLA1',
         '970403','JORGE1',
         '344524','ESTHER',
         '019283'
        );
      QryMdogRes:array[0..6] of longint =
        (506142342,1329450405,
         -168286520,971673818,
         -1558601762,-642714814,
         -54000306
        );
var i,nd:byte;
    swexiste,
    swok:boolean;
    ss,
    ConvertData: string[20];
    dwRetCode: longint;
    ii:word;
    xres:longint;
begin
  dogerror:=0;
  MDogExistio:=false;
  idMdogActivo:=0;
  SerieKeyMdog:=0;
  nd:=0;

  //swexiste:=false;
  swok:=false;
  repeat
    swexiste:=ExisteMDogId(nd);
    if swexiste then begin
      if SerieMDog(nd)=xserie then
        swok:=true;
      if not swok then
        inc(nd);
    end;
  until (swok)or(not swexiste)or(nd>10);
  if not swok then begin
    if nd=0 then begin
      dogerror:=1;
      raise Exception.Create('No existe llave instalada');
    end
    else begin
      dogerror:=2;
      raise Exception.Create('No existe llave con serie '+inttoclavenum(xserie,5));
    end;
  end;
  idMdogActivo:=nd;
  SerieKeyMdog:=xserie;
  for i:=1 to 6 do begin
    if not ValorMDogOk(idMdogActivo,tdir[i],tvalores[i]) then begin
      dogerror:=3;
      raise Exception.Create('Llave no es válida');
    end;
  end;
  ss:=ValorMdog(idMdogActivo,100,13);
  if StrMayuscIguales(copy(ss,1,5),'VENCE') then begin
    MDogVence:=true;
    ss:=copy(ss,6,8);
    MDogFechaVence:=StrToFecha(ss);
  end;

  randomize;
  ii:=random(7);
  ConvertData:=QryMdogCve[ii];
  xres:=QryMdogRes[ii];
  DogBytes:=6;
  DogData := @ ConvertData[1];
  dwRetCode := DogConvert();
  if dwRetCode<>0 then begin
    dogerror:=3;
    raise Exception.Create('Llave no es válida');
  end;
end;

procedure ValidaLlave(xClave:string);
const tvalores : array[1..5] of string[20]
       = ('Imagen Computacion',
          'ISC-970403-C24',
          'Sistemas Windows',
          'Version 3.1',
          'Interbase'
          );
       tdir : array[1..5] of byte = (0,20,40,60,80);
      QryMdogCve:array[0..6] of string[20] =
        ('IMAGEN','PAOLA1',
         '970403','JORGE1',
         '344524','ESTHER',
         '019283'
        );
      QryMdogRes:array[0..6] of longint =
        (506142342,1329450405,
         -168286520,971673818,
         -1558601762,-642714814,
         -54000306
        );
var nd:byte;
    swexiste,swok:boolean;
    ss,
    ConvertData: string[20];
    //dwRetCode: longint;
    //ii:word;
    //xres:longint;
  function ExisteMDogId(xid:byte):boolean;
  var dwRetCode: longint;
  begin
    DogCascade := xid;
    dwRetCode := DogCheck;
    result:=(dwRetCode=0);
  end;
begin
  dogerror:=0;
  idMdogActivo:=0;
  SerieKeyMdog:=0;
  nd:=0;
  swexiste:=false;
  swok:=false;
  repeat
    swexiste:=ExisteMDogId(nd);
    if swexiste then begin
      if ValorMDog(nd,186,5)=xClave then
        swok:=true;
      if not swok then
        inc(nd);
    end;
  until (swok)or(not swexiste)or(nd>10);
  if not swok then begin
    if nd=0 then begin
      dogerror:=1;
      raise Exception.Create('No existe llave instalada');
    end
    else begin
      dogerror:=2;
      raise Exception.Create('No existe llave '+xClave);
    end;
  end;
end;

procedure PonModoRespaldo;
begin
  ConexionModoRespaldo:=true;
end;

function EnModoRespaldo:boolean;
begin
  result:=ConexionModoRespaldo;
end;

Begin
  LlaveLicencia:='';
  LicenciaDemo:=false;
  MDogExistio:=false;
  MDogVence:=false;
  idMdogActivo:=0;
  SerieKeyMdog:=0;
  TiempoIniAplic:=Now;
  UltTiempoMDog:=0;
  ConexionModoRespaldo:=false;
end.








