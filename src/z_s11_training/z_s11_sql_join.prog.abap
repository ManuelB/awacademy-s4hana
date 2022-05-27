*&---------------------------------------------------------------------*
*& Report Z_S11_SQL_JOIN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s11_sql_join.


DATA:
  cityfr TYPE spfli-cityfrom VALUE 'NEW YORK',
  cityto TYPE spfli-cityto   VALUE  'SAN FRANCISCO'.

cl_demo_input=>new(
  )->add_field( CHANGING field = cityfr
  )->add_field( CHANGING field = cityto )->request( ).

SELECT c~carrid, c~carrname, p~connid, p~cityfrom, p~cityto, f~fldate, f~planetype
       FROM   scarr AS c


         inner JOIN spfli AS p ON p~carrid   = c~carrid
                              AND p~cityfrom = @cityfr
                              AND p~cityto   = @cityto


         INNER JOIN sflight AS f ON f~carrid = p~carrid
                                AND f~connid = p~connid


       ORDER BY  f~fldate ascending

       INTO TABLE @DATA(itab).

cl_demo_output=>display( itab ).

*DATA:
*  cityfr TYPE spfli-cityfrom VALUE 'FRANKFURT',
*  cityto TYPE spfli-cityto   VALUE 'OSAKA'.
*
*cl_demo_input=>new(
*  )->add_field( CHANGING field = cityfr
*  )->add_field( CHANGING field = cityto )->request( ).
*
*SELECT c~carrname, p~connid, p~cityfrom, p~cityto, f~fldate, f~planetype
*       FROM ( scarr AS c
*
*
*       INNER JOIN spfli AS p ON p~carrid   = c~carrid
*                              AND p~cityfrom = @cityfr
*                              AND p~cityto   = @cityto
*
*
*         INNER JOIN sflight AS f ON f~carrid = p~carrid
*                                AND f~connid = p~connid )
*
*
*       ORDER BY c~carrname, p~connid
*
*       INTO TABLE @DATA(itab).
*
*cl_demo_output=>display( itab ).
