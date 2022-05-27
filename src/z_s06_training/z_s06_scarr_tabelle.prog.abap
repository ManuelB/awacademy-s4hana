*&---------------------------------------------------------------------*
*& Report Z_S06_SCARR_TABELLE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S06_SCARR_TABELLE.

SELECT * INTO TABLE @DATA(scarr)
  FROM scarr.

  INSERT ZS06SCARR FROM TABLE scarr.

  IF sy-subrc = 0.
    Commit WORK.
    ENDIF.
