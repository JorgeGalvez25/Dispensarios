unit DDMCONS2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Db;

type
  TDMCONS2 = class(TDataModule)
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ImprimeTicketVolumetricoBarras(xfolio:integer;ximpre:string;copia:boolean);
    procedure ImprimeTicketVolumetrico(xfolio:integer;ximpre:string;copia:boolean);
    function EmpacaEstacionFolio(numest:string;folio:integer):string;
  end;

var
  DMCONS2: TDMCONS2;

implementation

uses DDMCONS, UFormaPreverTxt, ULIBGRAL, ULIBPRINT;

{$R *.DFM}

function TDMCONS2.EmpacaEstacionFolio(numest:string;folio:integer):string;
var ss:string;
begin
  if numest<>'' then begin
    ss:=inttostr(folio);
    if length(ss)<8 then begin
      while length(numest)>2 do
        delete(numest,1,1);
      while length(numest)<2 do
        numest:='0'+numest;
      result:=numest+inttoclavenum(folio,7);
    end
    else result:=ss;
  end
  else result:=inttoclavenum(folio,8);
end;

procedure TDMCONS2.ImprimeTicketVolumetricoBarras(xfolio:integer;ximpre:string;copia:boolean);
var i:integer;
    vgok:boolean;
    ss,numest,barras:string;
    tss:array[1..2] of string;
    lst:TextFile;
    xprecio,xprecioact:real;
begin
  with DMCONS do begin
    If ximpre='-1' Then
       exit;
    T_ConfIb.Active:=true;
    T_MoviIb.Active:=true;
    T_EstsIb.Active:=true;
    if not T_EstsIb.IsEmpty then
      numest:=FiltraStrNum(T_EstsIbNumeroEstacion.AsString)
    else
      numest:='';
    if T_MoviIb.Locate('Folio',xfolio,[]) then begin
      AssignFile(lst,ximpre);
      {$i-} Rewrite(lst); {$i+}
      if ioresult<>0 then
        raise Exception.Create('Error al imprimir en: '+ximpre);
      try
        T_EmprIb.Active:=true;
        ss:=T_EmprIbRazonSocial.asstring;
        tss[1]:=ExtraeLineaDeParrafo(ss,40,1);
        tss[2]:=ExtraeLineaDeParrafo(ss,40,2);
        writeln(lst,LlenaStr(tss[1],'C',40,' '));
        if limpiastr(tss[2])<>'' then
          writeln(lst,LlenaStr(tss[2],'C',40,' '));
        if Limpiastr(T_EmprIbDireccion.AsString)<>'' then begin
          ss:=T_EmprIbDireccion.asstring;
          tss[1]:=ExtraeLineaDeParrafo(ss,40,1);
          tss[2]:=ExtraeLineaDeParrafo(ss,40,2);
          writeln(lst,LlenaStr(tss[1],'C',40,' '));
          if limpiastr(tss[2])<>'' then
            writeln(lst,LlenaStr(tss[2],'C',40,' '));
        end;
        if Limpiastr(T_EmprIbPoblacion.AsString)<>'' then
          writeln(lst,LlenaStr(limpiastr(T_EmprIbPoblacion.AsString),'C',40,' '));
        writeln(lst,LlenaStr('RFC: '+limpiastr(T_EmprIbRfc.AsString),'C',40,' '));
        writeln(lst,LlenaStr('Cliente Pemex: '+limpiastr(T_EmprIbCLIENTEPEMEX.AsString),'C',40,' '));
        writeln(lst,LlenaStr('Estacion de Servicio: '+numest,'C',40,' '));
        if limpiastr(T_ConfIbEstacionServicio.AsString)<>'' then
          writeln(lst,LlenaStr(T_ConfIbEstacionServicio.AsString,'C',40,' '));
        writeln(lst,'Folio: '+T_MoviIbFolio.AsString+'   Fecha: '+FechaPaq(T_MoviIbFecha.AsDateTime)+
                     ' '+copy(HoraPaq(T_MoviIbHora.AsDateTime),1,5));
        If copia Then
          writeln(lst,LlenaStr('****** COPIA ******','C',40,' '));
        writeln(lst,'Posicion de Carga '+IntToClaveNum(T_MoviIbPosCarga.AsInteger,2));
        writeln(lst,LlenaStr('','I',40,'-'));
        writeln(lst,'LITROS  COMBUSTIBLE   PRECIO   IMPORTE');
        writeln(lst,LlenaStr('','I',40,'-'));

        xprecioact:=DamePrecioFH(T_MoviIbCombustible.AsInteger,T_MoviIbHora.AsDateTime);
        xprecio:=T_MoviIbPrecio.AsFloat;
        if abs(xprecio-xprecioact)<=0.05 then
          xprecio:=xprecioact;

        writeln(lst,FormatoNumero(T_MoviIbVolumen.AsFloat,7,3)+' '+
                     LlenaStr(T_MoviIbclavecombus.AsString+' '+T_MoviIbNombreComb.AsString,'I',14,' ')+
                     FormatoNumero(xprecio,6,2)+
                     FormatoNumero(T_MoviIbImporte.AsFloat,10,2));
        writeln(lst,LlenaStr('','I',40,'-'));
        ss:='Son'+ImporteToLetras(T_MoviIbImporte.AsFloat,'Pesos','MN');
        tss[1]:=ExtraeLineaDeParrafo(ss,40,1);
        tss[2]:=ExtraeLineaDeParrafo(ss,40,2);
        writeln(lst,LlenaStr(tss[1],'C',40,' '));
        if limpiastr(tss[2])<>'' then
          writeln(lst,LlenaStr(tss[2],'C',40,' '));
        barras:=EmpacaEstacionFolio(numest,T_MoviIbFolio.AsInteger);
        writeln(lst,#29#104#90 + #29#119#2 + #29#107#69+char(length(barras))+barras);
                 // ANCHO         ALTO         CODIGO BARRAS
        writeln(lst,LlenaStr('Gracias por su preferencia','C',40,' '));
        for i:=1 to 4 do
          writeln(lst,'');
        writeln(lst,#29#86#1); // CORTE DE PAPEL
        try
          if T_MoviIbImpreso.AsString='No' then begin
            T_MoviIb.Edit;
            T_MoviIbImpreso.AsString:='Si';
            T_MoviIb.Post;
          end;
        except
        end;
      finally
        CloseFile(lst);
        T_ConfIb.Active:=false;
      end;
    end;
  end;
end;

procedure TDMCONS2.ImprimeTicketVolumetrico(xfolio:integer;ximpre:string;copia:boolean);
var i:integer;
    vgok:boolean;
    SS,NUMEST:STRING;
    tss:array[1..2] of string;
    xprecio,xprecioact:real;
begin
  with DMCONS do begin
    If ximpre='-1' Then
       exit;
    T_ConfIb.Active:=true;
    T_MoviIb.Active:=true;
    T_EstsIb.Active:=true;
    if not T_EstsIb.IsEmpty then
      numest:=FiltraStrNum(T_EstsIbNumeroEstacion.AsString)
    else
      numest:='';
    if T_MoviIb.Locate('Folio',xfolio,[]) then begin
      IniciaImpresionTxt(ximpre);
      try
        T_EmprIb.Active:=true;
        ss:=T_EmprIbRazonSocial.asstring;
        tss[1]:=ExtraeLineaDeParrafo(ss,40,1);
        tss[2]:=ExtraeLineaDeParrafo(ss,40,2);
        ImprimeTxtLn(LlenaStr(tss[1],'C',40,' '));
        if limpiastr(tss[2])<>'' then
          ImprimeTxtLn(LlenaStr(tss[2],'C',40,' '));
        if Limpiastr(T_EmprIbDireccion.AsString)<>'' then begin
          ss:=T_EmprIbDireccion.asstring;
          tss[1]:=ExtraeLineaDeParrafo(ss,40,1);
          tss[2]:=ExtraeLineaDeParrafo(ss,40,2);
          ImprimeTxtLn(LlenaStr(tss[1],'C',40,' '));
          if limpiastr(tss[2])<>'' then
            ImprimeTxtLn(LlenaStr(tss[2],'C',40,' '));
        end;
        if Limpiastr(T_EmprIbPoblacion.AsString)<>'' then
          ImprimeTxtLn(LlenaStr(limpiastr(T_EmprIbPoblacion.AsString),'C',40,' '));
        ImprimeTxtLn(LlenaStr('RFC: '+limpiastr(T_EmprIbRfc.AsString),'C',40,' '));
        ImprimeTxtLn(LlenaStr('Cliente Pemex: '+limpiastr(T_EmprIbCLIENTEPEMEX.AsString),'C',40,' '));
        ImprimeTxtLn(LlenaStr('Estación de Servicio: '+numest,'C',40,' '));
        if limpiastr(T_ConfIbEstacionServicio.AsString)<>'' then
          ImprimeTxtLn(LlenaStr(T_ConfIbEstacionServicio.AsString,'C',40,' '));
        ImprimeTxtLn('Folio: '+T_MoviIbFolio.AsString+'   Fecha: '+FechaPaq(T_MoviIbFecha.AsDateTime)+
                     ' '+copy(HoraPaq(T_MoviIbHora.AsDateTime),1,5));
        If copia Then
          ImprimeTxtLn(LlenaStr('****** COPIA ******','C',40,' '));
        ImprimeTxtLn('Posicion de Carga '+IntToClaveNum(T_MoviIbPosCarga.AsInteger,2));
        ImprimeTxtLn(LlenaStr('','I',40,'-'));
        ImprimeTxtLn('LITROS  COMBUSTIBLE   PRECIO   IMPORTE');
        ImprimeTxtLn(LlenaStr('','I',40,'-'));

        xprecioact:=DamePrecioFH(T_MoviIbCombustible.AsInteger,T_MoviIbHora.AsDateTime);
        xprecio:=T_MoviIbPrecio.AsFloat;
        if abs(xprecio-xprecioact)<=0.05 then
          xprecio:=xprecioact;

        ImprimeTxtLn(FormatoNumero(T_MoviIbVolumen.AsFloat,7,3)+' '+
                     LlenaStr(T_MoviIbNombreComb.AsString,'I',14,' ')+
                     FormatoNumero(xprecio,6,2)+
                     FormatoNumero(T_MoviIbImporte.AsFloat,10,2));
        ImprimeTxtLn(LlenaStr('','I',40,'-'));
        ss:='Son'+ImporteToLetras(T_MoviIbImporte.AsFloat,'Pesos','MN');
        tss[1]:=ExtraeLineaDeParrafo(ss,40,1);
        tss[2]:=ExtraeLineaDeParrafo(ss,40,2);
        ImprimeTxtLn(LlenaStr(tss[1],'C',40,' '));
        if limpiastr(tss[2])<>'' then
          ImprimeTxtLn(LlenaStr(tss[2],'C',40,' '));
        ImprimeTxtLn(' ');
        ImprimeTxtLn(LlenaStr('Gracias por su preferencia','C',40,' '));
        for i:=1 to 5 do
          ImprimeTxtLn('');
        ImprimeTxt(#27#109);
        try
          if T_MoviIbImpreso.AsString='No' then begin
            T_MoviIb.Edit;
            T_MoviIbImpreso.AsString:='Si';
            T_MoviIb.Post;
            T_MoviIb.Refresh;
          end;
        except
        end;
      finally
        FinImpresionTxt(VgOk);
        T_ConfIb.Active:=false;
      end;
    end;
  end;
end;

(*
procedure TDMCONS2.ImprimeTicketContado(xpos:integer;xcomb:string;xfecha,xhora:TDateTime;xvol,ximp:real;swcopia:boolean);
var i:integer;
    vgok:boolean;
begin
  with DMCONS do begin
    T_ConfIb.Active:=true;
    IniciaImpresionTxt(T_ConfIbImpresoraTickets.asstring);
    try
      T_EmprIb.Active:=true;
      ImprimeTxtLn(#27#114#1+LlenaStr(T_ConfIbNombreComercial.asstring,'C',40,' '));
      ImprimeTxtLn(#27#114#1+LlenaStr(T_ConfIbEstacionServicio.AsString,'C',40,' '));
      if swcopia then
        ImprimeTxtLn(#27#114#1+LlenaStr('*** C O P I A ***','C',40,' '));
      ImprimeTxtLn(#27#114#0+'Fecha '+FechaPaq(xfecha)+
                   ' '+HoraPaq(xhora));
      ImprimeTxtLn('Posicion de Carga '+IntToClaveNum(xpos,2));
      ImprimeTxtLn(LlenaStr('','I',40,'-'));
      ImprimeTxtLn(' LITROS  COMBUSTIBLE             IMPORTE');
      ImprimeTxtLn(LlenaStr('','I',40,'-'));
      ImprimeTxtLn(FormatoNumero(xvol,7,3)+'  '+
                   LlenaStr(xcomb,'I',21,' ')+
                   FormatoNumero(ximp,10,2));
      for i:=1 to 3 do
        ImprimeTxtLn('');
      ImprimeTxtLn(LlenaStr('','I',40,'-'));
      for i:=1 to 8 do
        ImprimeTxtLn('');
      ImprimeTxt(#27#109);
    finally
      FinImpresionTxt(VgOk);
      T_ConfIb.Active:=false;
    end;
  end;
end;
  *)

end.
