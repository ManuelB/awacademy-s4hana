*&---------------------------------------------------------------------*
*& Report Z_S05_XPROBE15
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s05_xprobe15.
TABLES: sscrfields.
DATA : ucom LIKE sy-ucomm.

SELECTION-SCREEN BEGIN OF BLOCK b1.



  PARAMETERS:

    p_filnu3 TYPE  zsd_grp2_filbest-filialnummer OBLIGATORY,
    p_filbe3 TYPE  zsd_grp2_filbest-filialbezeichnung,
    p_ort    TYPE   ad_city1   OBLIGATORY,
    p_str    TYPE   ad_street   OBLIGATORY,
    p_plz    TYPE    ad_pstcd1  OBLIGATORY,
    p_tel    TYPE    ad_tlnmbr1.

  SELECTION-SCREEN PUSHBUTTON  /01(29) but1 USER-COMMAND but1.
  SELECTION-SCREEN PUSHBUTTON  /01(29) but2 USER-COMMAND but2.
  SELECTION-SCREEN PUSHBUTTON  /01(29) but3 USER-COMMAND but3.

*p_carrid TYPE sflights-carrid,
*
*p_cityfr TYPE sflights-cityfrom.

SELECTION-SCREEN END OF BLOCK b1.

INITIALIZATION.
  but1 = 'Show'.
  but2 = 'Update'.
  but3 = 'Reset'.

AT SELECTION-SCREEN.

*SELECT SINGLE CITYFROM FROM sflights INTO p_cityfr WHERE carrid = p_carrid.
  ucom = sy-ucomm.
*AT SELECTION-SCREEN OUTPUT.

*  BREAK-POINT.

*  when 'BUT2'
  CASE ucom.



    WHEN 'BUT1'.

      SELECT SINGLE filialbezeichnung FROM zsd_grp2_filbest INTO p_filbe3 WHERE filialnummer = p_filnu3.
      SELECT SINGLE ort FROM zsd_grp2_filbest INTO p_ort WHERE filialnummer = p_filnu3.
            SELECT SINGLE  FOR UPDATE strasse FROM zsd_grp2_filbest INTO p_str WHERE filialnummer = p_filnu3.
      SELECT SINGLE  FOR UPDATE plz FROM zsd_grp2_filbest INTO p_plz WHERE filialnummer = p_filnu3.
        SELECT SINGLE   FOR UPDATE telefon FROM zsd_grp2_filbest INTO p_tel WHERE filialnummer = p_filnu3.
*
*   case sy-ucomm.

    WHEN 'BUT2'.

      if p_filnu3 is not initial and p_filbe3 is not initial and p_ort is not initial and p_str is not initial and p_plz is not initial.
      UPDATE zsd_grp2_filbest
      SET filialbezeichnung = p_filbe3

  ort = P_orT
  strasse = P_str
  plz = P_plz


      WHERE filialnummer = p_filnu3.

*     endcase.
else.
MESSAGE |Not selected!| TYPE 'E'.
  endif.

 WHEN 'BUT3'.
   clear: p_filnu3,
          p_filbe3,
          p_ort   ,
          p_str   ,
          p_plz   ,
          p_tel   .

  ENDCASE.


AT SELECTION-SCREEN OUTPUT.
  LOOP AT SCREEN.
    IF screen-name = 'P_FILBE3'
      OR screen-name = 'P_ORT'
      OR screen-name = 'P_STR'
      OR screen-name = 'P_PLZ'
      OR screen-name = 'P_TEL'.
      screen-input = 0.
    ENDIF.
    MODIFY SCREEN.
  ENDLOOP.


*    CASE sy-tcode.
*
*        when 'BUT1'.
  CASE ucom.

    WHEN 'b1'.




    WHEN 'BUT1'.
      LOOP AT SCREEN.
        IF screen-name = 'P_FILNU3'. "OR screen-name = '%_P_FILNU3_%_APP_%-TEXT' OR screen-name = 'FILIALNUMMER'.
          screen-input = 0.

        ENDIF.
        MODIFY SCREEN.
   IF screen-name = 'P_FILBE3'
      OR screen-name = 'P_ORT'
      OR screen-name = 'P_STR'
      OR screen-name = 'P_PLZ'
      OR screen-name = 'P_TEL'.
      screen-input = 1.
    ENDIF.
*clear p_filbe3.
      MODIFY SCREEN.
*              endcase.
    ENDLOOP.

     WHEN 'BUT2'.
      LOOP AT SCREEN.
        IF screen-name = 'P_FILNU3'. "OR screen-name = '%_P_FILNU3_%_APP_%-TEXT' OR screen-name = 'FILIALNUMMER'.
          screen-input = 0.
    endif.
       MODIFY SCREEN.
    endloop.

ENDCASE.


*
*IF screen-name = 'P_FILBE3' OR screen-name = '%_P_FILBE3_%_APP_%-TEXT'
*        or screen-name = 'P_ORT' or screen-name = '%_P_ORT_%_APP_%-TEXT'
*        or screen-name = 'P_STR' or screen-name = '%_P_STR_%_APP_%-TEXT'
*        or screen-name = 'P_PLZ' or screen-name = '%_P_PLZ_%_APP_%-TEXT'
*        or screen-name = 'P_TEL' or screen-name = '%_P_TEL_%_APP_%-TEXT'.
*        screen-active = 1.
*        screen-invisible = 0.
*      ENDIF.
