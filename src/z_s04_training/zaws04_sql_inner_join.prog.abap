*&---------------------------------------------------------------------*
*& Report ZAWS04_SQL_INNER_JOIN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zaws04_sql_inner_join.

DATA:
  cityfr TYPE spfli-cityfrom VALUE 'FRANKFURT',
  cityto TYPE spfli-cityto   VALUE 'OSAKA'.

cl_demo_input=>new( )->add_field( CHANGING field = cityfr )->add_field( CHANGING field = cityto )->request( ).

SELECT c~carrname, p~connid, f~fldate
       FROM ( ( scarr AS c

         INNER JOIN spfli AS p
         ON p~carrid   = c~carrid
                              AND p~cityfrom = @cityfr
                              AND p~cityto   = @cityto )

         INNER JOIN sflight AS f
         ON f~carrid = p~carrid
                                AND f~connid = p~connid )

       ORDER BY c~carrname, p~connid, f~fldate

       INTO TABLE @DATA(itab).

cl_demo_output=>display( itab ).
