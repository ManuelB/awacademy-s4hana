*&---------------------------------------------------------------------*
*& Report Z_S09_FELDSYMBOLE_AUFGABE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S09_FELDSYMBOLE_AUFGABE.

INCLUDE Z_T04_I_FLUGDATEN.

"DATA ls_spfli TYPE c.

"DATA lt_spfli TYPE TABLE OF lty_spfli.

FIELD-SYMBOLS <flight> TYPE spfli.

LOOP AT lt_spfli ASSIGNING <flight> WHERE CITYFROM EQ 'FRANKFURT' OR cityto EQ 'FRANKFURT'.
  IF <flight>-cityfrom = 'FRANKFURT'.
    <flight>-cityfrom = 'DÜSSELDORF'.
    <flight>-airpfrom = 'DUS'.
    ENDIF.

    WRITE: / <flight>-carrid, <flight>-cityfrom, <flight>-airpfrom, <flight>-cityto.

  ENDLOOP.
