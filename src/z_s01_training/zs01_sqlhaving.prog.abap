*&---------------------------------------------------------------------*
*& Report ZAWT03_HAVING
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zawt03_having_r.

DATA: carrid TYPE sbook-carrid VALUE 'LH',
      connid TYPE sbook-connid VALUE '400'.

cl_demo_input=>new(
)->add_field( CHANGING field = carrid
)->add_field( CHANGING field = connid )->request( ).


SELECT fldate, class, COUNT(*) AS BuchungenPROKlasse
FROM sbook
WHERE connid = @connid
  GROUP BY carrid, fldate, class
  HAVING carrid = @carrid
  ORDER BY fldate ASCENDING, class DESCENDING
  INTO TABLE @DATA(result).

cl_demo_output=>display( result ).
