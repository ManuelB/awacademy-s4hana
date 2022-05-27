*&---------------------------------------------------------------------*
*& Report Z_S09_SELECT_ENDSELECT_SQL
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s09_select_endselect_sql.


"-----------------------------------------------"
"Version vom Rainer"

DATA: BEGIN OF wa,
  carrid TYPE sflight-carrid,
  connid TYPE sflight-caonnid,
  seatsocc TYPE sflight-seatsocc,
  END OF wa,
  tline like TABLE OF wa
WITH NON-UNIQUE DEFAULT KEY.

  SELECT carrid, cpnnid, SUM(seatsocc ) AS belegt
    FROM sflight
    GROUP BY carrid, connid
    ORDER BY carrid, connid
    INTO @wa.

    INSERT wa INTO TABLE tline.

    ENDSELECT.







"SELECT carrid, connid, SUM( seatocc ) AS seatsocc
"FROM sflight
"GROUP BY carrid, connid
"ORDER BY carrid, connid
"INTO (@DATA(carrid),@DATA(connid),@data(seatsocc)).
"ENDSELECT.

"-----------------------------------------"

"Version mit Hana"


TYPES: BEGIN OF lty_s_flights,
carrid TYPE ZS09_SFLIGHT-carrid,
CURRENCY TYPE ZS09_SFLIGHT-currency,
price TYPE ZS09_SFLIGHT-price,
END OF lty_s_flights,



lt_flights TYPE TABLE OF lty_s_flights.


SELECT CARRID, price, CURRENCY, SUM( price ) AS TotalPriceOfAll
FROM ZS09_SFLIGHT
GROUP BY CARRID, currency, price
ORDER BY CARRID DESCENDING, price ASCENDING
INTO @DATA(lt_flights).
ENDSELECT.



cl_demo_output=>display( lt_flights ).
