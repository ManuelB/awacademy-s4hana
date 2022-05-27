*&---------------------------------------------------------------------*
*& Report Z_S01_WDH_Z5
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s01_wdh_z5.


*Verstanden.
*Ranges

INCLUDE z_t04_i_flugdaten.

*Mit Ranges kann man abfragen ob ein oder mehrere Werte in einer Range enthalten ist.
*Es wird eine range Tabelle gebaut. Spezieller typ von Tabelle.
*Select options erstellt eine Interne Tabelle und wird mit einem selection screens genutzt.
*Ranges baut auch eine interne range Tabelle ohne die Verbindung zu einem selection screen.
*Ich kann anhand der Internen Tabelle Selektionsmerkmale (sign,option, low high) nutzen.
*in unserem Beispiel haben wir über eine interne tabelle geloopt,
*mit der Bedingung, dass ein bestimmtes Feld der Tabelle einen Wert zwischen 500 und 1000 hatte.
*die felder low und high bedeuten immer von-bisniedrigste und der höchste wert . (Intervalle). Können mehrere sein.


*Initialisiert Tabelle, die wir brauchen.
TABLES scarr.

*Typsiert lokale struktur mit strukturtyp scarr.
DATA ls_scarr TYPE scarr.

* Deklaration eines Selektionskriteriums mit Range-tabelle. Gleiche Funktion wie Ranges.

"Sortiert Kurzbezeichnungen der Fluggesellschaft.
SORT lt_scarr BY carrid.

*Überträgt lt_scarr zu ls. Keine Bedingung.
LOOP AT lt_scarr INTO ls_scarr .
  WRITE: / |{ ls_scarr-carrid } - { ls_scarr-carrname }|.
ENDLOOP.
IF sy-subrc <> 0.
  MESSAGE:  |Keine Fluggeselschaft gefunden.| TYPE 'S'. " Hie wird der harte Error am Ende abgefangen.
ENDIF.

*TYPISIERUNG der Range. alte deklaration.
*RANGES lr_range FOR scarr-carrid.

*Neue Deklaration
DATA lr_range TYPE RANGE OF  scarr-carrid.
*Nur deklaration der Struktur.
DATA ls_range LIKE LINE OF lr_range.

*Befüllen der Range mit Daten
ls_range-sign   = 'I'. " SIGN I oder E Include und exclude von Werten
ls_range-option = 'EQ'. " OPTION EQ = "=", BT = Between low bis high einschließlich, cp = beinhaltet Mustersuche
ls_range-low    = 'LH'. " LOW unterster Wert
ls_range-high   = ''. " HIGH höchster Wert,

APPEND ls_range TO lr_range.

*AUFGABE: Einschränkungkriterium Buchungsdatum 29.03.2021 UND zwischen 500 und 1000€ Kosten der Buchung.

*Deklaration von Struktur.
DATA ls_sbook TYPE sbook.

*Deklaration von Table.
DATA lt_sbook_result TYPE TABLE OF sbook.

*Deklaration vor LR-Tables. Und einer lokalen Variable.
DATA lr_datum TYPE RANGE OF  sbook-order_date.
DATA ls_datum LIKE LINE OF lr_Datum.


DATA lr_value TYPE RANGE OF sbook-forcuram.


DATA ls_value LIKE LINE OF lr_value.
*line of erstellt eine Struktur der Zeile der Tabelle die angegeben wird.

DATA lv_currency TYPE sbook-forcurkey VALUE 'EUR'.

*Befüllen der Range mit Daten
ls_datum-sign   = 'I'.
ls_datum-option = 'EQ'.
ls_datum-low    = '20210928'.
*lr_datum-high   = ''. Explizit leer, weil nur ein Wert.
APPEND ls_datum TO lr_datum.

*Befüllen der Range mit Daten
ls_value-sign   = 'I'.
ls_value-option = 'BT'.
ls_value-low    = 500.
ls_value-high   = 1000.
APPEND ls_value TO lr_value.


*Mehrere Suchkriterien.
LOOP AT lt_sbook INTO ls_sbook
  WHERE
  order_date IN lr_datum AND
  forcurkey EQ lv_currency AND
  Forcuram IN lr_value
  .

  APPEND ls_sbook TO lt_sbook_result.

ENDLOOP.

BREAK-POINT.
