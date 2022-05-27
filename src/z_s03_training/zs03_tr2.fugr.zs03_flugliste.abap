FUNCTION zs03_flugliste.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(I_CARRID) TYPE  SFLIGHT-CARRID OPTIONAL
*"  EXPORTING
*"     REFERENCE(EX_FLUGLISTE) TYPE  SFLIGHT_TAB2
*"  TABLES
*"      FLUGLISTE STRUCTURE  SFLIGHT
*"  EXCEPTIONS
*"      NOTHING_FOUND
*"----------------------------------------------------------------------
*----------------------------------------------------------------------
**"Lokale Schnittstelle:
*  IMPORTING
*     REFERENCE(I_CARRID) TYPE  SFLIGHT-CARRID OPTIONAL
*  TABLES
*      FLUGLISTE STRUCTURE  SFLIGHT
*----------------------------------------------------------------------


  IF i_carrid IS NOT INITIAL.
    SELECT * FROM sflight INTO TABLE flugliste
      WHERE carrid = i_carrid.
  ELSE.
    SELECT * FROM sflight INTO TABLE flugliste.
  ENDIF.

  IF sy-subrc <> 0.
    RAISE nothing_found.
    WRITE: / 'nothing found'.
  ENDIF.

  SELECT * FROM sflight INTO TABLE  ex_flugliste.






ENDFUNCTION.
