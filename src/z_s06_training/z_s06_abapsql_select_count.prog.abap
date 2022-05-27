*&---------------------------------------------------------------------*
*& Report Z_S06_ABAPSQL_SELECT_COUNT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s06_abapsql_select_count.



*DATA: BEGIN OF seat,
*        carrid TYPE sflight-carrid,
*        spfli  TYPE spfli,
*        cityto TYPE cityto,
*      END OF seat.

SELECT COUNT( DISTINCT carrid )
FROM spfli WHERE cityto = 'MUNICH'
  AND
cityfrom = 'MUNICH'
INTO @DATA(count).

  cl_demo_output=>display( count ).

"INSERT count INTO TABLE seat.

*  SELECT carrid, connid, SUM( seatsocc ) AS seatsocc
*  FROM sflight
*  GROUP BY carrid, connid
*  ORDER BY carrid, connid
*  INTO (@DATA(carrid),@DATA(connid), @DATA(seatsocc)).
*ENDSELECT.
*
"
