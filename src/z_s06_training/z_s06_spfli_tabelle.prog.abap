*&---------------------------------------------------------------------*
*& Report Z_S06_SPFLI_TABELLE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S06_SPFLI_TABELLE.

SELECT * INTO TABLE @DATA(spfli)
  FROM spfli.

  INSERT ZS06SPFLI FROM TABLE spfli.

  IF sy-subrc = 0.
    Commit WORK.
    ENDIF.
