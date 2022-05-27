*&---------------------------------------------------------------------*
*& Report ZAWT03_T83
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZS01_T83.


*Deklaration von lokalen table und typisierung
 DATA:
  st_sflight  TYPE zawt03_ttype_st_sflight,
  st_spfli    TYPE zawt03_ttype_st_spfli,
  ht_sbook    TYPE zawt03_ttype_ht_sbook,
*


*Deklaration von lokalen table und typisierung
  st_bookings TYPE SORTED TABLE OF sbook
              WITH UNIQUE KEY carrid, connid, fldate,

*Brauchen wir, weil wir über select options darüber referenzieren.
  carrier     TYPE scarr,
  loc         TYPE spfli.


*Feldsymbole, weil Fixer geht.
FIELD-SYMBOLS: <flights>  TYPE sflight,
               <bookings> TYPE sbook.

*Eingabe
SELECTION-SCREEN BEGIN OF BLOCK a WITH FRAME TITLE TEXT-001.

  SELECT-OPTIONS: so_scarr FOR carrier-carrid,
                  so_spfli FOR loc-cityfrom.

SELECTION-SCREEN END OF BLOCK a.

INITIALIZATION.

*so_scarr-low = 'LH'

*Start der Verarbeitung.

*Ranges vereinfachen die Selektion von Datenbanken für den Anwender.

START-OF-SELECTION.

*Selektiert Daten nacheinander. Liest SPFLI, sflight
*------ INNER JOIN geschickter ?
*- get flight scheduling according to select options
  SELECT DISTINCT * INTO TABLE st_spfli
   FROM spfli
   WHERE carrid IN so_scarr
     AND cityfrom IN so_spfli.

*Dieser Teil ist mit einem Inner Join lösbar,

*- get flights according to selection from spfli
*Für alle Eintröge in der oben genannten Tabelle such ich die ID wo, Merkmal, die hier drin stehen.
if not st_spfli[] is INITIAL.
  SELECT * INTO TABLE st_sflight
    FROM sflight
    FOR ALL ENTRIES IN st_spfli
    WHERE carrid = st_spfli-carrid
      AND connid = st_spfli-connid.

*Suchen alle Buchungen und klatschen sie in die s_book
*- get bookings if applicable
  SELECT * INTO TABLE ht_sbook
  FROM sbook.

 LOOP AT st_sflight ASSIGNING <flights>.
    IF <flights> IS ASSIGNED.

********** Hash table ersetzen durch standard table ??

      READ TABLE ht_sbook ASSIGNING <bookings>
      WITH KEY carrid = <flights>-carrid
               connid = <flights>-connid.

      IF <bookings> IS ASSIGNED.
        READ TABLE st_bookings
        WITH KEY carrid = <bookings>-carrid
                 connid = <bookings>-connid
        TRANSPORTING NO FIELDS.
        IF NOT sy-subrc = 0.
          INSERT <bookings> INTO TABLE st_bookings.
        ENDIF.
      ENDIF.

    ENDIF.
  ENDLOOP.

  cl_demo_output=>display( st_bookings ).
