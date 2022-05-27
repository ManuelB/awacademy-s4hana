*&---------------------------------------------------------------------*
*& Report Z_S06_ABAPSQL_HAVING
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s06_abapsql_having.

DATA: carrid TYPE sbook-carrid VALUE 'LH',
      connid TYPE sbook-connid VALUE '400'.

cl_demo_input=>new(
)->add_field( CHANGING field = carrid
  )->add_field( CHANGING field = connid )->request( ).

SELECT fldate, class, COUNT(*) AS class_CNT "bookings per class
  FROM sbook
  WHERE connid = @connid
  GROUP BY carrid, fldate, class "die zuordnung
  HAVING carrid = @carrid "zusatliches oder na folgende einschrankung
  ORDER BY fldate ASCENDING, class DESCENDING
  INTO TABLE @DATA(result).

cl_demo_output=>display( result ).



* DATA: carrid TYPE sbook-carrid VALUE 'LH',
*      connid TYPE sbook-connid VALUE '400'.
*
*cl_demo_input=>new(
*)->add_field( CHANGING field = carrid
*  )->add_field( CHANGING field = connid )->request( ).
*
*SELECT fldate, class, COUNT(*) AS class_CNT
*  FROM sbook
*  WHERE connid = @connid
*  GROUP BY carrid, fldate, class
*  HAVING carrid = @carrid
*  ORDER BY fldate, class
*  INTO TABLE @DATA(result).
*
*  cl_demo_output=>display( result ).
