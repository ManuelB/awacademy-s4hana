*&---------------------------------------------------------------------*
*& Include          ZISU_WECHSELI01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_1001  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*



*----------Dynpro 10001 Ablauflogik---------
MODULE user_command_1001 INPUT.

  CASE sy-ucomm.

    WHEN 'CHECK'.

      SELECT SINGLE kunname, geburtsd
        INTO @DATA(id_check)
        FROM zisu_fp_kunden
        WHERE kundennr = @zisu_fp_kunden-kundennr.

      IF sy-subrc = 0.

        zisu_fp_kunden-geburtsd = id_check-geburtsd.
        zisu_fp_kunden-kunname = id_check-kunname.

      ELSE.
*message 'eingegebene Kundennr. & ist nicht gültig '
        MESSAGE e000 WITH zisu_fp_kunden-kundennr.
      ENDIF.

    WHEN 'GOTO1002'.

      SELECT SINGLE k~kundennr, k~kunname, k~geburtsd, w~status
          FROM  zisu_fp_kunden AS k INNER JOIN zisu_fp_wechsel AS w
          ON k~kundennr = w~kundennr
          INTO @DATA(wa)
          WHERE k~kundennr = @zisu_fp_kunden-kundennr.

      IF sy-subrc = 0.
        gv_kunnr = zisu_fp_kunden-kundennr.
        CALL SCREEN 1002.
      ELSE.
        MESSAGE e008 WITH zisu_fp_kunden-kundennr.
      ENDIF.

    WHEN 'BACK'.
      LEAVE PROGRAM.

  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_1002 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_1002 OUTPUT.
* SET PF-STATUS 'PF1002'.
* SET TITLEBAR 'xxx'.
  DATA(lo_wechsel) = NEW z_grp2_wechsel( ).


  lo_wechsel->status_sehen(
    EXPORTING
      im_kunnr   = gv_kunnr "zisu_fp_wechsel-kundennr
    IMPORTING
      ex_wechsel = zisu_fp_wechsel
  ).



ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_1002  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_1002 INPUT.
  CASE sy-ucomm.
    WHEN 'BACK'.
      CALL SCREEN 1001.
    WHEN 'END'.
      LEAVE PROGRAM.

  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_1003 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_1003 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_1003  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_1003 INPUT.


  CASE sy-ucomm.

    WHEN 'SHOW'.

      SELECT SINGLE kundennr, status  INTO @DATA(wa2)
              FROM zisu_fp_wechsel
              WHERE kundennr = @zisu_fp_kunden-kundennr.

      IF sy-subrc = 0.
        zisu_fp_kunden-kundennr = wa2-kundennr.
        zisu_fp_wechsel-status = wa2-status.
      ELSE.
        MESSAGE e000.
      ENDIF.

    WHEN 'CHANGE'.
      DATA(lo_wechsel2) = NEW z_grp2_wechsel( ).

      lo_wechsel2->status_aendern(
        EXPORTING
          im_kunnr     = zisu_fp_kunden-kundennr
          im_status    = zisu_fp_wechsel-status
          im_vertragsn = zisu_fp_wechsel-vertragsnummer
        IMPORTING
          ex_status    = zisu_fp_wechsel-status
      ).


      IF zisu_fp_wechsel-status = 'G'.
        DATA text3 TYPE string.
        DATA text4 TYPE c LENGTH 12.
        SELECT SINGLE wechseldatum INTO @DATA(wd)
        FROM zisu_fp_wechsel
        WHERE kundennr = @zisu_fp_kunden-kundennr.
        WRITE wd TO text4.
        text3 = 'Kd.-Nr. : ' && zisu_fp_kunden-kundennr && '-' && 'Wechseldatum : ' && | | && text4 .
        CALL FUNCTION 'POPUP_TO_INFORM'
          EXPORTING
            titel = 'EDI@Energy'
            txt1  = 'EDI Nachricht über Ihren Anbieter-/Tarifwechsel wurde an die Bundesnetzagentur'
            txt2  = 'gesendet.'
            txt3  = text3.
      ENDIF.


    WHEN 'BACK'.
      LEAVE PROGRAM.

  ENDCASE.


ENDMODULE.
