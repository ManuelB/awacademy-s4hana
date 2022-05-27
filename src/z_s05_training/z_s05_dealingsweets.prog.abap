*&---------------------------------------------------------------------*
*& Modulpool        ZSD_DEALINGSWEETS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*


*Schematische Darstellung für Programmaufbau.
*
*Hauptprogramm (Modulpool)
*      Include *TOP - Datendeklaration / Definition der lokalen Klassen/Methoden
*      Include *F01 - Implementierung der Funktionalität für die definierten Methoden
*Instantiierung der Klassen/Methoden für eigentliche Funktionalität



INCLUDE Z_S05_DEALINGSWEETSTOP.
*INCLUDE zsd_grp2_dealingsweetstop.               " Global Data
INCLUDE Z_S05_DEALINGSWEETSF01.
*INCLUDE zsd_grp2_dealingsweetsf01.               " FORM-Routines



SELECTION-SCREEN BEGIN OF SCREEN 9000.

  PARAMETERS p_artnr TYPE z_artnr_grp2 DEFAULT 001.
  PARAMETERS p_neupr TYPE z_vp_brutto_grp2.
  PARAMETERS P_artgrp TYPE z_artgrp_grp2.
*PARAMETERS p_aus RADIOBUTTON GROUP rb_1.
*
*  PARAMETERS p_ein RADIOBUTTON GROUP rb_1.


SELECTION-SCREEN END OF SCREEN 9000.






*********************************************************************************



AT SELECTION-SCREEN OUTPUT.

*  BREAK-POINT.

  LOOP AT SCREEN.

    CASE sy-tcode.

*      WHEN 'ZSD_G2_ARTSUCHE'.
*        IF screen-name = 'P_ARTNR'.
**          screen-active = 0.
**          screen-invisible = 1.
*        ENDIF.
*        MODIFY SCREEN.


      WHEN 'ZSD_G2_VKCHANGE'.
        IF screen-name = 'P_ARTGRP' OR Screen-name = '%_P_ARTGRP_%_APP_%-TEXT'.
          screen-active = 0.
          screen-invisible = 1.
        ENDIF.
        MODIFY SCREEN.
*
      WHEN 'ZSD_G2_WARENBESTAND'.
        IF screen-name = 'P_ARTNR' OR Screen-name = '%_P_ARTNR_%_APP_%-TEXT'
        OR screen-name = 'P_NEUPR' OR screen-name = '%_P_NEUPR_%_APP_%-TEXT' .
        screen-active = 0.
        screen-invisible = 1.
      ENDIF.
      MODIFY SCREEN.
*
    WHEN 'ZSD_G2_AUSLISTEN'.
      IF screen-name = 'P_NEUPR' OR screen-name = '%_P_NEUPR_%_APP_%-TEXT'
        or screen-name = 'P_ARTGRP' OR screen-name = '%_P_ARTGRP_%_APP_%-TEXT'.
*        or screen-name = 'p_aus' or  screen-name = 'p_ein'  ."Parametername
          screen-active = 0.
          screen-invisible = 1.
      ENDIF.
      MODIFY SCREEN.

    WHEN OTHERS.
  ENDCASE.

ENDLOOP.


************************************************************************

AT SELECTION-SCREEN.

*  DATA lo_miniprojekt TYPE REF TO lcl_miniprojekt.

  DATA(lo_miniprojekt) = NEW lcl_miniprojekt( ).

  CASE sy-tcode.

    WHEN 'ZSD_G2_WARENBESTAND'.

      lo_miniprojekt->waren_bst_liste(
      EXPORTING
        im_artgruppe =  p_artgrp
          ).


*    WHEN 'ZSD_G2_ARTSUCHE'.
*      lo_miniprojekt->such_methode(
*      EXPORTING
*      im_artnr = p_artnr
*      IMPORTING
*      ex_stam  = gs_artikel
*       ).

    WHEN 'ZSD_G2_VKCHANGE'.
      lo_miniprojekt->vkchange(
      EXPORTING
      im_anr_v = p_artnr
      im_vkcha = p_neupr
      ).


    WHEN 'ZSD_G2_AUSLISTEN'.
      lo_miniprojekt->auslisten( im_artnr = p_artnr ).



    WHEN OTHERS.
      " nichts weiter
  ENDCASE.
