
START-OF-SELECTION.
  DATA p_swm TYPE c LENGTH 30.

MODULE user_command_0105 INPUT.
  CASE sy-ucomm.
    WHEN 'TR1'.
      p_swm = 'M-fix'.
      SET SCREEN 110.
    WHEN 'TR2'.
      p_swm = 'M-Ökostrom'.
      SET SCREEN 110.
    WHEN 'END'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.

MODULE user_command_0100 INPUT.

  zgrp3_kunde-neue_swm_tarife = p_swm.

  CASE sy-ucomm.
    WHEN 'GO'.
      DATA(lo_daten) = NEW zcl_grp3_kundendaten( ).
      lo_daten->save_data(
        EXPORTING
          im_vorname       =   zgrp3_kunde-vorname         " Vorname
          im_nachname      =   ZGrp3_kunde-name            " Nachname
          im_anrede        =   zgrp3_kunde-anrede          " Anrede
          im_geburtsdatum  =   zgrp3_kunde-geburtsdatum    " Geburtsdatum
          im_strasse       =    zgrp3_kunde-strasse        " Straße
          im_hausnr        =   zgrp3_kunde-hausnr          " Hausnummer
          im_plz           =   ZGRp3_kunde-plz             " Postleitzahl
          im_ort           =   ZGRp3_kunde-ort             " Ort
          im_pers_haushalt =    zgrp3_kunde-pers_haushalt  " Kunden Konditionsgruppe 1
          im_akt_anbieter  =    zgrp3_kunde-akt_anbieter   "  Stromanbieter
          im_anbietertarif =    zgrp3_kunde-anbietertarif  " Bezeichnung Stromtarif
          im_e_mail        =     zgrp3_kunde-e_mail        " Email Adresse
          im_swmtarif      =     p_swm                      " SWM Tarife GRP3
        EXCEPTIONS
          nachname_ng      = 1                " NACHNAME NICHT GEFUNDEN
          nachname_nr      = 2                " NACHNAME NICHT RICHTIG
          vorname_ng       = 3                " VORNAME NICHT GEFUNDEN
          vorname_nr       = 4              " VORNAME NICHT RICHTIG
          gebdatum_ng      = 5                " GEBURTSDATUM NICHT GEFUNDEN
          email_ng         = 6                " E-MAIL NICHT GEFUNDEN
          email_nr         = 7                " E-MAIL NICHT RICHTIG
          str_ng           = 8                " STRASSE NICHT GEFUNDEN
          str_nr           = 9                " STRASSE NICHT RICHTIG
          hausnum_ng       = 10               " HAUSNUMMER NICHT GEFUNDEN
          hausnum_nr       = 11               " HAUSNUMMER NICHT RICHTIG
          ort_ng           = 12               " ORT NICHT GEFUNDEN
          ort_nr           = 13               " ORT NICHT RICHTIG
          plz_ng           = 14               " ORT NICHT GEFUNDEN
          plz_nr           = 15               " ORT NICHT RICHTIG
          haushalt_ng      = 16               " PERSONEN IN HAUSHALT NICHT GEFUNDEN
          akt_anbieter_ng  = 17
          OTHERS           = 18
      ).
      CASE sy-subrc.
        WHEN 0.
          CALL FUNCTION 'POPUP_TO_INFORM'
            EXPORTING
              titel = 'Tarif erfolgreich geändert.'
              txt1  = 'Sehr geehrter SWM-Kunde,'
              txt2  = 'Sie haben erfolgreich einen Tarifwechsel beantragt!'
              txt3  = 'Sobald wir Ihre Daten geprüft haben, erhalten Sie eine Bestätigungs-E-Mail.'.
          SET SCREEN 0.

        WHEN 1.
          MESSAGE i006.
        WHEN 2.
          MESSAGE i007 WITH zgrp3_kunde-name.
        WHEN 3.
          MESSAGE i005.
        WHEN 4.
          MESSAGE i007 WITH zgrp3_kunde-vorname.
        WHEN 5.
          MESSAGE i008.
        WHEN 6.
          MESSAGE i010.
        WHEN 7.
          MESSAGE i011.
        WHEN 8.
          MESSAGE i013.
        WHEN 9.
          MESSAGE i014.
        WHEN 10.
          MESSAGE i013.
        WHEN 11.
          MESSAGE i015.
        WHEN 12.
          MESSAGE i013.
        WHEN 13.
          MESSAGE i016.
        WHEN 14.
          MESSAGE i013.
        WHEN 15.
          MESSAGE i017.
        WHEN 16.
          MESSAGE i019.
        WHEN 17.
          MESSAGE i012.
        WHEN 18.
          MESSAGE i020.
      ENDCASE.

    WHEN 'BACK'.
      SET SCREEN 110.
    WHEN 'END'.
      SET SCREEN 0.
  ENDCASE.
ENDMODULE.

MODULE user_command_0110 INPUT.
  CASE sy-ucomm.
    WHEN 'NEU'.
      SET SCREEN 100.
    WHEN 'SWM'.
      SET SCREEN 115.
    WHEN 'BACK'.
      SET SCREEN 105.
  ENDCASE.
ENDMODULE.

MODULE user_command_0115 INPUT.
  DATA lv_answer TYPE string.
  CASE sy-ucomm.
    WHEN 'BES'.
      SELECT SINGLE FOR UPDATE * FROM zgrp3_kunde INTO @DATA(ls_update)
      WHERE kunnr = @zgrp3_kunde-kunnr.
      IF sy-subrc = 0.

        DATA(lo_update) = NEW zcl_grp3_kundendaten( ).
        lo_update->data_update(
          EXPORTING
            im_swmtarif      = p_swm   " Kundennummer
            im_nummr         = zgrp3_kunde-kunnr   " Kunden Konditionsgruppe 1
            ).

        CALL FUNCTION 'POPUP_TO_INFORM'
          EXPORTING
            titel = 'Tarif erfolgreich geändert.'
            txt1  = 'Sehr geehrter SWM-Kunde,'
            txt2  = 'Sie haben erfolgreich einen Tarifwechsel beantragt!'
            txt3  = 'Sobald wir Ihre Daten geprüft haben, erhalten Sie eine Bestätigungs-E-Mail.'.
        SET SCREEN 0.

      ELSE.
        CALL FUNCTION 'POPUP_WITH_2_BUTTONS_TO_CHOOSE'
          EXPORTING
            defaultoption = '2'
            diagnosetext1 = 'Die von Ihnen eingegebene Kundennummer'
            diagnosetext2 = ' existiert nicht in unserem System.'
            diagnosetext3 = 'Sind Sie Neuer Kunde oder möchten Sie Zurück zur Eingabe?'
            textline1     = space
            textline2     = space
*           TEXTLINE3     = ' '
            text_option1  = 'Neuer Kunde'
            text_option2  = 'Zurück zur Eingabe'
            titel         = 'Kundennummer nicht gefunden'
          IMPORTING
            answer        = lv_answer.
        .
        CASE lv_answer.
          WHEN '1'.
            SET SCREEN 100.
          WHEN '2'.
            SET SCREEN 115.
          WHEN OTHERS.
        ENDCASE.
      ENDIF.
    WHEN 'BACK'.
      SET SCREEN 110.
  ENDCASE.
ENDMODULE.
