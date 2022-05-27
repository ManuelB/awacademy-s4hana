*&---------------------------------------------------------------------*
*& Report Z_S12_RANGES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s12_ranges.
INCLUDE Z_T04_I_Flugdaten.
TABLES scarr.

DATA ls_scarr TYPE scarr.


*********************************************************************************************
*Beispiel scarr
SELECT-OPTIONS so_carr FOR scarr-carrid.

SORT  lt_scarr BY carrid. "ASCENDING.
LOOP AT lt_scarr INTO ls_scarr WHERE carrid IN so_carr.

  WRITE: / |{ ls_scarr-carrid } - { ls_scarr-carrname }|.

ENDLOOP.
IF sy-subrc <> 0.
  MESSAGE: |Keine Fluggesellschaft gefunden| TYPE 'S'.

ENDIF.
*
**SELECT OPTIONS > Ranges
**Beispiel SCARR
*SELECT-OPTIONS so_carr FOR scarr-carrid NO INTERVALS DEFAULT 'ZZ' .  "ZZ = Leer
**
*SORT lt_scarr BY carrid.
*
*LOOP AT lt_scarr INTO ls_scarr WHERE carrid IN so_carr.
*  WRITE: / |{ ls_scarr-carrid } - { ls_scarr-carrname }|.
*ENDLOOP.
*IF sy-subrc <> 0.
*  MESSAGE:  |Keine Fluggeselschaft gefunden.| TYPE 'S'.
*ENDIF.
*
***********************************************************************************************
**RANGES Reichweiten
*"Tabelle aller Transaktionscodes
**Beispiel TSTC - Tabelle aller Transaktionscodes in SE16 ansehen, TCODE über SELECT-OPTION der SE16 einschränken.
**
**DATA lt_tstc TYPE TABLE OF tstc.
**DATA ls_tstc TYPE tstc.
**
**Typisierung der Range
***********************************************************************************************
**Neue Formulierung
*DATA lr_range TYPE RANGE OF scarr-carrid.
*DATA ls_range LIKE LINE OF lr_range. "Rangestruktur und nicht mehr Kopftzeile der Range-Tabelle
*
***********************************************************************************************
*Alte Formulierug
*RANGES lr_range FOR sbook-carrid. "Equivalent zu SELECT-OPTIONS
**lr_range ist jetzt auch eine lokale Struktur mit dem Namen lr_range
*APPEND lr_range TO lr_range.
*
**
**DATA lt_sbook_result TYPE TABLE OF sbook.
**lr_range-sign     = 'I'.  "Include/Exclude
**lr_range-option   = 'EQ'. "Welche Beziehung haben die Felder zueinandner
**lr_range-low      = 'LH'.
**lr_range-high     = ''.
**AUFGABE: Einschränkungkriterium Buchungsdatum 29.03.2021 UND zwischen 500 und 1000€ Kosten der Buchung.
*
*DATA ls_sbook TYPE sbook.
*DATA lt_sbook_result TYPE TABLE OF sbook.
*
**Obsolete Formulierung
**RANGES lr_rangedate FOR sbook-order_date.
**RANGES lr_rangeprice FOR sbook-forcuram.
**Neue Deklaration
*DATA lr_rangedate TYPE RANGE OF sbook-order_date.
*DATA ls_rangedate LIKE LINE OF lr_rangedate. "Erzeugt Struktur einer Zeile die angegebn wird
*
*DATA lr_rangeprice TYPE RANGE OF sbook-forcuram.
*DATA ls_rangeprice LIKE LINE OF lr_rangeprice.
*
*DATA lv_currency TYPE sbook-forcurkey VALUE 'EUR'.
*
*
*ls_rangedate-sign   = 'I'.
*ls_rangedate-option = 'EQ'.
*ls_rangedate-low    = '20210928'. "Für das Datum die RAW Datumsanzeige verwenden
*ls_rangedate-high   = ''.
*APPEND ls_rangedate TO lr_rangedate.
*
*ls_rangeprice-sign   = 'I'.
*ls_rangeprice-option = 'BT'.
*ls_rangeprice-low    = 500.
*ls_rangeprice-high   = 1000.
*APPEND ls_rangeprice TO lr_rangeprice.
*
*
**lr_rangedate =  '09/28/2021'.
**Write: / lr_rangedate.
**lr_rangeprice = 'I', 500 to 1000.
**Write: / lr_rangeprice.
*
*LOOP AT lt_sbook INTO ls_sbook
*  WHERE
*  order_date IN lr_rangedate
*  AND forcurkey EQ lv_currency
*  AND forcuram IN lr_rangeprice.
*  .
*  APPEND ls_sbook TO lt_sbook_result.
*  IF  sy-subrc <> 0.
*    WRITE: / |Keine Buchung mit diesen Spezifikationen gefunden!|.
*  ENDIF.
*
*ENDLOOP.
*
**data lt_OBSOLET type table of scarr WITH HEADER LINE.
*
*
**BREAK-POINT.
*
*INCLUDE z_t04_i_flugdaten.
*
*TABLES scarr.
*
*DATA ls_scarr TYPE scarr.
*
**SELECT OPTIONS > Ranges
**Beispiel SCARR
*SELECT-OPTIONS so_carr FOR scarr-carrid NO INTERVALS DEFAULT 'ZZ' .  "ZZ = Leer
*
*SORT lt_scarr BY carrid.
*
*LOOP AT lt_scarr INTO ls_scarr WHERE carrid IN so_carr.
*  WRITE: / |{ ls_scarr-carrid } - { ls_scarr-carrname }|.
*ENDLOOP.
*IF sy-subrc <> 0.
*  MESSAGE:  |Keine Fluggeselschaft gefunden.| TYPE 'S'.
*ENDIF.
