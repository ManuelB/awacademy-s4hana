*&---------------------------------------------------------------------*
*& Report Z_S01_FELDSYMBOL_AUFGABE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s01_feldsymbol_aufgabe.

INCLUDE z_t04_i_flugdaten.

*Verstanden.

*Brauchen keine Struktur, weil man mit dem Feldsymbol direkt zugreifen kann.
*Aufgabe: Implentiere das INCLUDE z_t04_i_flugdaten mit den dir bereits bekannten Flugdaten aus dem SAP Flugdatenmodell.
*         In der Lokalen Tabelle SPFLI sollen alle Verbindungen, die nach Frankfurt gehen und von Frankfurt kommen auf Düsseldorf umgeleitet werden.
*         Ändere die Daten in der internen Tabelle.
*         Gib die neuen Verbindungen aus.

INCLUDE z_t04_i_flugdaten.
*DATA lt_spfli   TYPE TABLE OF spfli. " Bereits in Include deklariert

*FIELD-SYMBOLS <spfli> TYPE spfli. "Übliche Deklaration des Feldsymbols

*LOOP über die Flugverbindungen abhängig von der Start- und Endstadt mit Inline-Deklaration des Feldsymbols.
LOOP AT lt_spfli ASSIGNING FIELD-SYMBOL(<spfli>) WHERE cityfrom EQ 'FRANKFURT' OR cityto EQ 'FRANKFURT'.
  IF <spfli>-cityfrom EQ 'FRANKFURT'. " Sucht nach Eintrag.
    <spfli>-cityfrom = 'DÜSSELDORF'. "modifiziert Eintrag im Table
    <spfli>-airpfrom = 'DUS'.  "modifiziert Eintrag im Table
*dasselbe hier.
  ELSEIF <spfli>-cityto EQ 'FRANKFURT'.
    <spfli>-cityto = 'DÜSSELDORF'.
    <spfli>-airpto = 'DUS'.

  ELSE.
*    Fehlernachricht.
    MESSAGE:|Es wurden unerwartete Daten selektiert. FROM:{ <spfli>-cityfrom } TO:{ <spfli>-cityto }| TYPE 'E'.
  ENDIF.

ENDLOOP.

*Weist einem FeldSymbol  die aktuelle Zeile zu.
LOOP AT lt_spfli ASSIGNING <spfli>.

* Gesonderte Formatierung unserer geänderten Zeilen
  FORMAT COLOR off.
  IF <spfli>-airpfrom EQ 'DUS' OR <spfli>-airpto EQ 'DUS'.
    FORMAT COLOR 6.
  ENDIF.

* Ausgabe aller Daten
  WRITE: / |ConnID:{ <spfli>-connid } From:{ <spfli>-cityfrom } TO:{ <spfli>-cityto }|.
ENDLOOP.
