unit ULIBPRINT;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,  StdCtrls, 
  ExtCtrls, Mask, ComCtrls, Printers,
  db, ULibGral, ULibDataBase, UFormaPreverTxt;

const TxVideo = 'VIDEO';

type PTxEtiqueta = ^TxEtiqueta;
     TxEtiqueta = record
       txBanda :string[2];
       txLeft,
       txTop,
       txSize  :word;
       txTipo  :char;
       txValor :string;
       txLetra :string[7];
       txAlinea:string[6];
       txEstilo1,
       txEstilo2:string[3];
     end;

     TxValores = record
       Nombre  :string[30];
       Valor   :string;
     end;

var
    ArchivoTxt  :Text;
    ArchivoDest,
    NombreTxt   :string;
    SwVideoTxt  :boolean;
    NomBufferTxt:string;

    SListRepCL:TStrings;
    SListRepDC:TStrings;
    SListRepTX:TStrings;
    SListRepBD:TStrings;
    // BDMemo
    TxAnchoPag,
    TxAltoPag,
    TxMizqPag,
    TxMderPag,
    TxMsupPag,
    TxMinfPag   :word;
    TxPaginas,
    TxPagiForm,
    TxBndDt,
    TxBndPh,
    TxBndPf,
    TxBndCh     :word;
    // CLMemo
    TxLetCh,
    TxLetMd,
    TxLetGr  :string[10];
    TxLonCh,
    TxLonMd,
    TxLonGr  :word;
    TxImpre  :string;
    TxDestinoRep:char;
    TxCantCol  :word;
    TxLabelCol:array [1..30] of PTxEtiqueta;
    TxCantEti  :word;
    TxLabelEti:array [1..100] of PTxEtiqueta;

    TxNombreRep:string;
    TxPaginaInicial,
    TxLabelNoPag:word;
    TxContador,
    TxLinBuffer,
    TxLongBuffer:integer;

procedure IniciaImpresionTxt(ArchImp:string);
procedure ImprimeTxt(str:string);
procedure ImprimeTxtLn(str:string);
procedure FinImpresionTxt(var swimpre:boolean);

procedure IniciaRepTxt
(NomRep:string;Conexion:longint;CL,DC,TX,BD:TMemoField;DestinoRep:char);
procedure MeteValorTxRep(xnombre,xvalor:string);
procedure GeneraRepTxt(Lista:TStrings;ximpre:string;NoPagIni:word;var swimpre:boolean);
procedure FinalizaRepTxt;
procedure PreparaListaTxt(Lista:TStrings);



implementation

procedure IniciaImpresionTxt(ArchImp:string);
begin
  if ArchImp=TxVideo then
    SwVideoTxt:=true
  else
    SwVideoTxt:=false;
  if NomBufferTxt='' then
    NomBufferTxt:=VSLocalDir+'\RP'+IntToClaveNum(ConexionActiva,6)+'.TMP';
  NombreTxt:=NomBufferTxt;
  ArchivoDest:=ArchImp;
  AssignFile(ArchivoTxt,NombreTxt);
  {$i-} rewrite(ArchivoTxt); {$i+}
  if ioresult<>0 then
    raise Exception.Create('No puedo crear archivo: '+NombreTxt);
  TxLinBuffer:=0;
end;

procedure ImprimeTxt(str:string);
var i:integer;
begin
  if not SwVideoTxt then begin
    for i:=1 to length(str) do begin
      case ord(str[i]) of
        209:str[i]:=char(165); //Ñ
        241:str[i]:=char(164); //ñ
        225:str[i]:=char(160); //á
        233:str[i]:=char(130); //é
        237:str[i]:=char(161); //í
        243:str[i]:=char(162); //ó
        250:str[i]:=char(163); //ú
      end;
    end;
  end;

  {$i-} write(ArchivoTxt,str); {$i+}
  if ioresult<>0 then
    raise Exception.Create('No puedo imprimir en: '+NombreTxt);
end;

procedure ImprimeTxtLn(str:string);
var i,j:integer;
    sw:boolean;
begin
  if ArchivoDest=TxVideo then begin
    i:=1;
    while i<=length(str) do begin
      if ord(str[i]) in [0..31] then
        delete(str,i,1)
      else
        inc(i);
    end;
  end;
  ImprimeTxt(str+#13#10);
  inc(TxLinBuffer);
  if TxLinBuffer>TxLongBuffer then begin
    FinImpresionTxt(sw);
    EsperaMiliSeg(3000);
    IniciaImpresionTxt(ArchivoDest);
  end;
end;

procedure FinImpresionTxt(var swimpre:boolean);
begin
  swimpre:=false;
  close(ArchivoTxt);
  try
    if ArchivoDest<>TxVideo then begin
      CopiarArchivo(NombreTxt,ArchivoDest);
    end
    else begin
      if FormaPreverTxt.ShowModal=mrOk then
        swimpre:=true;
    end;
  finally
    DeleteFile(NombreTxt);
  end;
end;

procedure CargaBndBD;
var ii:integer;
    lin:string;
    Bnd:string[2];
begin
  for ii:=0 to SListRepBd.Count-1 do begin
    lin:=LimpiaStr(SListRepBd[ii]);
    if lin<>'' then begin
      Bnd:=ExtraeElemStr(lin,1);
      if Bnd='PP' then begin
        TxAltoPag:=StrToInt(ExtraeElemStr(lin,2));
        TxAnchoPag:=StrToInt(ExtraeElemStr(lin,3));
        TxMizqPag:=StrToInt(ExtraeElemStr(lin,4));
        TxMderPag:=StrToInt(ExtraeElemStr(lin,5));
        TxMsupPag:=StrToInt(ExtraeElemStr(lin,6));
        TxMinfPag:=StrToInt(ExtraeElemStr(lin,7));
      end
      else if Bnd='PH' then begin
        TxBndPh:=StrToInt(ExtraeElemStr(lin,2));
      end
      else if Bnd='PF' then begin
        TxBndPf:=StrToInt(ExtraeElemStr(lin,2));
      end
      else if Bnd='CH' then begin
        TxBndCh:=StrToInt(ExtraeElemStr(lin,2));
      end;
    end;
  end;
end;

procedure CargaBndTX;
var ii,jj,kk:integer;
    lin,ss,ss2,ss3:string;
    ch:char;
begin
  // Carga Tipos de Letra
  TxLetCh:=#15;TxLonCh:=137;
  TxLetMd:=#18;TxLonMd:=80;
  TxLetGr:=#15#14;TxLonGr:=66;
  for ii:=0 to SListRepTx.Count-1 do begin
    lin:=LimpiaStr(SListRepTx[ii]);
    if lin<>'' then begin
      ss:=ExtraeElemStr(lin,1);
      ss2:=ExtraeElemStr(lin,2);
      jj:=NoElemStrSep(ss2,'+');
      ss3:=ExtraeElemStr(lin,3);
      if ss='Chica' then begin
        TxLonCh:=StrToInt(ss3);
        TxLetCh:='';
        for kk:=1 to jj do begin
          ch:=Char(StrToInt(ExtraeElemStrSep(ss2,kk,'+')));
          TxLetCh:=TxLetCh+ch;
        end;
      end
      else if ss='Mediana' then begin
        TxLonMd:=StrToInt(ss3);
        TxLetMd:='';
        for kk:=1 to jj do begin
          ch:=Char(StrToInt(ExtraeElemStrSep(ss2,kk,'+')));
          TxLetMd:=TxLetMd+ch;
        end;
      end
      else if ss='Grande' then begin
        TxLonGr:=StrToInt(ss3);
        TxLetGr:='';
        for kk:=1 to jj do begin
          ch:=Char(StrToInt(ExtraeElemStrSep(ss2,kk,'+')));
          TxLetGr:=TxLetGr+ch;
        end;
      end;
    end;
  end;
end;

procedure CargaBndCL;
var i,ind:integer;
    lin:string;
    P:PTxEtiqueta;
begin
  TxCantCol :=0;
  for i:=0 to SListRepCL.Count-1 do begin
    ind:=i+1;
    lin:=SListRepCL[i];
    if LimpiaStr(lin)<>'' then begin
      if txCantCol>=30 then
        raise Exception.Create('El máximo de columnas es de 30');
      inc(TxCantCol);
      New(P);
      TxLabelCol[ind]:=P;
      TxLabelCol[ind]^.txBanda:='CL';
      TxLabelCol[ind]^.txleft:=strtoint(ExtraeElemStr(lin,2));
      TxLabelCol[ind]^.txtop:=1;
      TxLabelCol[ind]^.txsize:=strtoint(ExtraeElemStr(lin,3));
      TxLabelCol[ind]^.txAlinea:=ExtraeElemStr(lin,4);
      TxLabelCol[ind]^.txletra:=ExtraeElemStr(lin,5);
      TxLabelCol[ind]^.txEstilo1:=ExtraeElemStr(lin,6);
      TxLabelCol[ind]^.txEstilo2:=ExtraeElemStr(lin,7);
    end;
  end;
end;

procedure CargaBndDC;
var i,ind,ii:integer;
    lin,ss,ssx:string;
    P:PTxEtiqueta;
begin
  TxCantEti :=0;
  TxLabelNoPag:=0;
  for i:=0 to SListRepDC.Count-1 do begin
    lin:=SListRepDC[i];
    if LimpiaStr(lin)<>'' then begin
      if txCantEti>=100 then
        raise Exception.Create('El máximo de etiquetas es 100');
      New(P);
      inc(TxCantEti);
      ind:=TxCantEti;
      TxLabelEti[ind]:=P;
      TxLabelEti[ind]^.txBanda:=ExtraeElemStr(lin,1);
      ssx:=ExtraeElemStr(lin,2);
      if Mayusculas(copy(ssx,1,4))='@COL' then begin
        delete(ssx,1,4);
        ii:=StrToInt(ssx);
        if ii<=TxCantCol then
          ii:=TxLabelCol[ii]^.txLeft
        else ii:=0;
        ssx:=IntToStr(ii);
      end;
      TxLabelEti[ind]^.txleft:=strtoint(ssx);
      TxLabelEti[ind]^.txtop:=strtoint(ExtraeElemStr(lin,3));
      ssx:=ExtraeElemStr(lin,4);
      if Mayusculas(copy(ssx,1,4))='@COL' then begin
        delete(ssx,1,4);
        ii:=StrToInt(ssx);
        if ii<=TxCantCol then
          ii:=TxLabelCol[ii]^.txSize
        else ii:=0;
        ssx:=IntToStr(ii);
      end;
      TxLabelEti[ind]^.txsize:=strtoint(ssx);
      TxLabelEti[ind]^.txAlinea:=ExtraeElemStr(lin,5);
      TxLabelEti[ind]^.txletra:=ExtraeElemStr(lin,6);
      TxLabelEti[ind]^.txEstilo1:=ExtraeElemStr(lin,7);
      TxLabelEti[ind]^.txEstilo2:=ExtraeElemStr(lin,7);
      TxLabelEti[ind]^.txTipo:=' ';
      TxLabelEti[ind]^.txValor:='';
      ss:=ExtraeElemStr(lin,8);
      if ss[1]='&' then begin // texto
        delete(ss,1,1);
        TxLabelEti[ind]^.txTipo:='T';
      end
      else if Mayusculas(ss)='@NOPAG' then
        TxLabelNoPag:=ind
      else if copy(ss,1,2)='@&' then
        ss:=CadenaStr(TxLabelEti[ind]^.txsize,ss[3])
      else if Mayusculas(ss)='TITULOREP' then
        ss:=TxNombreRep
      else
        TxLabelEti[ind]^.txTipo:='V';
      TxLabelEti[ind]^.txValor:=ss;
    end;
  end;
end;

procedure IniciaRepTxt
(NomRep:string;Conexion:longint;CL,DC,TX,BD:TMemoField;DestinoRep:char);
begin
  TxNombreRep:=NomRep;
  TxDestinoRep:=DestinoRep;
  SListRepCL:=TStringList.Create;
  SListRepDC:=TStringList.Create;
  SListRepTX:=TStringList.Create;
  SListRepBD:=TStringList.Create;
  try
    SListRepCL.Assign(CL);
    SListRepDC.Assign(DC);
    SListRepTX.Assign(TX);
    SListRepBD.Assign(BD);
    CargaBndBD;
    CargaBndTX;
    CargaBndCL;
    CargaBndDC;
  finally
    SListRepCL.Free;
    SListRepDC.Free;
    SListRepTX.Free;
    SListRepBD.Free;
  end;
end;

procedure MeteValorTxRep(xnombre,xvalor:string);
var neti:word;
    ss:string;
begin
  neti:=1;
  while neti<=TxCantEti do begin
    if TxLabelEti[neti]^.txTipo='V' then begin
      ss:=TxLabelEti[neti]^.txValor;
      if StrMayuscIguales(xnombre,ss) then begin
        TxLabelEti[neti]^.txValor:=xvalor;
        TxLabelEti[neti]^.txTipo:=' ';
      end;
    end;
    inc(neti);
  end;
end;

procedure GeneraRepTxt(Lista:TStrings;ximpre:string;NoPagIni:word;var swimpre:boolean);
var npag,nlin,xlin,
    ii,jj,kk,nbanda,tl,
    ancho,apdet,
    neti,areaancho,
    marg_izq,
    marg_der,
    marg_sup,
    marg_inf,
    ph_ini,ph_fin,
    ch_ini,ch_fin,
    dt_ini,dt_fin,
    pf_ini,pf_fin  :word;
    TotDet         :LongInt;
    ss,xtipo,
    ss2,ss3,
    lin,linu,
    linb       :string;
    lin3,lin3u,
    lin3b      :array[1..3] of string;
    ch,xbanda:char;
    swvideo,
    swtotal,
    sw,entra:boolean;
    xestilo :string[3];
    NoRengDet:LongInt;
    LineaVid:string;
    xTipoRen,
    xLetra  :string[10];

  procedure PreparaVideo(xlin:string);
  var i:word;
  begin
    for i:=1 to length(xlin) do begin
      if i<=length(LineaVid) then
        if (xlin[i]<>' ')and(LineaVid[i]=' ') then
          LineaVid[i]:=xlin[i];
    end;
  end;
  procedure ImprimeVideo;
  begin
    ImprimeTxtLn(LineaVid);
    LineaVid:=EspacioStr(TxAnchoPag);
  end;
begin
  swimpre:=false;
  // Calcula No Paginas
  TxBndDt:=TxAltoPag-TxBndPh-TxBndCh-TxBndPf-TxMSupPag-TxMInfPag;
  AreaAncho:=TxAnchoPag-TxMizqPag-TxMderPag;
  if TxBndDt>0 then begin
    TxPaginas:=(Lista.Count)div(TxBndDt);
    if (Lista.Count)mod(TxBndDt)>0 then
      inc(TxPaginas);
  end
  else TxPaginas:=1;
  TxPagiForm:=NoPagIni-1;

  // Determinar areas de bandas
  ph_ini:=TxMsupPag+1;
  ph_fin:=ph_ini+TxBndPh-1;
  ch_ini:=ph_fin+1;
  ch_fin:=ch_ini+TxBndCh-1;
  dt_ini:=ch_fin+1;
  dt_fin:=dt_ini+TxBndDt-1;
  pf_ini:=dt_fin+1;
  pf_fin:=pf_ini+TxBndPf-1;

  // Definir el puerto de impresion
  swvideo:=TxDestinoRep='V';
  if not swvideo then begin
    ss:=ximpre;
    ss2:=ss;
    ii:=NoElemStrSep(ss2,' ');
    ii:=pos(' on ',ss2);
    if ii>0 then begin
      ii:=ii+4;
      ss:=copy(ss2,ii,length(ss2)-ii+1);
      if copy(ss,length(ss),1)=':' then
        delete(ss,length(ss),1);
    end;

    if TxImpre<>'' then
      ss:=TxImpre;
  end
  else begin
    ss:=TxVideo;
    LineaVid:=espaciostr(TxAnchoPag);
  end;
  NomBufferTxt:=VSLocalDir+'\RP'+IntToClaveNum(ConexionActiva,6)+'.TMP';
  if copy(ss,length(ss),1)=':' then
    delete(ss,length(ss),1);
  IniciaImpresionTxt(ss);
  try
    ApDet:=0;
    TotDet:=Lista.Count;
    for npag:=1 to TxPaginas do begin
      inc(TxPagiForm);
      if TxLabelNoPag>0 then
        TxLabelEti[TxLabelNoPag]^.txValor:=inttostr(TxPagiForm);
      for nlin:=1 to TxAltoPag do begin // Lineas
        for tl:=1 to 3 do begin
          case tl of
            1:xtipo:='Chica';
            2:xtipo:='Mediana';
            3:xtipo:='Grande';
          end;
          lin:='';linu:='';linb:='';
          if (nlin>=ph_ini)and(nlin<=ph_fin) then begin
            xbanda:='H';
            xlin:=nlin-ph_ini+1;
          end
          else if (nlin>=ch_ini)and(nlin<=ch_fin) then begin
            xbanda:='C';
            xlin:=nlin-ch_ini+1;
          end
          else if (nlin>=dt_ini)and(nlin<=dt_fin) then begin
            xbanda:='D';
            xlin:=nlin-dt_ini+1;
          end
          else if (nlin>=pf_ini)and(nlin<=pf_fin) then begin
            xbanda:='F';
            xlin:=nlin-pf_ini+1;
          end
          else
            xbanda:=' ';
          // Bandas Header, Column  y Footer
          if xbanda in ['H','C','F'] then begin
            for neti:=1 to TxCantEti do begin
              if (xlin=TxLabelEti[neti]^.txTop)and(xtipo=TxLabelEti[neti]^.txLetra) then begin
                if TxLabelEti[neti]^.txBanda='PH' then
                  nbanda:=1
                else if TxLabelEti[neti]^.txBanda='PF' then
                  nbanda:=3
                else if TxLabelEti[neti]^.txBanda='CH' then
                  nbanda:=2
                else nbanda:=0;
                entra:=false;
                case xbanda of
                  'H':entra:=nbanda=1;
                  'C':entra:=nbanda=2;
                  'F':entra:=nbanda=3;
                end;
                if entra then begin
                  PegaStrPosLong(lin,TxLabelEti[neti]^.txValor,
                                 TxLabelEti[neti]^.txLeft,
                                 TxLabelEti[neti]^.txSize,
                                 TxLabelEti[neti]^.txAlinea
                                 );
                  if TxLabelEti[neti]^.txEstilo1[1]='B' then begin
                    PegaStrPosLong(linb,TxLabelEti[neti]^.txValor,
                                   TxLabelEti[neti]^.txLeft,
                                   TxLabelEti[neti]^.txSize,
                                   TxLabelEti[neti]^.txAlinea
                                   );
                  end;
                  if TxLabelEti[neti]^.txEstilo1[3]='U' then begin
                    PegaStrPosLong(linu,CadenaStr(TxLabelEti[neti]^.txSize,'_'),
                                   TxLabelEti[neti]^.txLeft,
                                   TxLabelEti[neti]^.txSize,
                                   TxLabelEti[neti]^.txAlinea
                                   );
                    ii:=length(lin);
                    while (ii>=1)and(lin[ii]=' ') do begin
                      linu[ii]:=' ';
                      dec(ii);
                    end;
                    ii:=1;
                    while (ii<=length(lin))and(lin[ii]=' ') do begin
                      linu[ii]:=' ';
                      inc(ii);
                    end;
                  end;
                end;
              end;
            end;
          end
          // Banda Detalle
          else if (xbanda='D')and(ApDet<TotDet) then begin
            swtotal:=false;
            ss:=Lista[ApDet];
            ss2:=ExtraeElemStr(ss,1);
            if ApDet+1<TotDet then begin
              xtiporen:=ExtraeElemStr(Lista[ApDet+1],1);
              if xtiporen[1] in ['T','G'] then
                swtotal:=true;
            end;
            for neti:=1 to TxCantCol do begin
              if xtipo=TxLabelCol[neti]^.txLetra then begin
                ss3:=ExtraeElemStr(ss,neti+1);
                ii:=1;
                while (ii<=length(ss3))and(ss3[ii]='&') do begin
                  ss3[ii]:='¨';
                  inc(ii);
                end;
                TxLabelCol[neti]^.txValor:=ss3;
                PegaStrPosLong(lin,TxLabelCol[neti]^.txValor,
                               TxLabelCol[neti]^.txLeft,
                               TxLabelCol[neti]^.txSize,
                               TxLabelCol[neti]^.txAlinea
                               );
                for ii:=1 to length(lin) do
                  if lin[ii]='¨' then
                    lin[ii]:=' ';
                if (ss2='M')or(ss2='E') then
                  xestilo:=TxLabelCol[neti]^.txEstilo1
                else
                  xestilo:=TxLabelCol[neti]^.txEstilo2;
                if swtotal then begin
                  if TxLabelCol[neti]^.txAlinea='Right' then
                    xestilo[3]:='U';
                end;
                if xestilo[1]='B' then begin
                  PegaStrPosLong(linb,TxLabelCol[neti]^.txValor,
                                 TxLabelCol[neti]^.txLeft,
                                 TxLabelCol[neti]^.txSize,
                                 TxLabelCol[neti]^.txAlinea
                                 );
                end;
                if xestilo[3]='U' then begin
                  PegaStrPosLong(linu,CadenaStr(TxLabelCol[neti]^.txSize,'_'),
                                 TxLabelCol[neti]^.txLeft,
                                 TxLabelCol[neti]^.txSize,
                                 TxLabelCol[neti]^.txAlinea
                                 );
                  if not swtotal then begin
                    ii:=length(lin);
                    while (ii>=1)and(lin[ii]=' ') do begin
                      linu[ii]:=' ';
                      dec(ii);
                    end;
                    ii:=1;
                    while (ii<=length(lin))and(lin[ii]=' ') do begin
                      linu[ii]:=' ';
                      inc(ii);
                    end;
                  end;
                end;
              end;
            end;
          end;
          lin3[tl]:=lin;
          lin3u[tl]:=linu;
          lin3b[tl]:=linb;
        end;

        // Imprime Lineas
        sw:=false;
        for tl:=1 to 3 do begin
          if lin3[tl]<>'' then begin
            if sw then begin
              if not swvideo then
                if npag>=TxPaginaInicial then
                  ImprimeTxt(#13);
            end
            else sw:=true;
            ancho:=areaancho;
            case tl of
              1:begin
                  xLetra:=TxLetCh;
                  ancho:=TxLonCh-marg_izq;
                end;
              2:begin
                  xLetra:=TxLetMd;
                  ancho:=TxLonMd-marg_izq;
                end;
              3:begin
                  xLetra:=TxLetGr;
                  ancho:=TxLonGr-marg_izq;
                end;
            end;
            if not swvideo then
              if npag>=TxPaginaInicial then
                ImprimeTxt(xLetra);
            if ancho>areaancho then
              ancho:=areaancho;
            if npag>=TxPaginaInicial then begin
              if not swvideo then begin
                ImprimeTxt(espaciostr(marg_izq)+copy(lin3[tl],1,Ancho));
              end
              else
                PreparaVideo(espaciostr(marg_izq)+copy(lin3[tl],1,Ancho));
            end;
            // Bold
            if lin3b[tl]<>'' then begin
              if not swvideo then begin
                if npag>=TxPaginaInicial then begin
                  ImprimeTxt(#13);
                  ImprimeTxt(xLetra+espaciostr(marg_izq)+copy(lin3b[tl],1,Ancho));
                end;
              end;
            end;
            // Underline
            if lin3u[tl]<>'' then begin
              if npag>=TxPaginaInicial then begin
                if not swvideo then begin
                  ImprimeTxt(#13);
                  ImprimeTxt(xLetra+espaciostr(marg_izq)+copy(lin3u[tl],1,Ancho));
                end
                else begin
                  PreparaVideo(espaciostr(marg_izq)+copy(lin3u[tl],1,Ancho));
                end;
              end;
            end;
          end;
        end;
        if npag>=TxPaginaInicial then begin
          if not swvideo then begin
            ImprimeTxtLn('');
          end
          else
            ImprimeVideo;
        end;
        if xbanda='D' then
          inc(apdet);
      end;
    end;
  finally
    FinImpresionTxt(swimpre);
  end;
end;

procedure FinalizaRepTxt;
var i:word;
begin
  for i:=1 to txCantEti do
    dispose(txLabelEti[i]);
  txCantEti:=0;
  for i:=1 to txCantCol do
    dispose(txLabelCol[i]);
  txCantCol:=0;
end;

procedure PreparaListaTxt(Lista:TStrings);
var i:longint;
    tpant,tipo:string;
begin
  TxPaginaInicial:=1;
  tpant:=' ';
  i:=0;
  while (i<=Lista.Count-1) do begin
    tipo:=ExtraeElemStr(Lista[i],1);
    if tipo<>'' then begin
      if (tpant[1] in ['T','G'])and(tipo[1] in ['D','M','E']) then
        Lista.Insert(i,'D // ');
      tpant:=tipo;
    end;
    inc(i);
  end;
end;

begin
  //PrBufferTxt:='Si';
  txCantEti:=0;
  txCantCol:=0;
  TxLetCh:=#15;
  TxLetMd:=#18;
  TxLetGr:=#15#14;
  TxImpre:='';
  TxLongBuffer:=10000;
end.
