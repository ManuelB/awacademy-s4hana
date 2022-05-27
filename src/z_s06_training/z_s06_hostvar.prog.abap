*&---------------------------------------------------------------------*
*& Report Z_S06_HOSTVAR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s06_hostvar.
*
*SELECTION-SCREEN BEGIN OF BLOCK al WITH FRAME.
*
*  PARAMETERS p_carr TYPE s_carr_id.
*  p_
*SELECTION-SCREEN END OF BLOCK al.
*
*START-OF-SELECTION.
*
*  SELECT carrid, distance, distid, cityfrom, cityto INTO @DATA(flights)
*    FROM spfli
*    WHERE carrid = @p_carr.
*    ENDSELECT.
*    BREAK-POINT.

DO 3 Times.
  Write / sy-index.
  DO 1 TIMES.
    IF sy-index = 1.
      WRITE sy-index.
      EXIT.
      ENDIF.
      ENDDO.
      IF sy-index MOD 3 = 0.
        CONTINUE.
        ENDIF.
        WRITE sy-index.
        ENDDO.
