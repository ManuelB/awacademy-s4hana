*&---------------------------------------------------------------------*
*& Report Z_S11_UNION_AGGREGATE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S11_UNION_AGGREGATE.
*
DATA: gr_table TYPE REF TO cl_salv_table.
*
WITH +aggregates AS (
  SELECT FROM sflight
         FIELDS carrid,
                connid,
                'MAX' AS function,
                MAX( CAST( seatsocc AS DEC( 31,2 ) ) ) AS agg
         GROUP BY carrid, connid
    UNION
      SELECT FROM sflight
             FIELDS carrid,
                    connid,
                    'MIN' AS function,
                    MIN( CAST( seatsocc AS DEC( 31,2 ) ) ) AS agg
             GROUP BY carrid, connid
        UNION
          SELECT FROM sflight
                 FIELDS carrid,
                 connid, 'AVG' AS function,
                 AVG( seatsocc AS DEC( 31,2 ) ) AS agg
                 GROUP BY carrid, connid )
  SELECT *
         FROM +aggregates
         WHERE carrid = 'LH' AND connid = '0400'
         ORDER BY carrid, connid, function DESCENDING
         INTO TABLE @DATA(result).

cl_salv_table=>factory( IMPORTING r_salv_table = gr_table CHANGING t_table = result ).
gr_table->display( ).
*
*SELECT ebeln, werks,
*  MAX( brtwr ) as max_price,
*  SUM( brtwr ) as tot_price,
*  AVG( brtwr ) as avg_price
*  from ekpo INTO table @data(lt_ekpo)
*  where ebeln = '4600000001'
*  group by ebeln, werks.
*  cl_demo_output=>display( lt_ekpo ).

SELECT carrid, connid,
  MAX( seatsocc ) as max,
  min( seatsocc ) as min,
  AVG( seatsocc ) as avg
  from sflight INTO table @data(lt_result)
  where carrid = 'LH'
  and connid = '0400'
  group by carrid, connid.
cl_salv_table=>factory( IMPORTING r_salv_table = gr_table CHANGING t_table = lt_result ).
gr_table->display( ).
