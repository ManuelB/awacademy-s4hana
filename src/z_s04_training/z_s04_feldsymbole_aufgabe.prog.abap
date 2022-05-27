*&---------------------------------------------------------------------*
*& Report Z_S04_FELDSYMBOLE_AUFGABE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s04_feldsymbole_aufgabe.

*Aufgabe: Implementiere INCLUDE z_t04_i_flugdaten mit den dir bereits bekannten Flugdaten aus dem SAP Flugdatenmodell.
* In der lokalen Tabelle SPFLI sollen alle Verbindungen, die nach Frankfurt gehen und von Frankfurt kommen auf Düsseldorf umgeleitet werden.
* Ändere die Daten in der internen Tabelle
* Gib die neuen Verbindungen aus.

INCLUDE z_t04_i_flugdaten.
"DATA lt_spfli TYPE TABLE OF spfli.

FIELD-SYMBOLS <spfli> TYPE spfli.

LOOP AT lt_spfli ASSIGNING <spfli> WHERE cityto EQ 'FRANKFURT' OR cityfrom EQ 'FRANKFURT'.

  IF <spfli>-cityto EQ 'FRANKFURT'.
    <spfli>-cityto = 'DÜSSELDORF'.
    <spfli>-airpto = 'DUS'.
  ENDIF.

  IF <spfli>-cityfrom EQ 'FRANKFURT'.
    <spfli>-cityfrom = 'DÜSSELDORF'.
    <spfli>-airpfrom = 'DUS'.
  ENDIF.

WRITE: / |FROM: { <spfli>-cityfrom } TO: { <spfli>-cityto }|.

ENDLOOP.

MESSAGE 'Alle Flüge von und nach Frankfurt starten und landen in Düsseldorf !' TYPE 'I' DISPLAY LIKE 'E'.
