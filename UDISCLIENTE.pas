unit UDISCLIENTE;

interface

uses Variants,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  OoMisc, AdPort, StdCtrls, Buttons, ComCtrls, ExtCtrls, Menus,
  Mask, ImgList, Db, DBTables, Grids, ULibPrint, DBGrids, RXShell, Registry;

const Version='3.1';
type
  TFDISCLIENTE = class(TForm)
    Panel1: TPanel;
    PageControl1: TPageControl;
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
    RadioGroup1: TRadioGroup;
    StaticText15: TStaticText;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label3: TLabel;
    MaskEdit1: TMaskEdit;
    MaskEdit2: TMaskEdit;
    BitBtn2: TBitBtn;
    ProgressBar1: TProgressBar;
    Label4: TLabel;
    ImageList1: TImageList;
    Panel2: TPanel;
    ListView1: TListView;
    StaticText16: TStaticText;
    Memo2: TMemo;
    QL_Cons: TQuery;
    Panel4: TPanel;
    PageControl2: TPageControl;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
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
    QL_ConsPOSCARGA: TIntegerField;
    QL_ConsMONVOL: TStringField;
    QL_ConsVALOR: TFloatField;
    QL_ConsESTATUS: TStringField;
    QL_ConsPOSICION: TIntegerField;
    QL_ConsVOLUMEN: TFloatField;
    QL_ConsPRECIO: TFloatField;
    QL_ConsIMPORTE: TFloatField;
    QL_ConsCOMBUSTIBLE: TStringField;
    QL_ConsFOLIO: TIntegerField;
    QL_ConsVALOR2: TFloatField;
    QL_ConsESTADO: TIntegerField;
    QL_ConsOTROS: TStringField;
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Restaurar1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
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
  private
    { Private declarations }
    SwProcesando,
    SwInicio:Boolean;
    swcerrar:boolean;
    SnPosCarga:integer;
    SnImporte:real;
    SnDirecto:boolean;
  public
    { Public declarations }
    procedure DespliegaPosCarga(xpos:integer);
    procedure IniciaBaseDeDatos;
    procedure IniciaEstacion;
  end;

type
     tiposcarga = record
       estatus  :integer;
       descestat:string[20];
       importe,
       volumen,
       precio   :real;
       isla,
       PosDispActual:integer;
       NoComb   :integer;
       TComb    :array[1..2] of integer;
       TPos     :array[1..2] of integer;
       TPrec    :array[1..2] of integer;
       TNombre  :array[1..2] of string[20];
       TotalLitros:array[1..2] of real;
     end;


var
  FDISCLIENTE: TFDISCLIENTE;
  TPrecio:array[1..9] of real;
  TPosCarga:array[1..32] of tiposcarga;
  MaxPosCarga:integer;
  AvanceBar:integer;
  SwSolOk:boolean;
  StErrSol:integer;
  ruta_db:string;

implementation

uses ULIBGRAL, ULIBLICENCIAS, DDMCONS, UAutoriza2,
  DDMCONS2, UDISMENU;

{$R *.DFM}

procedure TFDISCLIENTE.IniciaBaseDeDatos;
var xcom:string;
    i:integer;
begin
  with DMCONS do begin
    Screen.Cursor:=crHourGlass;
    try
      Q_BombIb.Active:=false;
      Q_BombIb.Active:=true;

      if Q_BombIb.IsEmpty then
        raise Exception.Create('Estación no existe, o no tiene posiciones de carga configurados');

      // Carga Combustibles
      for i:=1 to MaxComb do with TabComb[i] do begin
        Activo:=false;
        Nombre:='';
        Precio:=0;
        AplicaPrecio:=false;
        ProductoPrecio:='';
        Agruparcon:=0;
      end;
      Q_CombIb.Active:=true;
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
      CargaPreciosFH(Now,false); // no afecta precio físico
      DBGrid3.Refresh;
    finally
      Screen.Cursor:=crDefault;
    end;
  end;
end;

procedure TFDISCLIENTE.IniciaEstacion;
var i,j,xisla,xpos,xcomb,xnum:integer;
    existe:boolean;
begin
  with DMCONS do begin
    ListView1.Items.Clear;
    MaxPosCarga:=0;
    for i:=1 to 32 do with TPosCarga[i] do begin
      estatus:=0;
      NoComb:=0;
      for j:=1 to 2 do
        TotalLitros[j]:=0;
    end;
    Q_BombIb.First;
    while not Q_BombIb.Eof do begin
      xisla:=Q_BombIbIsla.asinteger;
      xpos:=Q_BombIbPosCarga.AsInteger;
      xcomb:=Q_BombIbCombustible.AsInteger;
      if xpos>MaxPosCarga then begin
        MaxPosCarga:=xpos;
        while ListView1.Items.Count<MaxPosCarga do
          ListView1.Items.Add;
        ListView1.Items[MaxPosCarga-1].Caption:=IntToClaveNum(xpos,2);
        ListView1.Items[MaxPosCarga-1].ImageIndex:=0;
      end;
      with TPosCarga[xpos] do begin
        Isla:=xisla;
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
          TPrec[TPos[NoComb]]:=Q_BombIbCon_Precio.AsInteger;
          TNombre[TPos[NoComb]]:=Q_BombIbNombreComb.AsString;
        end;
      end;
      Q_BombIb.Next;
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


procedure TFDISCLIENTE.FormShow(Sender: TObject);
begin
  if SwInicio then begin
    try
      SwInicio:=false;
      IniciaBaseDeDatos;
      ListBox1.ItemIndex:=0;
      IniciaEstacion;
      ListBox1.SetFocus;
      Timer1.Enabled:=true;
      Caption:=Caption+' Versión '+version;
      ErrorInic:=false;
    finally
      Timer1.Enabled:=true;
    end;
  end;
end;

procedure TFDISCLIENTE.DespliegaPosCarga(xpos:integer);
var i,xp,rango,posi,posf,xfolio,xcomb,xc,xpc:integer;
    xnombre:string;
begin
  // DESPLIEGA ISLA ACTUAL
  rango:=ListBox1.ItemIndex+1;
  if rango=0 then
    rango:=1;
  posi:=rango*4-3;
  posf:=rango*4;
  with TPosCarga[xpos] do begin
    xnombre:=TNombre[PosDispActual];
    if xpos in [posi..posf] then begin
      i:=xpos-posi+1;
      TStaticText(FindComponent('StaticText'+IntToStr(i))).Caption:=IntToClaveNum(xpos,2);
      TPanel(FindComponent('panelPC'+IntToStr(i))).Caption:=descestat+' - '+inttostr(estatus);
      case estatus of
        2:TPanel(FindComponent('panelPC'+IntToStr(i))).color:=ClLime;
        1:TPanel(FindComponent('panelPC'+IntToStr(i))).color:=ClRed;
        9:TPanel(FindComponent('panelPC'+IntToStr(i))).color:=ClYellow;
        else TPanel(FindComponent('panelPC'+IntToStr(i))).color:=ClWhite;
      end;
      TListBox(FindComponent('ListBoxPC'+IntToStr(i))).Items.Clear;
      TListBox(FindComponent('ListBoxPC'+IntToStr(i))).Items.Add(FormatFloat('##,##0.000',volumen)+' Litros');
      TListBox(FindComponent('ListBoxPC'+IntToStr(i))).Items.Add(FormatFloat('###,##0.00',importe)+' Pesos');
      TListBox(FindComponent('ListBoxPC'+IntToStr(i))).Items.Add(FormatFloat('##,##0.000',precio)+' $/Lts');
      TListBox(FindComponent('ListBoxPC'+IntToStr(i))).Items.Add(xnombre);
      TListBox(FindComponent('ListBoxPC'+IntToStr(i))).Items.Add('');
      for xp:=1 to NoComb do begin
        TListBox(FindComponent('ListBoxPC'+IntToStr(i))).Items.Add(FormatFloat('##,###,##0.00',totallitros[xp])+
                 ' '+copy(TNombre[xp],1,3)
                 );
      end;
    end;
  end;

  // Refresca Listas
  for i:=1 to MaxPosCarga do with TPosCarga[i] do begin
    case estatus of
      1:ListView1.Items[i-1].ImageIndex:=1;
      2:ListView1.Items[i-1].ImageIndex:=2;
      9:ListView1.Items[i-1].ImageIndex:=3;
      else ListView1.Items[i-1].ImageIndex:=0;
    end;
    ListView1.Items[i-1].Caption:=IntToClaveNum(i,2)+
                  '  '+LlenaStr(FormatFloat('##,##0.00',importe),'D',10,' ');
  end;
end;


procedure TFDISCLIENTE.Restaurar1Click(Sender: TObject);
begin
  Visible:=true;
end;

procedure TFDISCLIENTE.FormCreate(Sender: TObject);
begin
  SwInicio:=true;
  SwCerrar:=false;
end;

procedure TFDISCLIENTE.BitBtn3Click(Sender: TObject);
begin
  Visible:=false;
  NotificationIcon1.Show;
end;

procedure TFDISCLIENTE.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.Terminate;
end;

procedure TFDISCLIENTE.Timer1Timer(Sender: TObject);
var ss,rsp:string;
    i,xpos:integer;
begin
  QL_Cons.Active:=false;
  QL_Cons.Active:=true;
  while not QL_Cons.Eof do begin
    xpos:=QL_ConsPosCarga.AsInteger;
    if xpos in [1..MaxPosCarga] then with TPosCarga[xpos] do begin
      estatus:=QL_ConsEstado.asinteger;
      case estatus of
        0:descestat:='-0-';
        1:descestat:='Inactivo';
        2:descestat:='En Uso';
        3:descestat:='Usado';
        4:descestat:='-4-';
        5:descestat:='Llamando';
        6:descestat:='-6-';
        7:descestat:='-7-';
        8:descestat:='Parado';
        9:descestat:='Autorizado';
      end;
      importe:=QL_ConsImporte.AsFloat;
      volumen:=QL_ConsVolumen.AsFloat;
      precio:=QL_ConsPrecio.AsFloat;
      for i:=1 to 2 do
        if TNombre[i]=QL_ConsCombustible.asstring then
          posdispactual:=i;
      if not (posdispactual in [1,2]) then
        posdispactual:=1;
      try
        TotalLitros[1]:=StrToFloat(ExtraeElemStrSep(QL_ConsOtros.AsString,1,'|'));
      except
        TotalLitros[1]:=0;
      end;
      try
        TotalLitros[2]:=StrToFloat(ExtraeElemStrSep(QL_ConsOtros.AsString,2,'|'));
      except
        TotalLitros[2]:=0;
      end;
      DespliegaPosCarga(xpos);
    end;
    QL_Cons.Next;
  end;
  if NotificationIcon1.Tag=0 then begin
    if ErrorInic then begin
      EsperaMiliSeg(3000);
      Application.Terminate;
    end;
    NotificationIcon1.Tag:=1;
    FDISMENU.Visible:=false;
    NotificationIcon1.Show;
  end;
end;

procedure TFDISCLIENTE.MaskEdit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=13 then
    MaskEdit2.SetFocus;
  if key in [48..57] then begin
    MaskEdit2.Text:='';
    StaticText16.Caption:='';
  end;
end;

procedure TFDISCLIENTE.MaskEdit2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=13 then
    BitBtn2.SetFocus;
end;

procedure TFDISCLIENTE.ListBox1KeyPress(Sender: TObject; var Key: Char);
begin
  if key='*' then
    MaskEdit1.SetFocus;
end;

procedure TFDISCLIENTE.MaskEdit1Enter(Sender: TObject);
begin
  MaskEdit1.Text:='';
  MaskEdit2.Text:='';
end;

procedure TFDISCLIENTE.GroupBox1Enter(Sender: TObject);
begin
  if SwProcesando then
    Memo2.SetFocus;
end;

procedure TFDISCLIENTE.MaskEdit1Exit(Sender: TObject);
begin
  MaskEdit1.Text:=FiltraStrNum(MaskEdit1.Text);
end;

procedure TFDISCLIENTE.NotificationIcon1DblClick(Sender: TObject);
begin
  Restaurar1Click(Sender);
end;

procedure TFDISCLIENTE.ListView1DblClick(Sender: TObject);
var xpos,xind:integer;
begin
  xpos:=strtointdef(copy(ListView1.ItemFocused.Caption,1,2),0);
  xind:=(xpos)div(4);
  if (xpos)mod(4)>0 then
    inc(xind);
  ListBox1.ItemIndex:=xind-1;
end;

end.
