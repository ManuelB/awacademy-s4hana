*&---------------------------------------------------------------------*
*& Report Z_S02_FELDSYMBOLE_AUFGABE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s02_feldsymbole_aufgabe.

" Alle Flüge werden umgeleitet
" cityfrom und cityto ändern
" AUsgeben in

INCLUDE Z_T04_I_Flugdaten.


*DATA lt_spfli   TYPE TABLE OF spfli   .
*DATA lt_sflight TYPE TABLE OF sflight .
*DATA lt_scarr   TYPE TABLE OF scarr   .
*DATA lt_sbook   TYPE TABLE OF sbook   .
*DATA lt_scustom TYPE TABLE OF scustom .
*DATA lt_scounter TYPE TABLE OF scounter.
*DATA lt_SBUSPART TYPE TABLE OF SBUSPART.

FIELD-SYMBOLS <change> TYPE spfli.

LOOP AT lt_spfli ASSIGNING <change> WHERE Cityfrom EQ 'Frankfurt' OR Cityto EQ 'Frankfurt'.
  IF <change>-cityfrom = 'Frankfurt'.
    <change>-cityfrom = 'Düsseldorf'.
  ELSEIF <change>-cityto = 'Frankfurt'.
    <change>-cityto = 'Düsseldorf'.
  ELSE.
    MESSAGE: |Es wurden unerwartete Daten selektiert. FROM:{ <change>-cityfrom } TO:{ <change>-cityto }| TYPE 'E'.
  ENDIF.
ENDLOOP.

LOOP AT lt_spfli ASSIGNING <change>.

* Gesonderte Formatierung unserer geänderten Zeilen
  FORMAT COLOR OFF.
  IF <change>-airpfrom EQ 'DUS' OR <change>-airpto EQ 'DUS'.
    FORMAT COLOR 6.
  ENDIF.

* Ausgabe aller Daten
  WRITE: / |ConnID:{ <change>-connid } From:{ <change>-cityfrom } TO:{ <change>-cityto }|.
ENDLOOP.
