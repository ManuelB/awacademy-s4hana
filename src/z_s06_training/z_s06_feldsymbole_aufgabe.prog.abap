*&---------------------------------------------------------------------*
*& Report Z_S06_FELDSYMBOLE_AUFGABE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s06_feldsymbole_aufgabe.

INCLUDE z_t04_i_flugdaten.
"Data lt_spfli TYPE TABLE OF spfli.

FIELD-SYMBOLS <spfli> TYPE spfli.

LOOP AT lt_spfli
  ASSIGNING <spfli>
  WHERE cityto EQ 'FRANKFURT'
  OR airpto EQ 'FRA'.

  IF <spfli>-cityto EQ 'FRANKFURT'.
    <spfli>-cityto  = 'DÜSSELDORF'.
  ENDIF.

  IF
  <spfli>-airpto EQ 'FRA'.
    <spfli>-airpto  = 'DUS'.

  ENDIF.
ENDLOOP.


"WRITE <spfli>-carrid, <spfli>-connid, <spfli>-countryfr, <spfli>-cityfrom, <spfli>-airpfrom, <spfli>-countryto, <spfli>-cityto, <spfli>-airpto, <spfli>-fltime, <spfli>-deptime, <spfli>-arrtime, <spfli>-distance.
