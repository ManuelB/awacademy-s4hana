*&---------------------------------------------------------------------*
*& Report Z_S09_HAVING_SQL
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s09_having_sql.

DATA: carrid TYPE sbook-carrid VALUE 'LH',
      connid TYPE sbook-connid VALUE '400'.

cl_demo_input=>new(
)->add_field( CHANGING field = carrid
  )->add_field( CHANGING field = connid )->REQUEST( ).

SELECT fldate, class, COUNT( * ) AS class_cnt
  FROM sbook
  WHERE connid = @connid
  GROUP BY carrid, fldate, class
  HAVING carrid = @carrid
  ORDER BY fldate, class
  INTO TABLE @DATA(result).

cl_demo_output=>display( result ).
