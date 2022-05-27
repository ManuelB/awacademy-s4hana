FUNCTION ZS01_AUSGABE2.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  TABLES
*"      FLUGLISTE STRUCTURE  SFLIGHT
*"      LT_FLUEGE STRUCTURE  SFLIGHT
*"----------------------------------------------------------------------


LOOP AT lt_fluege INTO flugliste.
      WRITE: /
     flugliste-carrid,
     flugliste-connid,
     flugliste-fldate,
      flugliste-seatsocc,
      flugliste-planetype.

    ENDLOOP.


ENDFUNCTION.
