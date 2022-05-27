*&---------------------------------------------------------------------*
*& Include          ZMP_GRP03_DEALING_SWEETSF01
*&---------------------------------------------------------------------*


CLASS lcl_sweets IMPLEMENTATION.

  METHOD articlelist. " to get the warenbestandlist

    SELECT artikelgruppe, artikelnummer, aktueller_lagerbestand, vk_brutto
    INTO @DATA(ex_list)
    FROM zgrp03_sweets
    WHERE artikelnummer = @im_artnr
    AND artikelgruppe = @im_artgr
    AND activeflag = @abap_true.

    ENDSELECT.

    IF sy-subrc <> 0.
      MESSAGE e012.
    ELSE.
*      COMMIT WORK.
      cl_demo_output=>display( ex_list ).
*          WRITE: ex_tabelle-artikelnummer, ex_tabelle-artikelgruppe, ex_tabelle-aktueller_lagerbestand, ex_tabelle-vk_brutto.
    ENDIF.
*

  ENDMETHOD.

  METHOD delistarticle. "to deactivate the article for selection
    SELECT SINGLE * FROM zgrp03_sweets INTO @DATA(x) WHERE artikelnummer = @im_artnr.
    IF im_artnr = x-artikelnummer.
      IF x-min_bestand > x-aktueller_lagerbestand.
        UPDATE zgrp03_sweets
            SET activeflag = ' ',
                datum = @sy-datum,
                uname = @sy-uname
            WHERE artikelnummer = @im_artnr AND activeflag = 'X'.
        MESSAGE |Der Artikel { im_artnr } wurde erfolgreich ausgelistet!| TYPE 'I'.
      ELSE.
        MESSAGE |Der Artikel { im_artnr } konnte nicht ausgelistet werden, da der aktuelle Lagerbestand von { x-aktueller_lagerbestand } höher ist als der erforderliche Mindestbestand von { x-min_bestand }!| TYPE 'E'.
        EXIT.
      ENDIF.
    ELSE.
      MESSAGE e000 WITH im_artnr.
      IF sy-subrc <> 0.
        MESSAGE e005 WITH im_artnr.
      ELSE.
        COMMIT WORK.
      ENDIF.
    ENDIF.
  ENDMETHOD.

  METHOD newarticleprice. "to change the price
* import artikelnummer aus selection screen.

    SELECT SINGLE * FROM zgrp03_sweets INTO @DATA(x) WHERE artikelnummer = @im_artnr.
    IF im_artnr = x-artikelnummer.
      IF x-vk_brutto * '1.25' >= im_preis.
        UPDATE zgrp03_sweets
              SET vk_brutto = @im_preis,
                datum = @sy-datum,
                uname = @sy-uname
              WHERE artikelnummer = @im_artnr.
        MESSAGE |Der Artikelpreis wurde erfolgreich auf { im_preis } € geändert!| TYPE 'I'.
      ELSE.
        MESSAGE e002 WITH im_preis.
      ENDIF.
      IF sy-subrc <> 0.
*     MESSAGE e000 WITH im_artnr.
      ELSE.
*        sucess
        COMMIT WORK.
      ENDIF.
    ELSE.
      MESSAGE e000 WITH im_artnr.
    ENDIF.





  ENDMETHOD.

ENDCLASS.
