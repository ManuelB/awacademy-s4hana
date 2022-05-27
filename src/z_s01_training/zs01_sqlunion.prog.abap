*&---------------------------------------------------------------------*
*& Report Z_S01_SQL_UNION
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

*Hier weitermachen.
REPORT zs01_sqlunion.
WITH +aggregates AS (
SELECT FROM sflight
FIELDS carrid,
connid,
'Max' AS function,
MAX( CAST( seatsocc AS DEC( 31,2 ) ) ) AS agg
GROUP BY carrid, connid )


**UNION
*SELECT FROM sflight
*FIELDS carrid,
*  connid,
*  'Min' AS function,
*  MIN( CAST( seatsocc AS DEC( 31,2 ) ) ) AS agg
*  GROUP BY carrid- connid
*
*  UNION
*  SELECT FROM sflight
*  FIELDS carrid,
*  connid, 'AVG' AS function,
*  AVG( seatsocc AS DEC( 31,2 ) )  AS agg
*  GROUP BY carrid, connid )

  SELECT *
  FROM +aggregates
  WHERE carrid = 'LH' "And connid = '0400'
  ORDER BY carrid, connid, function DESCENDING
  INTO TABLE @DATA(result).
cl_demo_output=>display( result ).

*cl_salv_table=>factory( IMPORTING r_salv_table = gr_table CHANGING t_table = result ).
*gr_table->display( ).

*DATA: gr_table TYPE REF TO cl_salv_table.
**
*WITH +aggregates AS (
*  SELECT FROM sflight
*         FIELDS carrid,
*                connid,
*                'MAX' AS function,
*                MAX( CAST( seatsocc AS DEC( 31,2 ) ) ) AS agg
*         GROUP BY carrid, connid
*    UNION
*      SELECT FROM sflight
*             FIELDS carrid,
*                    connid,
*                    'MIN' AS function,
*                    MIN( CAST( seatsocc AS DEC( 31,2 ) ) ) AS agg
*             GROUP BY carrid, connid
*        UNION
*          SELECT FROM sflight
*                 FIELDS carrid,
*                 connid, 'AVG' AS function,
*                 AVG( seatsocc AS DEC( 31,2 ) ) AS agg
*                 GROUP BY carrid, connid )
*  SELECT *
*         FROM +aggregates
*         WHERE carrid = 'LH' "AND connid = '0400'
*         ORDER BY carrid, connid, function DESCENDING
*         INTO TABLE @DATA(result).
*
*cl_salv_table=>factory( IMPORTING r_salv_table = gr_table CHANGING t_table = result ).
*gr_table->display( ).
