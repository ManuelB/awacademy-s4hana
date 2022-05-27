*&---------------------------------------------------------------------*
*& Report Z_S01_WDH_Z4
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s01_wdh_z4.

*verstanden.


* Flugdaten

BREAK-POINT. "  um in den debugger zu kommen.

*Grundvorraussetzung: Zugriff auf die Tabellen.

INCLUDE z_t04_i_flugdaten. "Enthällt bereits erzeugte Tabellen mit selektierten Flugdaten.
*Befehl beinhaltet folgende Daten:
*DATA lt_spfli    TYPE TABLE OF spfli   . Flugplan Keys: Mandant, Fluggesellschaft, Verbindungsnummer
*DATA lt_sflight  TYPE TABLE OF sflight . Flüge (Mandant, Kennung der Fluggesellschaft, Verbindungsnummer, Flugdatum)
*DATA lt_scarr    TYPE TABLE OF scarr   . Fluggesellschaften (Mandant, Kennung der Fluggesellschaft)
*DATA lt_sbook    TYPE TABLE OF sbook   . FLugbuchungen (Mandant, Kennung der Fluggesellschaft, Verbindungsnummer)
*DATA lt_scustom  TYPE TABLE OF scustom . Kunden (Mandant, Kundennummer)
*DATA lt_scounter TYPE TABLE OF scounter. Verkaufsstellen  (Mandant, Kennung der Fluggesellschaft, Verbindungsnummer, Nummer der Verkaufsstelle)
*DATA lt_SBUSPART TYPE TABLE OF SBUSPART. Geschäftspartner (Mandant, Nummer des Partners)
*und noch mehr...

*Aufgabe: Anhand eines ausgewählten Kunden soll eine Liste seiner bisherigen Buchungen angegeben werden.

*Müssen jede Struktur und dessen typisierung derklarieren, damit wir die Struktur gleich nutzen, um zu speichern.
*Doppelklick, um Attribute & Datentypen für Tabelle zu sehen.
DATA ls_spfli    TYPE spfli   .
DATA ls_sflight  TYPE sflight .
DATA ls_scarr    TYPE scarr   .
DATA ls_sbook    TYPE sbook   .
DATA ls_scustom  TYPE scustom .
DATA ls_scounter TYPE scounter.
DATA ls_SBUSPART TYPE sbuspart.

PARAMETERS: p_kunde TYPE scustom-id. "Parameter wird auf Variablenformat im Strukturentyp typisiert. Mit F1 kann man...

*Übergabe der Verbindungsdaten
*liest alle Zeilen in der Tabelle und überträgt alle Einträge zur Struktur, die der Bedingung entsprechen.
LOOP AT lt_sbook INTO ls_sbook WHERE customid = p_kunde.
*  "liest lt_spfli mit Schlüssel (Attribut) connid, kopiert sie in Struktur ls_spfli, wo die Bedingung stimmt.
  READ TABLE lt_spfli INTO ls_spfli WITH KEY connid = ls_sbook-bookid. "  READ TABLE lt_spfli WITH KEY connid = ls_sbook-bookid INTO ls_spfli.


*übergabe der Fluggesellschaft
*sucht nach Bedingung bei Einträgen, überträgt Einträge nach ls_scarr, die dieser entsprechen.
  READ TABLE lt_scarr WITH KEY carrid = ls_sbook-carrid INTO ls_scarr.


*Drückt die Daten aus.
  WRITE: / |Flug: { ls_sbook-fldate DATE = ISO } { ls_scarr-carrname } FROM:{ ls_spfli-cityfrom } TO:{ ls_spfli-countryto }|.


ENDLOOP.
*Nützlich. 0 = keine Prolbeme. Alles andere fehler.
"Message: Drückt Nachricht aus. Typ entscheidet über Typ."
*  S = beendet nicht programm, E = beendet nach MEssage.

IF sy-subrc <> 0.  "Implementierter Rückgabewert.
  MESSAGE: |Keine Buchung für diesen Kunden gefunden. | TYPE 'S'.

ENDIF.
