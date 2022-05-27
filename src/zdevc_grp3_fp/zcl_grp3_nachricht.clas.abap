class ZCL_GRP3_NACHRICHT definition
  public
  final
  create public .

public section.

  methods CONSTRUCTOR
    importing
      !IM_K_KUNNR type ZGRP3_KUNNR
      !IM_K_NAME type P01_BVV_ZUNAME
      !IM_K_VORNAME type P01_BVV_VORNAME
      !IM_K_ANREDE type ZGRP3_ANREDE
      !IM_K_GBDAT type GBDAT
      !IM_K_STRASSE type AD_STREET
      !IM_K_HAUSNR type AD_HSNM1
      !IM_K_PLZ type PSTLZ
      !IM_K_ORT type ORT01_GP
      !IM_A_ANBIETERNAME type ZANBIETER
      !IM_A_STRASSE type AD_STREET
      !IM_A_HAUSNR type AD_HSNM1
      !IM_A_PLZ type PSTLZ
      !IM_A_ORT type ORT01_GP .
  methods SCHICKEN .
  methods GET_EDI
    RETURNING VALUE(EX_EDI) type ZGRP3_NACH .
  methods SET_EDI
    importing
      !IM_EDI type ZGRP3_NACH .

  PROTECTED SECTION.
private section.

  data K_KUNNR type ZGRP3_KUNNR .
  data K_NAME type P01_BVV_ZUNAME .
  data K_VORNAME type P01_BVV_VORNAME .
  data K_ANREDE type ZGRP3_ANREDE .
  data K_GBDAT type GBDAT .
  data K_STRASSE type AD_STREET .
  data K_HAUSNR type AD_HSNM1 .
  data K_PLZ type PSTLZ .
  data K_ORT type ORT01_GP .
  data A_ANBIETERNAME type ZANBIETER .
  data A_STRASSE type AD_STREET .
  data A_HAUSNR type AD_HSNM1 .
  data A_PLZ type PSTLZ .
  data A_ORT type ORT01_GP .
  data _EDI type ZGRP3_NACH .

  methods NACHRICHT_GENERIEREN
    exporting
      !EX_EDI type ZGRP3_NACH .
ENDCLASS.



CLASS ZCL_GRP3_NACHRICHT IMPLEMENTATION.


  METHOD nachricht_generieren.
    CONCATENATE 'Kunde:'  k_kunnr k_name k_vorname k_gbdat k_strasse k_hausnr k_plz k_ort 'Anbieter:' a_anbietername a_strasse a_hausnr a_plz a_ort
      INTO _edi SEPARATED BY space.
  ENDMETHOD.


  METHOD schicken.
    MESSAGE |Edi Nachricht { _edi } wurde erfolgreich übermittelt| TYPE 'I'.
  ENDMETHOD.


  method CONSTRUCTOR.
    k_kunnr       = im_k_kunnr.
    k_name        = im_k_name.
    k_vorname     = im_k_vorname.
    k_anrede      = im_k_anrede.
    k_gbdat       = im_k_gbdat.
    k_strasse     = im_k_strasse.
    k_hausnr      = im_k_hausnr.
    k_plz         = im_k_plz.
    k_ort         = im_k_ort.
    a_anbietername = im_a_anbietername.
    a_strasse      = im_a_strasse.
    a_hausnr       = im_a_hausnr.
    a_plz          = im_a_plz.
    a_ort          = im_a_ort.

    CALL METHOD NACHRICHT_GENERIEREN.
  endmethod.


  method GET_EDI.
    ex_edi = _edi.
  endmethod.


  method SET_EDI.
    _edi = im_edi.
  endmethod.
ENDCLASS.
