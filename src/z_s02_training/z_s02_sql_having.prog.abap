*&---------------------------------------------------------------------*
*& Report Z_S02_SQL_HAVING
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S02_SQL_HAVING.
****
* Zusätzlich HAVING und ORDER BY
****

DATA: carrid TYPE sbook-carrid VALUE 'LH',
      connid TYPE sbook-connid VALUE '400'.

cl_demo_input=>new(
)->add_field( CHANGING field = carrid
)->add_field( CHANGING field = connid )->request( ).

SELECT fldate, class, COUNT(*) AS class_cnt "die Anzahl der Klassen werden gezählt. Z.B. es gibt 30 Y-Klassen
  FROM sbook
  WHERE connid = @connid
  GROUP BY carrid, fldate, class
  HAVING carrid = @carrid
  ORDER BY fldate, class
  INTO TABLE @DATA(result).

  cl_demo_output=>display( result ).
