*&---------------------------------------------------------------------*
*& Report Z_S11_FELDSYMBOLE_AUFGABE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s11_feldsymbole_aufgabe.


INCLUDE Z_t04_i_flugdaten.

*Data lt_spfli type TABLE OF spfli.

FIELD-SYMBOLS <flight> TYPE spfli.

LOOP AT lt_spfli ASSIGNING <flight> WHERE cityfrom = 'FRANKFURT' OR cityto = 'FRANKFURT'.

  IF <flight>-cityfrom = 'FRANKFURT'.
    <flight>-cityfrom = 'DÜSSELDORF'.
   <flight>-airpfrom = 'DUS'.
   FORMAT COLOR 6.
  ELSEIF <flight>-cityto = 'FRANKFURT'.
    <flight>-cityto = 'DÜSSELDORF'.
    <flight>-airpto = 'DUS'.
    FORMAT COLOR 5.
  ENDIF.

  WRITE :/ <flight>-connid, <flight>-carrid, <flight>-cityfrom, <flight>-airpfrom, <flight>-cityto.

ENDLOOP.
