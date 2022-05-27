*&---------------------------------------------------------------------*
*& Report ZAWS12_TABELLEN_UEBUNG
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zaws12_tabellen_uebung.

DATA: "definieren von versch. internen Tabellen zum laden von Daten
  "mit unterschiedlichen Strukturen und Zugriffsmöglichkeiten
  sot_sflight  TYPE zaws12_ttyp_sot_sflight, "sot = sorted table
  sot_spfli    TYPE zaws12_ttyp_sot_spfli,
  ht_sbook     TYPE zaws12_ttyp_ht_test1,

  sot_bookings TYPE SORTED TABLE OF sbook
                 WITH UNIQUE KEY carrid, connid, fldate, "Schlüsselfelder carrid, connid, fldate

  carrier      TYPE scarr, "für select options / Auswahlfelder
  loc          TYPE spfli. "ich definiere für die SELECT OPTIONS die Felder mit dne Strukture --> waren davor nicht bekannt


FIELD-SYMBOLS: <flights>  TYPE sflight,
               <bookings> TYPE sbook.

SELECTION-SCREEN BEGIN OF BLOCK a WITH FRAME TITLE TEXT-001.

  SELECT-OPTIONS: so_scarr FOR carrier-carrid, "Ersatz für die TABLES Anweisung
                  so_spfli FOR loc-cityfrom. "muss Typisiert werden --> darum Zeilen 17/18
  "bei PARAMETERS ist die Typisierung bereits enthalten
SELECTION-SCREEN END OF BLOCK a.

START-OF-SELECTION. "Definition eines Ereignisses ähnlich wie INITIALISATION --> Zeitpunkt
  "Jetzt gehts los mit der reinen Datenverarbeitung

  SELECT DISTINCT * INTO TABLE sot_spfli
    FROM spfli
    WHERE carrid IN so_scarr
    AND cityfrom IN sot_spfli. "sind in spfli zu finden

  SELECT * INTO TABLE sot_sflight
    FROM sflight
    FOR ALL ENTRIES IN sot_spfli "nimm mir alle Einträge aus sot_spfli auf die carrid und connid zutreffen
    WHERE carrid = sot_spfli-carrid
      AND connid = sot_spfli-connid.

  SELECT * INTO TABLE ht_sbook "such mir alle Flugbuchungen und pack mir die in dne Hashtable-sbook
    FROM sbook.

  LOOP AT sot_sflight ASSIGNING <flights>.
    IF <flights> IS ASSIGNED.

      READ TABLE ht_sbook ASSIGNING <bookings>
      WITH KEY carrid = <flights>-carrid
               connid = <flights>-connid.

      IF <bookings> IS ASSIGNED.
        READ TABLE sot_bookings
        WITH KEY carrid = <flights>-carrid
                 connid = <flights>-connid
                 TRANSPORTING NO FIELDS.
        IF  NOT sy-subrc = 0.
          INSERT <bookings> INTO TABLE sot_bookings.
        ENDIF.
      ENDIF.
    ENDLOOP.
