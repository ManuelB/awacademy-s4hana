*&---------------------------------------------------------------------*
*& Report Z_S12_FLUGDATEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s12_flugdaten.


*DATA lt_spfli   TYPE TABLE OF spfli   .
*DATA lt_sflight TYPE TABLE OF sflight .
*DATA lt_scarr   TYPE TABLE OF scarr   .
*DATA lt_sbook   TYPE TABLE OF sbook   .
*DATA lt_scustom TYPE TABLE OF scustom .
*DATA lt_scounter TYPE TABLE OF scounter.
*DATA lt_SBUSPART TYPE TABLE OF SBUSPART.
INCLUDE Z_t04_i_Flugdaten.
*PARAMETERS: p_kunde TYPE scustom-id.
*PARAMETERS: p_custom TYPE sbook-connid.

*TYPES: BEGIN OF lty_s_user, "Strukturtyp
*         Abflugstatd(20) TYPE c,
*         Ankunftstadt(20) TYPE c,
*         Distanz    TYPE i,
*       END OF lty_s_user
*       .
*
*DATA ls_user TYPE lty_s_user. "lokale Struktur _ user
*DATA lt_user TYPE TABLE OF lty_s_user. "Interne Tabelle des Types unseres Strukturtypes #deutsch



*LOOP AT lt_sbook INTO lt_user where ls_sbook-connid EQ 00001682.
*IF sbook-connid EQ 00001682.
*  WRITE: / |Abflugstadt: { CITYFROM }|.
*  WRITE: / |Ankunftsstadt: { CITYTO }|.
*  WRITE: / |Distanz: { DISTANCE }|.
*ELSE.
*  WRITE: / |Ein Kunde mit diesem Namen konnte nicht gefunden werden|.
*ENDLOOP.
*LOOP AT spfli where spfli-.
*
*ENDLOOP.

*
*ENDIF.

*BREAK-POINT.
****************************************************************************************************************************
* Lösung von Robin
****************************************************************************************************************************
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

DO  TIMES.

ENDDO.

WHILE .

ENDWHILE.
