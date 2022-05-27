*&---------------------------------------------------------------------*
*& Report Z_S11_SQL_ORDERBY
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s11_sql_orderby.

DATA : carrid TYPE sbook-carrid VALUE 'LH',
       connid TYPE sbook-connid VALUE '400'.

cl_demo_input=>new(
)->add_field( CHANGING field = carrid
)->add_field( CHANGING field = connid )->request( ).

SELECT carrid, fldate , class, COUNT( * ) AS buchung_pro_klasse "ergebniss
  FROM sbook
  WHERE connid = @connid " selektion on datenbank mit WHERE
  GROUP BY carrid, fldate, class
HAVING carrid = @carrid "zusätzlich einschränkung on ergebnismenge die vorliegt mit Having
  ORDER BY fldate ASCENDING, class DESCENDING
  INTO TABLE @DATA(result).

cl_demo_output=>display( result ).
