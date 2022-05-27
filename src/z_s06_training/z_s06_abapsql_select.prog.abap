*&---------------------------------------------------------------------*
*& Report Z_S06_ABAPSQL_SELECT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s06_abapsql_select.


DATA: BEGIN OF seat,
         carrid   TYPE sflight-carrid,
         connid   TYPE sflight-connid,
         seatsocc TYPE sflight-seatsocc,
       END OF seat,
       tline LIKE TABLE OF seat WITH NON-UNIQUE DEFAULT KEY.



SELECT carrid, connid, SUM( seatsocc ) AS seatsocc
  FROM sflight
  GROUP BY carrid, connid
  ORDER BY carrid, connid
  INTO (@DATA(carrid),@DATA(connid), @DATA(seatsocc)).
ENDSELECT.

BREAK-POINT.
