*&---------------------------------------------------------------------*
*& Report Z_S05AUFGABE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_SQL_ENDSELECT.

TYPES: BEGIN OF lty_s_flights,
     carrid TYPE ZS05_SFLIGHT-carrid,
     CURRENCY TYPE ZS05_SFLIGHT-currency,
     price TYPE ZS05_SFLIGHT-price,
     END OF lty_s_flights,

lt_flights TYPE TABLE OF lty_s_flights.



  SELECT CARRID, price, CURRENCY, SUM( price ) AS TotalPriceOfAll
    FROM ZS05_SFLIGHT
    GROUP BY CARRID, currency, price
    ORDER BY CARRID DESCENDING, price ASCENDING
    INTO @DATA(lt_flights).
    ENDSELECT.

    cl_demo_output=>display( lt_flights ).
