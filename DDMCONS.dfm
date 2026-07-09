object DMCONS: TDMCONS
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 25
  Top = 25
  Height = 702
  Width = 1038
  object DBGASCON: TDatabase
    AliasName = 'GasConsolaImagen'
    DatabaseName = 'DBGASCONSOLA'
    LoginPrompt = False
    Params.Strings = (
      'USER NAME=SYSDBA'
      'PASSWORD=masterkey'
      '')
    SessionName = 'Default'
    Left = 24
    Top = 16
  end
  object T_MoviIb: TTable
    DatabaseName = 'DBGASCONSOLA'
    TableName = 'DPVGMOVI'
    Left = 25
    Top = 72
    object T_MoviIbFOLIO: TIntegerField
      Alignment = taLeftJustify
      FieldName = 'FOLIO'
      DisplayFormat = '00000000'
      EditFormat = '00000000'
      AttributeSet = 'Folio6NR'
    end
    object T_MoviIbFECHA: TDateTimeField
      FieldName = 'FECHA'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!99/99/0000;1;_'
      AttributeSet = 'Fecha'
    end
    object T_MoviIbHORA: TDateTimeField
      FieldName = 'HORA'
      DisplayFormat = 'hh:nn:ss'
      EditMask = '!99/99/0000;1;_'
      AttributeSet = 'Fecha'
    end
    object T_MoviIbPOSCARGA: TIntegerField
      Alignment = taLeftJustify
      FieldName = 'POSCARGA'
      DisplayFormat = '00'
      EditFormat = '00'
      AttributeSet = 'Folio2NR'
    end
    object T_MoviIbCOMBUSTIBLE: TIntegerField
      Alignment = taLeftJustify
      FieldName = 'COMBUSTIBLE'
      DisplayFormat = '00'
      EditFormat = '00'
      AttributeSet = 'Folio2NR'
    end
    object T_MoviIbVOLUMEN: TFloatField
      FieldName = 'VOLUMEN'
      DisplayFormat = '#,###,##0.000'
      EditFormat = '######0.000'
      AttributeSet = 'ImpMoneda'
    end
    object T_MoviIbIMPORTE: TFloatField
      FieldName = 'IMPORTE'
      DisplayFormat = '###,###,##0.00'
      EditFormat = '########0.00'
      AttributeSet = 'ImpMoneda'
    end
    object T_MoviIbIMPRESO: TStringField
      FieldName = 'IMPRESO'
      Size = 2
    end
    object T_MoviIbTRANSACCION: TIntegerField
      Alignment = taLeftJustify
      FieldName = 'TRANSACCION'
      DisplayFormat = '000000'
      EditFormat = '000000'
      AttributeSet = 'Folio6NR'
    end
    object T_MoviIbTARJETA: TStringField
      FieldName = 'TARJETA'
      Size = 16
    end
    object T_MoviIbKILOMETRAJE: TIntegerField
      FieldName = 'KILOMETRAJE'
    end
    object T_MoviIbNombreComb: TStringField
      FieldKind = fkLookup
      FieldName = 'NombreComb'
      LookupDataSet = Q_CombIb
      LookupKeyFields = 'CLAVE'
      LookupResultField = 'NOMBRE'
      KeyFields = 'COMBUSTIBLE'
      Lookup = True
    end
    object T_MoviIbHORASTR: TStringField
      FieldName = 'HORASTR'
      Size = 8
    end
    object T_MoviIbAPLICAR: TStringField
      FieldName = 'APLICAR'
      Size = 2
    end
    object T_MoviIbFECHACORTE: TDateTimeField
      FieldName = 'FECHACORTE'
    end
    object T_MoviIbCORTE: TIntegerField
      FieldName = 'CORTE'
    end
    object T_MoviIbFACTURADO: TStringField
      FieldName = 'FACTURADO'
      Size = 2
    end
    object T_MoviIbTOTAL01: TFloatField
      FieldName = 'TOTAL01'
    end
    object T_MoviIbTOTAL02: TFloatField
      FieldName = 'TOTAL02'
    end
    object T_MoviIbTAG: TIntegerField
      FieldName = 'TAG'
    end
    object T_MoviIbPRECIO: TFloatField
      FieldName = 'PRECIO'
      DisplayFormat = '###,###,##0.00'
      EditFormat = '########0.00'
      AttributeSet = 'ImpMoneda'
    end
    object T_MoviIbclavecombus: TStringField
      FieldKind = fkLookup
      FieldName = 'clavecombus'
      LookupDataSet = Q_CombIb
      LookupKeyFields = 'CLAVE'
      LookupResultField = 'CLAVEPEMEX'
      KeyFields = 'COMBUSTIBLE'
      Size = 5
      Lookup = True
    end
    object T_MoviIbFECHATURNO: TDateTimeField
      FieldName = 'FECHATURNO'
    end
    object T_MoviIbTURNO: TIntegerField
      FieldName = 'TURNO'
    end
    object T_MoviIbJARREO: TStringField
      FieldName = 'JARREO'
      Size = 2
    end
    object T_MoviIbMANGUERA: TIntegerField
      FieldName = 'MANGUERA'
    end
    object T_MoviIbTOTAL03: TFloatField
      FieldName = 'TOTAL03'
    end
    object T_MoviIbTOTAL04: TFloatField
      FieldName = 'TOTAL04'
    end
    object T_MoviIbTIPOPAGO: TIntegerField
      FieldName = 'TIPOPAGO'
    end
    object T_MoviIbBOUCHER: TStringField
      FieldName = 'BOUCHER'
      Size = 12
    end
    object T_MoviIbCUPONIMPRESO: TStringField
      FieldName = 'CUPONIMPRESO'
      Size = 2
    end
    object T_MoviIbREFERENCIABITACORA: TIntegerField
      FieldName = 'REFERENCIABITACORA'
    end
    object T_MoviIbGASID: TIntegerField
      FieldName = 'GASID'
    end
    object T_MoviIbSALDO: TFloatField
      FieldName = 'SALDO'
    end
    object T_MoviIbHEXHASH: TStringField
      FieldName = 'HEXHASH'
    end
    object T_MoviIbFECHAMODIF: TDateTimeField
      FieldName = 'FECHAMODIF'
    end
  end
  object T_FactIb: TTable
    OnCalcFields = T_FactIbCalcFields
    DatabaseName = 'DBGASCONSOLA'
    TableName = 'DPVGFACT'
    Left = 160
    Top = 72
    object T_FactIbPOSCARGA: TIntegerField
      Alignment = taLeftJustify
      FieldName = 'POSCARGA'
      DisplayFormat = '00'
      EditFormat = '00'
      AttributeSet = 'Folio2NR'
    end
    object T_FactIbCLAVE: TIntegerField
      FieldName = 'CLAVE'
    end
    object T_FactIbHORA: TDateTimeField
      FieldName = 'HORA'
    end
    object T_FactIbCOMBUSTIBLE: TIntegerField
      Alignment = taLeftJustify
      FieldName = 'COMBUSTIBLE'
      DisplayFormat = '00'
      EditFormat = '00'
      AttributeSet = 'Folio2NR'
    end
    object T_FactIbVOLUMEN: TFloatField
      FieldName = 'VOLUMEN'
      DisplayFormat = '###,###,##0.000'
      EditFormat = '########0.000'
      AttributeSet = 'ImpMoneda'
    end
    object T_FactIbIMPORTE: TFloatField
      FieldName = 'IMPORTE'
      DisplayFormat = '###,###,##0.00'
      EditFormat = '########0.00'
      AttributeSet = 'ImpMoneda'
    end
    object T_FactIbNombreComb: TStringField
      FieldKind = fkCalculated
      FieldName = 'NombreComb'
      Calculated = True
    end
    object T_FactIbIMPRESO: TStringField
      FieldName = 'IMPRESO'
      Size = 2
    end
    object T_FactIbFOLIO: TIntegerField
      FieldName = 'FOLIO'
    end
    object T_FactIbTRANSACCION: TIntegerField
      FieldName = 'TRANSACCION'
    end
  end
  object Q_Fact1: TQuery
    OnCalcFields = Q_Fact1CalcFields
    DatabaseName = 'DBGASCONSOLA'
    SQL.Strings = (
      'select * from DPVGFACT'
      'where clave=0'
      'order by PosCarga')
    Left = 224
    Top = 73
    object Q_Fact1POSCARGA: TIntegerField
      Alignment = taLeftJustify
      FieldName = 'POSCARGA'
      Origin = 'DBGASCONSOLA.DPVGFACT.POSCARGA'
      DisplayFormat = '00'
      EditFormat = '00'
      AttributeSet = 'Folio2NR'
    end
    object Q_Fact1CLAVE: TIntegerField
      FieldName = 'CLAVE'
      Origin = 'DBGASCONSOLA.DPVGFACT.CLAVE'
    end
    object Q_Fact1HORA: TDateTimeField
      FieldName = 'HORA'
      Origin = 'DBGASCONSOLA.DPVGFACT.HORA'
    end
    object Q_Fact1COMBUSTIBLE: TIntegerField
      FieldName = 'COMBUSTIBLE'
      Origin = 'DBGASCONSOLA.DPVGFACT.COMBUSTIBLE'
    end
    object Q_Fact1VOLUMEN: TFloatField
      FieldName = 'VOLUMEN'
      Origin = 'DBGASCONSOLA.DPVGFACT.VOLUMEN'
      DisplayFormat = '###,###,##0.000'
      EditFormat = '########0.000'
      AttributeSet = 'ImpMoneda'
    end
    object Q_Fact1IMPORTE: TFloatField
      FieldName = 'IMPORTE'
      Origin = 'DBGASCONSOLA.DPVGFACT.IMPORTE'
      DisplayFormat = '###,###,##0.00'
      EditFormat = '########0.00'
      AttributeSet = 'ImpMoneda'
    end
    object Q_Fact1NombreComb: TStringField
      FieldKind = fkCalculated
      FieldName = 'NombreComb'
      Calculated = True
    end
    object Q_Fact1IMPRESO: TStringField
      FieldName = 'IMPRESO'
      Origin = 'DBGASCONSOLA.DPVGFACT.IMPRESO'
      Size = 2
    end
    object Q_Fact1FOLIO: TIntegerField
      FieldName = 'FOLIO'
      Origin = 'DBGASCONSOLA.DPVGFACT.FOLIO'
    end
    object Q_Fact1TRANSACCION: TIntegerField
      FieldName = 'TRANSACCION'
      Origin = 'DBGASCONSOLA.DPVGFACT.TRANSACCION'
    end
  end
  object Q_Fact2: TQuery
    OnCalcFields = Q_Fact2CalcFields
    DatabaseName = 'DBGASCONSOLA'
    SQL.Strings = (
      'select * from DPVGFACT'
      'where clave=1'
      'order by PosCarga')
    Left = 272
    Top = 74
    object Q_Fact2POSCARGA: TIntegerField
      Alignment = taLeftJustify
      FieldName = 'POSCARGA'
      Origin = 'DBGASCONSOLA.DPVGFACT.POSCARGA'
      DisplayFormat = '00'
      EditFormat = '00'
      AttributeSet = 'Folio2NR'
    end
    object Q_Fact2CLAVE: TIntegerField
      FieldName = 'CLAVE'
      Origin = 'DBGASCONSOLA.DPVGFACT.CLAVE'
    end
    object Q_Fact2HORA: TDateTimeField
      FieldName = 'HORA'
      Origin = 'DBGASCONSOLA.DPVGFACT.HORA'
    end
    object Q_Fact2COMBUSTIBLE: TIntegerField
      FieldName = 'COMBUSTIBLE'
      Origin = 'DBGASCONSOLA.DPVGFACT.COMBUSTIBLE'
    end
    object Q_Fact2VOLUMEN: TFloatField
      FieldName = 'VOLUMEN'
      Origin = 'DBGASCONSOLA.DPVGFACT.VOLUMEN'
      DisplayFormat = '###,###,##0.000'
      EditFormat = '########0.000'
      AttributeSet = 'ImpMoneda'
    end
    object Q_Fact2IMPORTE: TFloatField
      FieldName = 'IMPORTE'
      Origin = 'DBGASCONSOLA.DPVGFACT.IMPORTE'
      DisplayFormat = '###,###,##0.00'
      EditFormat = '########0.00'
      AttributeSet = 'ImpMoneda'
    end
    object Q_Fact2NombreComb: TStringField
      FieldKind = fkCalculated
      FieldName = 'NombreComb'
      Calculated = True
    end
    object Q_Fact2IMPRESO: TStringField
      FieldName = 'IMPRESO'
      Origin = 'DBGASCONSOLA.DPVGFACT.IMPRESO'
      Size = 2
    end
    object Q_Fact2FOLIO: TIntegerField
      FieldName = 'FOLIO'
      Origin = 'DBGASCONSOLA.DPVGFACT.FOLIO'
    end
    object Q_Fact2TRANSACCION: TIntegerField
      FieldName = 'TRANSACCION'
      Origin = 'DBGASCONSOLA.DPVGFACT.TRANSACCION'
    end
  end
  object DSQ_Fact1: TDataSource
    DataSet = Q_Fact1
    Left = 224
    Top = 128
  end
  object DSQ_Fact2: TDataSource
    DataSet = Q_Fact2
    Left = 272
    Top = 128
  end
  object Q_MoviTarj: TQuery
    DatabaseName = 'DBGASCONSOLA'
    SQL.Strings = (
      'select * from DPVGMOVI'
      'where Aplicar='#39'Si'#39)
    Left = 96
    Top = 128
    object Q_MoviTarjFOLIO: TIntegerField
      FieldName = 'FOLIO'
      Origin = 'DBGASCONSOLA.DPVGMOVI.FOLIO'
    end
    object Q_MoviTarjFECHA: TDateTimeField
      FieldName = 'FECHA'
      Origin = 'DBGASCONSOLA.DPVGMOVI.FECHA'
    end
    object Q_MoviTarjHORA: TDateTimeField
      FieldName = 'HORA'
      Origin = 'DBGASCONSOLA.DPVGMOVI.HORA'
    end
    object Q_MoviTarjPOSCARGA: TIntegerField
      FieldName = 'POSCARGA'
      Origin = 'DBGASCONSOLA.DPVGMOVI.POSCARGA'
    end
    object Q_MoviTarjCOMBUSTIBLE: TIntegerField
      FieldName = 'COMBUSTIBLE'
      Origin = 'DBGASCONSOLA.DPVGMOVI.COMBUSTIBLE'
    end
    object Q_MoviTarjVOLUMEN: TFloatField
      FieldName = 'VOLUMEN'
      Origin = 'DBGASCONSOLA.DPVGMOVI.VOLUMEN'
    end
    object Q_MoviTarjIMPORTE: TFloatField
      FieldName = 'IMPORTE'
      Origin = 'DBGASCONSOLA.DPVGMOVI.IMPORTE'
    end
    object Q_MoviTarjIMPRESO: TStringField
      FieldName = 'IMPRESO'
      Origin = 'DBGASCONSOLA.DPVGMOVI.IMPRESO'
      Size = 2
    end
    object Q_MoviTarjTRANSACCION: TIntegerField
      FieldName = 'TRANSACCION'
      Origin = 'DBGASCONSOLA.DPVGMOVI.TRANSACCION'
    end
    object Q_MoviTarjTARJETA: TStringField
      FieldName = 'TARJETA'
      Origin = 'DBGASCONSOLA.DPVGMOVI.TARJETA'
      Size = 16
    end
    object Q_MoviTarjKILOMETRAJE: TIntegerField
      FieldName = 'KILOMETRAJE'
      Origin = 'DBGASCONSOLA.DPVGMOVI.KILOMETRAJE'
    end
    object Q_MoviTarjAPLICAR: TStringField
      FieldName = 'APLICAR'
      Origin = 'DBGASCONSOLA.DPVGMOVI.APLICAR'
      Size = 2
    end
  end
  object T_Corte: TTable
    DatabaseName = 'DBGASCONSOLA'
    TableName = 'DPVGCORTE'
    Left = 24
    Top = 128
    object T_CorteFECHA: TDateTimeField
      FieldName = 'FECHA'
    end
    object T_CorteTURNO: TIntegerField
      FieldName = 'TURNO'
    end
    object T_CorteISLA: TIntegerField
      FieldName = 'ISLA'
    end
    object T_CortePOSCARGA: TIntegerField
      FieldName = 'POSCARGA'
    end
    object T_CorteCOMBUSTIBLE: TIntegerField
      FieldName = 'COMBUSTIBLE'
    end
    object T_CorteCONTADORLITROS: TFloatField
      FieldName = 'CONTADORLITROS'
    end
    object T_CorteCONTADORIMPORTE: TFloatField
      FieldName = 'CONTADORIMPORTE'
    end
  end
  object Q_Corte: TQuery
    DatabaseName = 'DBGASCONSOLA'
    SQL.Strings = (
      'select count(*) as Cantidad from DPVGCORTE'
      'where fecha=:pfecha and turno=:pturno '
      '    and isla=:pisla')
    Left = 24
    Top = 184
    ParamData = <
      item
        DataType = ftDateTime
        Name = 'pfecha'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'pturno'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'pisla'
        ParamType = ptUnknown
      end>
    object Q_CorteCANTIDAD: TIntegerField
      FieldName = 'CANTIDAD'
    end
  end
  object T_ConsIb: TTable
    OnCalcFields = T_ConsIbCalcFields
    DatabaseName = 'DBGASCONSOLA'
    Filter = 'PosCarga>0'
    Filtered = True
    TableName = 'DPVGCONS'
    Left = 24
    Top = 248
    object T_ConsIbPOSCARGA: TIntegerField
      Alignment = taLeftJustify
      FieldName = 'POSCARGA'
      DisplayFormat = '00'
      EditFormat = '00'
      AttributeSet = 'Folio2NR'
    end
    object T_ConsIbMONVOL: TStringField
      FieldName = 'MONVOL'
      Size = 1
    end
    object T_ConsIbVALOR: TFloatField
      FieldName = 'VALOR'
      DisplayFormat = '###,###,##0.00'
      EditFormat = '########0.00'
      AttributeSet = 'ImpMoneda'
    end
    object T_ConsIbESTATUS: TStringField
      FieldName = 'ESTATUS'
      Size = 1
    end
    object T_ConsIbPOSICION: TIntegerField
      Alignment = taLeftJustify
      FieldName = 'POSICION'
      DisplayFormat = '00'
      EditFormat = '00'
      AttributeSet = 'Folio2NR'
    end
    object T_ConsIbVOLUMEN: TFloatField
      FieldName = 'VOLUMEN'
      DisplayFormat = '###,###,##0.00'
      EditFormat = '########0.00'
      AttributeSet = 'ImpMoneda'
    end
    object T_ConsIbPRECIO: TFloatField
      FieldName = 'PRECIO'
      DisplayFormat = '###,###,##0.00'
      EditFormat = '########0.00'
      AttributeSet = 'ImpMoneda'
    end
    object T_ConsIbIMPORTE: TFloatField
      FieldName = 'IMPORTE'
      DisplayFormat = '###,###,##0.00'
      EditFormat = '########0.00'
      AttributeSet = 'ImpMoneda'
    end
    object T_ConsIbDescEstatus: TStringField
      FieldKind = fkCalculated
      FieldName = 'DescEstatus'
      Calculated = True
    end
    object T_ConsIbCOMBUSTIBLE: TStringField
      FieldName = 'COMBUSTIBLE'
    end
    object T_ConsIbFOLIO: TIntegerField
      FieldName = 'FOLIO'
    end
    object T_ConsIbVALOR2: TFloatField
      FieldName = 'VALOR2'
    end
    object T_ConsIbESTADO: TIntegerField
      FieldName = 'ESTADO'
    end
    object T_ConsIbOTROS: TStringField
      FieldName = 'OTROS'
      FixedChar = True
      Size = 200
    end
    object T_ConsIbARO: TSmallintField
      FieldName = 'ARO'
    end
    object T_ConsIbTIPOPAGO: TIntegerField
      FieldName = 'TIPOPAGO'
    end
  end
  object T_ConfIb: TTable
    DatabaseName = 'DBGASCONSOLA'
    TableName = 'DPVGCONF'
    Left = 96
    Top = 248
    object T_ConfIbRAZONSOCIAL: TStringField
      FieldName = 'RAZONSOCIAL'
      Size = 80
    end
    object T_ConfIbNOMBRECOMERCIAL: TStringField
      FieldName = 'NOMBRECOMERCIAL'
      Size = 40
    end
    object T_ConfIbESTACIONSERVICIO: TStringField
      FieldName = 'ESTACIONSERVICIO'
      Size = 60
    end
    object T_ConfIbLECTORSERIAL: TStringField
      FieldName = 'LECTORSERIAL'
      Size = 2
    end
    object T_ConfIbULTIMOFOLIOCR: TIntegerField
      FieldName = 'ULTIMOFOLIOCR'
    end
    object T_ConfIbULTIMOFOLIOPP: TIntegerField
      FieldName = 'ULTIMOFOLIOPP'
    end
    object T_ConfIbIMPRESORATICKETS: TStringField
      FieldName = 'IMPRESORATICKETS'
      Size = 40
    end
    object T_ConfIbPOSCLIENTE: TIntegerField
      FieldName = 'POSCLIENTE'
    end
    object T_ConfIbLONGCLIENTE: TIntegerField
      FieldName = 'LONGCLIENTE'
    end
    object T_ConfIbPOSVEHICULO: TIntegerField
      FieldName = 'POSVEHICULO'
    end
    object T_ConfIbLONGVEHICULO: TIntegerField
      FieldName = 'LONGVEHICULO'
    end
    object T_ConfIbCONFIGPUERTOTARJETA: TStringField
      FieldName = 'CONFIGPUERTOTARJETA'
      Size = 50
    end
    object T_ConfIbRUTAVOLUMETRICOS: TStringField
      FieldName = 'RUTAVOLUMETRICOS'
      Size = 60
    end
    object T_ConfIbIMPO_BOMBAS: TStringField
      FieldName = 'IMPO_BOMBAS'
      Size = 2
    end
    object T_ConfIbIMPO_ESTACIONES: TStringField
      FieldName = 'IMPO_ESTACIONES'
      Size = 2
    end
    object T_ConfIbIMPO_PRECIOS: TStringField
      FieldName = 'IMPO_PRECIOS'
      Size = 2
    end
    object T_ConfIbIMPO_TANQUES: TStringField
      FieldName = 'IMPO_TANQUES'
      Size = 2
    end
    object T_ConfIbIMPO_COMBUSTIBLES: TStringField
      FieldName = 'IMPO_COMBUSTIBLES'
      Size = 2
    end
    object T_ConfIbIMPO_TARJETAS: TStringField
      FieldName = 'IMPO_TARJETAS'
      Size = 2
    end
    object T_ConfIbIMPO_CONFIG: TStringField
      FieldName = 'IMPO_CONFIG'
      Size = 2
    end
    object T_ConfIbMASCARA_FLOAT: TStringField
      FieldName = 'MASCARA_FLOAT'
      Size = 15
    end
    object T_ConfIbMASCARA_HORA: TStringField
      FieldName = 'MASCARA_HORA'
      Size = 15
    end
    object T_ConfIbPERMITIR_CAMBIO_FECHAHORA: TStringField
      FieldName = 'PERMITIR_CAMBIO_FECHAHORA'
      Size = 2
    end
    object T_ConfIbINT_ACT_PRECIOS: TIntegerField
      FieldName = 'INT_ACT_PRECIOS'
    end
    object T_ConfIbIMPRESORAVOLUMETRICOS: TStringField
      FieldName = 'IMPRESORAVOLUMETRICOS'
      Size = 60
    end
    object T_ConfIbCOMANDO1: TStringField
      FieldName = 'COMANDO1'
      FixedChar = True
      Size = 200
    end
    object T_ConfIbCOMANDO2: TStringField
      FieldName = 'COMANDO2'
      FixedChar = True
      Size = 200
    end
    object T_ConfIbLEVANTAR_CONSOLAS: TStringField
      FieldName = 'LEVANTAR_CONSOLAS'
      Size = 2
    end
    object T_ConfIbRUTA_RESPALDOS: TStringField
      FieldName = 'RUTA_RESPALDOS'
      Size = 80
    end
    object T_ConfIbLICENCIA: TStringField
      FieldName = 'LICENCIA'
      Size = 8
    end
    object T_ConfIbNUMEROSERIE: TIntegerField
      FieldName = 'NUMEROSERIE'
    end
    object T_ConfIbIMPRESORAGRAFICA: TStringField
      FieldName = 'IMPRESORAGRAFICA'
      Size = 2
    end
    object T_ConfIbDISPENSARIOS: TMemoField
      FieldName = 'DISPENSARIOS'
      BlobType = ftMemo
      Size = 500
    end
    object T_ConfIbESTACION_IGAS: TIntegerField
      FieldName = 'ESTACION_IGAS'
    end
    object T_ConfIbCONFIG_TICKET: TMemoField
      FieldName = 'CONFIG_TICKET'
      BlobType = ftMemo
      Size = 1
    end
    object T_ConfIbESTEMPORAL: TStringField
      FieldName = 'ESTEMPORAL'
      Size = 2
    end
    object T_ConfIbFECHAVENCE: TDateTimeField
      FieldName = 'FECHAVENCE'
    end
    object T_ConfIbDIRECCIONPEMEX: TStringField
      FieldName = 'DIRECCIONPEMEX'
      Size = 150
    end
    object T_ConfIbUSUARIOPEMEX: TStringField
      FieldName = 'USUARIOPEMEX'
    end
    object T_ConfIbCLAVEPEMEX: TStringField
      FieldName = 'CLAVEPEMEX'
    end
    object T_ConfIbCOMANDO3: TStringField
      FieldName = 'COMANDO3'
      FixedChar = True
      Size = 200
    end
    object T_ConfIbCOMANDO4: TStringField
      FieldName = 'COMANDO4'
      FixedChar = True
      Size = 200
    end
    object T_ConfIbMODOADI: TSmallintField
      FieldName = 'MODOADI'
    end
    object T_ConfIbLICENCIA5: TStringField
      FieldName = 'LICENCIA5'
      Size = 8
    end
    object T_ConfIbFECHAVENCE5: TDateTimeField
      FieldName = 'FECHAVENCE5'
    end
    object T_ConfIbESTEMPORAL5: TStringField
      FieldName = 'ESTEMPORAL5'
      Size = 2
    end
    object T_ConfIbUSATURNOSALTERNATIVOS: TStringField
      FieldName = 'USATURNOSALTERNATIVOS'
      Size = 2
    end
    object T_ConfIbLICENCIA3: TStringField
      FieldName = 'LICENCIA3'
      Size = 8
    end
    object T_ConfIbLICENCIA4: TStringField
      FieldName = 'LICENCIA4'
      Size = 8
    end
    object T_ConfIbLICENCIA2: TStringField
      FieldName = 'LICENCIA2'
      Size = 8
    end
    object T_ConfIbFECHAVENCE2: TDateTimeField
      FieldName = 'FECHAVENCE2'
    end
    object T_ConfIbESTEMPORAL2: TStringField
      FieldName = 'ESTEMPORAL2'
      Size = 2
    end
    object T_ConfIbULTIMOIMPRESO: TIntegerField
      FieldName = 'ULTIMOIMPRESO'
    end
    object T_ConfIbCONFIGCUPON: TMemoField
      FieldName = 'CONFIGCUPON'
      BlobType = ftMemo
      Size = 1
    end
    object T_ConfIbUSARCUPONCORTESIA: TStringField
      FieldName = 'USARCUPONCORTESIA'
      Size = 2
    end
    object T_ConfIbBAN_NAME: TStringField
      FieldName = 'BAN_NAME'
    end
    object T_ConfIbBAN_PASSWORD: TStringField
      FieldName = 'BAN_PASSWORD'
    end
    object T_ConfIbBAN_CLIENID: TStringField
      FieldName = 'BAN_CLIENID'
    end
    object T_ConfIbMODOPAGOSBANCARIOS: TStringField
      FieldName = 'MODOPAGOSBANCARIOS'
      FixedChar = True
      Size = 1
    end
    object T_ConfIbTICKET_PROMO: TMemoField
      FieldName = 'TICKET_PROMO'
      BlobType = ftMemo
      Size = 1
    end
    object T_ConfIbALIASMASTER: TStringField
      FieldName = 'ALIASMASTER'
      Size = 50
    end
    object T_ConfIbFECHAINICIOSAT2014: TDateTimeField
      FieldName = 'FECHAINICIOSAT2014'
    end
  end
  object T_TarjIb: TTable
    DatabaseName = 'DBGASCONSOLA'
    TableName = 'DPVGTARJ'
    Left = 24
    Top = 304
    object T_TarjIbNOCLIE: TIntegerField
      FieldName = 'NOCLIE'
    end
    object T_TarjIbVEHIC: TIntegerField
      FieldName = 'VEHIC'
    end
    object T_TarjIbCODIGO: TStringField
      FieldName = 'CODIGO'
    end
    object T_TarjIbNOMBRECLIENTE: TStringField
      FieldName = 'NOMBRECLIENTE'
      Size = 50
    end
    object T_TarjIbDESCRIPVEHICULO: TStringField
      FieldName = 'DESCRIPVEHICULO'
      Size = 50
    end
    object T_TarjIbCONDUCTOR: TStringField
      FieldName = 'CONDUCTOR'
      Size = 30
    end
    object T_TarjIbCONFIDENCIAL: TStringField
      FieldName = 'CONFIDENCIAL'
      Size = 10
    end
    object T_TarjIbTIPOTARJETA: TStringField
      FieldName = 'TIPOTARJETA'
      Size = 2
    end
  end
  object Q_ConsIb: TQuery
    DatabaseName = 'DBGASCONSOLA'
    SQL.Strings = (
      'select * from DPVGCONS'
      'where (estatus=:pestatus or estatus=:pestatus2)'
      'and poscarga>0')
    Left = 168
    Top = 248
    ParamData = <
      item
        DataType = ftString
        Name = 'pestatus'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'pestatus2'
        ParamType = ptUnknown
      end>
    object Q_ConsIbPOSCARGA: TIntegerField
      FieldName = 'POSCARGA'
      Origin = 'DBGASCONSOLA.DPVGCONS.POSCARGA'
    end
    object Q_ConsIbMONVOL: TStringField
      FieldName = 'MONVOL'
      Origin = 'DBGASCONSOLA.DPVGCONS.MONVOL'
      Size = 1
    end
    object Q_ConsIbVALOR: TFloatField
      FieldName = 'VALOR'
      Origin = 'DBGASCONSOLA.DPVGCONS.VALOR'
    end
    object Q_ConsIbESTATUS: TStringField
      FieldName = 'ESTATUS'
      Origin = 'DBGASCONSOLA.DPVGCONS.ESTATUS'
      Size = 1
    end
    object Q_ConsIbPOSICION: TIntegerField
      FieldName = 'POSICION'
      Origin = 'DBGASCONSOLA.DPVGCONS.POSICION'
    end
    object Q_ConsIbVOLUMEN: TFloatField
      FieldName = 'VOLUMEN'
      Origin = 'DBGASCONSOLA.DPVGCONS.VOLUMEN'
    end
    object Q_ConsIbPRECIO: TFloatField
      FieldName = 'PRECIO'
      Origin = 'DBGASCONSOLA.DPVGCONS.PRECIO'
    end
    object Q_ConsIbIMPORTE: TFloatField
      FieldName = 'IMPORTE'
      Origin = 'DBGASCONSOLA.DPVGCONS.IMPORTE'
    end
    object Q_ConsIbCOMBUSTIBLE: TStringField
      FieldName = 'COMBUSTIBLE'
      Origin = 'DBGASCONSOLA.DPVGCONS.COMBUSTIBLE'
    end
    object Q_ConsIbFOLIO: TIntegerField
      FieldName = 'FOLIO'
      Origin = 'DBGASCONSOLA.DPVGCONS.FOLIO'
    end
    object Q_ConsIbVALOR2: TFloatField
      FieldName = 'VALOR2'
      Origin = 'DBGASCONSOLA.DPVGCONS.VALOR2'
    end
    object Q_ConsIbESTADO: TIntegerField
      FieldName = 'ESTADO'
      Origin = 'DBGASCONSOLA.DPVGCONS.ESTADO'
    end
    object Q_ConsIbOTROS: TStringField
      FieldName = 'OTROS'
      Origin = 'DBGASCONSOLA.DPVGCONS.OTROS'
      FixedChar = True
      Size = 200
    end
    object Q_ConsIbARO: TSmallintField
      FieldName = 'ARO'
      Origin = 'DBGASCONSOLA.DPVGCONS.ARO'
    end
    object Q_ConsIbTIPOPAGO: TIntegerField
      FieldName = 'TIPOPAGO'
      Origin = 'DBGASCONSOLA.DPVGCONS.TIPOPAGO'
    end
  end
  object Q_Cons2Ib: TQuery
    DatabaseName = 'DBGASCONSOLA'
    SQL.Strings = (
      'select * from DPVGCONS'
      'where estatus=:pestatus or estatus=:pestatus2')
    Left = 224
    Top = 248
    ParamData = <
      item
        DataType = ftString
        Name = 'pestatus'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'pestatus2'
        ParamType = ptUnknown
      end>
    object Q_Cons2IbPOSCARGA: TIntegerField
      FieldName = 'POSCARGA'
      Origin = 'DBGASCONSOLA.DPVGCONS.POSCARGA'
    end
    object Q_Cons2IbMONVOL: TStringField
      FieldName = 'MONVOL'
      Origin = 'DBGASCONSOLA.DPVGCONS.MONVOL'
      Size = 1
    end
    object Q_Cons2IbVALOR: TFloatField
      FieldName = 'VALOR'
      Origin = 'DBGASCONSOLA.DPVGCONS.VALOR'
    end
    object Q_Cons2IbESTATUS: TStringField
      FieldName = 'ESTATUS'
      Origin = 'DBGASCONSOLA.DPVGCONS.ESTATUS'
      Size = 1
    end
    object Q_Cons2IbPOSICION: TIntegerField
      FieldName = 'POSICION'
      Origin = 'DBGASCONSOLA.DPVGCONS.POSICION'
    end
    object Q_Cons2IbVOLUMEN: TFloatField
      FieldName = 'VOLUMEN'
      Origin = 'DBGASCONSOLA.DPVGCONS.VOLUMEN'
    end
    object Q_Cons2IbPRECIO: TFloatField
      FieldName = 'PRECIO'
      Origin = 'DBGASCONSOLA.DPVGCONS.PRECIO'
    end
    object Q_Cons2IbIMPORTE: TFloatField
      FieldName = 'IMPORTE'
      Origin = 'DBGASCONSOLA.DPVGCONS.IMPORTE'
    end
    object Q_Cons2IbCOMBUSTIBLE: TStringField
      FieldName = 'COMBUSTIBLE'
      Origin = 'DBGASCONSOLA.DPVGCONS.COMBUSTIBLE'
    end
  end
  object T_TranIb: TTable
    DatabaseName = 'DBGASCONSOLA'
    TableName = 'DPVGTRAN'
    Left = 96
    Top = 304
    object T_TranIbTIPOVENTA: TStringField
      FieldName = 'TIPOVENTA'
      Size = 2
    end
    object T_TranIbFOLIO: TIntegerField
      FieldName = 'FOLIO'
    end
    object T_TranIbHORA: TDateTimeField
      FieldName = 'HORA'
    end
    object T_TranIbCLIENTE: TIntegerField
      Alignment = taLeftJustify
      FieldName = 'CLIENTE'
      DisplayFormat = '000000'
      EditFormat = '000000'
      AttributeSet = 'Folio6NR'
    end
    object T_TranIbVEHICULO: TIntegerField
      FieldName = 'VEHICULO'
      DisplayFormat = '000'
      EditFormat = '000'
      AttributeSet = 'Folio3NR'
    end
    object T_TranIbPOSCARGA: TIntegerField
      FieldName = 'POSCARGA'
    end
    object T_TranIbCOMBUSTIBLE: TIntegerField
      FieldName = 'COMBUSTIBLE'
    end
    object T_TranIbLITROS: TFloatField
      FieldName = 'LITROS'
      DisplayFormat = '###,###,##0.00'
      EditFormat = '########0.00'
      AttributeSet = 'ImpMoneda'
    end
    object T_TranIbTOTAL: TFloatField
      FieldName = 'TOTAL'
      DisplayFormat = '###,###,##0.00'
      EditFormat = '########0.00'
      AttributeSet = 'ImpMoneda'
    end
  end
  object T_EmprIb: TTable
    DatabaseName = 'DBGASCONSOLA'
    TableName = 'DGENEMPR'
    Left = 24
    Top = 360
    object T_EmprIbCLAVE: TIntegerField
      FieldName = 'CLAVE'
    end
    object T_EmprIbRAZONSOCIAL: TStringField
      FieldName = 'RAZONSOCIAL'
      Size = 50
    end
    object T_EmprIbREVISION: TStringField
      FieldName = 'REVISION'
      Size = 6
    end
    object T_EmprIbFECHAREV: TDateTimeField
      FieldName = 'FECHAREV'
    end
    object T_EmprIbTIPO: TStringField
      FieldName = 'TIPO'
      Size = 10
    end
    object T_EmprIbSERIEKEY: TIntegerField
      FieldName = 'SERIEKEY'
    end
    object T_EmprIbNOMCOMERCIAL: TStringField
      FieldName = 'NOMCOMERCIAL'
      Size = 50
    end
    object T_EmprIbDIRECCION: TStringField
      FieldName = 'DIRECCION'
      Size = 50
    end
    object T_EmprIbPOBLACION: TStringField
      FieldName = 'POBLACION'
      Size = 50
    end
    object T_EmprIbRFC: TStringField
      FieldName = 'RFC'
      Size = 16
    end
    object T_EmprIbCLAVESUPER: TStringField
      FieldName = 'CLAVESUPER'
    end
    object T_EmprIbCLAVEDIA: TStringField
      FieldName = 'CLAVEDIA'
      Size = 8
    end
    object T_EmprIbFORMATOCTAS: TStringField
      FieldName = 'FORMATOCTAS'
      Size = 5
    end
    object T_EmprIbTIPOLICENCIA: TStringField
      FieldName = 'TIPOLICENCIA'
      Size = 15
    end
    object T_EmprIbMANTENIMIENTO: TStringField
      FieldName = 'MANTENIMIENTO'
      Size = 2
    end
    object T_EmprIbCONSOLA: TMemoField
      FieldName = 'CONSOLA'
      BlobType = ftMemo
      Size = 1
    end
    object T_EmprIbCLIENTEPEMEX: TStringField
      FieldName = 'CLIENTEPEMEX'
      Size = 10
    end
    object T_EmprIbULTIMA_ACTUALIZACION: TDateTimeField
      FieldName = 'ULTIMA_ACTUALIZACION'
    end
    object T_EmprIbULTIMO_RESPALDO: TDateTimeField
      FieldName = 'ULTIMO_RESPALDO'
    end
    object T_EmprIbESTACION_IGAS: TIntegerField
      FieldName = 'ESTACION_IGAS'
    end
  end
  object T_EstsIb: TTable
    DatabaseName = 'DBGASCONSOLA'
    TableName = 'DPVGESTS'
    Left = 96
    Top = 368
    object T_EstsIbCLAVE: TIntegerField
      FieldName = 'CLAVE'
    end
    object T_EstsIbNOMBRE: TStringField
      FieldName = 'NOMBRE'
      Size = 40
    end
    object T_EstsIbCONSOLA: TMemoField
      FieldName = 'CONSOLA'
      BlobType = ftMemo
      Size = 1
    end
    object T_EstsIbTIPODISPENSARIO: TIntegerField
      FieldName = 'TIPODISPENSARIO'
    end
    object T_EstsIbTIPOTANQUES: TIntegerField
      FieldName = 'TIPOTANQUES'
    end
    object T_EstsIbNUMEROESTACION: TStringField
      FieldName = 'NUMEROESTACION'
      Size = 6
    end
  end
  object Q_BombIb: TQuery
    DatabaseName = 'DBGASCONSOLA'
    SQL.Strings = (
      'select isla,poscarga,combustible,manguera,con_precio,'
      
        '          con_posicion,con_digitoajuste,digitoajusteprecio,modoo' +
        'peracion,digitoajustevol,'
      
        '          digitosgilbarco,decimalesgilbarco,digitoajustepreset,c' +
        'ampolectura,'
      '          team_nodisp,team_lado,hj_addr,hj_lado,impretarjetas'
      'from dpvgbomb'
      'where poscarga>=1 and poscarga<=99 and Activo='#39'Si'#39
      'order by poscarga,con_posicion'
      '')
    Left = 168
    Top = 368
    object Q_BombIbISLA: TIntegerField
      FieldName = 'ISLA'
    end
    object Q_BombIbPOSCARGA: TIntegerField
      FieldName = 'POSCARGA'
    end
    object Q_BombIbCOMBUSTIBLE: TIntegerField
      FieldName = 'COMBUSTIBLE'
    end
    object Q_BombIbCON_PRECIO: TIntegerField
      FieldName = 'CON_PRECIO'
    end
    object Q_BombIbCON_POSICION: TIntegerField
      FieldName = 'CON_POSICION'
    end
    object Q_BombIbCON_DIGITOAJUSTE: TIntegerField
      FieldName = 'CON_DIGITOAJUSTE'
    end
    object Q_BombIbNombreComb: TStringField
      FieldKind = fkLookup
      FieldName = 'NombreComb'
      LookupDataSet = Q_CombIb
      LookupKeyFields = 'CLAVE'
      LookupResultField = 'NOMBRE'
      KeyFields = 'COMBUSTIBLE'
      Lookup = True
    end
    object Q_BombIbMANGUERA: TIntegerField
      FieldName = 'MANGUERA'
    end
    object Q_BombIbDIGITOAJUSTEPRECIO: TIntegerField
      FieldName = 'DIGITOAJUSTEPRECIO'
    end
    object Q_BombIbMODOOPERACION: TStringField
      FieldName = 'MODOOPERACION'
      Size = 8
    end
    object Q_BombIbDIGITOAJUSTEVOL: TIntegerField
      FieldName = 'DIGITOAJUSTEVOL'
    end
    object Q_BombIbDIGITOSGILBARCO: TIntegerField
      FieldName = 'DIGITOSGILBARCO'
    end
    object Q_BombIbDECIMALESGILBARCO: TIntegerField
      FieldName = 'DECIMALESGILBARCO'
    end
    object Q_BombIbDIGITOAJUSTEPRESET: TIntegerField
      FieldName = 'DIGITOAJUSTEPRESET'
    end
    object Q_BombIbCAMPOLECTURA: TStringField
      FieldName = 'CAMPOLECTURA'
      Size = 7
    end
    object Q_BombIbTEAM_NODISP: TIntegerField
      FieldName = 'TEAM_NODISP'
    end
    object Q_BombIbTEAM_LADO: TIntegerField
      FieldName = 'TEAM_LADO'
    end
    object Q_BombIbHJ_ADDR: TIntegerField
      FieldName = 'HJ_ADDR'
    end
    object Q_BombIbHJ_LADO: TIntegerField
      FieldName = 'HJ_LADO'
    end
    object Q_BombIbIMPRETARJETAS: TStringField
      FieldName = 'IMPRETARJETAS'
      Size = 40
    end
  end
  object Q_CombIb: TQuery
    DatabaseName = 'DBGASCONSOLA'
    SQL.Strings = (
      'select * from dpvgtcmb t'
      
        'where exists(select combustible from dpvgbomb where combustible=' +
        't.clave)'
      'order by clave')
    Left = 224
    Top = 368
    object Q_CombIbCLAVE: TIntegerField
      FieldName = 'CLAVE'
      Origin = 'DBGASCONSOLA.DPVGTCMB.CLAVE'
    end
    object Q_CombIbNOMBRE: TStringField
      FieldName = 'NOMBRE'
      Origin = 'DBGASCONSOLA.DPVGTCMB.NOMBRE'
      Size = 30
    end
    object Q_CombIbCLAVEPEMEX: TStringField
      FieldName = 'CLAVEPEMEX'
      Origin = 'DBGASCONSOLA.DPVGTCMB.CLAVEPEMEX'
      Size = 5
    end
    object Q_CombIbCON_PRODUCTOPRECIO: TStringField
      FieldName = 'CON_PRODUCTOPRECIO'
      Origin = 'DBGASCONSOLA.DPVGTCMB.CON_PRODUCTOPRECIO'
      Size = 6
    end
    object Q_CombIbPRECIOFISICO: TFloatField
      FieldName = 'PRECIOFISICO'
      Origin = 'DBGASCONSOLA.DPVGTCMB.PRECIOFISICO'
      DisplayFormat = '###,###,##0.00'
      EditFormat = '########0.00'
      AttributeSet = 'ImpMoneda'
    end
    object Q_CombIbAGRUPAR_CON: TIntegerField
      FieldName = 'AGRUPAR_CON'
      Origin = 'DBGASCONSOLA.DPVGTCMB.AGRUPAR_CON'
    end
    object Q_CombIbDIGITOAJUSTEPRECIO: TIntegerField
      FieldName = 'DIGITOAJUSTEPRECIO'
      Origin = 'DBGASCONSOLA.DPVGTCMB.DIGITOAJUSTEPRECIO'
    end
    object Q_CombIbTAG: TStringField
      FieldName = 'TAG'
      Origin = 'DBGASCONSOLA.DPVGTCMB.TAG'
      Size = 2
    end
    object Q_CombIbTAG2: TStringField
      FieldName = 'TAG2'
      Origin = 'DBGASCONSOLA.DPVGTCMB.TAG2'
      Size = 2
    end
    object Q_CombIbTAG3: TStringField
      FieldName = 'TAG3'
      Origin = 'DBGASCONSOLA.DPVGTCMB.TAG3'
      Size = 1
    end
  end
  object Q_Prec: TQuery
    DatabaseName = 'DBGASCONSOLA'
    SQL.Strings = (
      'select * from DPVGPREC'
      'where fechahora>=:pfecha'
      '   and aplicado='#39'No'#39
      '   and en_edicion='#39'No'#39
      '   and fechahora<=:phora'
      'order by combustible, fechahora')
    Left = 24
    Top = 416
    ParamData = <
      item
        DataType = ftDateTime
        Name = 'pfecha'
        ParamType = ptUnknown
      end
      item
        DataType = ftDateTime
        Name = 'phora'
        ParamType = ptUnknown
      end>
    object Q_PrecFECHAHORA: TDateTimeField
      FieldName = 'FECHAHORA'
      Origin = 'DBGASCONSOLA.DPVGPREC.FECHAHORA'
    end
    object Q_PrecCOMBUSTIBLE: TIntegerField
      FieldName = 'COMBUSTIBLE'
      Origin = 'DBGASCONSOLA.DPVGPREC.COMBUSTIBLE'
    end
    object Q_PrecPRECIO: TFloatField
      FieldName = 'PRECIO'
      Origin = 'DBGASCONSOLA.DPVGPREC.PRECIO'
    end
    object Q_PrecAPLICADO: TStringField
      FieldName = 'APLICADO'
      Origin = 'DBGASCONSOLA.DPVGPREC.APLICADO'
      Size = 2
    end
    object Q_PrecFOLIO: TIntegerField
      FieldName = 'FOLIO'
      Origin = 'DBGASCONSOLA.DPVGPREC.FOLIO'
    end
    object Q_PrecEN_EDICION: TStringField
      FieldName = 'EN_EDICION'
      Origin = 'DBGASCONSOLA.DPVGPREC.EN_EDICION'
      Size = 2
    end
    object Q_PrecERROR: TStringField
      FieldName = 'ERROR'
      Origin = 'DBGASCONSOLA.DPVGPREC.ERROR'
      Size = 2
    end
  end
  object Q_AplicaPrecioF: TQuery
    DatabaseName = 'DBGASCONSOLA'
    SQL.Strings = (
      'UPDATE DPVGPREC SET APLICADO="Si", ERROR=:PERROR'
      'WHERE FOLIO=:PFOLIO'
      '      AND COMBUSTIBLE=:PCOMBUSTIBLE')
    Left = 96
    Top = 416
    ParamData = <
      item
        DataType = ftString
        Name = 'PERROR'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'PFOLIO'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'PCOMBUSTIBLE'
        ParamType = ptUnknown
      end>
  end
  object T_Tanq: TTable
    DatabaseName = 'DBGASCONSOLA'
    TableName = 'DPVGTANQ'
    Left = 376
    Top = 80
    object T_TanqTANQUE: TIntegerField
      FieldName = 'TANQUE'
    end
    object T_TanqCOMBUSTIBLE: TIntegerField
      FieldName = 'COMBUSTIBLE'
    end
    object T_TanqCLAVEPRODUCTOMEDICION: TStringField
      FieldName = 'CLAVEPRODUCTOMEDICION'
      Size = 5
    end
    object T_TanqVOLUMENFONDAJE: TFloatField
      FieldName = 'VOLUMENFONDAJE'
    end
    object T_TanqCAPACIDAD: TFloatField
      FieldName = 'CAPACIDAD'
    end
    object T_TanqALTURA: TFloatField
      FieldName = 'ALTURA'
    end
    object T_TanqNombreComb: TStringField
      FieldKind = fkLookup
      FieldName = 'NombreComb'
      LookupDataSet = Q_CombIb
      LookupKeyFields = 'CLAVE'
      LookupResultField = 'NOMBRE'
      KeyFields = 'COMBUSTIBLE'
      Lookup = True
    end
    object T_TanqACTIVO: TStringField
      FieldName = 'ACTIVO'
      Size = 2
    end
  end
  object Q_Cvol: TQuery
    AfterOpen = Q_CvolAfterOpen
    BeforeClose = Q_CvolBeforeClose
    OnCalcFields = Q_CvolCalcFields
    DatabaseName = 'DBGASCONSOLA'
    SQL.Strings = (
      'select first 1 * from DPVGCVOL'
      'where estatus='#39'A'#39
      'order by FechaHoraInicial Desc')
    Left = 752
    Top = 16
    object Q_CvolFECHA: TDateTimeField
      FieldName = 'FECHA'
      Origin = 'GASCONSOLAIMAGEN.DPVGCVOL.FECHA'
    end
    object Q_CvolCORTE: TIntegerField
      FieldName = 'CORTE'
      Origin = 'GASCONSOLAIMAGEN.DPVGCVOL.CORTE'
    end
    object Q_CvolFECHAHORAINICIAL: TDateTimeField
      FieldName = 'FECHAHORAINICIAL'
      Origin = 'GASCONSOLAIMAGEN.DPVGCVOL.FECHAHORAINICIAL'
    end
    object Q_CvolFECHAHORAFINAL: TDateTimeField
      FieldName = 'FECHAHORAFINAL'
      Origin = 'GASCONSOLAIMAGEN.DPVGCVOL.FECHAHORAFINAL'
    end
    object Q_CvolESTATUS: TStringField
      FieldName = 'ESTATUS'
      Origin = 'GASCONSOLAIMAGEN.DPVGCVOL.ESTATUS'
      Size = 1
    end
    object Q_CvolGENERADO: TStringField
      FieldName = 'GENERADO'
      Origin = 'GASCONSOLAIMAGEN.DPVGCVOL.GENERADO'
      Size = 2
    end
    object Q_CvolDescripCorte: TStringField
      FieldKind = fkCalculated
      FieldName = 'DescripCorte'
      Size = 40
      Calculated = True
    end
  end
  object T_Cvolt: TTable
    DatabaseName = 'DBGASCONSOLA'
    IndexFieldNames = 'FECHA;CORTE'
    MasterFields = 'FECHA;CORTE'
    MasterSource = DSQ_Cvol
    TableName = 'DPVGCVOLT'
    Left = 825
    Top = 17
    object T_CvoltFECHA: TDateTimeField
      FieldName = 'FECHA'
    end
    object T_CvoltCORTE: TIntegerField
      FieldName = 'CORTE'
    end
    object T_CvoltTANQUE: TIntegerField
      Alignment = taLeftJustify
      FieldName = 'TANQUE'
      DisplayFormat = '00'
      EditFormat = '00'
      AttributeSet = 'Folio2NR'
    end
    object T_CvoltFECHAHORA: TDateTimeField
      FieldName = 'FECHAHORA'
    end
    object T_CvoltCOMBUSTIBLE: TIntegerField
      FieldName = 'COMBUSTIBLE'
    end
    object T_CvoltVOLUMEN: TFloatField
      FieldName = 'VOLUMEN'
      DisplayFormat = '###,###,##0.00'
      EditFormat = '########0.00'
      AttributeSet = 'ImpMoneda'
    end
    object T_CvoltPORLLENAR: TFloatField
      FieldName = 'PORLLENAR'
    end
    object T_CvoltNIVEL: TFloatField
      FieldName = 'NIVEL'
    end
    object T_CvoltVOLUMENAGUA: TFloatField
      FieldName = 'VOLUMENAGUA'
    end
    object T_CvoltTEMPERATURA: TFloatField
      FieldName = 'TEMPERATURA'
      DisplayFormat = '###,###,##0.00'
      EditFormat = '########0.00'
      AttributeSet = 'ImpMoneda'
    end
    object T_CvoltVOLUMENFONDAJE: TFloatField
      FieldName = 'VOLUMENFONDAJE'
    end
    object T_CvoltVOLUMENUTIL: TFloatField
      FieldName = 'VOLUMENUTIL'
      ReadOnly = True
    end
    object T_CvoltNombreComb: TStringField
      FieldKind = fkLookup
      FieldName = 'NombreComb'
      LookupDataSet = Q_CombIb
      LookupKeyFields = 'CLAVE'
      LookupResultField = 'NOMBRE'
      KeyFields = 'COMBUSTIBLE'
      Lookup = True
    end
  end
  object DSQ_Cvol: TDataSource
    DataSet = Q_Cvol
    Left = 752
    Top = 80
  end
  object T_Etan: TTable
    DatabaseName = 'DBGASCONSOLA'
    TableName = 'DPVGETAN'
    Left = 448
    Top = 88
    object T_EtanFOLIO: TIntegerField
      FieldName = 'FOLIO'
    end
    object T_EtanFECHA: TDateTimeField
      FieldName = 'FECHA'
    end
    object T_EtanCORTE: TIntegerField
      FieldName = 'CORTE'
    end
    object T_EtanTANQUE: TIntegerField
      FieldName = 'TANQUE'
    end
    object T_EtanCOMBUSTIBLE: TIntegerField
      FieldName = 'COMBUSTIBLE'
    end
    object T_EtanVOLUMENINICIAL: TFloatField
      FieldName = 'VOLUMENINICIAL'
    end
    object T_EtanVOLUMENFINAL: TFloatField
      FieldName = 'VOLUMENFINAL'
    end
    object T_EtanVOLUMENRECEPCION: TFloatField
      FieldName = 'VOLUMENRECEPCION'
    end
    object T_EtanTEMPERATURA: TFloatField
      FieldName = 'TEMPERATURA'
    end
    object T_EtanTERMINALDIST: TStringField
      FieldName = 'TERMINALDIST'
      Size = 4
    end
    object T_EtanTIPODOC: TStringField
      FieldName = 'TIPODOC'
      Size = 2
    end
    object T_EtanFECHADOC: TDateTimeField
      FieldName = 'FECHADOC'
    end
    object T_EtanFOLIODOC: TStringField
      FieldName = 'FOLIODOC'
      Size = 8
    end
    object T_EtanVOLUMENDOC: TFloatField
      FieldName = 'VOLUMENDOC'
    end
    object T_EtanFECHAHORAINICIAL: TDateTimeField
      FieldName = 'FECHAHORAINICIAL'
    end
    object T_EtanFECHAHORAFINAL: TDateTimeField
      FieldName = 'FECHAHORAFINAL'
    end
    object T_EtanDATOSADICIONALES: TStringField
      FieldName = 'DATOSADICIONALES'
      Size = 2
    end
    object T_EtanFECHAHORADISP: TStringField
      FieldName = 'FECHAHORADISP'
      Size = 10
    end
  end
  object SP_Corte: TStoredProc
    DatabaseName = 'DBGASCONSOLA'
    StoredProcName = 'CVOL_REALIZA_CORTE'
    Left = 512
    Top = 88
    ParamData = <
      item
        DataType = ftDateTime
        Name = 'P_FECHA'
        ParamType = ptInput
      end>
  end
  object DST_Cvolt: TDataSource
    DataSet = T_Cvolt
    Left = 832
    Top = 64
  end
  object Q_Etan: TQuery
    DatabaseName = 'DBGASCONSOLA'
    DataSource = DSQ_Cvol
    SQL.Strings = (
      'select * from DPVGETAN'
      'where fecha=:fecha'
      '    and corte=:corte'
      'order by FechaHoraDisp')
    Left = 944
    Top = 24
    ParamData = <
      item
        DataType = ftDateTime
        Name = 'FECHA'
        ParamType = ptUnknown
        Size = 8
      end
      item
        DataType = ftInteger
        Name = 'CORTE'
        ParamType = ptUnknown
        Size = 4
      end>
    object Q_EtanFOLIO: TIntegerField
      FieldName = 'FOLIO'
      Origin = 'DBGASCONSOLA.DPVGETAN.FOLIO'
    end
    object Q_EtanFECHA: TDateTimeField
      FieldName = 'FECHA'
      Origin = 'DBGASCONSOLA.DPVGETAN.FECHA'
    end
    object Q_EtanCORTE: TIntegerField
      FieldName = 'CORTE'
      Origin = 'DBGASCONSOLA.DPVGETAN.CORTE'
    end
    object Q_EtanTANQUE: TIntegerField
      Alignment = taLeftJustify
      FieldName = 'TANQUE'
      Origin = 'DBGASCONSOLA.DPVGETAN.TANQUE'
      DisplayFormat = '00'
      EditFormat = '00'
      AttributeSet = 'Folio2NR'
    end
    object Q_EtanCOMBUSTIBLE: TIntegerField
      FieldName = 'COMBUSTIBLE'
      Origin = 'DBGASCONSOLA.DPVGETAN.COMBUSTIBLE'
    end
    object Q_EtanVOLUMENINICIAL: TFloatField
      FieldName = 'VOLUMENINICIAL'
      Origin = 'DBGASCONSOLA.DPVGETAN.VOLUMENINICIAL'
    end
    object Q_EtanVOLUMENFINAL: TFloatField
      FieldName = 'VOLUMENFINAL'
      Origin = 'DBGASCONSOLA.DPVGETAN.VOLUMENFINAL'
    end
    object Q_EtanVOLUMENRECEPCION: TFloatField
      FieldName = 'VOLUMENRECEPCION'
      Origin = 'DBGASCONSOLA.DPVGETAN.VOLUMENRECEPCION'
      DisplayFormat = '###,###,##0.00'
      EditFormat = '########0.00'
      AttributeSet = 'ImpMoneda'
    end
    object Q_EtanTEMPERATURA: TFloatField
      FieldName = 'TEMPERATURA'
      Origin = 'DBGASCONSOLA.DPVGETAN.TEMPERATURA'
    end
    object Q_EtanTERMINALDIST: TStringField
      FieldName = 'TERMINALDIST'
      Origin = 'DBGASCONSOLA.DPVGETAN.TERMINALDIST'
      Size = 4
    end
    object Q_EtanTIPODOC: TStringField
      FieldName = 'TIPODOC'
      Origin = 'DBGASCONSOLA.DPVGETAN.TIPODOC'
      Size = 2
    end
    object Q_EtanFECHADOC: TDateTimeField
      FieldName = 'FECHADOC'
      Origin = 'DBGASCONSOLA.DPVGETAN.FECHADOC'
    end
    object Q_EtanFOLIODOC: TStringField
      FieldName = 'FOLIODOC'
      Origin = 'DBGASCONSOLA.DPVGETAN.FOLIODOC'
      Size = 8
    end
    object Q_EtanVOLUMENDOC: TFloatField
      FieldName = 'VOLUMENDOC'
      Origin = 'DBGASCONSOLA.DPVGETAN.VOLUMENDOC'
    end
    object Q_EtanFECHAHORAINICIAL: TDateTimeField
      FieldName = 'FECHAHORAINICIAL'
      Origin = 'DBGASCONSOLA.DPVGETAN.FECHAHORAINICIAL'
    end
    object Q_EtanFECHAHORAFINAL: TDateTimeField
      FieldName = 'FECHAHORAFINAL'
      Origin = 'DBGASCONSOLA.DPVGETAN.FECHAHORAFINAL'
      DisplayFormat = 'dd/mm/yyyy hh:nn'
      EditMask = '!99/99/0000;1;_'
      AttributeSet = 'Fecha'
    end
    object Q_EtanDATOSADICIONALES: TStringField
      FieldName = 'DATOSADICIONALES'
      Origin = 'DBGASCONSOLA.DPVGETAN.DATOSADICIONALES'
      Size = 2
    end
    object Q_EtanFECHAHORADISP: TStringField
      FieldName = 'FECHAHORADISP'
      Origin = 'DBGASCONSOLA.DPVGETAN.FECHAHORADISP'
      Size = 10
    end
    object Q_EtanFECHAHORA: TDateTimeField
      FieldName = 'FECHAHORA'
      Origin = 'DBGASCONSOLA.DPVGETAN.FECHAHORA'
    end
    object Q_EtanNombreComb: TStringField
      FieldKind = fkLookup
      FieldName = 'NombreComb'
      LookupDataSet = Q_CombIb
      LookupKeyFields = 'CLAVE'
      LookupResultField = 'NOMBRE'
      KeyFields = 'COMBUSTIBLE'
      Lookup = True
    end
  end
  object DSQ_Etan: TDataSource
    DataSet = Q_Etan
    Left = 944
    Top = 75
  end
  object Q_Ctan: TQuery
    OnCalcFields = Q_CvolCalcFields
    DatabaseName = 'DBGASCONSOLA'
    SQL.Strings = (
      'select * from DPVGCTAN'
      'where tanque=:ptanque'
      'order by FechaHora Desc')
    Left = 648
    Top = 320
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ptanque'
        ParamType = ptUnknown
      end>
    object Q_CtanFOLIO: TIntegerField
      FieldName = 'FOLIO'
      Origin = 'DBGASCONSOLA.DPVGCTAN.FOLIO'
    end
    object Q_CtanFECHA: TDateTimeField
      FieldName = 'FECHA'
      Origin = 'DBGASCONSOLA.DPVGCTAN.FECHA'
    end
    object Q_CtanCORTE: TIntegerField
      FieldName = 'CORTE'
      Origin = 'DBGASCONSOLA.DPVGCTAN.CORTE'
    end
    object Q_CtanTANQUE: TIntegerField
      FieldName = 'TANQUE'
      Origin = 'DBGASCONSOLA.DPVGCTAN.TANQUE'
    end
    object Q_CtanFECHAHORA: TDateTimeField
      FieldName = 'FECHAHORA'
      Origin = 'DBGASCONSOLA.DPVGCTAN.FECHAHORA'
    end
    object Q_CtanCOMBUSTIBLE: TIntegerField
      FieldName = 'COMBUSTIBLE'
      Origin = 'DBGASCONSOLA.DPVGCTAN.COMBUSTIBLE'
    end
    object Q_CtanNUEVOESTADO: TStringField
      FieldName = 'NUEVOESTADO'
      Origin = 'DBGASCONSOLA.DPVGCTAN.NUEVOESTADO'
      Size = 1
    end
  end
  object T_Ctan: TTable
    OnCalcFields = T_CtanCalcFields
    DatabaseName = 'DBGASCONSOLA'
    IndexFieldNames = 'FECHA;CORTE'
    MasterFields = 'FECHA;CORTE'
    MasterSource = DSQ_Cvol
    TableName = 'DPVGCTAN'
    Left = 840
    Top = 144
    object T_CtanFOLIO: TIntegerField
      Alignment = taLeftJustify
      FieldName = 'FOLIO'
      DisplayFormat = '00'
      EditFormat = '00'
      AttributeSet = 'Folio2NR'
    end
    object T_CtanFECHA: TDateTimeField
      FieldName = 'FECHA'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!99/99/0000;1;_'
      AttributeSet = 'Fecha'
    end
    object T_CtanCORTE: TIntegerField
      Alignment = taLeftJustify
      FieldName = 'CORTE'
      DisplayFormat = '00'
      EditFormat = '00'
      AttributeSet = 'Folio2NR'
    end
    object T_CtanTANQUE: TIntegerField
      Alignment = taLeftJustify
      FieldName = 'TANQUE'
      DisplayFormat = '00'
      EditFormat = '00'
      AttributeSet = 'Folio2NR'
    end
    object T_CtanFECHAHORA: TDateTimeField
      FieldName = 'FECHAHORA'
      DisplayFormat = 'dd/mm/yyyy hh:nn'
      EditMask = '!99/99/0000;1;_'
      AttributeSet = 'Fecha'
    end
    object T_CtanCOMBUSTIBLE: TIntegerField
      FieldName = 'COMBUSTIBLE'
    end
    object T_CtanNUEVOESTADO: TStringField
      FieldName = 'NUEVOESTADO'
      Size = 1
    end
    object T_CtanNombreComb: TStringField
      FieldKind = fkLookup
      FieldName = 'NombreComb'
      LookupDataSet = Q_CombIb
      LookupKeyFields = 'CLAVE'
      LookupResultField = 'NOMBRE'
      KeyFields = 'COMBUSTIBLE'
      Lookup = True
    end
    object T_CtanDescEstado: TStringField
      FieldKind = fkCalculated
      FieldName = 'DescEstado'
      Size = 12
      Calculated = True
    end
  end
  object DST_Ctan: TDataSource
    DataSet = T_Ctan
    Left = 840
    Top = 200
  end
  object Q_Movi: TQuery
    DatabaseName = 'DBGASCONSOLA'
    DataSource = DSQ_Cvol
    SQL.Strings = (
      'select * from DPVGMOVI'
      'where fecha=:fecha and corte=:corte'
      'order by hora')
    Left = 944
    Top = 144
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'fecha'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'corte'
        ParamType = ptUnknown
      end>
    object Q_MoviFOLIO: TIntegerField
      FieldName = 'FOLIO'
      Origin = 'DBGASCONSOLA.DPVGMOVI.FOLIO'
    end
    object Q_MoviFECHA: TDateTimeField
      FieldName = 'FECHA'
      Origin = 'DBGASCONSOLA.DPVGMOVI.FECHA'
    end
    object Q_MoviHORA: TDateTimeField
      FieldName = 'HORA'
      Origin = 'DBGASCONSOLA.DPVGMOVI.HORA'
      DisplayFormat = 'hh:nn'
      EditMask = '!99/99/0000;1;_'
      AttributeSet = 'Fecha'
    end
    object Q_MoviPOSCARGA: TIntegerField
      Alignment = taLeftJustify
      FieldName = 'POSCARGA'
      Origin = 'DBGASCONSOLA.DPVGMOVI.POSCARGA'
      DisplayFormat = '00'
      EditFormat = '00'
      AttributeSet = 'Folio2NR'
    end
    object Q_MoviCOMBUSTIBLE: TIntegerField
      FieldName = 'COMBUSTIBLE'
      Origin = 'DBGASCONSOLA.DPVGMOVI.COMBUSTIBLE'
    end
    object Q_MoviVOLUMEN: TFloatField
      FieldName = 'VOLUMEN'
      Origin = 'DBGASCONSOLA.DPVGMOVI.VOLUMEN'
      DisplayFormat = '###,###,##0.00'
      EditFormat = '########0.00'
      AttributeSet = 'ImpMoneda'
    end
    object Q_MoviIMPORTE: TFloatField
      FieldName = 'IMPORTE'
      Origin = 'DBGASCONSOLA.DPVGMOVI.IMPORTE'
      DisplayFormat = '###,###,##0.00'
      EditFormat = '########0.00'
      AttributeSet = 'ImpMoneda'
    end
    object Q_MoviIMPRESO: TStringField
      FieldName = 'IMPRESO'
      Origin = 'DBGASCONSOLA.DPVGMOVI.IMPRESO'
      Size = 2
    end
    object Q_MoviTRANSACCION: TIntegerField
      FieldName = 'TRANSACCION'
      Origin = 'DBGASCONSOLA.DPVGMOVI.TRANSACCION'
    end
    object Q_MoviTARJETA: TStringField
      FieldName = 'TARJETA'
      Origin = 'DBGASCONSOLA.DPVGMOVI.TARJETA'
      Size = 16
    end
    object Q_MoviKILOMETRAJE: TIntegerField
      FieldName = 'KILOMETRAJE'
      Origin = 'DBGASCONSOLA.DPVGMOVI.KILOMETRAJE'
    end
    object Q_MoviAPLICAR: TStringField
      FieldName = 'APLICAR'
      Origin = 'DBGASCONSOLA.DPVGMOVI.APLICAR'
      Size = 2
    end
    object Q_MoviHORASTR: TStringField
      FieldName = 'HORASTR'
      Origin = 'DBGASCONSOLA.DPVGMOVI.HORASTR'
      Size = 8
    end
    object Q_MoviFECHACORTE: TDateTimeField
      FieldName = 'FECHACORTE'
      Origin = 'DBGASCONSOLA.DPVGMOVI.FECHACORTE'
    end
    object Q_MoviCORTE: TIntegerField
      FieldName = 'CORTE'
      Origin = 'DBGASCONSOLA.DPVGMOVI.CORTE'
    end
    object Q_MoviNombreComb: TStringField
      FieldKind = fkLookup
      FieldName = 'NombreComb'
      LookupDataSet = Q_CombIb
      LookupKeyFields = 'CLAVE'
      LookupResultField = 'NOMBRE'
      KeyFields = 'COMBUSTIBLE'
      Lookup = True
    end
  end
  object DSQ_Movi: TDataSource
    DataSet = Q_Movi
    Left = 944
    Top = 200
  end
  object T_Logs: TTable
    DatabaseName = 'DBGASCONSOLA'
    TableName = 'DPVGLOGS'
    Left = 496
    Top = 200
    object T_LogsMODULO: TStringField
      FieldName = 'MODULO'
      Size = 4
    end
    object T_LogsFECHAHORAINICIAL: TDateTimeField
      FieldName = 'FECHAHORAINICIAL'
    end
    object T_LogsFECHAHORAFINAL: TDateTimeField
      FieldName = 'FECHAHORAFINAL'
    end
  end
  object Q_Auxi: TQuery
    AfterClose = Q_AuxiAfterClose
    DatabaseName = 'DBGASCONSOLA'
    SQL.Strings = (
      'select * from dgenempr')
    Left = 99
    Top = 24
    object Q_AuxiReal1: TFloatField
      FieldKind = fkCalculated
      FieldName = 'Real1'
      Calculated = True
    end
    object Q_AuxiReal2: TFloatField
      FieldKind = fkCalculated
      FieldName = 'Real2'
      Calculated = True
    end
    object Q_AuxiReal3: TFloatField
      FieldKind = fkCalculated
      FieldName = 'Real3'
      Calculated = True
    end
    object Q_AuxiReal4: TFloatField
      FieldKind = fkCalculated
      FieldName = 'Real4'
      Calculated = True
    end
    object Q_AuxiReal5: TFloatField
      FieldKind = fkCalculated
      FieldName = 'Real5'
      Calculated = True
    end
    object Q_AuxiReal6: TFloatField
      FieldKind = fkCalculated
      FieldName = 'Real6'
      Calculated = True
    end
    object Q_AuxiEntero1: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'Entero1'
      Calculated = True
    end
    object Q_AuxiEntero2: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'Entero2'
      Calculated = True
    end
    object Q_AuxiEntero3: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'Entero3'
      Calculated = True
    end
    object Q_AuxiChar1: TStringField
      FieldKind = fkCalculated
      FieldName = 'Char1'
      Size = 1
      Calculated = True
    end
    object Q_AuxiStr10: TStringField
      FieldKind = fkCalculated
      FieldName = 'Str10'
      Size = 10
      Calculated = True
    end
    object Q_AuxiStr10_2: TStringField
      FieldKind = fkCalculated
      FieldName = 'Str10_2'
      Size = 10
      Calculated = True
    end
    object Q_AuxiStr6_1: TStringField
      FieldKind = fkCalculated
      FieldName = 'Str6_1'
      Size = 6
      Calculated = True
    end
    object Q_AuxiStr6_2: TStringField
      FieldKind = fkCalculated
      FieldName = 'Str6_2'
      Size = 6
      Calculated = True
    end
    object Q_AuxiDate1: TDateTimeField
      FieldKind = fkCalculated
      FieldName = 'Date1'
      Calculated = True
    end
    object Q_AuxiStr20: TStringField
      FieldKind = fkCalculated
      FieldName = 'Str20'
      Calculated = True
    end
    object Q_AuxiStr255: TStringField
      FieldKind = fkCalculated
      FieldName = 'Str255'
      Size = 255
      Calculated = True
    end
  end
  object SP_DamePrec: TStoredProc
    DatabaseName = 'DBGASCONSOLA'
    StoredProcName = 'PREC_DAME'
    Left = 288
    Top = 368
    ParamData = <
      item
        DataType = ftInteger
        Name = 'PCOMBUST'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'PFECHAHORA'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'RPRECIO'
        ParamType = ptOutput
      end>
  end
  object DSQ_Comb: TDataSource
    DataSet = Q_CombIb
    Left = 224
    Top = 416
  end
  object T_Tcmb: TTable
    DatabaseName = 'DBGASCONSOLA'
    IndexFieldNames = 'CLAVE'
    TableName = 'DPVGTCMB'
    Left = 352
    Top = 368
    object T_TcmbCLAVE: TIntegerField
      FieldName = 'CLAVE'
    end
    object T_TcmbNOMBRE: TStringField
      FieldName = 'NOMBRE'
      Size = 30
    end
    object T_TcmbCLAVEPEMEX: TStringField
      FieldName = 'CLAVEPEMEX'
      Size = 5
    end
    object T_TcmbCON_PRODUCTOPRECIO: TStringField
      FieldName = 'CON_PRODUCTOPRECIO'
      Size = 6
    end
    object T_TcmbPRECIOFISICO: TFloatField
      FieldName = 'PRECIOFISICO'
    end
    object T_TcmbAGRUPAR_CON: TIntegerField
      FieldName = 'AGRUPAR_CON'
    end
    object T_TcmbDIGITOAJUSTEPRECIO: TIntegerField
      FieldName = 'DIGITOAJUSTEPRECIO'
    end
    object T_TcmbTAG: TStringField
      FieldName = 'TAG'
      Size = 2
    end
    object T_TcmbTAG2: TStringField
      FieldName = 'TAG2'
      Size = 2
    end
    object T_TcmbTAG3: TStringField
      FieldName = 'TAG3'
      Size = 1
    end
  end
  object Q_Cmnd: TQuery
    DatabaseName = 'DBGASCONSOLA'
    SQL.Strings = (
      'select * from DPVGCMND'
      'where aplicado='#39'No'#39
      '     and modulo=:pmodulo'
      'order by folio     ')
    Left = 552
    Top = 200
    ParamData = <
      item
        DataType = ftString
        Name = 'pmodulo'
        ParamType = ptUnknown
      end>
    object Q_CmndFOLIO: TIntegerField
      FieldName = 'FOLIO'
      Origin = 'DBGASCONSOLA.DPVGCMND.FOLIO'
    end
    object Q_CmndMODULO: TStringField
      FieldName = 'MODULO'
      Origin = 'DBGASCONSOLA.DPVGCMND.MODULO'
      Size = 4
    end
    object Q_CmndFECHAHORA: TDateTimeField
      FieldName = 'FECHAHORA'
      Origin = 'DBGASCONSOLA.DPVGCMND.FECHAHORA'
    end
    object Q_CmndCOMANDO: TStringField
      FieldName = 'COMANDO'
      Origin = 'DBGASCONSOLA.DPVGCMND.COMANDO'
      Size = 80
    end
    object Q_CmndAPLICADO: TStringField
      FieldName = 'APLICADO'
      Origin = 'DBGASCONSOLA.DPVGCMND.APLICADO'
      Size = 2
    end
    object Q_CmndRESULTADO: TStringField
      FieldName = 'RESULTADO'
      Origin = 'DBGASCONSOLA.DPVGCMND.RESULTADO'
      Size = 80
    end
  end
  object T_Cmnd: TTable
    DatabaseName = 'DBGASCONSOLA'
    TableName = 'DPVGCMND'
    Left = 600
    Top = 200
    object T_CmndFOLIO: TIntegerField
      FieldName = 'FOLIO'
    end
    object T_CmndMODULO: TStringField
      FieldName = 'MODULO'
      Size = 4
    end
    object T_CmndFECHAHORA: TDateTimeField
      FieldName = 'FECHAHORA'
    end
    object T_CmndCOMANDO: TStringField
      FieldName = 'COMANDO'
      Size = 80
    end
    object T_CmndAPLICADO: TStringField
      FieldName = 'APLICADO'
      Size = 2
    end
    object T_CmndRESULTADO: TStringField
      FieldName = 'RESULTADO'
      Size = 80
    end
  end
  object T_Bita: TTable
    DatabaseName = 'DBGASCONSOLA'
    TableName = 'DPVGBITA'
    Left = 651
    Top = 203
    object T_BitaFOLIO: TIntegerField
      FieldName = 'FOLIO'
    end
    object T_BitaFECHAHORA: TDateTimeField
      FieldName = 'FECHAHORA'
    end
    object T_BitaUSUARIO: TIntegerField
      FieldName = 'USUARIO'
    end
    object T_BitaOPERACION: TStringField
      FieldName = 'OPERACION'
      Size = 30
    end
    object T_BitaOBSERVACIONES: TMemoField
      FieldName = 'OBSERVACIONES'
      BlobType = ftMemo
      Size = 1
    end
    object T_BitaFECHA: TDateTimeField
      FieldName = 'FECHA'
    end
    object T_BitaTIPOSUCESO: TStringField
      FieldName = 'TIPOSUCESO'
      FixedChar = True
      Size = 1
    end
    object T_BitaTXT: TStringField
      FieldName = 'TXT'
      FixedChar = True
      Size = 1
    end
  end
  object T_Puer: TTable
    DatabaseName = 'DBGASCONSOLA'
    TableName = 'DPVGPUER'
    Left = 704
    Top = 200
    object T_PuerCLAVE: TStringField
      FieldName = 'CLAVE'
      Size = 4
    end
    object T_PuerNUMEROPUERTO: TIntegerField
      FieldName = 'NUMEROPUERTO'
    end
    object T_PuerVELOCIDAD: TIntegerField
      FieldName = 'VELOCIDAD'
    end
    object T_PuerPARIDAD: TStringField
      FieldName = 'PARIDAD'
      Size = 8
    end
    object T_PuerBITSDATOS: TIntegerField
      FieldName = 'BITSDATOS'
    end
    object T_PuerBITSPARO: TIntegerField
      FieldName = 'BITSPARO'
    end
  end
  object Q_Pcar: TQuery
    DatabaseName = 'DBGASCONSOLA'
    SQL.Strings = (
      'select * from DPVGPCAR'
      'order by poscarga')
    Left = 696
    Top = 320
    object Q_PcarPOSCARGA: TIntegerField
      FieldName = 'POSCARGA'
      Origin = 'DBGASCONSOLA.DPVGPCAR.POSCARGA'
    end
    object Q_PcarSLOWFLOW: TFloatField
      FieldName = 'SLOWFLOW'
      Origin = 'DBGASCONSOLA.DPVGPCAR.SLOWFLOW'
    end
    object Q_PcarSLOWFLOW2: TFloatField
      FieldName = 'SLOWFLOW2'
      Origin = 'DBGASCONSOLA.DPVGPCAR.SLOWFLOW2'
    end
    object Q_PcarSLOWFLOW3: TFloatField
      FieldName = 'SLOWFLOW3'
      Origin = 'DBGASCONSOLA.DPVGPCAR.SLOWFLOW3'
    end
  end
  object T_Cvold: TTable
    DatabaseName = 'DBGASCONSOLA'
    IndexFieldNames = 'FECHA;CORTE'
    MasterFields = 'FECHA;CORTE'
    MasterSource = DSQ_Cvol
    TableName = 'DPVGCVOLD'
    Left = 880
    Top = 17
    object T_CvoldFECHA: TDateTimeField
      FieldName = 'FECHA'
    end
    object T_CvoldCORTE: TIntegerField
      FieldName = 'CORTE'
    end
    object T_CvoldPOSCARGA: TIntegerField
      FieldName = 'POSCARGA'
    end
    object T_CvoldTOTAL01: TFloatField
      FieldName = 'TOTAL01'
    end
    object T_CvoldTOTAL02: TFloatField
      FieldName = 'TOTAL02'
    end
    object T_CvoldTOTAL03: TFloatField
      FieldName = 'TOTAL03'
    end
    object T_CvoldTOTAL04: TFloatField
      FieldName = 'TOTAL04'
    end
  end
  object T_Turc: TTable
    DatabaseName = 'DBGASCONSOLA'
    TableName = 'DPVGTURC'
    Left = 456
    Top = 320
    object T_TurcTURNO: TIntegerField
      FieldName = 'TURNO'
    end
    object T_TurcHORAINICIAL: TStringField
      FieldName = 'HORAINICIAL'
      Size = 5
    end
    object T_TurcHORAFINAL: TStringField
      FieldName = 'HORAFINAL'
      Size = 5
    end
    object T_TurcHORAMIN: TStringField
      FieldName = 'HORAMIN'
      Size = 5
    end
    object T_TurcHORAMAX: TStringField
      FieldName = 'HORAMAX'
      Size = 5
    end
  end
  object Q_Turn: TQuery
    DatabaseName = 'DBGASCONSOLA'
    SQL.Strings = (
      'select first 1 * from DPVGTURN'
      'where estatus='#39'A'#39)
    Left = 512
    Top = 320
    object Q_TurnFECHA: TDateTimeField
      FieldName = 'FECHA'
      Origin = 'DBGASCONSOLA.DPVGTURN.FECHA'
    end
    object Q_TurnTURNO: TIntegerField
      FieldName = 'TURNO'
      Origin = 'DBGASCONSOLA.DPVGTURN.TURNO'
    end
    object Q_TurnFECHAHORAINICIAL: TDateTimeField
      FieldName = 'FECHAHORAINICIAL'
      Origin = 'DBGASCONSOLA.DPVGTURN.FECHAHORAINICIAL'
    end
    object Q_TurnFECHAHORAFINAL: TDateTimeField
      FieldName = 'FECHAHORAFINAL'
      Origin = 'DBGASCONSOLA.DPVGTURN.FECHAHORAFINAL'
    end
    object Q_TurnESTATUS: TStringField
      FieldName = 'ESTATUS'
      Origin = 'DBGASCONSOLA.DPVGTURN.ESTATUS'
      Size = 1
    end
  end
  object T_Turn: TTable
    DatabaseName = 'DBGASCONSOLA'
    TableName = 'DPVGTURN'
    Left = 568
    Top = 320
    object T_TurnFECHA: TDateTimeField
      FieldName = 'FECHA'
    end
    object T_TurnTURNO: TIntegerField
      FieldName = 'TURNO'
    end
    object T_TurnFECHAHORAINICIAL: TDateTimeField
      FieldName = 'FECHAHORAINICIAL'
    end
    object T_TurnFECHAHORAFINAL: TDateTimeField
      FieldName = 'FECHAHORAFINAL'
    end
    object T_TurnESTATUS: TStringField
      FieldName = 'ESTATUS'
      Size = 1
    end
  end
  object QL_Bomb: TQuery
    DatabaseName = 'DBGASCONSOLA'
    SQL.Strings = (
      'select * from DPVGBOMB '
      'order by poscarga,combustible')
    Left = 452
    Top = 377
    object QL_BombMANGUERA: TIntegerField
      FieldName = 'MANGUERA'
      Origin = 'DBGASCONSOLA.DPVGBOMB.MANGUERA'
    end
    object QL_BombPOSCARGA: TIntegerField
      FieldName = 'POSCARGA'
      Origin = 'DBGASCONSOLA.DPVGBOMB.POSCARGA'
    end
    object QL_BombCOMBUSTIBLE: TIntegerField
      FieldName = 'COMBUSTIBLE'
      Origin = 'DBGASCONSOLA.DPVGBOMB.COMBUSTIBLE'
    end
    object QL_BombISLA: TIntegerField
      FieldName = 'ISLA'
      Origin = 'DBGASCONSOLA.DPVGBOMB.ISLA'
    end
    object QL_BombCON_PRECIO: TIntegerField
      FieldName = 'CON_PRECIO'
      Origin = 'DBGASCONSOLA.DPVGBOMB.CON_PRECIO'
    end
    object QL_BombCON_POSICION: TIntegerField
      FieldName = 'CON_POSICION'
      Origin = 'DBGASCONSOLA.DPVGBOMB.CON_POSICION'
    end
    object QL_BombCON_DIGITOAJUSTE: TIntegerField
      FieldName = 'CON_DIGITOAJUSTE'
      Origin = 'DBGASCONSOLA.DPVGBOMB.CON_DIGITOAJUSTE'
    end
    object QL_BombIMPRESORA: TIntegerField
      FieldName = 'IMPRESORA'
      Origin = 'DBGASCONSOLA.DPVGBOMB.IMPRESORA'
    end
    object QL_BombACTIVO: TStringField
      FieldName = 'ACTIVO'
      Origin = 'DBGASCONSOLA.DPVGBOMB.ACTIVO'
      Size = 2
    end
    object QL_BombIMPRIMEAUTOM: TStringField
      FieldName = 'IMPRIMEAUTOM'
      Origin = 'DBGASCONSOLA.DPVGBOMB.IMPRIMEAUTOM'
      Size = 2
    end
    object QL_BombDIGITOAJUSTEPRECIO: TIntegerField
      FieldName = 'DIGITOAJUSTEPRECIO'
      Origin = 'DBGASCONSOLA.DPVGBOMB.DIGITOAJUSTEPRECIO'
    end
    object QL_BombCAMPOLECTURA: TStringField
      FieldName = 'CAMPOLECTURA'
      Origin = 'DBGASCONSOLA.DPVGBOMB.CAMPOLECTURA'
      Size = 7
    end
    object QL_BombMODOOPERACION: TStringField
      FieldName = 'MODOOPERACION'
      Origin = 'DBGASCONSOLA.DPVGBOMB.MODOOPERACION'
      Size = 8
    end
  end
  object SP_Paq_Volum: TStoredProc
    DatabaseName = 'DBGASCONSOLA'
    StoredProcName = 'RUTINA02'
    Left = 560
    Top = 384
    ParamData = <
      item
        DataType = ftInteger
        Name = 'P_COMBUSTIBLE'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'P_IMPORTE'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'P_FECHACORTE'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'R_TRANSACCION'
        ParamType = ptOutput
      end>
  end
  object SP_Calcula_Ventas_Etan: TStoredProc
    DatabaseName = 'DBGASCONSOLA'
    StoredProcName = 'CALCULA_VENTAS_ETAN'
    Left = 664
    Top = 384
    ParamData = <
      item
        DataType = ftInteger
        Name = 'P_FOLIO'
        ParamType = ptInput
      end>
  end
  object ROBinMessage1: TROBinMessage
    Left = 464
    Top = 488
  end
  object ROIndyHTTPServer1: TROIndyHTTPServer
    Dispatchers = <
      item
        Name = 'ROBinMessage1'
        Message = ROBinMessage1
        Enabled = True
        PathInfo = 'Bin'
      end>
    IndyServer.Bindings = <>
    IndyServer.CommandHandlers = <>
    IndyServer.DefaultPort = 8099
    IndyServer.Greeting.NumericCode = 0
    IndyServer.MaxConnectionReply.NumericCode = 0
    IndyServer.ReplyExceptionCode = 0
    IndyServer.ReplyTexts = <>
    IndyServer.ReplyUnknownCommand.NumericCode = 0
    Port = 8099
    Left = 576
    Top = 488
  end
  object ADOConnectionTeam: TADOConnection
    ConnectionString = 
      'Provider=MSDASQL.1;Persist Security Info=False;User ID=masterkey' +
      ';Extended Properties="DSN=TanquesTeam;ID=masterkey"'
    LoginPrompt = False
    Provider = 'MSDASQL.1'
    Left = 800
    Top = 320
  end
  object ADOTableInv: TADOTable
    Connection = ADOConnectionTeam
    CursorType = ctStatic
    TableName = 'Inventarios'
    Left = 904
    Top = 328
    object ADOTableInvTanque: TStringField
      FieldName = 'Tanque'
      Size = 15
    end
    object ADOTableInvProducto: TStringField
      FieldName = 'Producto'
    end
    object ADOTableInvNivel: TFloatField
      FieldName = 'Nivel'
    end
    object ADOTableInvTemperatura: TFloatField
      FieldName = 'Temperatura'
    end
    object ADOTableInvAgua: TFloatField
      FieldName = 'Agua'
    end
    object ADOTableInvVolBruto: TFloatField
      FieldName = 'VolBruto'
    end
    object ADOTableInvVolNeto: TFloatField
      FieldName = 'VolNeto'
    end
    object ADOTableInvCapDisponible: TFloatField
      FieldName = 'CapDisponible'
    end
    object ADOTableInvEstado: TStringField
      FieldName = 'Estado'
    end
  end
  object ADOQueryEnt: TADOQuery
    Connection = ADOConnectionTeam
    MaxRecords = 10
    Parameters = <>
    SQL.Strings = (
      'select * from entrega_producto'
      'order by llave desc')
    Left = 872
    Top = 400
    object ADOQueryEntTanque: TStringField
      FieldName = 'Tanque'
      Size = 15
    end
    object ADOQueryEntNivel_Gas_ini: TFloatField
      FieldName = 'Nivel_Gas_ini'
    end
    object ADOQueryEntNivel_Gas_fin: TFloatField
      FieldName = 'Nivel_Gas_fin'
    end
    object ADOQueryEntNivel_Agua_ini: TFloatField
      FieldName = 'Nivel_Agua_ini'
    end
    object ADOQueryEntNivel_Agua_fin: TFloatField
      FieldName = 'Nivel_Agua_fin'
    end
    object ADOQueryEntTemperatura_ini: TFloatField
      FieldName = 'Temperatura_ini'
    end
    object ADOQueryEntTemperatura_fin: TFloatField
      FieldName = 'Temperatura_fin'
    end
    object ADOQueryEntVol_Bruto_ini: TFloatField
      FieldName = 'Vol_Bruto_ini'
    end
    object ADOQueryEntVol_Bruto_fin: TFloatField
      FieldName = 'Vol_Bruto_fin'
    end
    object ADOQueryEntVol_Neto_ini: TFloatField
      FieldName = 'Vol_Neto_ini'
    end
    object ADOQueryEntVol_Neto_fin: TFloatField
      FieldName = 'Vol_Neto_fin'
    end
    object ADOQueryEntTurno: TFloatField
      FieldName = 'Turno'
    end
    object ADOQueryEntHora_Ini: TDateTimeField
      FieldName = 'Hora_Ini'
    end
    object ADOQueryEntHora_Fin: TDateTimeField
      FieldName = 'Hora_Fin'
    end
    object ADOQueryEntProducto: TStringField
      FieldName = 'Producto'
      Size = 50
    end
    object ADOQueryEntFecha_Ini: TStringField
      FieldName = 'Fecha_Ini'
      Size = 10
    end
    object ADOQueryEntFecha_Fin: TStringField
      FieldName = 'Fecha_Fin'
      Size = 10
    end
    object ADOQueryEntLlave: TAutoIncField
      FieldName = 'Llave'
      ReadOnly = True
    end
    object ADOQueryEntHoraI: TStringField
      FieldName = 'HoraI'
      Size = 30
    end
    object ADOQueryEntHoraF: TStringField
      FieldName = 'HoraF'
      Size = 30
    end
  end
  object pFIBDb1: TpFIBDatabase
    DBParams.Strings = (
      'password=masterkey'
      'user_name=SYSDBA')
    SQLDialect = 1
    Timeout = 0
    WaitForRestoreConnect = 0
    Left = 832
    Top = 264
  end
  object SIBfibEA1: TSIBfibEventAlerter
    Events.Strings = (
      'Cliente0'
      'Cliente1')
    OnEventAlert = SIBfibEA1EventAlert
    Database = pFIBDb1
    Left = 936
    Top = 264
  end
  object T_Alar: TTable
    DatabaseName = 'DBGASCONSOLA'
    TableName = 'DPVGALAR'
    Left = 104
    Top = 192
    object T_AlarFOLIO: TIntegerField
      FieldName = 'FOLIO'
      Required = True
    end
    object T_AlarFECHAHORA: TDateTimeField
      FieldName = 'FECHAHORA'
    end
    object T_AlarTANQUE: TIntegerField
      FieldName = 'TANQUE'
    end
    object T_AlarTIPOALARMA: TStringField
      FieldName = 'TIPOALARMA'
    end
  end
  object Q_UltPrec: TQuery
    DatabaseName = 'DBGASCONSOLA'
    SQL.Strings = (
      'select * from DPVGPREC'
      'where folio=(select max(folio) from dpvgprec)'
      'order by combustible, fechahora')
    Left = 25
    Top = 479
    object Q_UltPrecFOLIO: TIntegerField
      FieldName = 'FOLIO'
    end
    object Q_UltPrecCOMBUSTIBLE: TIntegerField
      FieldName = 'COMBUSTIBLE'
    end
    object Q_UltPrecFECHAHORA: TDateTimeField
      FieldName = 'FECHAHORA'
    end
    object Q_UltPrecPRECIO: TFloatField
      FieldName = 'PRECIO'
    end
    object Q_UltPrecAPLICADO: TStringField
      FieldName = 'APLICADO'
      Size = 2
    end
    object Q_UltPrecEN_EDICION: TStringField
      FieldName = 'EN_EDICION'
      Size = 2
    end
    object Q_UltPrecERROR: TStringField
      FieldName = 'ERROR'
      Size = 2
    end
  end
end
