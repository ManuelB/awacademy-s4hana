FUNCTION ZS07_FLUGLISTE.
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
if i_carrid is not INITIAL.
select * FROM sflight into TABLE flugliste
  where carrid = i_carrid.
  else.
    Select * from sflight INTO TABLE flugliste.
      ENDIF.
      if sy-subrc <> 0.
        raise nothing_found.
        ENDIF.

       SELECT * FROM sflight into table ex_flugliste.

ENDFUNCTION.
