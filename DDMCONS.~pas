unit DDMCONS;

interface

uses Variants,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, ULibGral, uROClient, uROServer,
  uROIndyTCPServer, uROIndyHTTPServer, uROBinMessage, ADODB, SIBEABase,
  SIBFIBEA, FIBDatabase, pFIBDatabase;


const MaxComb=9;
      LitrosXGalon=3.7854;
      MargenTurnoAdmin=0.5/24;

type RegComb = record
       Activo :boolean;
       Nombre :string[20];
       ClavePemex:string[5];
       Precio :real;
       PrecioNuevo :real;
       PrecioAnt :real;
       SwLeePrecioFisico,
       AplicaPrecio:boolean;
       FechaHora:TDateTime;
       Folio:Integer;
       ProductoPrecio:string[6];
       Agruparcon:Integer;
       DigitoPrec:integer;
       Tag3  :integer;
     end;

     RegCmnd = record
       SwActivo   :boolean;
       folio      :integer;
       hora       :TDateTime;
       Comando    :string[80];
       SwResp,
       SwNuevo    :boolean;
       Respuesta  :string[80];
     end;

type
  TDMCONS = class(TDataModule)
    DBGASCON: TDatabase;
    T_MoviIb: TTable;
    T_FactIb: TTable;
    T_FactIbPOSCARGA: TIntegerField;
    T_FactIbCLAVE: TIntegerField;
    T_FactIbHORA: TDateTimeField;
    T_FactIbCOMBUSTIBLE: TIntegerField;
    T_FactIbVOLUMEN: TFloatField;
    T_FactIbIMPORTE: TFloatField;
    T_FactIbNombreComb: TStringField;
    Q_Fact1: TQuery;
    Q_Fact2: TQuery;
    DSQ_Fact1: TDataSource;
    DSQ_Fact2: TDataSource;
    Q_Fact1POSCARGA: TIntegerField;
    Q_Fact1CLAVE: TIntegerField;
    Q_Fact1HORA: TDateTimeField;
    Q_Fact1COMBUSTIBLE: TIntegerField;
    Q_Fact1VOLUMEN: TFloatField;
    Q_Fact1IMPORTE: TFloatField;
    Q_Fact2POSCARGA: TIntegerField;
    Q_Fact2CLAVE: TIntegerField;
    Q_Fact2HORA: TDateTimeField;
    Q_Fact2COMBUSTIBLE: TIntegerField;
    Q_Fact2VOLUMEN: TFloatField;
    Q_Fact2IMPORTE: TFloatField;
    Q_Fact1NombreComb: TStringField;
    Q_Fact2NombreComb: TStringField;
    T_FactIbIMPRESO: TStringField;
    Q_Fact1IMPRESO: TStringField;
    Q_Fact2IMPRESO: TStringField;
    T_MoviIbFOLIO: TIntegerField;
    T_MoviIbFECHA: TDateTimeField;
    T_MoviIbHORA: TDateTimeField;
    T_MoviIbPOSCARGA: TIntegerField;
    T_MoviIbCOMBUSTIBLE: TIntegerField;
    T_MoviIbVOLUMEN: TFloatField;
    T_MoviIbIMPORTE: TFloatField;
    T_MoviIbIMPRESO: TStringField;
    T_MoviIbTRANSACCION: TIntegerField;
    T_FactIbFOLIO: TIntegerField;
    T_FactIbTRANSACCION: TIntegerField;
    Q_Fact1FOLIO: TIntegerField;
    Q_Fact1TRANSACCION: TIntegerField;
    Q_Fact2FOLIO: TIntegerField;
    Q_Fact2TRANSACCION: TIntegerField;
    T_MoviIbTARJETA: TStringField;
    T_MoviIbKILOMETRAJE: TIntegerField;
    Q_MoviTarj: TQuery;
    Q_MoviTarjFOLIO: TIntegerField;
    Q_MoviTarjFECHA: TDateTimeField;
    Q_MoviTarjHORA: TDateTimeField;
    Q_MoviTarjPOSCARGA: TIntegerField;
    Q_MoviTarjCOMBUSTIBLE: TIntegerField;
    Q_MoviTarjVOLUMEN: TFloatField;
    Q_MoviTarjIMPORTE: TFloatField;
    Q_MoviTarjIMPRESO: TStringField;
    Q_MoviTarjTRANSACCION: TIntegerField;
    Q_MoviTarjTARJETA: TStringField;
    Q_MoviTarjKILOMETRAJE: TIntegerField;
    Q_MoviTarjAPLICAR: TStringField;
    T_Corte: TTable;
    T_CorteFECHA: TDateTimeField;
    T_CorteTURNO: TIntegerField;
    T_CorteISLA: TIntegerField;
    T_CortePOSCARGA: TIntegerField;
    T_CorteCOMBUSTIBLE: TIntegerField;
    T_CorteCONTADORLITROS: TFloatField;
    T_CorteCONTADORIMPORTE: TFloatField;
    Q_Corte: TQuery;
    Q_CorteCANTIDAD: TIntegerField;
    T_ConsIb: TTable;
    T_ConsIbPOSCARGA: TIntegerField;
    T_ConsIbMONVOL: TStringField;
    T_ConsIbVALOR: TFloatField;
    T_ConsIbESTATUS: TStringField;
    T_ConsIbPOSICION: TIntegerField;
    T_ConsIbVOLUMEN: TFloatField;
    T_ConsIbPRECIO: TFloatField;
    T_ConsIbIMPORTE: TFloatField;
    T_ConsIbDescEstatus: TStringField;
    T_ConfIb: TTable;
    T_ConfIbRAZONSOCIAL: TStringField;
    T_ConfIbNOMBRECOMERCIAL: TStringField;
    T_ConfIbESTACIONSERVICIO: TStringField;
    T_ConfIbLECTORSERIAL: TStringField;
    T_ConfIbULTIMOFOLIOCR: TIntegerField;
    T_ConfIbULTIMOFOLIOPP: TIntegerField;
    T_ConfIbIMPRESORATICKETS: TStringField;
    T_ConfIbPOSCLIENTE: TIntegerField;
    T_ConfIbLONGCLIENTE: TIntegerField;
    T_ConfIbPOSVEHICULO: TIntegerField;
    T_ConfIbLONGVEHICULO: TIntegerField;
    T_ConfIbCONFIGPUERTOTARJETA: TStringField;
    T_TarjIb: TTable;
    T_TarjIbNOCLIE: TIntegerField;
    T_TarjIbVEHIC: TIntegerField;
    T_TarjIbCODIGO: TStringField;
    T_TarjIbNOMBRECLIENTE: TStringField;
    T_TarjIbDESCRIPVEHICULO: TStringField;
    T_TarjIbCONDUCTOR: TStringField;
    T_TarjIbCONFIDENCIAL: TStringField;
    T_TarjIbTIPOTARJETA: TStringField;
    Q_ConsIb: TQuery;
    Q_Cons2Ib: TQuery;
    Q_ConsIbPOSCARGA: TIntegerField;
    Q_ConsIbMONVOL: TStringField;
    Q_ConsIbVALOR: TFloatField;
    Q_ConsIbESTATUS: TStringField;
    Q_ConsIbPOSICION: TIntegerField;
    Q_ConsIbVOLUMEN: TFloatField;
    Q_ConsIbPRECIO: TFloatField;
    Q_ConsIbIMPORTE: TFloatField;
    Q_Cons2IbPOSCARGA: TIntegerField;
    Q_Cons2IbMONVOL: TStringField;
    Q_Cons2IbVALOR: TFloatField;
    Q_Cons2IbESTATUS: TStringField;
    Q_Cons2IbPOSICION: TIntegerField;
    Q_Cons2IbVOLUMEN: TFloatField;
    Q_Cons2IbPRECIO: TFloatField;
    Q_Cons2IbIMPORTE: TFloatField;
    T_TranIb: TTable;
    T_TranIbTIPOVENTA: TStringField;
    T_TranIbFOLIO: TIntegerField;
    T_TranIbHORA: TDateTimeField;
    T_TranIbCLIENTE: TIntegerField;
    T_TranIbVEHICULO: TIntegerField;
    T_TranIbPOSCARGA: TIntegerField;
    T_TranIbCOMBUSTIBLE: TIntegerField;
    T_TranIbLITROS: TFloatField;
    T_TranIbTOTAL: TFloatField;
    T_ConsIbCOMBUSTIBLE: TStringField;
    Q_ConsIbCOMBUSTIBLE: TStringField;
    Q_Cons2IbCOMBUSTIBLE: TStringField;
    T_EmprIb: TTable;
    T_EmprIbCLAVE: TIntegerField;
    T_EmprIbRAZONSOCIAL: TStringField;
    T_EmprIbREVISION: TStringField;
    T_EmprIbFECHAREV: TDateTimeField;
    T_EmprIbTIPO: TStringField;
    T_EmprIbSERIEKEY: TIntegerField;
    T_EmprIbNOMCOMERCIAL: TStringField;
    T_EmprIbDIRECCION: TStringField;
    T_EmprIbPOBLACION: TStringField;
    T_EmprIbRFC: TStringField;
    T_EmprIbCLAVESUPER: TStringField;
    T_EmprIbCLAVEDIA: TStringField;
    T_EmprIbFORMATOCTAS: TStringField;
    T_EmprIbTIPOLICENCIA: TStringField;
    T_EmprIbMANTENIMIENTO: TStringField;
    T_EmprIbCONSOLA: TMemoField;
    T_EmprIbCLIENTEPEMEX: TStringField;
    T_EmprIbULTIMA_ACTUALIZACION: TDateTimeField;
    T_EstsIb: TTable;
    T_EstsIbCLAVE: TIntegerField;
    T_EstsIbNOMBRE: TStringField;
    T_EstsIbCONSOLA: TMemoField;
    T_EstsIbTIPODISPENSARIO: TIntegerField;
    T_EstsIbTIPOTANQUES: TIntegerField;
    T_EstsIbNUMEROESTACION: TStringField;
    Q_BombIb: TQuery;
    Q_BombIbISLA: TIntegerField;
    Q_BombIbPOSCARGA: TIntegerField;
    Q_BombIbCOMBUSTIBLE: TIntegerField;
    Q_BombIbCON_PRECIO: TIntegerField;
    Q_BombIbCON_POSICION: TIntegerField;
    Q_BombIbCON_DIGITOAJUSTE: TIntegerField;
    Q_CombIb: TQuery;
    Q_CombIbCLAVE: TIntegerField;
    Q_CombIbNOMBRE: TStringField;
    Q_CombIbCLAVEPEMEX: TStringField;
    Q_BombIbNombreComb: TStringField;
    Q_Prec: TQuery;
    Q_AplicaPrecioF: TQuery;
    T_Tanq: TTable;
    T_TanqTANQUE: TIntegerField;
    T_TanqCOMBUSTIBLE: TIntegerField;
    T_TanqCLAVEPRODUCTOMEDICION: TStringField;
    T_TanqVOLUMENFONDAJE: TFloatField;
    T_TanqCAPACIDAD: TFloatField;
    T_TanqALTURA: TFloatField;
    T_TanqNombreComb: TStringField;
    Q_Cvol: TQuery;
    Q_CvolFECHA: TDateTimeField;
    Q_CvolCORTE: TIntegerField;
    Q_CvolFECHAHORAINICIAL: TDateTimeField;
    Q_CvolFECHAHORAFINAL: TDateTimeField;
    Q_CvolESTATUS: TStringField;
    Q_CvolGENERADO: TStringField;
    T_Cvolt: TTable;
    DSQ_Cvol: TDataSource;
    T_CvoltFECHA: TDateTimeField;
    T_CvoltCORTE: TIntegerField;
    T_CvoltTANQUE: TIntegerField;
    T_CvoltFECHAHORA: TDateTimeField;
    T_CvoltCOMBUSTIBLE: TIntegerField;
    T_CvoltVOLUMEN: TFloatField;
    T_CvoltPORLLENAR: TFloatField;
    T_CvoltNIVEL: TFloatField;
    T_CvoltVOLUMENAGUA: TFloatField;
    T_CvoltTEMPERATURA: TFloatField;
    T_CvoltVOLUMENFONDAJE: TFloatField;
    T_Etan: TTable;
    T_EtanFOLIO: TIntegerField;
    T_EtanFECHA: TDateTimeField;
    T_EtanCORTE: TIntegerField;
    T_EtanTANQUE: TIntegerField;
    T_EtanCOMBUSTIBLE: TIntegerField;
    T_EtanVOLUMENINICIAL: TFloatField;
    T_EtanVOLUMENFINAL: TFloatField;
    T_EtanVOLUMENRECEPCION: TFloatField;
    T_EtanTEMPERATURA: TFloatField;
    T_EtanTERMINALDIST: TStringField;
    T_EtanTIPODOC: TStringField;
    T_EtanFECHADOC: TDateTimeField;
    T_EtanFOLIODOC: TStringField;
    T_EtanVOLUMENDOC: TFloatField;
    T_EtanFECHAHORAINICIAL: TDateTimeField;
    T_EtanFECHAHORAFINAL: TDateTimeField;
    T_EtanDATOSADICIONALES: TStringField;
    T_EtanFECHAHORADISP: TStringField;
    T_CvoltVOLUMENUTIL: TFloatField;
    SP_Corte: TStoredProc;
    Q_CvolDescripCorte: TStringField;
    DST_Cvolt: TDataSource;
    T_CvoltNombreComb: TStringField;
    Q_Etan: TQuery;
    Q_EtanFOLIO: TIntegerField;
    Q_EtanFECHA: TDateTimeField;
    Q_EtanCORTE: TIntegerField;
    Q_EtanTANQUE: TIntegerField;
    Q_EtanCOMBUSTIBLE: TIntegerField;
    Q_EtanVOLUMENINICIAL: TFloatField;
    Q_EtanVOLUMENFINAL: TFloatField;
    Q_EtanVOLUMENRECEPCION: TFloatField;
    Q_EtanTEMPERATURA: TFloatField;
    Q_EtanTERMINALDIST: TStringField;
    Q_EtanTIPODOC: TStringField;
    Q_EtanFECHADOC: TDateTimeField;
    Q_EtanFOLIODOC: TStringField;
    Q_EtanVOLUMENDOC: TFloatField;
    Q_EtanFECHAHORAINICIAL: TDateTimeField;
    Q_EtanFECHAHORAFINAL: TDateTimeField;
    Q_EtanDATOSADICIONALES: TStringField;
    Q_EtanFECHAHORADISP: TStringField;
    Q_EtanFECHAHORA: TDateTimeField;
    DSQ_Etan: TDataSource;
    Q_EtanNombreComb: TStringField;
    Q_Ctan: TQuery;
    Q_CtanFOLIO: TIntegerField;
    Q_CtanFECHA: TDateTimeField;
    Q_CtanCORTE: TIntegerField;
    Q_CtanTANQUE: TIntegerField;
    Q_CtanFECHAHORA: TDateTimeField;
    Q_CtanCOMBUSTIBLE: TIntegerField;
    Q_CtanNUEVOESTADO: TStringField;
    T_Ctan: TTable;
    T_CtanFOLIO: TIntegerField;
    T_CtanFECHA: TDateTimeField;
    T_CtanCORTE: TIntegerField;
    T_CtanTANQUE: TIntegerField;
    T_CtanFECHAHORA: TDateTimeField;
    T_CtanCOMBUSTIBLE: TIntegerField;
    T_CtanNUEVOESTADO: TStringField;
    DST_Ctan: TDataSource;
    T_CtanNombreComb: TStringField;
    T_CtanDescEstado: TStringField;
    Q_Movi: TQuery;
    Q_MoviFOLIO: TIntegerField;
    Q_MoviFECHA: TDateTimeField;
    Q_MoviHORA: TDateTimeField;
    Q_MoviPOSCARGA: TIntegerField;
    Q_MoviCOMBUSTIBLE: TIntegerField;
    Q_MoviVOLUMEN: TFloatField;
    Q_MoviIMPORTE: TFloatField;
    Q_MoviIMPRESO: TStringField;
    Q_MoviTRANSACCION: TIntegerField;
    Q_MoviTARJETA: TStringField;
    Q_MoviKILOMETRAJE: TIntegerField;
    Q_MoviAPLICAR: TStringField;
    Q_MoviHORASTR: TStringField;
    Q_MoviFECHACORTE: TDateTimeField;
    Q_MoviCORTE: TIntegerField;
    Q_MoviNombreComb: TStringField;
    DSQ_Movi: TDataSource;
    T_MoviIbNombreComb: TStringField;
    T_Logs: TTable;
    T_LogsMODULO: TStringField;
    T_LogsFECHAHORAINICIAL: TDateTimeField;
    T_LogsFECHAHORAFINAL: TDateTimeField;
    T_MoviIbHORASTR: TStringField;
    Q_PrecCOMBUSTIBLE: TIntegerField;
    Q_PrecPRECIO: TFloatField;
    Q_PrecAPLICADO: TStringField;
    Q_Auxi: TQuery;
    Q_AuxiReal1: TFloatField;
    Q_AuxiReal2: TFloatField;
    Q_AuxiReal3: TFloatField;
    Q_AuxiReal4: TFloatField;
    Q_AuxiReal5: TFloatField;
    Q_AuxiReal6: TFloatField;
    Q_AuxiEntero1: TIntegerField;
    Q_AuxiEntero2: TIntegerField;
    Q_AuxiChar1: TStringField;
    Q_AuxiStr10: TStringField;
    Q_AuxiStr10_2: TStringField;
    Q_AuxiStr6_1: TStringField;
    Q_AuxiStr6_2: TStringField;
    Q_AuxiDate1: TDateTimeField;
    T_MoviIbAPLICAR: TStringField;
    T_MoviIbFECHACORTE: TDateTimeField;
    T_MoviIbCORTE: TIntegerField;
    Q_PrecFECHAHORA: TDateTimeField;
    SP_DamePrec: TStoredProc;
    Q_CombIbCON_PRODUCTOPRECIO: TStringField;
    Q_PrecFOLIO: TIntegerField;
    Q_PrecEN_EDICION: TStringField;
    Q_PrecERROR: TStringField;
    Q_CombIbPRECIOFISICO: TFloatField;
    DSQ_Comb: TDataSource;
    T_Tcmb: TTable;
    T_TcmbCLAVE: TIntegerField;
    T_TcmbNOMBRE: TStringField;
    T_TcmbCLAVEPEMEX: TStringField;
    T_TcmbCON_PRODUCTOPRECIO: TStringField;
    T_TcmbPRECIOFISICO: TFloatField;
    T_ConfIbRUTAVOLUMETRICOS: TStringField;
    T_ConfIbIMPO_BOMBAS: TStringField;
    T_ConfIbIMPO_ESTACIONES: TStringField;
    T_ConfIbIMPO_PRECIOS: TStringField;
    T_ConfIbIMPO_TANQUES: TStringField;
    T_ConfIbIMPO_COMBUSTIBLES: TStringField;
    T_ConfIbIMPO_TARJETAS: TStringField;
    T_ConfIbIMPO_CONFIG: TStringField;
    T_ConfIbMASCARA_FLOAT: TStringField;
    T_ConfIbMASCARA_HORA: TStringField;
    T_ConfIbPERMITIR_CAMBIO_FECHAHORA: TStringField;
    Q_Cmnd: TQuery;
    Q_CmndFOLIO: TIntegerField;
    Q_CmndMODULO: TStringField;
    Q_CmndFECHAHORA: TDateTimeField;
    Q_CmndCOMANDO: TStringField;
    Q_CmndAPLICADO: TStringField;
    T_Cmnd: TTable;
    T_CmndFOLIO: TIntegerField;
    T_CmndMODULO: TStringField;
    T_CmndFECHAHORA: TDateTimeField;
    T_CmndCOMANDO: TStringField;
    T_CmndAPLICADO: TStringField;
    T_ConfIbINT_ACT_PRECIOS: TIntegerField;
    T_ConfIbIMPRESORAVOLUMETRICOS: TStringField;
    T_MoviIbFACTURADO: TStringField;
    T_MoviIbTOTAL01: TFloatField;
    T_MoviIbTOTAL02: TFloatField;
    T_Bita: TTable;
    T_ConfIbCOMANDO1: TStringField;
    T_ConfIbCOMANDO2: TStringField;
    T_ConfIbLEVANTAR_CONSOLAS: TStringField;
    T_ConfIbRUTA_RESPALDOS: TStringField;
    T_ConfIbLICENCIA: TStringField;
    T_ConfIbNUMEROSERIE: TIntegerField;
    T_Puer: TTable;
    T_PuerCLAVE: TStringField;
    T_PuerNUMEROPUERTO: TIntegerField;
    T_PuerVELOCIDAD: TIntegerField;
    T_PuerPARIDAD: TStringField;
    T_PuerBITSDATOS: TIntegerField;
    T_PuerBITSPARO: TIntegerField;
    T_EmprIbESTACION_IGAS: TIntegerField;
    T_MoviIbTAG: TIntegerField;
    T_ConsIbFOLIO: TIntegerField;
    T_ConfIbIMPRESORAGRAFICA: TStringField;
    T_ConsIbVALOR2: TFloatField;
    Q_ConsIbFOLIO: TIntegerField;
    Q_ConsIbVALOR2: TFloatField;
    T_TanqACTIVO: TStringField;
    Q_CombIbAGRUPAR_CON: TIntegerField;
    T_MoviIbPRECIO: TFloatField;
    T_MoviIbclavecombus: TStringField;
    Q_Pcar: TQuery;
    Q_PcarPOSCARGA: TIntegerField;
    Q_PcarSLOWFLOW: TFloatField;
    T_CmndRESULTADO: TStringField;
    Q_CmndRESULTADO: TStringField;
    T_ConsIbESTADO: TIntegerField;
    T_ConsIbOTROS: TStringField;
    T_Cvold: TTable;
    T_CvoldFECHA: TDateTimeField;
    T_CvoldCORTE: TIntegerField;
    T_CvoldPOSCARGA: TIntegerField;
    T_CvoldTOTAL01: TFloatField;
    T_CvoldTOTAL02: TFloatField;
    T_ConfIbDISPENSARIOS: TMemoField;
    T_Turc: TTable;
    T_TurcTURNO: TIntegerField;
    T_TurcHORAINICIAL: TStringField;
    T_TurcHORAFINAL: TStringField;
    Q_Turn: TQuery;
    Q_TurnFECHA: TDateTimeField;
    Q_TurnTURNO: TIntegerField;
    Q_TurnFECHAHORAINICIAL: TDateTimeField;
    Q_TurnFECHAHORAFINAL: TDateTimeField;
    Q_TurnESTATUS: TStringField;
    T_Turn: TTable;
    T_TurnFECHA: TDateTimeField;
    T_TurnTURNO: TIntegerField;
    T_TurnFECHAHORAINICIAL: TDateTimeField;
    T_TurnFECHAHORAFINAL: TDateTimeField;
    T_TurnESTATUS: TStringField;
    QL_Bomb: TQuery;
    QL_BombMANGUERA: TIntegerField;
    QL_BombPOSCARGA: TIntegerField;
    QL_BombCOMBUSTIBLE: TIntegerField;
    QL_BombISLA: TIntegerField;
    QL_BombCON_PRECIO: TIntegerField;
    QL_BombCON_POSICION: TIntegerField;
    QL_BombCON_DIGITOAJUSTE: TIntegerField;
    QL_BombIMPRESORA: TIntegerField;
    QL_BombACTIVO: TStringField;
    QL_BombIMPRIMEAUTOM: TStringField;
    Q_ConsIbESTADO: TIntegerField;
    Q_ConsIbOTROS: TStringField;
    Q_BombIbMANGUERA: TIntegerField;
    T_BitaFOLIO: TIntegerField;
    T_BitaFECHAHORA: TDateTimeField;
    T_BitaUSUARIO: TIntegerField;
    T_BitaOPERACION: TStringField;
    T_BitaOBSERVACIONES: TMemoField;
    T_BitaFECHA: TDateTimeField;
    Q_BombIbDIGITOAJUSTEPRECIO: TIntegerField;
    Q_CombIbDIGITOAJUSTEPRECIO: TIntegerField;
    T_TcmbAGRUPAR_CON: TIntegerField;
    T_TcmbDIGITOAJUSTEPRECIO: TIntegerField;
    T_MoviIbFECHATURNO: TDateTimeField;
    T_MoviIbTURNO: TIntegerField;
    T_MoviIbJARREO: TStringField;
    T_MoviIbMANGUERA: TIntegerField;
    SP_Paq_Volum: TStoredProc;
    T_CvoldTOTAL03: TFloatField;
    T_CvoldTOTAL04: TFloatField;
    T_MoviIbTOTAL03: TFloatField;
    T_MoviIbTOTAL04: TFloatField;
    QL_BombDIGITOAJUSTEPRECIO: TIntegerField;
    QL_BombCAMPOLECTURA: TStringField;
    QL_BombMODOOPERACION: TStringField;
    Q_BombIbMODOOPERACION: TStringField;
    T_ConfIbESTACION_IGAS: TIntegerField;
    T_ConfIbCONFIG_TICKET: TMemoField;
    T_ConfIbESTEMPORAL: TStringField;
    T_ConfIbFECHAVENCE: TDateTimeField;
    SP_Calcula_Ventas_Etan: TStoredProc;
    T_MoviIbTIPOPAGO: TIntegerField;
    T_TurcHORAMIN: TStringField;
    T_TurcHORAMAX: TStringField;
    Q_BombIbDIGITOAJUSTEVOL: TIntegerField;
    Q_BombIbDIGITOSGILBARCO: TIntegerField;
    Q_BombIbDECIMALESGILBARCO: TIntegerField;
    T_MoviIbBOUCHER: TStringField;
    T_MoviIbCUPONIMPRESO: TStringField;
    T_MoviIbREFERENCIABITACORA: TIntegerField;
    Q_AuxiStr20: TStringField;
    Q_PcarSLOWFLOW2: TFloatField;
    Q_PcarSLOWFLOW3: TFloatField;
    Q_AuxiEntero3: TIntegerField;
    T_ConsIbARO: TSmallintField;
    Q_ConsIbARO: TSmallintField;
    Q_BombIbDIGITOAJUSTEPRESET: TIntegerField;
    Q_BombIbCAMPOLECTURA: TStringField;
    T_ConsIbTIPOPAGO: TIntegerField;
    Q_ConsIbTIPOPAGO: TIntegerField;
    Q_BombIbTEAM_NODISP: TIntegerField;
    Q_BombIbTEAM_LADO: TIntegerField;
    Q_BombIbHJ_ADDR: TIntegerField;
    Q_BombIbHJ_LADO: TIntegerField;
    T_TcmbTAG: TStringField;
    T_TcmbTAG2: TStringField;
    T_TcmbTAG3: TStringField;
    Q_CombIbTAG: TStringField;
    Q_CombIbTAG2: TStringField;
    Q_CombIbTAG3: TStringField;
    T_ConfIbDIRECCIONPEMEX: TStringField;
    T_ConfIbUSUARIOPEMEX: TStringField;
    T_ConfIbCLAVEPEMEX: TStringField;
    T_ConfIbCOMANDO3: TStringField;
    T_ConfIbCOMANDO4: TStringField;
    T_ConfIbMODOADI: TSmallintField;
    T_ConfIbLICENCIA5: TStringField;
    T_ConfIbFECHAVENCE5: TDateTimeField;
    T_ConfIbESTEMPORAL5: TStringField;
    ROBinMessage1: TROBinMessage;
    ROIndyHTTPServer1: TROIndyHTTPServer;
    T_MoviIbGASID: TIntegerField;
    T_ConfIbUSATURNOSALTERNATIVOS: TStringField;
    ADOConnectionTeam: TADOConnection;
    ADOTableInv: TADOTable;
    ADOTableInvTanque: TStringField;
    ADOTableInvProducto: TStringField;
    ADOTableInvNivel: TFloatField;
    ADOTableInvTemperatura: TFloatField;
    ADOTableInvAgua: TFloatField;
    ADOTableInvVolBruto: TFloatField;
    ADOTableInvVolNeto: TFloatField;
    ADOTableInvCapDisponible: TFloatField;
    ADOTableInvEstado: TStringField;
    ADOQueryEnt: TADOQuery;
    ADOQueryEntTanque: TStringField;
    ADOQueryEntNivel_Gas_ini: TFloatField;
    ADOQueryEntNivel_Gas_fin: TFloatField;
    ADOQueryEntNivel_Agua_ini: TFloatField;
    ADOQueryEntNivel_Agua_fin: TFloatField;
    ADOQueryEntTemperatura_ini: TFloatField;
    ADOQueryEntTemperatura_fin: TFloatField;
    ADOQueryEntVol_Bruto_ini: TFloatField;
    ADOQueryEntVol_Bruto_fin: TFloatField;
    ADOQueryEntVol_Neto_ini: TFloatField;
    ADOQueryEntVol_Neto_fin: TFloatField;
    ADOQueryEntTurno: TFloatField;
    ADOQueryEntHora_Ini: TDateTimeField;
    ADOQueryEntHora_Fin: TDateTimeField;
    ADOQueryEntProducto: TStringField;
    ADOQueryEntFecha_Ini: TStringField;
    ADOQueryEntFecha_Fin: TStringField;
    ADOQueryEntLlave: TAutoIncField;
    ADOQueryEntHoraI: TStringField;
    ADOQueryEntHoraF: TStringField;
    pFIBDb1: TpFIBDatabase;
    SIBfibEA1: TSIBfibEventAlerter;
    T_MoviIbSALDO: TFloatField;
    T_MoviIbHEXHASH: TStringField;
    T_MoviIbFECHAMODIF: TDateTimeField;
    T_Alar: TTable;
    T_AlarFOLIO: TIntegerField;
    T_AlarFECHAHORA: TDateTimeField;
    T_AlarTANQUE: TIntegerField;
    T_AlarTIPOALARMA: TStringField;
    T_ConfIbLICENCIA3: TStringField;
    T_ConfIbLICENCIA4: TStringField;
    T_ConfIbLICENCIA2: TStringField;
    T_ConfIbFECHAVENCE2: TDateTimeField;
    T_ConfIbESTEMPORAL2: TStringField;
    T_ConfIbULTIMOIMPRESO: TIntegerField;
    T_ConfIbCONFIGCUPON: TMemoField;
    T_ConfIbUSARCUPONCORTESIA: TStringField;
    T_ConfIbBAN_NAME: TStringField;
    T_ConfIbBAN_PASSWORD: TStringField;
    T_ConfIbBAN_CLIENID: TStringField;
    T_ConfIbMODOPAGOSBANCARIOS: TStringField;
    T_ConfIbTICKET_PROMO: TMemoField;
    T_ConfIbALIASMASTER: TStringField;
    T_ConfIbFECHAINICIOSAT2014: TDateTimeField;
    T_BitaTIPOSUCESO: TStringField;
    T_BitaTXT: TStringField;
    Q_AuxiStr255: TStringField;
    Q_BombIbIMPRETARJETAS: TStringField;
    Q_UltPrec: TQuery;
    Q_UltPrecFOLIO: TIntegerField;
    Q_UltPrecCOMBUSTIBLE: TIntegerField;
    Q_UltPrecFECHAHORA: TDateTimeField;
    Q_UltPrecPRECIO: TFloatField;
    Q_UltPrecAPLICADO: TStringField;
    Q_UltPrecEN_EDICION: TStringField;
    Q_UltPrecERROR: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure T_FactIbCalcFields(DataSet: TDataSet);
    procedure Q_Fact1CalcFields(DataSet: TDataSet);
    procedure Q_Fact2CalcFields(DataSet: TDataSet);
    procedure T_ConsIbCalcFields(DataSet: TDataSet);
    procedure Q_CvolCalcFields(DataSet: TDataSet);
    procedure Q_CvolAfterOpen(DataSet: TDataSet);
    procedure T_CtanCalcFields(DataSet: TDataSet);
    procedure Q_AuxiAfterClose(DataSet: TDataSet);
    procedure T_EtanTIPODOCValidate(Sender: TField);
    procedure DBGASCONAfterConnect(Sender: TObject);
    procedure Q_CvolBeforeClose(DataSet: TDataSet);
    procedure SIBfibEA1EventAlert(Sender: TObject; EventName: String;
      EventCount: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
    TCombuPos   :array[1..2,1..32] of integer;
    TabCmnd     :array[1..40] of RegCmnd;
    TabHrsCorte :array[1..6] of TDateTime;
    NumHrsCorte,
    FolioCmnd   :integer;
    Md5Exe,Md5Cfg,
    AliasConsolaEsts:string;
    GasId  :integer;

    // DECLARACION VARIABLES
    ModoTurnos,
    CortesPorDia        :integer;
    FechaInicioSat      :TDateTime;

    HorasCorteTurnoAutom,
    TipoVolumenEntradaTanques,
    BitacoraTanques,
    SoportaSeleccionProducto,
    ControlAros,
    PuertoServicio,
    Inocuidad31Licencia,
    Inocuidad31FechaVence,
    GuardaLogEntradaTanques,
    TotalCalculado,
    OrdenMangueras,
    ValorDispensarios           :String;

    // VEEDER ROOT
    CodigoSeguridadVeederRoot,
    SincHoraVeederRoot          :String;
    MinutosReinicioTanques,
    SegEsperaEntradaVeederRoot  :Integer;

    // AUTOSTICK
    ValidaCheckSumAutostik,
    AutostikEnGalones,
    AutostikAlarmas             :String;

    // GILBARCO 2W
    GtwDivPresetLts,        // Divisor preset litros           **
    GtwDivPresetPesos,      // Divisor preset pesos            **

    GtwDivPrecio,           // Divisor precio para lecturas y cambio de precios       **
    GtwDivImporte,          // Divisor importe para lecturas y ventas                 **
    GtwDivLitros,           // Divisor litros para ventas                             **

    GtwDivTotLts,           // Divisor totales litros     **
    GtwDivTotImporte,       // Divisor totales pesos      **

    GtwTimeOut,             // Timeout miliseg
    GtwTiempoCmnd :integer; // Tiempo entre comandos miliseg

    // WAYNE
    WayneFusion,
    MapeoFusion,
    WayneFusionNivelPrecio,
    WayneFusionCombXPrecio,
    WayneValidaImporteDespacho,
    WayneAjusteImporte,
    ModoPrecioWayne,
    TierLavelWayne,
    AjusteWayne,
    AjusteWayne2,
    InicializaWayne,
    ManejaCanalWayne,
    PosicionProductoWayne       :String;
    DecimalesPresetWayne,
    DecimalesPresetWayneLitros  :Integer;

    // PAM
    AjustePAM,
    AjustePAMDiezMil,
    ReautorizaPam,
    PamNivelPrecio,
    VersionPam1000,
    SetUpPAM1000              :String;

    // BENNETT
    BennettPararVentaCompleta,
    Bennett8Digitos           :String;
    BennettReintentosPreset,
    ModoAutorizaBennett        :Integer;


    ReconexionesAros,PosVehiculo,
    MinimoHorasCorte,
    MaximoDePosiciones,
    MaxRegCmnd                :Integer;

    CierraBD,
    TresDecimTotTeam,
    TurnosAlternativos,
    LogTotales,
    ValidaCambioPrecio,
    ServidorGateway         :string;
    FlujoPorVehiculo:Boolean;
    TimerDisp,ConteoOcc:Integer;
    // FIN VARIABLES
    PuertoGatewayDisp,
    PuertoGatewayTanq,    
    emEstacionServicio            :integer;
    SegundosFINV            :Integer;
    PreciosInicio           :Boolean;

    TabComb:array[1..MaxComb] of RegComb;
    PrimeraCarga:boolean;
    ListaConsola:TStrings;
    lcPosCarga  :integer;
    lcEstatus,
    lcMonVol    :string[1];
    lcValor     :real;
    lcPosicion  :integer;
    lcVolumen,
    lcPrecio,
    lcImporte   :real;
    lcDescEstatus,
    lcCombustible:string[20];
    lcFolio  :integer;
    ListaSolicitud:TStrings;
    SwCorteOk,
    SwCorteParcial,
    SwCorteTurno:boolean;
    xIslaCorte,
    xTurnoCorte:integer;
    FechaHoraLog,
    FechaHoraRefLog,
    FechaHoraPrecio,
    FechaHoraComando,
    HoraUltimoCorte,
    xFechaCorte:TDateTime;
    SwEmular,
    SwMapOff,
    SwSolicitud:boolean;
    SwChecaVentaTarjeta:boolean;
    FechaUltimoCorte,
    FechaSiguienteCorte :TDateTime;
    ModuloActual:String;
    SwCambioPrecio,
    SwPrecioFisico:boolean;
    SwFechaHoraTM:boolean;
    UltimaFechaHoraTM,
    UltimaFechaHora:TDateTime;
    LcLicencia:string;
    LcLicTemporal:boolean;
    LcLicVence:TDateTime;
    StLevanta:string;
    LcSerie:integer;
    PtParidad   :string[1];
    PtPuerto,
    PtBaudios,
    PtBitsDatos,
    PtBitsParada:word;
    IniTurnoActual:TDateTime;
    FinTurnoActual:TDateTime;
    FinTurnoActualMin:TDateTime;
    FinTurnoActualMax:TDateTime;
    FechaTurnoActual:TDateTime;
    FinTurnoActualMargenPos,FinTurnoActualMargenAnt:real;
    TurnoActual:integer;
    ContadorTot,
    ContadorTotPos:integer;
    ListaLog,
    ListaLogCmnd :TStrings;
    Accion  :string;
    procedure ConectaBaseDatos;
    procedure CargaPreciosFH(xFechaHora:TDateTime;SwMeteAFisico:boolean);
    function DamePrecioFH(xComb:integer;xFechaHora:TDateTime):real;
    function LeeTxtConsola(xpos:integer):boolean;
    procedure CargaConfiguracionConsola;
    function AplicarPrecios:boolean;
    procedure AplicarUltimosPrecios;
    procedure CalculaFechasCorte;
    function UltimoEstadoTanque(xtan:integer):string;
    procedure ConectaAplicacion;
    procedure RefrescaConexion;
    procedure RegistraBitacora(xUsuario:integer;xOperacion:string;xObserva:TStrings);
    procedure RegistraBitacora2(xUsuario:integer;xOperacion:string);
    procedure RegistraBitacora3(xUsuario:integer;xOperacion:string;xObserva:String;xTipo:char);
    procedure RegistraTotales_BD(xposcarga:integer;xtotal01,xtotal02:real);
    procedure RegistraTotales_BD4(xposcarga:integer;xtotal01,xtotal02,xtotal03,xtotal04:real);
    procedure ActualizaTotalesPrecio(xposcarga,xposmang:integer;xvolumen:real);
    procedure CalculaTurnoActual(xFechaHora:TDateTime);
    procedure AbreNuevoTurno;
    procedure CalculaTurnoActual2;
    procedure AgregaLog(lin:string);
    procedure AgregaLogCmnd(lin:string);
    function DameTotalCombuPos(xpos,xcomb:integer;xtot1,xtot2:real):real;
    procedure ReviConsola(xrevi:string);
    procedure ActualizaDispensarios(xdisp:string);
    function DameDispensarios:string;
    function EjecutaComando(xCmnd:string):integer;
    function ResultadoComando(xFolio:integer):string;
    procedure ActivaModoPrepago(xpos:integer);
    procedure DesActivaModoPrepago(xpos:integer);
    function CalculaVentaPorLectura(xlectini,xlectfin:real):real;
    procedure ParametrosArosMagneticos(xpos:integer; var xmangera,xcliente,xvehiculo:integer);
    function ControlArosMagneticos(xpos:integer; var xmanguera,xcliente,xvehiculo:integer):boolean;
    function ControlArosMagneticos2(xpos:integer; var xmanguera,xcliente,xvehiculo:integer):boolean;
    function ConexionArosActiva(xpos:integer):boolean;
    function ControlArosMagneticosRecon(xpos:integer; var xmanguera,xcliente,xvehiculo:integer):boolean;
    procedure BorraComandos;
    procedure BorraComandos2(xcant:integer);
    procedure InsertaComandoFinv(xpos,xpago:integer);
    procedure ActivaSrvDispensarios;
    function EncriptaCadena(const APassword, ATexto: String): String;
    function ValidaCifra(xvalor:real;xenteros,xdecimales:byte):string;
    function AutoValidarMD5:Boolean;
  end;

var
  DMCONS: TDMCONS;

implementation

uses UIMGUTIL, DECUTIL, Cipher, Hashes;

{$R *.DFM}

//Los parámetros que recibe la función son el número de estación y el importe
function TDMCONS.EncriptaCadena(const APassword, ATexto: String): String;
begin
  with TCipher_Blowfish.Create(APassword, nil) do
  try
    Result := CodeString(ATexto, paEncode, TStringFormat_HEX.Format);
  finally
    Free;
  end;
end;

procedure TDMCONS.ActivaSrvDispensarios;
//  PuertoServicio:='http://127.0.0.1:8199/bin/';
var xpuerto:string;
begin
  try
    if not ROIndyHTTPServer1.Active then begin
      xpuerto:=ExtraeElemStrSep(PuertoServicio,3,':');
      xpuerto:=ExtraeElemStrSep(xpuerto,1,'/');
      ROIndyHTTPServer1.Port:=StrToIntDef(xpuerto,8199);
      ROIndyHTTPServer1.Active:=true;
    end;
  except
  end;
end;

function TDMCONS.ValidaCifra(xvalor:real;xenteros,xdecimales:byte):string;
var xmax,xaux:real;
    i:integer;
begin
  if xvalor<-0.0001 then begin
    result:='Valor negativo no permitido';
    exit;
  end;
  xmax:=1;
  for i:=1 to xenteros do
    xmax:=xmax*10;
  if xvalor>(xmax-0.0000000001) then begin
    result:='Valor excede maximo permitido';
    exit;
  end;
  xaux:=AjustaFloat(xvalor,xdecimales);
  if abs(xaux-xvalor)>0.000000001 then begin
    if xdecimales=0 then
      result:='Solo se permiten valores enteros'
    else
      result:='Numero de decimales excede maximo permitido';
    exit;
  end;
  result:='OK';
end;

procedure TDMCONS.ActualizaTotalesPrecio(xposcarga,xposmang:integer;xvolumen:real);
var tot1,tot2,tot3,tot4:real;
    xfechora:Tdatetime;
    xturno:integer;
begin
  try
    Q_Auxi.Active:=false;
    Q_AuxiEntero1.FieldKind:=fkInternalCalc;
    Q_AuxiEntero2.FieldKind:=fkInternalCalc;
    Q_AuxiDate1.FieldKind:=fkInternalCalc;
    Q_AuxiReal1.FieldKind:=fkInternalCalc;
    Q_AuxiReal2.FieldKind:=fkInternalCalc;
    Q_AuxiReal3.FieldKind:=fkInternalCalc;
    Q_AuxiReal4.FieldKind:=fkInternalCalc;
    Q_Auxi.SQL.Clear;
    Q_Auxi.SQL.Add('Select First 1 FechaHora as Date1,Turno as Entero2,PosCarga as Entero1,Total01 as Real1,Total02 as Real2,Total03 as Real3,Total04 as Real4 from DPVGTURNDD');
    Q_Auxi.SQL.Add('WHERE PosCarga='+inttostr(xposcarga));
    Q_Auxi.SQL.Add('Order by FechaHora desc');
    Q_Auxi.Active:=true;
    if Q_AuxiEntero1.AsInteger=xposcarga then begin
      xfechora:=Q_AuxiDate1.AsDateTime;
      xturno:=Q_AuxiEntero2.AsInteger;
      tot1:=Q_AuxiReal1.AsFloat;
      tot2:=Q_AuxiReal2.AsFloat;
      tot3:=Q_AuxiReal3.AsFloat;
      tot4:=Q_AuxiReal4.AsFloat;
      case xposmang of
        1:tot1:=tot1+xvolumen;
        2:tot2:=tot2+xvolumen;
        3:tot3:=tot3+xvolumen;
        4:tot4:=tot4+xvolumen;
      end;
      Q_Auxi.Active:=false;
      Q_Auxi.SQL.Clear;
      Q_Auxi.SQL.Add('UPDATE DPVGTURNDD SET TOTAL01='+FormatoNumeroSinComas(tot1,10,2)+
                                         ', TOTAL02='+FormatoNumeroSinComas(tot2,10,2)+
                                         ', TOTAL03='+FormatoNumeroSinComas(tot3,10,2)+
                                         ', TOTAL04='+FormatoNumeroSinComas(tot4,10,2)
                                         );
      Q_Auxi.SQL.Add('WHERE FechaHora>="'+FechaHoraToStrSQL(xfechora)+'"');
      Q_Auxi.SQL.Add('  AND Turno='+inttostr(xturno));
      Q_Auxi.SQL.Add('  AND PosCarga='+inttostr(xposcarga));
      Q_Auxi.ExecSQL;
      Q_Auxi.Active:=false;
    end;
  finally
    Q_Auxi.Active:=false;
  end;
end;

function TDMCONS.DameDispensarios:string;
begin
  try
    result:='';
    ActivaSrvDispensarios;
    result:=ValorDispensarios;
  except
  end;
end;

function TDMCONS.EjecutaComando(xCmnd:string):integer;
var ind:integer;
begin
  // busca un registro disponible
  ind:=0;
  repeat
    inc(ind);
    if (TabCmnd[ind].SwActivo)and((now-TabCmnd[ind].hora)>tmMinuto) then begin
      TabCmnd[ind].SwActivo:=false;
      TabCmnd[ind].SwResp:=false;
      TabCmnd[ind].SwNuevo:=true;
    end;
  until (not TabCmnd[ind].SwActivo)or(ind>40);
  // Si no lo encuentra se sale
  if ind>40 then begin
    result:=0;
    exit;
  end;
  // envia el comando
  with TabCmnd[ind] do begin
    inc(FolioCmnd);
    if FolioCmnd<=0 then
      FolioCmnd:=1;
    Folio:=FolioCmnd;
    hora:=Now;
    SwActivo:=true;
    Comando:=xCmnd;
    SwResp:=false;
    Respuesta:='';
  end;
  Result:=FolioCmnd;
end;

function TDMCONS.ResultadoComando(xFolio:integer):string;
var i:integer;
begin
  Result:='*';
  for i:=1 to 40 do
    if (TabCmnd[i].folio=xfolio)and(TabCmnd[i].SwResp) then
      result:=TabCmnd[i].Respuesta;
end;

procedure TDMCONS.ActualizaDispensarios(xdisp:string);
begin
  try
    ActivaSrvDispensarios;
    ValorDispensarios:=xdisp;
  except
  end;
end;

procedure TDMCONS.BorraComandos;
var xfolio:integer;
begin
  if MaxRegCmnd<100 then
    MaxRegCmnd:=100;
  try
    Q_Auxi.Active:=false;
    Q_AuxiEntero1.FieldKind:=fkInternalCalc;
    Q_Auxi.SQL.Clear;
    Q_Auxi.SQL.Add('Select Max(Folio) as Entero1 from DPVGCMND');
    Q_Auxi.Active:=true;
    xfolio:=Q_AuxiEntero1.AsInteger;
    if xfolio>100 then begin
      Q_Auxi.Active:=false;
      Q_Auxi.SQL.Clear;
      Q_Auxi.SQL.Add('DELETE FROM DPVGCMND WHERE FOLIO<'+inttostr(xfolio-MaxRegCmnd));
      Q_Auxi.ExecSQL;
      Q_Auxi.Active:=false;
    end;
  finally
    Q_Auxi.Active:=false;
  end;
end;

procedure TDMCONS.BorraComandos2(xcant:integer);
var xfolio:integer;
begin
  try
    Q_Auxi.Active:=false;
    Q_AuxiEntero1.FieldKind:=fkInternalCalc;
    Q_Auxi.SQL.Clear;
    Q_Auxi.SQL.Add('Select Max(Folio) as Entero1 from DPVGCMND');
    Q_Auxi.Active:=true;
    xfolio:=Q_AuxiEntero1.AsInteger;
    if xfolio>xcant then begin
      Q_Auxi.Active:=false;
      Q_Auxi.SQL.Clear;
      Q_Auxi.SQL.Add('DELETE FROM DPVGCMND WHERE FOLIO<='+inttostr(xfolio-xcant));
      Q_Auxi.ExecSQL;
      Q_Auxi.Active:=false;
    end;
  finally
    Q_Auxi.Active:=false;
  end;
end;

procedure TDMCONS.InsertaComandoFinv(xpos,xpago:integer);
var xcmnd:string;
begin
  xcmnd:='FINV '+inttostr(xpos)+' '+inttostr(xpago);
  try
    Q_Auxi.Active:=false;
    Q_Auxi.SQL.Clear;
    Q_Auxi.SQL.Add('INSERT INTO DPVGCMND (MODULO,COMANDO) VALUES (''DISP'','''+'FINV '+inttostr(xpos)+' '+inttostr(xpago)+''')');
    Q_Auxi.ExecSQL;
  finally
    Q_Auxi.Active:=false;
  end;
end;

function TDMCONS.CalculaVentaPorLectura(xlectini,xlectfin:real):real;
var xvol:real;
begin
  xvol:=0;
  if xlectini<=xlectfin+0.001 then begin
    xvol:=xlectfin-xlectini;
  end
  else begin
    if (xlectini>80000)and(xlectini<100000) then
      xvol:=100000-xlectini+xlectfin
    else if (xlectini>980000)and(xlectini<1000000) then
      xvol:=1000000-xlectini+xlectfin
    else if (xlectini>9980000)and(xlectini<10000000) then
      xvol:=10000000-xlectini+xlectfin;
  end;
  result:=xvol;
end;

procedure TDMCONS.ReviConsola(xrevi:string);
begin
  T_EmprIb.Active:=true;
  if xrevi<>'*' then begin
    if xrevi>T_EmprIbREVISION.AsString then
      MensajeWarn('Se requiere actualizar la base de datos CONSOLA a la Rev. '+xrevi);
    if xrevi<T_EmprIbREVISION.AsString then begin
      MensajeWarn('Se requiere actualizar versión del sistema!! (Podría funcionar incorrectamente).');
      MensajeWarn('Revision Base Datos Volumetrico: '+T_EmprIbRevision.AsString+'. Revision Ejscutable: '+xrevi);
    end;
  end;
end;


procedure TDMCONS.RegistraBitacora(xUsuario:integer;xOperacion:string;xObserva:TStrings);
begin
  if LimpiaStr(xOperacion)='' then
    raise Exception.Create('Operacion es Requerida');
  if xObserva.Count=0 then
    raise Exception.Create('Observación es Requerida');
  if LimpiaStr(xObserva[0])='' then
    raise Exception.Create('Observación es Requerida');
  try
    T_Bita.Active:=true;
    T_Bita.Insert;
    T_BitaUsuario.AsInteger:=xUsuario;
    T_BitaOperacion.AsString:=xOperacion;
    T_BitaObservaciones.Assign(xObserva);
    T_Bita.Post
  except
  end;
end;

procedure TDMCONS.RegistraBitacora2(xUsuario:integer;xOperacion:string);
begin
  try
    T_Bita.Active:=true;
    T_Bita.Insert;
    T_BitaUsuario.AsInteger:=xUsuario;
    T_BitaOperacion.AsString:=xOperacion;
    T_BitaFecha.AsDateTime:=date;
    T_Bita.Post;
  except
  end;
end;

procedure TDMCONS.RegistraBitacora3(xUsuario:integer;xOperacion:string;xObserva:String;xtipo:char);
begin
  try
    T_Bita.Active:=true;
    T_Bita.Insert;
    T_BitaUsuario.AsInteger:=xUsuario;
    T_BitaOperacion.AsString:=xOperacion;
    T_BitaObservaciones.AsString:=xObserva;
    T_BitaTipoSuceso.AsString:=xtipo;
    T_Bita.Post
  except
  end;
end;

procedure TDMCONS.ConectaAplicacion;
begin
  if ModuloActual='' then
    exit;
  T_Logs.Active:=true;
  try
    T_Logs.Insert;
    T_LogsModulo.AsString:=ModuloActual;
    FechaHoraLog:=Now;
    T_LogsFechaHoraInicial.AsDateTime:=FechaHoraLog;
    T_Logs.Post;
    FechaHoraRefLog:=Now;
    FechaHoraPrecio:=Now;
    FechaHoraComando:=Now;
  finally
    T_Logs.Active:=false;
  end;
end;

procedure TDMCONS.RefrescaConexion;
begin
  FechaHoraRefLog:=Now;
  if ModuloActual='' then
    exit;
  T_Logs.Active:=true;
  try
    if T_Logs.Locate('Modulo;FechaHoraInicial',VarArrayOf([ModuloActual,FechaHoraLog]),[]) then begin
      T_Logs.Edit;
      T_LogsFechaHoraFinal.AsDateTime:=Now;
      T_Logs.Post;
    end;
  finally
    T_Logs.Active:=false;
  end;
end;

function TDMCONS.UltimoEstadoTanque(xtan:integer):string;
begin
  Q_Ctan.Active:=false;
  Q_Ctan.ParamByName('ptanque').AsInteger:=xtan;
  Q_Ctan.Active:=true;
  if Q_Ctan.IsEmpty then
    result:='A'
  else
    result:=Q_CtanNuevoEstado.AsString;
  Q_Ctan.Active:=false;
end;

procedure TDMCONS.CalculaFechasCorte;
var horascorte,siguientedia:real;
begin
  if date>=FechaInicioSat then
    CortesPorDia:=1
  else CortesPorDia:=6;
  horascorte:=1/CortesPorDia;
  siguientedia:=date+1;
  DMCONS.DBGASCON.Connected:=true;
  try
    Q_Cvol.Active:=false;
    Q_Cvol.Active:=true;
    if (not Q_Cvol.IsEmpty) then begin
      FechaUltimoCorte:=Q_CvolFechaHoraInicial.AsDateTime;
      FechaSiguienteCorte:=Q_CvolFecha.AsDateTime+Q_CvolCorte.AsInteger*horascorte;

      if (FechaSiguienteCorte-now)>(horascorte+tmminuto) then
        FechaSiguienteCorte:=now+horascorte;
      if FechaSiguienteCorte>siguientedia then
        FechaSiguienteCorte:=siguientedia;
    end
    else begin
      FechaSiguienteCorte:=now;
    end;
  finally
    DMCONS.DBGASCON.Connected:=false;
  end;
end;

function TDMCONS.AplicarPrecios:boolean;
var swcon:boolean;
    xcomb,xc:integer;
begin
  result:=false;
  try
    swcon:=DBGasCon.Connected;
    DBGasCon.Connected:=true;
    try
      Q_Prec.active:=false;
      Q_Prec.ParamByName('pfecha').asdatetime:=Now-1;
      Q_Prec.ParamByName('phora').asdatetime:=now;
      Q_Prec.active:=true;
      if Q_PrecPrecio.AsInteger>0 then begin
        while not Q_Prec.Eof do begin
          xcomb:=Q_PrecCombustible.AsInteger;
          if xcomb in [1..MaxComb] then
            if TabComb[xcomb].Activo then begin
              TabComb[xcomb].PrecioAnt:=TabComb[xcomb].Precio;
              TabComb[xcomb].Precio:=Q_PrecPrecio.AsFloat;
              TabComb[xcomb].PrecioNuevo:=Q_PrecPrecio.AsFloat; //act 110913
              TabComb[xcomb].AplicaPrecio:=true;
              TabComb[xcomb].FechaHora:=Q_PrecFechaHora.AsDateTime;
              TabComb[xcomb].Folio:=Q_PrecFolio.AsInteger;
              for xc:=1 to MaxComb do
                if TabComb[xc].Agruparcon=xcomb then begin
                  TabComb[xc].PrecioAnt:=TabComb[xc].Precio;
                  TabComb[xc].Precio:=Q_PrecPrecio.AsFloat;
                  TabComb[xc].PrecioNuevo:=Q_PrecPrecio.AsFloat;     //act 110913
                  TabComb[xc].AplicaPrecio:=true;
                  TabComb[xc].FechaHora:=Q_PrecFechaHora.AsDateTime;
                  TabComb[xc].Folio:=Q_PrecFolio.AsInteger;
                end;
            end;
          Q_Prec.Next;
        end;
        result:=true;
      end;
    finally
      Q_Prec.Active:=false;
      if not swcon then
        DBGasCon.Connected:=false;
    end;
  except
  end;
end;

procedure TDMCONS.CargaPreciosFH(xFechaHora:TDateTime;SwMeteAFisico:boolean);
var i,xc:integer;
    swcon:boolean;
begin
  try
    swcon:=DBGasCon.Connected;
    DBGasCon.Connected:=true;
    try
      Q_CombIb.Active:=false;
      Q_CombIb.Active:=true;
      for i:=1 to MaxComb do begin
        if TabComb[i].Activo then begin
          TabComb[i].PrecioNuevo:=0;
          SP_DamePrec.ParamByName('PCombust').asinteger:=i;
          SP_DamePrec.ParamByName('PFechaHora').asdatetime:=xFechaHora;
          SP_DamePrec.ExecProc;
          if not PrimeraCarga then
            TabComb[i].Precioant:=TabComb[i].Precio;
          if TabComb[i].Agruparcon=0 then
            TabComb[i].Precio:=SP_DamePrec.ParamByName('RPrecio').asfloat
          else if TabComb[i].Agruparcon<=MaxComb then begin
            xc:=TabComb[i].Agruparcon;
            TabComb[i].Precio:=TabComb[xc].Precio;
          end;
          if SwMeteAFisico then begin
            T_Tcmb.Active:=true;
            try
              if T_Tcmb.Locate('Clave',i,[]) then begin
                T_Tcmb.Edit;
                T_TcmbPrecioFisico.AsFloat:=TabComb[i].Precio;
                T_Tcmb.Post;
              end;
            finally
              T_Tcmb.Active:=false;
            end;
          end;
          if PrimeraCarga then
            TabComb[i].Precioant:=TabComb[i].Precio;
        end;
      end;
    finally
      if not swcon then
        DBGasCon.Connected:=false;
      PrimeraCarga:=false;
    end;
  except
  end;
end;

function TDMCONS.DamePrecioFH(xComb:integer;xFechaHora:TDateTime):real;
var swcon:boolean;
begin
  result:=0;
  try
    swcon:=DBGasCon.Connected;
    DBGasCon.Connected:=true;
    try
      SP_DamePrec.ParamByName('PCombust').asinteger:=xcomb;
      SP_DamePrec.ParamByName('PFechaHora').asdatetime:=xFechaHora;
      SP_DamePrec.ExecProc;
      result:=SP_DamePrec.ParamByName('RPrecio').asfloat;
    finally
      if not swcon then
        DBGasCon.Connected:=false;
    end;
  except
  end;
end;

procedure TDMCONS.CargaConfiguracionConsola;
var lin,ss:string;
    i:integer;
    lista:TStrings;
begin
  T_EstsIb.active:=true;
  T_EstsIb.Locate('Clave',emEstacionServicio,[]);
  ReconexionesAros:=2;
  ModoPrecioWayne:='2';
  TierLavelWayne:='0';
  MaxRegCmnd:=100;
  MaximoDePosiciones:=32;
  SoportaSeleccionProducto:='Si';
  PosicionProductoWayne:='No';
  AutostikEnGalones:='No';
  AutostikAlarmas:='No';
  AjusteWayne:='No';
  AjusteWayne2:='No';
  AjustePAM:='No';
  AjustePAMDiezMil:='No';
  ReautorizaPAM:='No';
  InicializaWayne:='Si';
  ManejaCanalWayne:='No';
  ControlAros:='No';
  FlujoPorVehiculo:=False;
  TotalCalculado:='No';
  OrdenMangueras:='Combustible';

  // Gilbarco 2W
  GtwDivPresetLts:=100;
  GtwDivPresetPesos:=100;

  GtwDivPrecio:=100;
  GtwDivImporte:=100;
  GtwDivLitros:=100;

  GtwDivTotLts:=100;
  GtwDivTotImporte:=100;

  GtwTimeOut:=1000;
  GtwTiempoCmnd:=100;



  WayneFusion:='No';
  WayneAjusteImporte:='No';
  TresDecimTotTeam:='No';
  CierraBD:='Si';
  WayneFusionCombXPrecio:='Si';
  MapeoFusion:='No';
  WayneFusionNivelPrecio:='2X';
  PamNivelPrecio:='12';
  WayneValidaImporteDespacho:='No';
  ValidaCheckSumAutostik:='Si';
  ValidaCambioPrecio:='Si';
  VersionPam1000:='3';
  SetUpPam1000:='';
  ModoAutorizaBennett:=0;
  BennettPararVentaCompleta:='No';
  Bennett8Digitos:='No';
  BennettReintentosPreset:=5;
  //ModoAutorizaPAM:=0;
  PuertoServicio:='http://127.0.0.1:8199/bin/';
  DecimalesPresetWayne:=-1;
  DecimalesPresetWayneLitros:=3;
  //DecimalesPresetPAM:=2;
  //DecimalesPresetPAMLitros:=2;
  MinutosReinicioTanques:=0;
  SegEsperaEntradaVeederRoot:=1;
  ModoTurnos:=1;
  MinimoHorasCorte:=0;
  CodigoSeguridadVeederRoot:='';
  HorasCorteTurnoAutom:='06:00/14:00/22:00';
  TipoVolumenEntradaTanques:='Bruto';
  SincHoraVeederRoot:='No';
  GuardaLogEntradaTanques:='No';
  BitacoraTanques:='No';
  Inocuidad31Licencia:='';
  Inocuidad31FechaVence:='';
  SegundosFINV:=3;
  TimerDisp:=0;
  ConteoOcc:=16;
  lista:=TStringList.Create;
  // CARGA VARIBLES
  try
    lista.Assign(T_EstsIbConsola);
    for i:=0 to lista.Count-1 do begin
      lin:=lista[i];
      ss:=ExtraeElemStrSep(lin,1,'=');

      // VARIABLES TELEMEDICION TANQUES
      if Mayusculas(ss)='TIPOVOLUMENENTRADATANQUES' then
        TipoVolumenEntradaTanques:=ExtraeElemStrSep(lin,2,'=');
      if Mayusculas(ss)='HORASCORTETURNOAUTOM' then
        HorasCorteTurnoAutom:=ExtraeElemStrSep(lin,2,'=');
      if Mayusculas(ss)='CODIGOSEGURIDADVEEDERROOT' then
        CodigoSeguridadVeederRoot:=ExtraeElemStrSep(lin,2,'=');
      if Mayusculas(ss)='SINCHORAVEEDERROOT' then
        SincHoraVeederRoot:=ExtraeElemStrSep(lin,2,'=');
      if Mayusculas(ss)='AUTOSTIKENGALONES' then
        AutostikEnGalones:=ExtraeElemStrSep(lin,2,'=');
      if Mayusculas(ss)='AUTOSTIKALARMAS' then
        AutostikAlarmas:=ExtraeElemStrSep(lin,2,'=');
      if Mayusculas(ss)='GUARDALOGENTRADATANQUES' then
        GuardaLogEntradaTanques:=ExtraeElemStrSep(lin,2,'=');
      if Mayusculas(ss)='MINIMOHORASCORTE' then
        MinimoHorasCorte:=StrToIntDef(ExtraeElemStrSep(lin,2,'='),0);
      if Mayusculas(ss)='MINUTOSREINICIOTANQUES' then
        MinutosReinicioTanques:=StrToIntDef(ExtraeElemStrSep(lin,2,'='),0);
      if Mayusculas(ss)='MODOTURNOS' then
        ModoTurnos:=StrToIntDef(ExtraeElemStrSep(lin,2,'='),1);
      if Mayusculas(ss)='SEGESPERAENTRADAVEEDERROOT' then
        SegEsperaEntradaVeederRoot:=StrToIntDef(ExtraeElemStrSep(lin,2,'='),1);
      if Mayusculas(ss)='BITACORATANQUES' then
        BitacoraTanques:=ExtraeElemStrSep(lin,2,'=');
      if Mayusculas(ss)='VALIDACHECKSUMAUTOSTIK' then
        ValidaCheckSumAutoStik:=ExtraeElemStrSep(lin,2,'=');
      if Mayusculas(ss)='VALIDACAMBIOPRECIO' then
        ValidaCambioPrecio:=ExtraeElemStrSep(lin,2,'=');
      if Mayusculas(ss)='CIERRABD' then
        CierraBD:=ExtraeElemStrSep(lin,2,'=');

      // VARIABLES TEAM
      if Mayusculas(ss)='TRESDECIMTOTTEAM' then
        TresDecimTotTeam:=ExtraeElemStrSep(lin,2,'=');

      // VARIABLES GILBARCO 2W
      if Mayusculas(ss)='GTWDIVPRESETLTS' then
        GtwDivPresetLts:=StrToIntDef(ExtraeElemStrSep(lin,2,'='),100);
      if Mayusculas(ss)='GTWDIVPRESETPESOS' then
        GtwDivPresetPesos:=StrToIntDef(ExtraeElemStrSep(lin,2,'='),100);

      if Mayusculas(ss)='GTWDIVPRECIO' then
        GtwDivPrecio:=StrToIntDef(ExtraeElemStrSep(lin,2,'='),100);
      if Mayusculas(ss)='GTWDIVIMPORTE' then
        GtwDivImporte:=StrToIntDef(ExtraeElemStrSep(lin,2,'='),100);
      if Mayusculas(ss)='GTWDIVLITROS' then
        GtwDivLitros:=StrToIntDef(ExtraeElemStrSep(lin,2,'='),100);

      if Mayusculas(ss)='GTWDIVTOTLTS' then
        GtwDivTotLts:=StrToIntDef(ExtraeElemStrSep(lin,2,'='),100);
      if Mayusculas(ss)='GTWDIVTOTIMPORTE' then
        GtwDivTotImporte:=StrToIntDef(ExtraeElemStrSep(lin,2,'='),100);

      if Mayusculas(ss)='GTWTIMEOUT' then
        GtwTimeout:=StrToIntDef(ExtraeElemStrSep(lin,2,'='),1000);
      if Mayusculas(ss)='GTWTIEMPOCMND' then
        GtwTiempoCmnd:=StrToIntDef(ExtraeElemStrSep(lin,2,'='),100);

      // VARIABLES WAYNE
      if Mayusculas(ss)='DECIMALESPRESETWAYNE' then
        DecimalesPresetWayne:=StrToIntDef(ExtraeElemStrSep(lin,2,'='),-1);
      if Mayusculas(ss)='DECIMALESPRESETWAYNELITROS' then begin
        DecimalesPresetWayneLitros:=StrToIntDef(ExtraeElemStrSep(lin,2,'='),3);
        if not (DecimalesPresetWayneLitros in [1..4]) then
          DecimalesPresetWayneLitros:=3;
      end;
      if Mayusculas(ss)='WAYNEFUSION' then
        WayneFusion:=ExtraeElemStrSep(lin,2,'=');
      if Mayusculas(ss)='WAYNEAJUSTEIMPORTE' then
        WayneAjusteImporte:=ExtraeElemStrSep(lin,2,'=');
      if Mayusculas(ss)='POSICIONPRODUCTOWAYNE' then
        WayneFusion:=ExtraeElemStrSep(lin,2,'=');
      if Mayusculas(ss)='WAYNEFUSIONCOMBXPRECIO' then
        WayneFusionCombXPrecio:=ExtraeElemStrSep(lin,2,'=');
      if Mayusculas(ss)='MAPEOFUSION' then
        MapeoFusion:=ExtraeElemStrSep(lin,2,'=');
      if Mayusculas(ss)='WAYNEFUSIONNIVELPRECIO' then begin
        WayneFusionNivelPrecio:=ExtraeElemStrSep(lin,2,'=');
        while length(WayneFusionNivelPrecio)<2 do
          WayneFusionNivelPrecio:=WayneFusionNivelPrecio+'X';
      end;
      if Mayusculas(ss)='WAYNEVALIDAIMPORTEDESPACHO' then begin
        WayneValidaImporteDespacho:=ExtraeElemStrSep(lin,2,'=');
      end;
      if Mayusculas(ss)='AJUSTEWAYNE' then
        AjusteWayne:=ExtraeElemStrSep(lin,2,'=');
      if Mayusculas(ss)='AJUSTEWAYNE2' then
        AjusteWayne2:=ExtraeElemStrSep(lin,2,'=');
      if Mayusculas(ss)='MODOPRECIOWAYNE' then
        ModoPrecioWayne:=ExtraeElemStrSep(lin,2,'=');
      if Mayusculas(ss)='TIERLAVELWAYNE' then
        TierLavelWayne:=ExtraeElemStrSep(lin,2,'=');         
      if Mayusculas(ss)='INICIALIZAWAYNE' then
        InicializaWayne:=ExtraeElemStrSep(lin,2,'=');
      if Mayusculas(ss)='MANEJACANALWAYNE' then
        ManejaCanalWayne:=ExtraeElemStrSep(lin,2,'=');

      // VARIABLES PAM1000
      //if Mayusculas(ss)='MODOAUTORIZAPAM' then
      //  ModoAutorizaPAM:=StrToIntDef(ExtraeElemStrSep(lin,2,'='),0);
      if Mayusculas(ss)='VERSIONPAM1000' then begin
        VersionPam1000:=ExtraeElemStrSep(lin,2,'=');
        if (VersionPam1000='11')or(VersionPam1000='1') then
          VersionPam1000:='1'
        else
          VersionPam1000:='3';
      end;
      if Mayusculas(ss)='SETUPPAM1000' then
        SetUpPam1000:=ExtraeElemStrSep(lin,2,'=');
      //if Mayusculas(ss)='DECIMALESPRESETPAM' then
      //  DecimalesPresetPAM:=StrToIntDef(ExtraeElemStrSep(lin,2,'='),2);
      //if Mayusculas(ss)='DECIMALESPRESETPAMLITROS' then
      //  DecimalesPresetPAMLitros:=StrToIntDef(ExtraeElemStrSep(lin,2,'='),2);
      if Mayusculas(ss)='AJUSTEPAM' then
        AjustePAM:=ExtraeElemStrSep(lin,2,'=');
      if Mayusculas(ss)='AJUSTEPAMDIEZMIL' then
        AjustePAMDiezMil:=ExtraeElemStrSep(lin,2,'=');
      if Mayusculas(ss)='REAUTORIZAPAM' then
        ReautorizaPAM:=ExtraeElemStrSep(lin,2,'=');
      if Mayusculas(ss)='PAMNIVELPRECIO' then begin
        PamNivelPrecio:=ExtraeElemStrSep(lin,2,'=');
        while length(WayneFusionNivelPrecio)<2 do
          PamNivelPrecio:=PamNivelPrecio+'X';
      end;

      // VARIABLES BENNETT
      if Mayusculas(ss)='MODOAUTORIZABENNETT' then
        ModoAutorizaBennett:=StrToIntDef(ExtraeElemStrSep(lin,2,'='),0);
      if Mayusculas(ss)='BENNETTREINTENTOSPRESET' then
        BennettReintentosPreset:=StrToIntDef(ExtraeElemStrSep(lin,2,'='),3);
      if Mayusculas(ss)='SOPORTASELECCIONPRODUCTO' then
        SoportaSeleccionProducto:=ExtraeElemStrSep(lin,2,'=');
      if Mayusculas(ss)='BENNETTPARARVENTACOMPLETA' then
        BennettPararVentaCompleta:=ExtraeElemStrSep(lin,2,'=');
      if Mayusculas(ss)='BENNETT8DIGITOS' then
        Bennett8Digitos:=ExtraeElemStrSep(lin,2,'=');

      // OTRAS VARIABLES
      if Mayusculas(ss)='INOCUIDAD31LICENCIA' then
        Inocuidad31Licencia:=ExtraeElemStrSep(lin,2,'=');
      if Mayusculas(ss)='INOCUIDAD31FECHAVENCE' then
        Inocuidad31FechaVence:=ExtraeElemStrSep(lin,2,'=');
      if Mayusculas(ss)='PUERTOSERVICIO' then begin
        PuertoServicio:=ExtraeElemStrSep(lin,2,'=');
        ROIndyHTTPServer1.Active:=false;
      end;
      if Mayusculas(ss)='MAXIMODEPOSICIONES' then
        MaximoDePosiciones:=StrToIntDef(ExtraeElemStrSep(lin,2,'='),24);
      if Mayusculas(ss)='MAXREGCMND' then
        MaxRegCmnd:=StrToIntDef(ExtraeElemStrSep(lin,2,'='),24);
      if Mayusculas(ss)='RECONEXIONESAROS' then
        reconexionesAros:=StrToIntDef(ExtraeElemStrSep(lin,2,'='),2);
      if Mayusculas(ss)='CONTROLAROS' then
        ControlAros:=ExtraeElemStrSep(lin,2,'=');
      if Mayusculas(ss)='SERVIDORGATEWAY' then
        ServidorGateway:=ExtraeElemStrSep(lin,2,'=');
      if Mayusculas(ss)='PUERTOGATEWAYDISP' then
        PuertoGatewayDisp:=StrToInt(ExtraeElemStrSep(lin,2,'='));
      if Mayusculas(ss)='PUERTOGATEWAYTANQ' then
        PuertoGatewayTanq:=StrToInt(ExtraeElemStrSep(lin,2,'='));
      if Mayusculas(ss)='PRECIOSINICIO' then
        PreciosInicio:=Mayusculas(ExtraeElemStrSep(lin,2,'='))='SI';
      if Mayusculas(ss)='SEGUNDOSFINV' then
        SegundosFINV:=StrToIntDef(ExtraeElemStrSep(lin,2,'='),3);
      if Mayusculas(ss)='FLUJOPORVEHICULO' then
        FlujoPorVehiculo:=Mayusculas(ExtraeElemStrSep(lin,2,'='))='SI';
      if Mayusculas(ss)='TOTALCALCULADO' then
        TotalCalculado:=ExtraeElemStrSep(lin,2,'=');
      if Mayusculas(ss)='ORDENMANGUERAS' then
        OrdenMangueras:=ExtraeElemStrSep(lin,2,'=');
      if Mayusculas(ss)='TIMERDISP' then
        TimerDisp:=StrToIntDef(ExtraeElemStrSep(lin,2,'='),0);
      if Mayusculas(ss)='CONTEOOCC' then
        ConteoOcc:=StrToIntDef(ExtraeElemStrSep(lin,2,'='),16);
    end;
  finally
    lista.Free;
  end;
end;

procedure TDMCONS.ConectaBaseDatos;
begin
  DBGASCON.Connected:=false;
  DBGASCON.AliasName:=AliasConsolaEsts;
  DBGASCON.Connected:=true;

  pFIBDB1.DatabaseName := ruta_db_from_alias(AliasConsolaEsts);
  pFIBDB1.Open;
  SIBfibEA1.AutoRegister := True;
  Randomize;

  // VALIDA EXISTENCIA DE CAMPOS NUEVOS 04/feb/2014
    Q_Auxi.Active:=false;
    Q_AuxiEntero1.FieldKind:=fkInternalCalc;
    Q_Auxi.SQL.Clear;
    Q_Auxi.SQL.Add('Select Count(*) as Entero1 from RDB$RELATION_FIELDS');
    Q_Auxi.SQL.Add('WHERE RDB$FIELD_NAME STARTING "USATURNOSALTERNATIVOS" AND RDB$RELATION_NAME STARTING "DPVGCONF"');
    Q_Auxi.Active:=true;
    if Q_AuxiEntero1.AsInteger=0 then begin
      Q_Auxi.Active:=false;
      Q_Auxi.SQL.Clear;
      Q_Auxi.SQL.Add('ALTER TABLE DPVGCONF ADD USATURNOSALTERNATIVOS DOM$CHAR2');
      Q_Auxi.ExecSQL;
      Q_Auxi.Active:=false;
    end;
  // FIN

  Q_Auxi.Active:=false;

  DBGASCONAfterConnect(Self);

  ConectaAplicacion;
  CargaConfiguracionConsola;
  T_MoviIb.Active:=true;
  T_ConfIb.Active:=true;
  PosVehiculo:=T_ConfIbPosVehiculo.AsInteger;
  FechaInicioSat:=T_ConfIbFechaInicioSat2014.AsDateTime;
  TurnosAlternativos:=T_ConfIbUsaTurnosAlternativos.AsString;
  if T_ConfIb.IsEmpty then
    raise Exception.Create('No existe configuración del sistema');
  T_ConfIb.Edit;
  T_ConfIbLevantar_Consolas.AsString:='Si';
  T_ConfIb.Post;
  lcLicencia:=T_ConfIbLicencia.AsString;
  lcLicTemporal:=T_ConfIbEsTemporal.AsString='Si';
  lcLicVence:=T_ConfIbFechaVence.AsDateTime;
  StLevanta:=T_ConfIbLevantar_Consolas.AsString;
  lcSerie:=T_ConfIbNumeroSerie.AsInteger;
  T_EmprIb.Active:=true;
  T_EstsIb.Active:=true;
  if T_EstsIb.IsEmpty then
    raise Exception.Create('No existe estacion configurada');
  if T_EmprIb.IsEmpty then
    raise Exception.Create('No existe empresa configurada');
  emEstacionServicio:=T_EmprIbEstacion_Igas.AsInteger;
  if not T_EstsIb.Locate('Clave',emEstacionServicio,[]) then begin
    T_EstsIb.First;
    emEstacionServicio:=T_EstsIbClave.asinteger;
  end;
  if T_EstsIbTipoTanques.AsInteger=7 then begin

  end;
  T_Puer.Active:=true;
  if T_Puer.Locate('Clave',ModuloActual,[]) then begin
    ptPuerto:=T_PuerNumeroPuerto.AsInteger;
    ptBaudios:=T_PuerVelocidad.AsInteger;
    ptParidad:=copy(T_PuerParidad.AsString,1,1);
    case ptParidad[1] of
      'I':ptParidad:='O'; // Odd
      'P':ptParidad:='E'; // Even
      'E':ptParidad:='S'; // Space
    end;
    ptBitsDatos:=T_PuerBitsDatos.AsInteger;
    ptBitsParada:=T_PuerBitsParo.asinteger;
  end
  else begin
    ptPuerto:=1;
    ptBaudios:=9600;
    ptParidad:='N';
    ptBitsDatos:=8;
    ptBitsParada:=1;
  end;
end;

procedure TDMCONS.DataModuleCreate(Sender: TObject);
var i:integer;
begin
  for i:=1 to 40 do begin
    TabCmnd[i].SwActivo:=false;
    TabCmnd[i].SwResp:=false;
    TabCmnd[i].SwNuevo:=true;
    TabCmnd[i].Comando:='';
  end;
  FolioCmnd:=0;
  ThousandSeparator := ',';
  DecimalSeparator := '.';
  DateSeparator := '/';
  ShortDateFormat := 'dd/mm/yyyy';
  Application.UpDateFormatSettings := False;
  ContadorTot:=0;
  ContadorTotPos:=0;
  ListaSolicitud:=TStringList.Create;
  ListaLog:=TStringList.Create;
  ListaLogCmnd:=TStringList.Create;
  ModuloActual:='';
  Accion:='';
  PrimeraCarga:=true;
  SwCorteTurno:=false;
  SwCorteParcial:=false;
  SwSolicitud:=false;
  SwPrecioFisico:=true;
  SwCambioPrecio:=false;
  SwChecaVentaTarjeta:=true;
  UltimaFechaHora:=Now;
  SwFechaHoraTM:=true;
  ListaConsola:=TStringList.Create;
  HoraUltimoCorte:=date-1;
end;


function TDMCONS.LeeTxtConsola(xpos:integer):boolean;
var lin:string;
    i,pc:integer;
begin
  result:=false;
  lcDescEstatus:='';
  for i:=0 to ListaConsola.Count-1 do begin
    lin:=ListaConsola[i];
    pc:=StrToIntDef(ExtraeElemStr(lin,1),0);
    if xpos=pc then begin
      lcPosCarga:=pc;
      lcMonVol:=ExtraeElemStr(lin,2);
      lcValor:=StrToFloat(ExtraeElemStr(lin,3));
      lcEstatus:=ExtraeElemStr(lin,4);
      lcPosicion:=StrToIntDef(ExtraeElemStr(lin,5),1);
      lcVolumen:=StrToFloat(ExtraeElemStr(lin,6));
      lcPrecio:=StrToFloat(ExtraeElemStr(lin,7));
      lcImporte:=StrToFloat(ExtraeElemStr(lin,8));
      lcCombustible:=ExtraeElemStr(lin,9);
      lcDescEstatus:=ExtraeElemStr(lin,10);
      lcFolio:=StrToIntDef(ExtraeElemStr(lin,11),0);
      result:=true;
      exit;
    end;
  end;
end;


procedure TDMCONS.T_FactIbCalcFields(DataSet: TDataSet);
var i:integer;
begin
  i:=T_FactIbCombustible.AsInteger;
  T_FactIbNombreComb.AsString:=TabComb[i].Nombre;
end;

procedure TDMCONS.Q_Fact1CalcFields(DataSet: TDataSet);
var i:integer;
begin
  i:=Q_Fact1Combustible.AsInteger;
  if i in [1..MaxComb] then
    if TabComb[i].Activo then
      Q_Fact1NombreComb.AsString:=TabComb[i].Nombre;
end;

procedure TDMCONS.Q_Fact2CalcFields(DataSet: TDataSet);
var i:integer;
begin
  i:=Q_Fact2Combustible.AsInteger;
  if i in [1..MaxComb] then
    if TabComb[i].Activo then
      Q_Fact2NombreComb.AsString:=TabComb[i].Nombre;
end;

procedure TDMCONS.T_ConsIbCalcFields(DataSet: TDataSet);
begin
  if T_ConsIbEstatus.AsString='P' then
    T_ConsIbDescEstatus.AsString:='Cargando';
  if (T_ConsIbEstatus.AsString='F')or(T_ConsIbEstatus.AsString='f') then
    T_ConsIbDescEstatus.AsString:='Terminó';
end;

procedure TDMCONS.Q_CvolCalcFields(DataSet: TDataSet);
begin
  Q_CvolDescripCorte.AsString:='Corte '+IntToClaveNum(Q_CvolCorte.AsInteger,2)+' - '+FechaPaq(Q_CvolFecha.AsDateTime);
end;

procedure TDMCONS.Q_CvolAfterOpen(DataSet: TDataSet);
begin
  Q_Etan.Active:=true;
  T_Cvolt.Active:=true;
end;

procedure TDMCONS.T_CtanCalcFields(DataSet: TDataSet);
begin
  if T_CtanNuevoEstado.AsString='A' then
    T_CtanDescEstado.AsString:='Activo';
  if T_CtanNuevoEstado.AsString='I' then
    T_CtanDescEstado.AsString:='Inactivo';
end;

procedure TDMCONS.Q_AuxiAfterClose(DataSet: TDataSet);
begin
  Q_AuxiReal1.FieldKind:=fkCalculated;
  Q_AuxiReal2.FieldKind:=fkCalculated;
  Q_AuxiReal3.FieldKind:=fkCalculated;
  Q_AuxiReal4.FieldKind:=fkCalculated;
  Q_AuxiReal5.FieldKind:=fkCalculated;
  Q_AuxiReal6.FieldKind:=fkCalculated;
  Q_AuxiEntero1.FieldKind:=fkCalculated;
  Q_AuxiEntero2.FieldKind:=fkCalculated;
  Q_AuxiEntero3.FieldKind:=fkCalculated;
  Q_AuxiChar1.FieldKind:=fkCalculated;
  Q_AuxiStr10.FieldKind:=fkCalculated;
  Q_AuxiStr10_2.FieldKind:=fkCalculated;
  Q_AuxiStr6_1.FieldKind:=fkCalculated;
  Q_AuxiStr6_2.FieldKind:=fkCalculated;
  Q_AuxiDate1.FieldKind:=fkCalculated;
  Q_AuxiStr20.FieldKind:=fkCalculated;
  Q_AuxiStr255.FieldKind:=fkCalculated;
end;

procedure TDMCONS.T_EtanTIPODOCValidate(Sender: TField);
begin
  if (T_EtanTipoDoc.AsString<>'CP')and(T_EtanTipoDoc.AsString<>'RP') then
    raise Exception.Create('Tipo de Documento perimito: CP o RP');
end;

procedure TDMCONS.RegistraTotales_BD(xposcarga:integer;xtotal01,xtotal02:real);
begin
  try
    Q_Cvol.Active:=false;
    Q_Cvol.Active:=true;
    if not Q_Cvol.IsEmpty then begin
      T_Cvold.Active:=true;
      if not T_Cvold.Locate('PosCarga',xposcarga,[]) then begin
        T_Cvold.Insert;
        T_CvoldFecha.AsDateTime:=Q_CvolFecha.AsDateTime;
        T_CvoldCorte.AsInteger:=Q_CvolCorte.AsInteger;
        T_CvoldPosCarga.AsInteger:=xposcarga;
        T_CvoldTotal01.AsFloat:=xtotal01;
        T_CvoldTotal02.AsFloat:=xtotal02;
        T_Cvold.Post;
      end
      else begin
        T_Cvold.Edit;
        T_CvoldTotal01.AsFloat:=xtotal01;
        T_CvoldTotal02.AsFloat:=xtotal02;
        T_Cvold.Post;
      end;
      T_Cvold.Active:=false;
    end;
  except
    if (T_Cvold.State in [dsInsert,dsEdit]) then
      T_Cvold.Cancel;
    T_Cvold.Active:=false;
  end;
end;

procedure TDMCONS.RegistraTotales_BD4(xposcarga:integer;xtotal01,xtotal02,xtotal03,xtotal04:real);
begin
  try
    logtotales:='LogTot '+inttostr(xposcarga)+' '+FormatoMoneda(xtotal01)+' '+FormatoMoneda(xtotal02)+' /';
    Q_Cvol.Active:=false;
    Q_Cvol.Active:=true;
    if not Q_Cvol.IsEmpty then begin
      logtotales:=logtotales+'No Vacio/';
      T_Cvold.Active:=true;
      if not T_Cvold.Locate('PosCarga',xposcarga,[]) then begin
        logtotales:=logtotales+'Insert/';
        T_Cvold.Insert;
        T_CvoldFecha.AsDateTime:=Q_CvolFecha.AsDateTime;
        T_CvoldCorte.AsInteger:=Q_CvolCorte.AsInteger;
        T_CvoldPosCarga.AsInteger:=xposcarga;
        T_CvoldTotal01.AsFloat:=xtotal01;
        T_CvoldTotal02.AsFloat:=xtotal02;
        T_CvoldTotal03.AsFloat:=xtotal03;
        T_CvoldTotal04.AsFloat:=xtotal04;
        T_Cvold.Post;
      end
      else begin
        logtotales:=logtotales+'Edit/';
        T_Cvold.Edit;
        if xtotal01>0.01 then
          T_CvoldTotal01.AsFloat:=xtotal01;
        if xtotal02>0.01 then
          T_CvoldTotal02.AsFloat:=xtotal02;
        if xtotal03>0.01 then
          T_CvoldTotal03.AsFloat:=xtotal03;
        if xtotal04>0.01 then
          T_CvoldTotal04.AsFloat:=xtotal04;
        T_Cvold.Post;
      end;
      T_Cvold.Active:=false;
    end
    else
      logtotales:=logtotales+'Vacio/';
  except
    logtotales:=logtotales+'Error';
    if (T_Cvold.State in [dsInsert,dsEdit]) then
      T_Cvold.Cancel;
    T_Cvold.Active:=false;
  end;
end;

procedure TDMCONS.CalculaTurnoActual(xFechaHora:TDateTime);
var xhor,xhori,xhorf,xhormin,xhormax,fec1,fec2:string;
    margenant,margenpos:real;
    swhoy:boolean;
    FechoraCambio:TDateTime;
begin
  swhoy:=false;
  margenant:=3/24;Margenpos:=3/24;
  xhor:=FiltraStrNum(HoraToStr24(xFechaHora));
  if ValidaCambioPrecio='Si' then begin
    T_Turc.Active:=false;
    T_Turc.TableName:='DPVGTURC';
    try
      fec1:=fechatostrsql(date);
      fec2:=fechahoratostrsql(date+0.25);
      try
        Q_Auxi.Active:=false;
        Q_AuxiEntero1.FieldKind:=fkInternalCalc;
        Q_AuxiDate1.FieldKind:=fkInternalCalc;
        Q_Auxi.SQL.Clear;
        Q_Auxi.SQL.Add('Select count(*) as Entero1,max(fechahora) as Date1 from DPVGCPRE');
        Q_Auxi.SQL.Add('where fechahora>="'+fec1+'" and fechahora<"'+fec2+'"');
        Q_Auxi.Active:=true;
        if (Q_AuxiEntero1.AsInteger>0) then begin
          swhoy:=true;
          FechoraCambio:=Q_AuxiDate1.AsDateTime;
        end
      finally
        Q_Auxi.Active:=false;
      end;
    except
    end;
  end;
  // fin verifica hoy

  T_Turc.Active:=true;
  TurnoActual:=0;FechaTurnoActual:=Trunc(xFechaHora);
  T_Turc.First;
  if (swhoy)and(now<FechoraCambio) then begin // Cambio de precios hoy
    T_Turc.Last;
    FechaTurnoActual:=FechaTurnoActual-1;
    TurnoActual:=T_TurcTurno.AsInteger;
  end
  else begin
    while not T_Turc.Eof do begin
      xhori:=FiltraStrNum(T_TurcHoraInicial.AsString);
      xhorf:=FiltraStrNum(T_TurcHoraFinal.AsString);
      xhormin:=FiltraStrNum(T_TurcHoraMin.AsString);
      if xhormin='' then begin
        xhormin:='0000';
        margenant:=2/24;
      end;
      xhormax:=FiltraStrNum(T_TurcHoraMax.AsString);
      if xhormax='' then begin
        xhormax:='0000';
        margenpos:=2/24;
      end;
      if (xhori<=xhorf) then begin
        if (xhor>=xhori)and(xhor<=xhorf) then begin
          TurnoActual:=T_TurcTurno.AsInteger;
          IniTurnoActual:=FechaTurnoActual+StrToHora(xhori);
          FinTurnoActual:=FechaTurnoActual+StrToHora(xhorf);
          FinTurnoActualMin:=FechaTurnoActual+StrToHora(xhormin);
          FinTurnoActualMax:=FechaTurnoActual+StrToHora(xhormax);

          if (FinTurnoActualMax<FinTurnoActual) then
            FinTurnoActualMax:=FinTurnoActualMax+1;

          if (FinTurnoActual-FinTurnoActualMin)>margenant then
            FinTurnoActualMin:=FinTurnoActual-margenant;
          if (FinTurnoActual<FinTurnoActualMin) then
            FinTurnoActualMin:=FinTurnoActual;

          if (FinTurnoActualMax-FinTurnoActual)>margenpos then
            FinTurnoActualMax:=FinTurnoActual+margenpos;
          if (FinTurnoActualMax<FinTurnoActual) then
            FinTurnoActualMax:=FinTurnoActual;

          FinTurnoActualMargenPos:=FinTurnoActualMax-FinTurnoActual; // cuanto despues de la hora programada
          FinTurnoActualMargenAnt:=FinTurnoActual-FinTurnoActualMin;  // cuanto antes de la hora programada
        end;
      end
      else if (xhor<=xhorf)or(xhor>=xhori) then begin
        TurnoActual:=T_TurcTurno.AsInteger;
        if (xhor<=xhorf) then
          FechaTurnoActual:=Trunc(xFechaHora)-1;
        IniTurnoActual:=FechaTurnoActual+StrToHora(xhori);
        FinTurnoActual:=FechaTurnoActual+1+StrToHora(xhorf);
        FinTurnoActualMin:=FechaTurnoActual+1+StrToHora(xhormin);
        FinTurnoActualMax:=FechaTurnoActual+1+StrToHora(xhormax);
        FinTurnoActualMargenPos:=FinTurnoActualMax-FinTurnoActual; // cuanto despues de la hora programada
        FinTurnoActualMargenAnt:=FinTurnoActual-FinTurnoActualMin;  // cuanto antes de la hora programada
      end;
      T_Turc.Next;
    end;
    if swhoy then begin
      if FechaTurnoActual<date then begin
        FechaTurnoActual:=Date;
        TurnoActual:=1;
      end;
    end;
  end;
  Q_Turn.Active:=false;Q_Turn.Active:=true;
end;

procedure TDMCONS.AbreNuevoTurno;
var xturno:integer;
begin
  try
    try
      Q_Auxi.Active:=false;
      Q_AuxiEntero1.FieldKind:=fkInternalCalc;
      Q_AuxiEntero2.FieldKind:=fkInternalCalc;
      Q_Auxi.SQL.Clear;
      Q_Auxi.SQL.Add('Select count(*) as Entero1, max(turno) as Entero2 from DPVGTURN');
      Q_Auxi.SQL.Add('where fecha="'+fechatostrsql(date)+'"');
      Q_Auxi.Active:=true;
      if (Q_AuxiEntero1.AsInteger>0) then
        xturno:=Q_AuxiEntero2.AsInteger+1
      else
        xturno:=1;
    finally
      Q_Auxi.Active:=true;
    end;
    T_Turn.Active:=true;
    try
      T_Turn.Insert;
      T_TurnFecha.AsDateTime:=Date;
      T_TurnTurno.AsInteger:=xturno;
      T_Turn.Post;
    finally
      T_Turn.Active:=false;
    end;
  except
  end;
end;

procedure TDMCONS.CalculaTurnoActual2;
//const xmargen=0.5/24;
var i:integer;
    xtiempo:TDateTime;
  procedure CalculaHorasCorte;
  var nn,i:integer;
      ss,xfec:string;
      FecHora:TDateTime;
  begin
    nn:=NoElemStrSep(HorasCorteTurnoAutom,'/');
    if nn>6 then nn:=6;
    for i:=1 to nn do begin
      ss:=ExtraeElemStrSep(HorasCorteTurnoAutom,i,'/');
      FecHora:=Date+StrToTime(ss);
      xfec:=FechaHoraToStr(FecHora);
      TabHrsCorte[i]:=FecHora;
    end;
    NumHrsCorte:=nn;
  end;
begin
  CalculaHorasCorte;
  Q_Turn.Active:=false;Q_Turn.Active:=true;
  if not (Q_Turn.IsEmpty) then begin
    for i:=1 to NumHrsCorte do begin
      xtiempo:=now-TabHrsCorte[i];
      if (xtiempo>=0)and(xtiempo<MargenTurnoAdmin) then begin     // candidato a cortar
        if abs(Q_TurnFechaHoraInicial.AsDateTime-TabHrsCorte[i])>MargenTurnoAdmin then begin  // Cortar
          // Cierra turno
          try
            Q_Auxi.Active:=false;
            Q_Auxi.SQL.Clear;
            Q_Auxi.SQL.Add('EXECUTE PROCEDURE TURN_REALIZA_CORTE');
            Q_Auxi.ExecSQL;
          finally
            Q_Auxi.active:=false;
          end;
          AbreNuevoTurno;
        end;
      end;
    end;
  end;
  Q_Turn.Active:=false;Q_Turn.Active:=true;
  FechaTurnoActual:=Q_TurnFecha.AsDateTime;
  TurnoActual:=Q_TurnTurno.AsInteger;
end;

procedure TDMCONS.AgregaLog(lin:string);
var lin2:string;
    i:integer;
begin
  lin2:=fechahoraexttostr(now)+' ';
  for i:=1 to length(lin) do
    case lin[i] of
      #2:lin2:=lin2+'<STX>';
      #3:lin2:=lin2+'<ETX>';
      #6:lin2:=lin2+'<ACK>';
      #21:lin2:=lin2+'<NAK>';
      else lin2:=lin2+lin[i];
    end;
  while ListaLog.Count>10000 do
    ListaLog.Delete(0);
  ListaLog.Add(lin2);
end;

procedure TDMCONS.AgregaLogCmnd(lin:string);
begin
  while ListaLogCmnd.Count>200 do
    ListaLogCmnd.Delete(0);
  ListaLogCmnd.Add(fechahoraexttostr(now)+' '+lin);
end;

function TDMCONS.DameTotalCombuPos(xpos,xcomb:integer;xtot1,xtot2:real):real;
var i,xt:integer;
begin
  xt:=0;
  for i:=1 to 2 do
    if TCombuPos[i,xpos]=xcomb then
      xt:=i;
  case xt of
    1:result:=xtot1;
    2:result:=xtot2;
    else result:=0;
  end;
end;

procedure TDMCONS.DBGASCONAfterConnect(Sender: TObject);
var xt,xp:integer;
begin
  for xt:=1 to 2 do
    for xp:=1 to 32 do
      TCombuPos[xt,xp]:=0;
  QL_Bomb.Active:=true;
  try
    xp:=0;xt:=0;
    while not QL_Bomb.Eof do begin
      if QL_BombPosCarga.AsInteger>xp then begin
        xp:=QL_BombPosCarga.AsInteger;
        xt:=1;
      end
      else inc(xt);
      if xt in [1..2] then
        TCombuPos[xt,xp]:=QL_BombCombustible.AsInteger;
      QL_Bomb.Next;
    end;
  finally
    QL_Bomb.Active:=false;
  end;
end;

procedure TDMCONS.ActivaModoPrepago(xpos:integer);
begin
  try
    try
      Q_Auxi.Active:=false;
      Q_Auxi.SQL.Clear;
      Q_Auxi.SQL.Add('UPDATE DPVGBOMB SET ModoOperacion="Prepago"');
      if xpos>0 then
        Q_Auxi.SQL.Add('WHERE POSCARGA='+inttostr(xpos));
      Q_Auxi.ExecSQL;
    finally
      Q_Auxi.Active:=false;
    end;
  except
  end
end;

procedure TDMCONS.DesActivaModoPrepago(xpos:integer);
begin
  try
    try
      Q_Auxi.Active:=false;
      Q_Auxi.SQL.Clear;
      Q_Auxi.SQL.Add('UPDATE DPVGBOMB SET ModoOperacion="Normal"');
      if xpos>0 then
        Q_Auxi.SQL.Add('WHERE POSCARGA='+inttostr(xpos));
      Q_Auxi.ExecSQL;
    finally
      Q_Auxi.Active:=false;
    end;
  except
  end
end;

procedure TDMCONS.ParametrosArosMagneticos(xpos:integer; var xmangera,xcliente,xvehiculo:integer);
begin
  try
    Q_Auxi.Active:=false;
    Q_AuxiEntero1.FieldKind:=fkInternalCalc;
    Q_Auxi.SQL.Clear;
    Q_Auxi.SQL.Add('SELECT COUNT(*) AS ENTERO1 FROM DPVGBOMB WHERE CONTROL_AROS=''X'' AND POSCARGA='+inttostr(xpos));
    Q_Auxi.Active:=true;
  finally
    Q_Auxi.Active:=false;
  end;
end;

procedure TDMCONS.SIBfibEA1EventAlert(Sender: TObject; EventName: String;
  EventCount: Integer);
begin
  Accion:=EventName;
end;

function TDMCONS.ControlArosMagneticos(xpos:integer; var xmanguera,xcliente,xvehiculo:integer):boolean;
begin
  xmanguera:=0; result:=false; xcliente:=0; xvehiculo:=0;
  try
    try
      Q_Auxi.Active:=false;
      Q_AuxiEntero1.FieldKind:=fkInternalCalc;
      Q_AuxiStr10.FieldKind:=fkInternalCalc;
      Q_AuxiStr10_2.FieldKind:=fkInternalCalc;
      Q_Auxi.SQL.Clear;
      Q_Auxi.SQL.Add('SELECT MAX(MANGUERA) AS ENTERO1, MAX(CLIENTE) AS Str10, MAX(VEHICULO) AS Str10_2 FROM DPVGBOMB WHERE CONTROL_AROS=''X'' AND POSCARGA='+inttostr(xpos));
      Q_Auxi.Active:=true;
      if Q_AuxiEntero1.AsInteger>0 then begin
        xmanguera:=Q_AuxiEntero1.AsInteger;
        xcliente:=StrToIntDef(Q_AuxiStr10.AsString,0);
        xvehiculo:=StrToIntDef(Q_AuxiStr10_2.AsString,0);
        result:=true;
      end;
    finally
      Q_Auxi.Active:=false;
    end;
  except
    result:=false;
  end
end;

function TDMCONS.ControlArosMagneticos2(xpos:integer; var xmanguera,xcliente,xvehiculo:integer):boolean;
begin
  xmanguera:=0; result:=false; xcliente:=0; xvehiculo:=0;
  try
    try
      Q_Auxi.Active:=false;
      Q_AuxiEntero1.FieldKind:=fkInternalCalc;
      Q_AuxiStr10.FieldKind:=fkInternalCalc;
      Q_AuxiStr10_2.FieldKind:=fkInternalCalc;
      Q_Auxi.SQL.Clear;
      Q_Auxi.SQL.Add('SELECT MAX(MANGUERA) AS ENTERO1, MAX(CLIENTE) AS Str10, MAX(VEHICULO) AS Str10_2 FROM DPVGBOMB');
      Q_Auxi.SQL.Add('WHERE POSCARGA='+inttostr(xpos));
      Q_Auxi.Active:=true;
      if Q_AuxiEntero1.AsInteger>0 then begin
        xmanguera:=Q_AuxiEntero1.AsInteger;
        xcliente:=StrToIntDef(Q_AuxiStr10.AsString,0);
        xvehiculo:=StrToIntDef(Q_AuxiStr10_2.AsString,0);
        result:=((xcliente>0)and(xvehiculo>0));
      end;
    finally
      Q_Auxi.Active:=false;
    end;
  except
    result:=false;
  end
end;

function TDMCONS.ConexionArosActiva(xpos:integer):boolean;
var i1,i2,i3:integer;
begin
  result:=ControlArosMagneticos(xpos,i1,i2,i3);
end;

function TDMCONS.ControlArosMagneticosRecon(xpos:integer; var xmanguera,xcliente,xvehiculo:integer):boolean;
begin
  result:=false;
  xmanguera:=0;xcliente:=0; xvehiculo:=0;
  try
    try
      Q_Auxi.Active:=false;
      Q_AuxiEntero1.FieldKind:=fkInternalCalc;
      Q_AuxiStr10.FieldKind:=fkInternalCalc;
      Q_AuxiStr10_2.FieldKind:=fkInternalCalc;
      Q_Auxi.SQL.Clear;
      Q_Auxi.SQL.Add('SELECT MAX(MANGUERA) AS ENTERO1, MAX(CLIENTE) AS Str10, MAX(VEHICULO) AS Str10_2 FROM DPVGBOMB WHERE POSCARGA='+inttostr(xpos)+' AND CLIENTE>''0'' AND VEHICULO>''0''');
      Q_Auxi.Active:=true;
      if Q_AuxiEntero1.AsInteger>0 then begin
        xmanguera:=Q_AuxiEntero1.AsInteger;
        xcliente:=StrToIntDef(Q_AuxiStr10.AsString,0);
        xvehiculo:=StrToIntDef(Q_AuxiStr10_2.AsString,0);
        result:=true;
      end
      else result:=false;
    finally
      Q_Auxi.Active:=false;
    end;
  except
    result:=false;
  end
end;


procedure TDMCONS.Q_CvolBeforeClose(DataSet: TDataSet);
begin
  Q_Etan.Active:=false;
  T_Cvolt.Active:=false;
end;

function desencriptar(s: String): String;
var
  i:Integer;
begin
  Result:='';
  for i := 1 to Length(s) do
    s[i] := Char(128-Ord(s[i]));
  Result:=s;
end;

function TDMCONS.AutoValidarMD5:Boolean;
var
  swresul:string;
  MD5Encriptado:string;
  MD5Desencriptado:string;
  Str255,
  RutaModulo:string;
begin
  Result:=False;
  MD5Desencriptado:='';
  try
    try
        Q_Auxi.Active:=false;
        Q_AuxiStr255.FieldKind:=fkInternalCalc;
        Q_Auxi.SQL.Clear;
        Q_Auxi.SQL.Add('SELECT INOCUIDAD AS STR255 FROM DPVGESTS');
        Q_Auxi.Active:=true;
        Str255:=Q_AuxisTR255.AsString;
        MD5Desencriptado:=Desencriptar(Str255);
    except
      Result:=False;
      Exit;
    end;
    RutaModulo:=Application.ExeName;
    swresul:=Uppercase(CheckSum(RutaModulo));
    Result:= MD5Desencriptado=swresul;

    Md5Exe:=swresul;
    Md5Cfg:=MD5Desencriptado;
  finally
    Q_Auxi.Active:=false;
  end;
end;


procedure TDMCONS.AplicarUltimosPrecios;
var swcon:boolean;
    xcomb,xc:integer;
begin
  try
    swcon:=DBGasCon.Connected;
    DBGasCon.Connected:=true;
    try
      Q_UltPrec.active:=false;
      Q_UltPrec.active:=true;
      if Q_UltPrecPrecio.AsInteger>0 then begin
        while not Q_UltPrec.Eof do begin
          xcomb:=Q_UltPrecCombustible.AsInteger;
          if xcomb in [1..MaxComb] then
            if TabComb[xcomb].Activo then begin
              TabComb[xcomb].PrecioAnt:=TabComb[xcomb].Precio;
              TabComb[xcomb].Precio:=Q_UltPrecPrecio.AsFloat;
              TabComb[xcomb].PrecioNuevo:=Q_UltPrecPrecio.AsFloat; //act 110913
              if TabComb[xcomb].Precio>0 then
                TabComb[xcomb].AplicaPrecio:=true;
              TabComb[xcomb].FechaHora:=Q_UltPrecFechaHora.AsDateTime;
              TabComb[xcomb].Folio:=Q_UltPrecFolio.AsInteger;
              for xc:=1 to MaxComb do
                if TabComb[xc].Agruparcon=xcomb then begin
                  TabComb[xc].PrecioAnt:=TabComb[xc].Precio;
                  TabComb[xc].Precio:=Q_UltPrecPrecio.AsFloat;
                  TabComb[xc].PrecioNuevo:=Q_UltPrecPrecio.AsFloat;     //act 110913
                  TabComb[xc].AplicaPrecio:=true;
                  TabComb[xc].FechaHora:=Q_UltPrecFechaHora.AsDateTime;
                  TabComb[xc].Folio:=Q_UltPrecFolio.AsInteger;
                end;
            end;
          Q_UltPrec.Next;
        end;
      end;
    finally
      Q_UltPrec.Active:=false;
      if not swcon then
        DBGasCon.Connected:=false;
    end;
  except
  end;
end;

end.

// Tanque inactivo            RegistraBitacora3(1,'Reconexión de Tanque','Tanque '+inttostr(xtan),'U');
// Desconexion de consola          DMCONS.RegistraBitacora3(1,'Desconexion de Dispositivo','Error de Comunicación','U');

