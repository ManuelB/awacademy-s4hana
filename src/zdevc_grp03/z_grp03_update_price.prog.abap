*&---------------------------------------------------------------------*
*& Report Z_GRP03_UPDATE_PRICE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_GRP03_UPDATE_PRICE MESSAGE-ID ZMSG_demo.

SELECTION-SCREEN BEGIN OF BLOCK 001 WITH FRAME.
  PARAMETERS:

  p_artnr type ZGRP03_sweets-artikelnummer,
   p_preis type ZGRP03_sweets-vk_brutto.

SELECTION-SCREEN END OF BLOCK 001.


*if p_preis <=  '1.25' * p_preis  and p_artnr = 'ZGRP03_sweets-artikelnummer'.
*
*update ZGRP03_sweets set vk_brutto = p_preis
*where artikelnummer = p_artnr.
*
*else .
*  write :  'Fehler : der neue Verkaufspreis mind. 25% über dem aktuellen VK liegt.'.
*
*endif.


    SELECT SINGLE * FROM zgrp03_sweets INTO @DATA(x) WHERE artikelnummer = @p_artnr.
      IF x-vk_brutto * '1.25' >= p_preis.
        UPDATE zgrp03_sweets
              SET vk_brutto = @p_preis,
                datum = @sy-datum,
                uname = @sy-uname
              WHERE artikelnummer = @p_artnr.
        MESSAGE |Der Artikelpreis wurde erfolgreich auf { p_preis } € geändert!| TYPE 'I'.
*      ENDIF.
*      IF sy-subrc <> 0.
      else.
      MESSAGE e000 WITH p_artnr.
      endif.
*      ELSE.
**        sucess
*        COMMIT WORK.
*      ENDIF.

* SELECT artikelgruppe, artikelnummer, aktueller_lagerbestand, vk_brutto
*      into @data(ex_tabelle)
*      FROM zgrp03_sweets
*      WHERE artikelnummer = @p_artnr.
*      ENDSELECT.
**      if sy-subrc <> 0.
**      Message (e000) with im_artnr.
**      endif.
*
**     BREAK-POINT.
