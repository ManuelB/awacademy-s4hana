FUNCTION ZS11_FLUGLISTE.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(I_CARRID) TYPE  SFLIGHT-CARRID OPTIONAL
*"  EXPORTING
*"     REFERENCE(EX_FLIGHTLIST_OHNETABLES) TYPE  SFLIGHT_TAB2
*"  TABLES
*"      FLIGHTLIST STRUCTURE  SFLIGHT
*"  EXCEPTIONS
*"      NOTHINGFOUND
*"----------------------------------------------------------------------
if i_carrid is not initial.
Select * from sflight into table flightlist
  where carrid = i_carrid.
  else.
  select * from sflight into table flightlist.
    endif.
if sy-subrc <> 0.
  raise Nothingfound.
  endif.

select * from sflight into table  ex_flightlist_ohnetables.

ENDFUNCTION.
