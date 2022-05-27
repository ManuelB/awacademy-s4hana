class ZCL_GRP3_WECHSEL definition
  public
  final
  create public .

public section.

  methods CONSTRUCTOR .
  methods BEARBEITEN
    importing
      !IM_KUNNR type ZGRP3_KUNNR
      !IM_NAME type P01_BVV_ZUNAME
      !IM_VORNAME type P01_BVV_VORNAME
      !IM_ANREDE type ZGRP3_ANREDE
      !IM_GBDAT type GBDAT
      !IM_STRASSE type AD_STREET
      !IM_HAUSNR type AD_HSNM1
      !IM_PLZ type PSTLZ
      !IM_ORT type ORT01_GP
      !IM_STATUS type ZGRP3_STATUS
      !IM_ANBIETERNAME type ZANBIETER
      !IM_NACHART type ZGRP3_NACHART optional
      !IM_EDI_TYP type ZGRP3_NACHRICHT optional
    exporting
      !EX_EDI type ref to ZCL_GRP3_NACHRICHT .
  methods STELLE_IM_WARTEN
    importing
      !IM_KUNNR type ZGRP3_KUNNR
      !IM_NAME type P01_BVV_ZUNAME
      !IM_VORNAME type P01_BVV_VORNAME
      !IM_ANREDE type ZGRP3_ANREDE
      !IM_GBDAT type GBDAT
      !IM_STRASSE type AD_STREET
      !IM_HAUSNR type AD_HSNM1
      !IM_PLZ type PSTLZ
      !IM_ORT type ORT01_GP
      !IM_STATUS type ZGRP3_STATUS
      !IM_ANBIETERNAME type ZANBIETER
      !IM_NACHART type ZGRP3_NACHART optional
      !IM_EDI_TYP type ZGRP3_NACHRICHT optional
      !IM_NACHRICHT type ZGRP3_NACH .
  methods AKTIVIEREN
    importing
      !IM_KUNNR type ZGRP3_KUNNR
      !IM_NAME type P01_BVV_ZUNAME
      !IM_VORNAME type P01_BVV_VORNAME
      !IM_ANREDE type ZGRP3_ANREDE
      !IM_GBDAT type GBDAT
      !IM_STRASSE type AD_STREET
      !IM_HAUSNR type AD_HSNM1
      !IM_PLZ type PSTLZ
      !IM_ORT type ORT01_GP
      !IM_STATUS type ZGRP3_STATUS
      !IM_ANBIETERNAME type ZANBIETER
      !IM_NACHART type ZGRP3_NACHART optional
      !IM_EDI_TYP type ZGRP3_NACHRICHT optional
      !IM_NACHRICHT type ZGRP3_NACH .
  methods ABLEHNEN
    importing
      !IM_KUNNR type ZGRP3_KUNNR
      !IM_NAME type P01_BVV_ZUNAME
      !IM_VORNAME type P01_BVV_VORNAME
      !IM_ANREDE type ZGRP3_ANREDE
      !IM_GBDAT type GBDAT
      !IM_STRASSE type AD_STREET
      !IM_HAUSNR type AD_HSNM1
      !IM_PLZ type PSTLZ
      !IM_ORT type ORT01_GP
      !IM_STATUS type ZGRP3_STATUS
      !IM_ANBIETERNAME type ZANBIETER
      !IM_NACHART type ZGRP3_NACHART optional
      !IM_EDI_TYP type ZGRP3_NACHRICHT optional
      !IM_NACHRICHT type ZGRP3_NACH .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_GRP3_WECHSEL IMPLEMENTATION.


  METHOD aktivieren.

    IF im_status = 'NEW'.
      MESSAGE |Dies ist ein neuer potenzieller Kunde! Drücken sie bitte die Taste "in Bearbeitung".| TYPE 'I'.
      EXIT.
    ENDIF.

    IF im_status = 'PRO'.
      MESSAGE |Die Anfrage des Kunden wurde bereits bearbeitet und warten auf ein Antwort von der aktueler Anbieter.| TYPE 'I'.
      EXIT.
    ENDIF.

    IF im_status = 'REJ'.
      MESSAGE |Die Anfrage des Kunden wurde bereits abgehlent!| TYPE 'I'.
      EXIT.
    ENDIF.

*    DATA edi_nachricht TYPE REF TO ZCL_GRP3_NACHRICHT.
    DATA: ls_liefwe TYPE zgrp3_liefwe,
          lt_liefwe TYPE TABLE OF zgrp3_liefwe.

    DATA(utc) = utclong_current( ).

    SELECT SINGLE * FROM zgrp3_stranb INTO @DATA(akt_anbieter)
      WHERE anbietername = @im_anbietername.

    ls_liefwe-mandant = sy-mandt.
    ls_liefwe-wechselbeleg = utc.
    ls_liefwe-kunnr = im_kunnr.
    ls_liefwe-anbietername = im_anbietername.
    ls_liefwe-status = 'ACC'.
    ls_liefwe-nachrichtart = 'Annahme'.
    ls_liefwe-edi_nachtyp = '414'.
    ls_liefwe-nachricht = im_nachricht.
    ls_liefwe-creauser = sy-uname.
    ls_liefwe-creadat = sy-datum.

    APPEND ls_liefwe TO lt_liefwe.
    INSERT  zgrp3_liefwe FROM TABLE lt_liefwe.
    UPDATE zgrp3_kunde
          SET status =  @ls_liefwe-status
          WHERE kunnr = @ls_liefwe-kunnr .
    IF sy-subrc = 0.
      MESSAGE |Der Status von Kunde { im_kunnr } wurde erfolgreich geändert!| TYPE 'I'.
      MESSAGE |Der Nachricht " { im_nachricht }" wurde erfolgreich übermittelt! | TYPE 'I' DISPLAY LIKE 'S'.
    ELSE.
*      MESSAGE e004.
    ENDIF.

  ENDMETHOD.


  METHOD bearbeiten.

    IF im_status = 'PRO'.
      MESSAGE |Die Anfrage des Kunden wurde bereits bearbeitet und warten auf ein Antwort von der aktueler Anbieter.| TYPE 'I'.
      EXIT.
    ENDIF.

    IF im_status = 'PEN'.
      MESSAGE |Die Anfrage des Kunden wurde bereits bearbeitet und befindet sich im Wartestellung| TYPE 'I'.
      EXIT.
    ENDIF.

    IF im_status = 'ACC'.
      MESSAGE |Der Kunde wurde bereits aktiviert!| TYPE 'I'.
      EXIT.
    ENDIF.

    IF im_status = 'REJ'.
      MESSAGE |Die Anfrage des Kunden wurde bereits abgehlent!| TYPE 'I'.
      EXIT.
    ENDIF.

    DATA edi_nachricht TYPE REF TO ZCL_GRP3_NACHRICHT.
    DATA: ls_liefwe TYPE zgrp3_liefwe,
          lt_liefwe TYPE TABLE OF zgrp3_liefwe.

    DATA(utc) = utclong_current( ).

    SELECT SINGLE * FROM zgrp3_stranb INTO @DATA(akt_anbieter)
      WHERE anbietername = @im_anbietername.

    edi_nachricht = NEW ZCL_GRP3_NACHRICHT(
      im_k_kunnr = im_kunnr
      im_k_name  = im_name
      im_k_vorname = im_vorname
      im_k_anrede  = im_anrede
      im_k_gbdat   = im_gbdat
      im_k_strasse = im_strasse
      im_k_hausnr  = im_hausnr
      im_k_plz     = im_plz
      im_k_ort     = im_ort
      im_a_anbietername = im_anbietername
      im_a_strasse      = akt_anbieter-strasse
      im_a_hausnr       = akt_anbieter-hausnr
      im_a_plz          = akt_anbieter-plz
      im_a_ort          = akt_anbieter-ort ).
    ex_edi = edi_nachricht.
    edi_nachricht->schicken( ).

    ls_liefwe-mandant = sy-mandt.
    ls_liefwe-wechselbeleg = utc.
    ls_liefwe-kunnr = im_kunnr.
    ls_liefwe-anbietername = im_anbietername.
    ls_liefwe-status = 'PRO'.
    ls_liefwe-nachrichtart = 'Anmeldung'.
    ls_liefwe-edi_nachtyp = '392'.
    ls_liefwe-creauser = sy-uname.
    ls_liefwe-creadat = sy-datum.
    ls_liefwe-nachricht = edi_nachricht->get_edi( ).

    APPEND ls_liefwe TO lt_liefwe.
    INSERT  zgrp3_liefwe FROM TABLE lt_liefwe.
    UPDATE zgrp3_kunde
          SET status =  @ls_liefwe-status
          WHERE kunnr = @ls_liefwe-kunnr .
    IF sy-subrc = 0.
      MESSAGE |Der Status von Kunde { im_kunnr } wurde erfolgreich geändert!| TYPE 'I'.
    ELSE.
*      MESSAGE e004.
      EXIT.
    ENDIF.

  ENDMETHOD.


  METHOD ablehnen.

    IF im_status = 'ACC'.
      MESSAGE |Der Kunde wurde bereits aktiviert und und kann nicht Ablehnung bekommen| TYPE 'I'.
      EXIT.
    ENDIF.

    IF im_status = 'NEW'.
      MESSAGE |Dies ist ein neuer potenzieller Kunde! Drücken sie bitte die Taste "in Bearbeitung".| TYPE 'I'.
      EXIT.
    ENDIF.

    IF im_status = 'PRO'.
      MESSAGE |Die Anfrage des Kunden wurde bereits bearbeitet und befindet sich im Status { im_status }| TYPE 'I'.
      EXIT.
    ENDIF.

*    DATA edi_nachricht TYPE REF TO ZCL_GRP3_NACHRICHT.
    DATA: ls_liefwe TYPE zgrp3_liefwe,
          lt_liefwe TYPE TABLE OF zgrp3_liefwe.

    DATA(utc) = utclong_current( ).

    SELECT SINGLE * FROM zgrp3_stranb INTO @DATA(akt_anbieter)
      WHERE anbietername = @im_anbietername.

    ls_liefwe-mandant = sy-mandt.
    ls_liefwe-wechselbeleg = utc.
    ls_liefwe-kunnr = im_kunnr.
    ls_liefwe-anbietername = im_anbietername.
    ls_liefwe-status = 'REJ'.
    ls_liefwe-nachrichtart = 'ABLEHNUNG'.
    ls_liefwe-edi_nachtyp = '414'.
    ls_liefwe-nachricht = im_nachricht.
    ls_liefwe-creauser = sy-uname.
    ls_liefwe-creadat = sy-datum.

    APPEND ls_liefwe TO lt_liefwe.
    INSERT  zgrp3_liefwe FROM TABLE lt_liefwe.
    UPDATE zgrp3_kunde
          SET status =  @ls_liefwe-status
          WHERE kunnr = @ls_liefwe-kunnr .
    IF sy-subrc = 0.
      MESSAGE |Der Status vom Kunden { im_kunnr } wurde erfolgreich geändert!| TYPE 'I'.
    ELSE.
*      MESSAGE e004.
    ENDIF.

  ENDMETHOD.


  METHOD constructor.
  ENDMETHOD.


  METHOD stelle_im_warten.

    IF im_status = 'ACC'.
      MESSAGE |Der Kunde wurde bereits aktiviert und und kann nicht wieder im Wartestellung sein| TYPE 'I'.
      EXIT.
    ENDIF.

    IF im_status = 'NEW'.
      MESSAGE |Dies ist ein neuer potenzieller Kunde! Drücken sie bitte die Taste "in Bearbeitung".| TYPE 'I'.
      EXIT.
    ENDIF.

    IF im_status = 'REJ'.
      MESSAGE |Die Anfrage des Kunden wurde bereits abgehlent!| TYPE 'I'.
      EXIT.
    ENDIF.

    DATA edi_nachricht TYPE REF TO ZCL_GRP3_NACHRICHT.
    DATA: ls_liefwe TYPE zgrp3_liefwe,
          lt_liefwe TYPE TABLE OF zgrp3_liefwe.

    DATA(utc) = utclong_current( ).

    SELECT SINGLE * FROM zgrp3_stranb INTO @DATA(akt_anbieter)
      WHERE anbietername = @im_anbietername.

    ls_liefwe-mandant = sy-mandt.
    ls_liefwe-wechselbeleg = utc.
    ls_liefwe-kunnr = im_kunnr.
    ls_liefwe-anbietername = im_anbietername.
    ls_liefwe-status = 'PEN'.
    ls_liefwe-nachrichtart = 'Anmeldung'.
    ls_liefwe-edi_nachtyp = '392'.
    ls_liefwe-nachricht = im_nachricht.
    ls_liefwe-creauser = sy-uname.
    ls_liefwe-creadat = sy-datum.

    ls_liefwe-nachricht = edi_nachricht->get_edi( ).

    APPEND ls_liefwe TO lt_liefwe.
    INSERT  zgrp3_liefwe FROM TABLE lt_liefwe.
    UPDATE zgrp3_kunde
          SET status =  @ls_liefwe-status
          WHERE kunnr = @ls_liefwe-kunnr .
    IF sy-subrc = 0.
      MESSAGE |Der Status vom Kunden { im_kunnr } wurde erfolgreich geändert!| TYPE 'I'.
    ELSE.
*      MESSAGE e004.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
