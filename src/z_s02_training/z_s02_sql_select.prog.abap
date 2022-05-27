*&---------------------------------------------------------------------*
*& Report Z_S02_SQL_SELECT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S02_SQL_SELECT.
***
* SELECT - ENDSELECT
***



DATA: BEGIN OF wa,      "mit DATA macht man gleich eine befüllbare Struktur
carrid   TYPE sflight-carrid,
connid   TYPE sflight-connid,
seatsocc TYPE sflight-seatsocc,
END OF wa,
tline LIKE TABLE OF wa.






SELECT carrid, connid, SUM( seatsocc ) AS belegt
  FROM sflight
  GROUP BY carrid, connid
  ORDER BY carrid, connid
  INTO @DATA(line).

  INSERT line INTO TABLE tline.

  ENDSELECT.

  BREAK-POINT.
