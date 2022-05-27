FUNCTION zs01_flugliste.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(I_CARRID) TYPE  SFLIGHT-CARRID OPTIONAL
*"  EXPORTING
*"     REFERENCE(EX_FLUGLISTE) TYPE  SFLIGHT_TAB2
*"     REFERENCE(EX_FLUGVIEW) TYPE  Z02_SFLIGHTS_TAB
*"  TABLES
*"      FLUGLISTE STRUCTURE  SFLIGHT
*"  EXCEPTIONS
*"      NOTHING_FOUND
*"----------------------------------------------------------------------



  IF i_carrid IS NOT INITIAL.
    SELECT * FROM sflight INTO TABLE Flugliste
      WHERE carrid = i_carrid.
      ELSE.
    SELECT * FROM sflight INTO  TABLE Flugliste.
        ENDIF.
  IF sy-subrc <> 0.
    RAISE nothing_found.

  ENDIF.
*Warum das?
  SELECT * FROM sflight INTO TABLE ex_flugliste.

  SELECT * from sflights INTO TABLE ex_flugview.


ENDFUNCTION.
