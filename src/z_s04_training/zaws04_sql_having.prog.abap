*&---------------------------------------------------------------------*
*& Report ZAW_S04_HAVING
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZAWS04_SQL_HAVING.

DATA: carrid TYPE sbook-carrid VALUE 'LH',
      connid TYPE sbook-connid VALUE '400'.


*cl_demo_input=>new( )->add_field( CHANGING field = carrid )->add_field( CHANGING field = connid )->request( ).
*
*SELECT fldate, class, COUNT( * ) AS class_cnt FROM sbook WHERE connid = @connid GROUP BY carrid, fldate, class HAVING carrid = @carrid ORDER BY fldate, class INTO TABLE @DATA(result).
*
*  cl_demo_output=>display( result ).



cl_demo_input=>new( )->add_field( CHANGING field = carrid )->request( ).

SELECT cityfrom, cityto, fltime
  FROM spfli
  WHERE carrid = @carrid
  GROUP BY cityfrom, cityto, fltime, connid, carrid
  HAVING carrid = @carrid
  ORDER BY connid
  INTO TABLE @DATA(result).

  cl_demo_output=>display( result ).
