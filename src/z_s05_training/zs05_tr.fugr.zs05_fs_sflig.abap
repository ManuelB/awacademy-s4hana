FUNCTION ZS05_FS_SFLIG.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(I_CARRID) TYPE  SFLIGHT-CARRID OPTIONAL
*"  EXPORTING
*"     REFERENCE(EX_FLUGLISTE) TYPE  SFLIGHT_TAB2
*"     REFERENCE(EX_FLUGVIEW) TYPE  Z05_SFLIGHTS_TAB
*"  TABLES
*"      FLUGLISTE STRUCTURE  SFLIGHT
*"  EXCEPTIONS
*"      NOTHING_FOUND
*"----------------------------------------------------------------------

IF i_carrid IS NOT INITIAL.
    SELECT * FROM sflight INTO TABLE flugliste
      WHERE carrid = i_carrid.
  ELSE.
    SELECT * FROM sflight INTO TABLE flugliste.
  ENDIF.
  IF sy-subrc <> 0.
    RAISE nothing_found.
  ENDIF.

SELECT * FROM sflight INTO TABLE ex_flugliste.

SELECT * FROM sflights INTO TABLE ex_flugview.

ENDFUNCTION.
