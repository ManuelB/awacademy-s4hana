*&---------------------------------------------------------------------*
*& Report ZAWT03_ENDSELECT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s01_sql_endselect_r.

*Deklaration von Struktur
DATA : BEGIN OF  wa,
         carrid   TYPE sflight-carrid,
         connid   TYPE sflight-connid,
         seatsocc TYPE sflight-seatsocc,
       END OF wa,
       tline like TABLE OF wa .

SELECT carrid, connid, SUM( seatsocc ) AS belegt
  FROM sflight
  GROUP BY carrid, connid
  ORDER BY carrid, connid
  INTO @wa.

  INSERT wa INTO TABLE tline.

ENDSELECT.

BREAK-POINT.
