*&---------------------------------------------------------------------*
*& Report Z_S06_SFLIGHT_TABELLE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S06_SFLIGHT_TABELLE.

SELECT * INTO TABLE @DATA(sflight)
  FROM sflight.

  INSERT ZS06SFLIGHT FROM TABLE sflight.

  IF sy-subrc = 0.
    Commit WORK.
    ENDIF.
