*&---------------------------------------------------------------------*
*& Report ZAW_S04_SELECT_ENDSELECT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zaws04_sql_select_endselect.

*DATA ls_seatsocc TYPE zaws04_sflight.
*DATA lt_seatsocc TYPE TABLE OF zaws04_sflight.


DATA: BEGIN OF wa,
        carrid   TYPE zaws04_sflight-carrid,
        connid   TYPE zaws04_sflight-connid,
        seatsocc TYPE zaws04_sflight-seatsocc,
      END OF wa,
      lt_line LIKE TABLE OF wa.

SELECT carrid, connid, SUM( seatsocc ) AS belegt
  FROM zaws04_sflight
  GROUP BY carrid, connid
  ORDER BY carrid, connid
  INTO @wa.
*INTO (@DATA(carrid),@DATA(connid),@DATA(seatsocc)).
*into corresponding fields of @ls_seatsocc.

  INSERT wa INTO TABLE lt_line.


ENDSELECT.
