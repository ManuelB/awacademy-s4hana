class Z_GRP2_WECHSEL definition
  public
  final
  create public .

public section.

  events DOUBLE_CLICK .
  events WECHSEL_ERLEDIGT
    exporting
      value(IM_STATUS) type ZGRP2_STATUS .

  methods STATUS_SEHEN
    importing
      value(IM_KUNNR) type ZGRP3_KUNNR
    exporting
      !EX_WECHSEL type ZISU_FP_WECHSEL .
  methods TARIF_WECHSELN
    importing
      !IM_KUNNR type ZISU_FP_KUNDEN-KUNDENNR
      !IM_ALTANBIETER type ZISU_FP_WECHSEL-ALT_ANBIETER
      !IM_TARIFE type ZISU_FP_TARIFE .
  methods EDINACHRICHT_SCHICKEN .
  methods STATUS_AENDERN
    importing
      value(IM_KUNNR) type ZGRP3_KUNNR
      !IM_STATUS type ZGRP2_STATUS
      value(IM_VERTRAGSN) type RANL optional
    exporting
      value(EX_STATUS) type ZGRP2_STATUS .
  methods NEU_KUNDE_TARIF_WAEHLEN
    importing
      !IM_KUNDE type ZISU_FP_KUNDEN
      !IM_TARIFE type ZISU_FP_TARIFE .
protected section.
private section.

  data IM_KUNNR type ZISU_FP_KUNDEN-KUNDENNR .
  data IM_ALTANBIETER type ZISU_FP_WECHSEL-ALT_ANBIETER .
  data LS_TARIF type ZISU_FP_TARIFE .
ENDCLASS.



CLASS Z_GRP2_WECHSEL IMPLEMENTATION.


  method EDINACHRICHT_SCHICKEN.
    WRITE: 'EDI Nachricht wurde verschickt'.
  endmethod.


  METHOD neu_kunde_tarif_waehlen.
    DATA: ls_kunden  TYPE zisu_fp_kunden,
          ls_wechsel TYPE zisu_fp_wechsel.

    "Befüllung der Kunden Daten Tabelle
*
*
*    SELECT MAX( Kundennr ) FROM zisu_fp_kunden INTO ls_kunden-kundennr.
*    ls_kunden-kundennr = ls_kunden-kundennr + 1.
*      add 1 to ls_kunden-kundennr.
CALL FUNCTION 'NUMBER_GET_NEXT'
  EXPORTING
    nr_range_nr                   = '01'
    object                        = 'ZKUNNR'
 IMPORTING
   NUMBER                        = ls_kunden-kundennr
          .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.
*if im_kunde-kunname = ''.
*  Message e005.
*  endif.
*  if im_kunde-kunname CN 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.
*    Message e006.
*    endif.
    ls_kunden-kunname = im_kunde-kunname.
    ls_kunden-geburtsd = im_kunde-geburtsd.
    ls_kunden-ort = im_kunde-ort.
    ls_kunden-plz = im_kunde-plz.
    ls_kunden-strasse = im_kunde-strasse.
    ls_kunden-tel = im_kunde-tel.
    ls_kunden-email = im_kunde-email.
*    insert ls_kunden into table zisu_fp_kunden.

**    IF im_kunde-tel CO '+ 0123456789'.
    INSERT zisu_fp_kunden FROM ls_kunden.
**    else.
*      Message |'Der Telefon Nummer muss numerisch sein!'| type 'E'.
*      Message e003 with im_kunde-tel.
**      endif.

    IF sy-subrc = 0.
      MESSAGE | Kunden Daten sind gespeichert| TYPE 'I'.
    ENDIF.
    "Befüllung der Wechsel Tabelle
*    SELECT MAX( vertragsnummer ) FROM zisu_fp_wechsel INTO ls_wechsel-vertragsnummer.
*    ls_wechsel-vertragsnummer = ls_wechsel-vertragsnummer + 1.

    CALL FUNCTION 'NUMBER_GET_NEXT'
      EXPORTING
        nr_range_nr                   = '01'
        object                        = 'ZVERTRAG'
     IMPORTING
       NUMBER                        = ls_wechsel-vertragsnummer
              .
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.


    ls_wechsel-kundennr = ls_kunden-kundennr.
    ls_wechsel-alt_anbieter = 'Keine'.
    ls_wechsel-anbietername = im_tarife-anbietername.
    ls_wechsel-anbietertarif = im_tarife-anbietertarif.
    ls_wechsel-status = 'Offen'.
    ls_wechsel-wechseldatum = sy-datum.

*    insert ls_wechsel into table zisu_fp_wechsel.
    INSERT zisu_fp_wechsel FROM ls_wechsel.
    IF sy-subrc = 0.
      MESSAGE |Ihr Vertrag ist angekommen| TYPE 'I'.
    ENDIF.



  ENDMETHOD.


  METHOD status_aendern.

    SELECT SINGLE status, kundennr INTO @DATA(wa3)
    FROM zisu_fp_wechsel
    WHERE kundennr = @im_kunnr.

    IF sy-subrc = 0.


                        CALL FUNCTION 'ENQUEUE_EY_EQ_ZISUWECHS'
                         EXPORTING
                           MODE_ZISU_FP_WECHSEL       = 'E'
                           MANDT                      = SY-MANDT
                           VERTRAGSNUMMER             = im_vertragsn
                           X_VERTRAGSNUMMER           = ' '
                           _SCOPE                     = '2'
                           _WAIT                      = 'X'
                           _COLLECT                   = ' '
                         EXCEPTIONS
                           FOREIGN_LOCK               = 1
                           SYSTEM_FAILURE             = 2
                           OTHERS                     = 3.



                        UPDATE zisu_fp_wechsel
           SET status   = @im_status
         WHERE kundennr = @im_kunnr.
                        COMMIT WORK.
                        ex_status = im_status.
 MESSAGE s001 WITH im_kunnr. " 'Der Wechselstatus wurde erfolgreich geändert!' TYPE 'I'.



*         IF sy-subrc <> 0.
*MESSAGE : |Die Wechseldaten werden schon bearbeitet.| TYPE 'I'.

                                  .

*IF sy-subrc = 0.

CALL FUNCTION 'DEQUEUE_EY_EQ_ZISUWECHS'
 EXPORTING
   MODE_ZISU_FP_WECHSEL       = 'E'
   MANDT                      = SY-MANDT
   VERTRAGSNUMMER             = im_vertragsn
   X_VERTRAGSNUMMER           = ' '
   _SCOPE                     = '3'
   _SYNCHRON                  = ' '
   _COLLECT                   = ' '
          .
ELSE.
        MESSAGE e004 WITH im_kunnr.
        ENDIF.



  ENDMETHOD.


  METHOD status_sehen.


    SELECT SINGLE *
        INTO @DATA(wa)
            FROM zisu_fp_wechsel
            WHERE kundennr = @im_kunnr.


    IF sy-subrc = 0.

      ex_wechsel-vertragsnummer = wa-vertragsnummer.
      ex_wechsel-kundennr = im_kunnr.
      ex_wechsel-anbietertarif = wa-anbietertarif.
      ex_wechsel-alt_anbieter = wa-alt_anbieter.
      ex_wechsel-anbietername = wa-anbietername.
      ex_wechsel-wechseldatum = wa-wechseldatum.
      ex_wechsel-status = wa-status.

    ELSE.
MESSAGE i000(ZMSG_FP_GRP2).
    ENDIF.



  ENDMETHOD.


  method TARIF_WECHSELN.

data : ls_wechsel type zisu_fp_wechsel.
*        ls_wechsel-vertragsnummer = '1'.
CALL FUNCTION 'NUMBER_GET_NEXT'
  EXPORTING
    nr_range_nr                   = '01'
    object                        = 'ZVERTRAG'

 IMPORTING
   NUMBER                        = ls_wechsel-vertragsnummer

          .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.


        ls_wechsel-kundennr = im_kunnr.
        ls_wechsel-alt_anbieter = im_altanbieter.
        ls_wechsel-anbietername = im_tarife-anbietername.
        ls_wechsel-anbietertarif = im_tarife-anbietertarif.
        ls_wechsel-status = 'Offen'.
        ls_wechsel-wechseldatum = sy-datum.



      INSERT zisu_fp_wechsel FROM ls_wechsel.
      if sy-subrc = 0.
        MESSAGE: |Wir haben Ihre Antrag erhalten| TYPE 'S'.
        endif.

  endmethod.
ENDCLASS.
