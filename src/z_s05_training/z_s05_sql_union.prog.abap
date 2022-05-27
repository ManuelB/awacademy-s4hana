*&---------------------------------------------------------------------*
*& Report ZAWS05_UNION
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_SQL_UNION.

DATA gr_table TYPE REF TO cl_salv_table.

WITH +aggregates AS (
SELECT FROM sflight
FIELDS carrid,
        connid,
        'MAX' as function,
        MAX( CAST( seatsocc AS DEC( 31,2 ) ) ) AS agg
        group by carrid, connid

        UNION

        SELECT FROM sflight
        fields carrid,
              connid,
         'MIN' as function,
        MIN( CAST( seatsocc AS DEC( 31,2 ) ) ) AS agg
         group by carrid, connid

        UNION

          SELECT FROM sflight
                 FIELDS carrid,
                 connid, 'AVG' AS function,
                 AVG( seatsocc AS DEC( 31,2 ) ) AS agg
                 GROUP BY carrid, connid )

        SELECT *
        FROM +aggregates
        where carrid = 'LH'
        ORDER BY carrid, connid, function DESCENDING
        INTO TABLE @DATA(RESULT).

          cl_salv_table=>factory( IMPORTING r_salv_table = gr_table CHANGING t_table = result ).
gr_table->display( ).
