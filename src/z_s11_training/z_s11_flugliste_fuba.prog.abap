*&---------------------------------------------------------------------*
*& Report Z_S11_FLUGLISTE_FUBA
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s11_flugliste_fuba.

PARAMETERS p_carrid TYPE sflight-carrid.

DATA : ls_flightlist TYPE sflight,
       lt_flightlist TYPE TABLE OF sflight.


DATA : lt_ex_flightlist TYPE sflight_tab2,
*       ls_ex_flightlist TYPE LINE OF sflight_tab2,
  ls_ex_flightlist TYPE  sflight.



CALL FUNCTION 'ZS11_FLUGLISTE'
  EXPORTING
    i_carrid                 = p_carrid
  IMPORTING
    ex_flightlist_ohnetables = lt_ex_flightlist
  TABLES
    flightlist               = lt_flightlist
        EXCEPTIONS
          NOTHINGFOUND                   = 1
          OTHERS                         = 2
.

IF sy-subrc <> 0.
* Implement suitable error handling here
  WRITE: / 'Some Mistake!'.
ELSE.
  WRITE: / lines( lt_flightlist ), 'Found flights'.
  LOOP AT  lt_flightlist INTO ls_flightlist.
    WRITE :/ ls_flightlist-carrid, ls_flightlist-connid, ls_flightlist-fldate.
  ENDLOOP.
*    cl_demo_output=>display( lt_flightlist ).


  WRITE: / lines( lt_ex_flightlist ), 'Found flights with exporting parameter'.
  LOOP AT  lt_ex_flightlist INTO ls_ex_flightlist.
    WRITE :/ ls_ex_flightlist-carrid, ls_ex_flightlist-connid, ls_ex_flightlist-fldate.
  ENDLOOP.
*     cl_demo_output=>display( lt_ex_flightlist ).

ENDIF.
