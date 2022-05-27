*&---------------------------------------------------------------------*
*& Report Z_S03_FLUGDATEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S03_FLUGDATEN.

*INCLUDE -> Enthällt bereits erzeugte Tabellen mit selektierten Flugdaten.
*Das Include und sein Inhalt sind erst Relevant im Modul "Modularisierung" bzw. "SQL"
*DATA lt_spfli    TYPE TABLE OF spfli   .
*DATA lt_sflight  TYPE TABLE OF sflight .
*DATA lt_scarr    TYPE TABLE OF scarr   .
*DATA lt_sbook    TYPE TABLE OF sbook   .
*DATA lt_scustom  TYPE TABLE OF scustom .
*DATA lt_scounter TYPE TABLE OF scounter.
*DATA lt_SBUSPART TYPE TABLE OF SBUSPART.

INCLUDE z_t04_i_flugdaten.

********************************************************************************************************************************************
*Aufgabe: Anhand eines ausgewählten Kunden soll eine Liste seiner bisherigen Buchungen angegeben werden.
********************************************************************************************************************************************

DATA ls_spfli    TYPE spfli   . "Deklaration einer lokalen Struktur anhand der Datenbanktabelle SPFLI
*DATA ls_sflight  TYPE sflight .
DATA ls_scarr    TYPE scarr   .
DATA ls_sbook    TYPE sbook   .
*DATA ls_scustom  TYPE scustom .
*DATA ls_scounter TYPE scounter.
*DATA ls_SBUSPART TYPE sbuspart.

PARAMETERS: p_kunde TYPE scustom-id DEFAULT '00000098'. "Es ist bereits eine Wertehilfe hinterlegt.

*Hole alle Buchungen des Kunden
LOOP AT lt_sbook INTO ls_sbook WHERE customid EQ p_kunde.

*Liefere Detaildaten zu den Buchungen
  "Übergabe der Verbindungsdaten
  READ TABLE lt_spfli WITH KEY connid = ls_sbook-connid INTO ls_spfli.
  "Übergabe der Fluggesellschaft
  READ TABLE lt_scarr WITH KEY carrid = ls_sbook-carrid INTO ls_scarr.

  WRITE: / |Flug: { ls_sbook-fldate DATE = ISO } #with:{ ls_scarr-carrname  } #from:{ ls_spfli-cityfrom } #to:{ ls_spfli-cityto }|.

ENDLOOP.
IF sy-subrc NE 0.
  MESSAGE: |Keine Buchung für diesen Kunden gefunden. | TYPE 'S'.
ENDIF.
