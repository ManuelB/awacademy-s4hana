*&---------------------------------------------------------------------*
*& Report Z_S05_JOINS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_SQL_JOINS.

"DATA:
  "cityfr TYPE zS05_spfli-cityfrom VALUE 'FRANKFURT',
  "cityto TYPE zS05_spfli-cityto   VALUE 'DE'.

"cl_demo_input=>new(
 " )->add_field( CHANGING field = cityfr
 " )->add_field( CHANGING field = cityto )->request( ).

"SELECT c~carrname, p~connid, f~fldate
      " FROM ( ( zS05_scarr AS c

        " INNER JOIN zS05_spfli AS p ON p~carrid   = c~carrid
                              "AND p~cityfrom = @cityfr
                           "   AND p~countryfr = @cityto )

       "  INNER JOIN zS05_sflight AS f ON f~carrid = p~carrid
                              "  AND f~connid = p~connid )
"

     "  ORDER BY c~carrname, p~connid, f~fldate

      " INTO TABLE @DATA(itab).





       DATA:
  carrid TYPE zS05_spfli-carrid VALUE 'LH',
  COUNTRYFR TYPE zS05_spfli-countryfr VALUE 'DE'.

cl_demo_input=>new(
  )->add_field( CHANGING field = carrid
  )->add_field( CHANGING field = countryfr )->request( ).

SELECT c~carrname, p~carrid, p~countryfr, f~fldate
       FROM ( ( zS05_scarr AS c

         INNER JOIN zS05_spfli AS p ON p~carrid   = c~carrid
                              AND p~countryfr = @countryfr
                              AND p~carrid   = @carrid )

         INNER JOIN zS05_sflight AS f ON f~carrid = p~carrid
                                AND f~connid = p~connid )


       ORDER BY c~carrname, p~countryfr, f~connid

       INTO TABLE @DATA(itab2).

          cl_demo_output=>display( itab2 ).
