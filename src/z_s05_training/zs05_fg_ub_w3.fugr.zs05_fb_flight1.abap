FUNCTION ZS05_FB_FLIGHT1.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(P_CARRID) TYPE  SFLIGHT-CARRID
*"  EXPORTING
*"     REFERENCE(EX_FLUGLISTE) TYPE  SFLIGHT_TAB2
*"     REFERENCE(EX_FLUGVIEW) TYPE  Z05_SFLIGHTS_TAB
*"  TABLES
*"      LT_FLUG STRUCTURE  SFLIGHT
*"  EXCEPTIONS
*"      NOTHING_FOUND
*"----------------------------------------------------------------------
IF p_carrid IS NOT INITIAL.
  SELECT * FROM SFLIGHT INTO TABLE lt_flug
    WHERE CARRID = P_CARRID.
    ELSE.
      SELECT * FROM SFLIGHT INTO TABLE lt_flug.
        ENDIF.
IF sy-subrc <> 0.
  RAISE NOTHING_FOUND.
  ENDIF.

  SELECT * FROM SFLIGHT INTO TABLE EX_FLUGLISTE.

    SELECT * FROM SFLIGHTS INTO TABLE EX_FLUGVIEW.










ENDFUNCTION.
