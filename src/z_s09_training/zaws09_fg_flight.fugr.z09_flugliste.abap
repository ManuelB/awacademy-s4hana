FUNCTION z09_flugliste.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(I_CARRID) TYPE  SFLIGHT-CARRID
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




ENDFUNCTION.
