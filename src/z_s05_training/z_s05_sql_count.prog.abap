*&---------------------------------------------------------------------*
*& Report Z_S05_SQL_COUNT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_SQL_COUNT.


TYPES: BEGIN OF lty_s_flights,
     connid TYPE ZS05_Spfli-connid,
     cityfrom TYPE ZS05_Spfli-cityfrom,
     cityto TYPE ZS05_Spfli-cityto,
  distance TYPE ZS05_Spfli-distance,
     END OF lty_s_flights,

lt_flights TYPE TABLE OF lty_s_flights.



SELECT COUNT( DISTINCT CONNID )
  from ZS05_spfli
  WHERE FLTIME GT 200
  AND CITYFROM = 'NEW YORK'
  "GROUP BY connid, cityfrom, cityto
  INTO @DATA(lt_flights1).
 " ENDSELECT.

   cl_demo_output=>display( lt_flights1 ).


SELECTION-SCREEN BEGIN OF BLOCK B0 WITH FRAME.
  parameterS p_CITYF TYPE ZS05_spfli-cityfrom DEFAULT 'NEW YORK'."ZS05_AIRFROM.

  SELECTION-SCREEN END OF BLOCK B0.

START-OF-SELECTION.


SELECT DISTINCT CITYFROM, FLTIME, CITYTO
  from ZS05_spfli
  WHERE FLTIME GT 200
  AND CITYFROM = @p_cityf
  "AND CITYFROM = 'NEW YORK'
  "OR CITYFROM = 'MUNICH'
 " OR CITYFROM = 'FRANKFURT'
  "GROUP BY connid, cityfrom, cityto
  GROUP BY CITYFROM, FLTIME, CITYTO
  ORDER BY CITYFROM ASCENDING, FLTIME, CITYTO
  INTO TABLE @DATA(lt_flights).
 " ENDSELECT.

   cl_demo_output=>display( lt_flights ).
