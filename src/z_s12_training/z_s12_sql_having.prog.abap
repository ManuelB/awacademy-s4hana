*&---------------------------------------------------------------------*
*& Report Z_S12_SQL_HAVING
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s12_sql_having.

DATA: carrid TYPE sbook-carrid VALUE 'LH',
      connid TYPE sbook-connid VALUE '400'.

cl_demo_input=>new(
)->add_field( CHANGING field = carrid "Fügt suchfelder für CARRID und CONNID hinzu
  )->add_field( CHANGING field = connid )->request( ). "Request fügt einen Enter button hinzu

SELECT fldate, class, COUNT( * ) AS class_cnt
  FROM sbook
  WHERE connid = @connid "Selektiert von der DB
  GROUP BY carrid, fldate, class "Sortiert
  HAVING carrid = @carrid
  ORDER BY fldate, class
  INTO TABLE @DATA(result).

cl_demo_output=>display( result ).

DATA: fldate TYPE sflight-fldate VALUE '10202021',
      price TYPE sflight-price VALUE '1030'.

cl_demo_input=>new(
)->add_field( CHANGING field = fldate
  )->add_field( CHANGING field = price )->request( ).

SELECT fldate, price,carrid, COUNT( * ) AS Optionen
  FROM sflight
  WHERE fldate = @fldate
  GROUP BY carrid, fldate, price
  HAVING carrid = @carrid
  ORDER BY carrid
  INTO TABLE @DATA(result2).

cl_demo_output=>display( result2 ).
