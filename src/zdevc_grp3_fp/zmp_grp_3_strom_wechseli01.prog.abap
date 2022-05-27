*&---------------------------------------------------------------------*
*& Include          ZMP_GRP_3_STROM_WECHSELI01
*&---------------------------------------------------------------------*

MODULE user_command_0100 INPUT.

  CASE sy-ucomm.

    WHEN 'SHOW'.
      IF zgrp3_tstatus-status IS INITIAL.
        SELECT * FROM zgrp3_kunde INTO TABLE lt_kunde.
      ELSE.
        SELECT * FROM zgrp3_kunde INTO TABLE lt_kunde
          WHERE status = zgrp3_tstatus-status.
      ENDIF.

      IF sy-subrc <> 0.
*            Message 'Fehler'
*          CLEAR: zgrp3_kunde.
      ENDIF.

    WHEN 'GOTO200'.
      CALL METHOD alv1->get_selected_rows
        IMPORTING
          et_row_no = DATA(selection).
      IF selection IS INITIAL.
        MESSAGE  'Bitte selektieren eine Kunde!' TYPE 'I'.
      ELSE.
        READ TABLE lt_kunde INDEX selection[ 1 ]-row_id INTO ls_kunde.
*        sperren
        CALL FUNCTION 'ENQUEUE_EY_EQ_ZGRP3KUNDE'
         EXPORTING
           MODE_ZGRP3_KUNDE       = 'E'
           MANDANT                = SY-MANDT
           KUNNR                  = zgrp3_kunde-kunnr
           X_KUNNR                = ' '
           _SCOPE                 = '2'
           _WAIT                  = 'X'
           _COLLECT               = ' '
         EXCEPTIONS
           FOREIGN_LOCK           = 1
           SYSTEM_FAILURE         = 2
           OTHERS                 = 3
                  .
        IF sy-subrc <> 0.
* Implement suitable error handling here
        ENDIF.

        SET SCREEN 200.
      ENDIF.

    WHEN 'BACK'.
      LEAVE PROGRAM.

    WHEN 'REPORT'.
      SUBMIT z_s05_graphs_dynpros AND RETURN.

  ENDCASE.
ENDMODULE.


*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0200  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0200 INPUT.

  CASE sy-ucomm.
    WHEN 'PROGRESS'.
      lo_wechseln->bearbeiten(
        EXPORTING
          im_kunnr        = ls_kunde-kunnr
          im_name         = ls_kunde-name
          im_vorname      = ls_kunde-vorname
          im_anrede       = ls_kunde-anrede
          im_gbdat        = ls_kunde-geburtsdatum
          im_strasse      = ls_kunde-strasse
          im_hausnr       = ls_kunde-hausnr
          im_plz          = ls_kunde-plz
          im_ort          = ls_kunde-ort
          im_anbietername = ls_kunde-akt_anbieter
          im_status       = ls_kunde-status
        IMPORTING
          ex_edi = DATA(edi) ).

      IF edit IS NOT INITIAL.
        display_text = edi->get_edi( ).
        APPEND display_text TO it_text.
        CALL METHOD edit->set_text_as_stream
          EXPORTING
            text = it_text.
      ENDIF.

    WHEN 'ACTIVATE'.

      CALL METHOD edit->get_text_as_stream
        IMPORTING
          text = it_text.

      IF it_text IS NOT INITIAL.
        display_text = it_text[ 1 ].
      ELSE.
        display_text = 'N/A'.
      ENDIF.

      lo_wechseln->aktivieren(
        EXPORTING
          im_kunnr        = ls_kunde-kunnr
          im_name         = ls_kunde-name
          im_vorname      = ls_kunde-vorname
          im_anrede       = ls_kunde-anrede
          im_gbdat        = ls_kunde-geburtsdatum
          im_strasse      = ls_kunde-strasse
          im_hausnr       = ls_kunde-hausnr
          im_plz          = ls_kunde-plz
          im_ort          = ls_kunde-ort
          im_anbietername = ls_kunde-akt_anbieter
          im_status       = ls_kunde-status
          im_nachricht    = display_text ).

    WHEN 'PENDING'.

      CALL METHOD edit->get_text_as_stream
        IMPORTING
          text = it_text.

      IF it_text IS NOT INITIAL.
        display_text = it_text[ 1 ].
      ELSE.
        display_text = 'N/A'.
      ENDIF.

      lo_wechseln->stelle_im_warten(
        EXPORTING
          im_kunnr        = ls_kunde-kunnr
          im_name         = ls_kunde-name
          im_vorname      = ls_kunde-vorname
          im_anrede       = ls_kunde-anrede
          im_gbdat        = ls_kunde-geburtsdatum
          im_strasse      = ls_kunde-strasse
          im_hausnr       = ls_kunde-hausnr
          im_plz          = ls_kunde-plz
          im_ort          = ls_kunde-ort
          im_anbietername = ls_kunde-akt_anbieter
          im_status       = ls_kunde-status
          im_nachricht = display_text ).

    WHEN 'REJECT'.

      CALL METHOD edit->get_text_as_stream
        IMPORTING
          text = it_text.
      IF it_text IS NOT INITIAL.
        display_text = it_text[ 1 ].
      ELSE.
        display_text = 'N/A'.
      ENDIF.

      lo_wechseln->ablehnen(
        EXPORTING
          im_kunnr        = ls_kunde-kunnr
          im_name         = ls_kunde-name
          im_vorname      = ls_kunde-vorname
          im_anrede       = ls_kunde-anrede
          im_gbdat        = ls_kunde-geburtsdatum
          im_strasse      = ls_kunde-strasse
          im_hausnr       = ls_kunde-hausnr
          im_plz          = ls_kunde-plz
          im_ort          = ls_kunde-ort
          im_anbietername = ls_kunde-akt_anbieter
          im_status       = ls_kunde-status
          im_nachricht = display_text ).

    WHEN 'BACK'.
* entsperren
      CALL FUNCTION 'DEQUEUE_EY_EQ_ZGRP3KUNDE'
       EXPORTING
         MODE_ZGRP3_KUNDE       = 'E'
         MANDANT                = SY-MANDT
         KUNNR                  = zgrp3_kunde-kunnr
         X_KUNNR                = ' '
         _SCOPE                 = '3'
         _SYNCHRON              = ' '
         _COLLECT               = ' ' .

      SET SCREEN 100.

  ENDCASE.
ENDMODULE.
