*&---------------------------------------------------------------------*
*& Report Z_AW07_FELDSYMBOLE_AUFGABE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_aw07_feldsymbole_aufgabe.

*Aufgabe: Implentiere das INCLUDE z_t04_i_flugdaten mit den dir bereits bekannten Flugdaten aus dem
*SAP Flugdatenmodell.In der Lokalen Tabelle SPFLI sollen alle Verbindungen, die nach Frankfurt gehen
*und von Frankfurt kommen auf Düsseldorf umgeleitet werden.Ändere die Daten in der internen Tabelle.
*Gib die neuen Verbindungen aus.

INCLUDE z_t04_i_flugdaten.



*FIELD-SYMBOLS <city> TYPE spfli.

*HK Code
*LOOP AT lt_spfli ASSIGNING <city> WHERE cityfrom = |FRANKFURT| OR cityto = |FRANKFURT|.
*  if cityfrom = |FRANKFURT|
*  <city>-cityfrom = 'DUESSELDORF'.
*  <city>-cityto = 'DUESSELDORF'.
*ENDLOOP.
*BREAK-POINT.


LOOP AT lt_spfli ASSIGNING FIELD-SYMBOL(<spfli>) WHERE cityfrom EQ 'FRANKFURT' OR cityto EQ 'FRANKFURT'.
  IF <spfli>-cityfrom EQ 'FRANKFURT'.
    <spfli>-cityfrom = 'DÜSSELDORF'.
    <spfli>-airpfrom = 'DUS'.

  ELSEIF <spfli>-cityto EQ 'FRANKFURT'.
    <spfli>-cityto = 'DÜSSELDORF'.
    <spfli>-airpto = 'DUS'.

  ELSE.
    MESSAGE:|Es wurden unerwartete Daten selektiert. FROM:{ <spfli>-cityfrom } TO:{ <spfli>-cityto }| TYPE 'E'.

  ENDIF.

ENDLOOP.

LOOP AT lt_spfli ASSIGNING <spfli>.

* Gesonderte Formatierung unserer geänderten Zeilen
  FORMAT COLOR off.
  IF <spfli>-airpfrom EQ 'DUS' OR <spfli>-airpto EQ 'DUS'.
    FORMAT COLOR 6.
  ENDIF.

* Ausgabe aller Daten
  WRITE: / |ConnID:{ <spfli>-connid } From:{ <spfli>-cityfrom } TO:{ <spfli>-cityto }|.
ENDLOOP.
