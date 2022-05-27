*&---------------------------------------------------------------------*
*& Report Z_S11_SQL_ENDSELECT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S11_SQL_ENDSELECT.

Data ls_sflight type sflight.
Data lt_sflight type table of sflight.

Select carrid, connid, SUM( seatsocc ) AS seatsocc
  FROM sflight
  GROUP BY carrid, connid
  ORDER BY carrid, connid
 into CORRESPONDING FIELDS OF @ls_sflight.
*  into CORRESPONDING FIELDS OF table @lt_sflight.
*  into (@DATA(carrid),@DATA(connid),@data(seatsocc)).

  Insert ls_sflight into table lt_sflight.

  ENDSELECT.

  BREAK-POINT.
