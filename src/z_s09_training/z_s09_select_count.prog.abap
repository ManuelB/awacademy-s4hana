*&---------------------------------------------------------------------*
*& Report Z_S09_SELECT_COUNT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S09_SELECT_COUNT.

"SELECT COUNT( DISTINCT carrid )
"  FROM spfli
"  WHERE cityto = 'NEW YORK'
"  INTO @DATA(count)




 TYPES: BEGIN OF lty_s_flights,
connid TYPE ZS09_spfli-connid,
cityfrom TYPE ZS09_spfli-cityfrom,
cityto TYPE ZS09_spfli-cityto,
distance TYPE ZS09_spfli-distance,
END OF lty_s_flights,

lt_flights TYPE TABLE OF lty_s_flights.


SELECT COUNT( DISTINCT CONNID )
from ZS09_spfli
WHERE FLTIME GE 600
GROUP BY connid, cityfrom, cityto
INTO @DATA(lt_flights).
ENDSELECT.



cl_demo_output=>display( lt_flights ).
