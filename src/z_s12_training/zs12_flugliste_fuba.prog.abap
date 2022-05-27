*&---------------------------------------------------------------------*
*& Report ZS12_FLUGLISTE_FUBA
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs12_flugliste_fuba.
*
DATA:
  lt_flugliste    TYPE sflight_tab2,
  lt_fluege       TYPE TABLE OF sflight,
  lt_ex_flugliste TYPE sflight_tab2,
  ls_ex_flugliste TYPE sflight
  .
*
CALL FUNCTION 'ZS12_FLUGLISTE'
* EXPORTING
*   I_CARRID            =
  IMPORTING
    ex_flugliste  = lt_ex_flugliste
  TABLES
    flugliste     = lt_fluege
  EXCEPTIONS
    nothing_found = 1
    OTHERS        = 2.
.
*LOOP AT SFLIGHT into flugliste where carrid = i_carrid.
*
*
*ENDLOOP.

IF sy-subrc <> 0.
* Implement suitable error handling here
  WRITE: / 'Irgendein Fehler'.
ELSE.
  WRITE: / lines( lt_flugliste ), 'Flüge gefunden'.
  LOOP AT lt_flugliste INTO ls_ex_flugliste.
    WRITE:/ ls_ex_flugliste-carrid, ls_ex_flugliste-connid, ls_ex_flugliste-fldate.
  ENDLOOP.

  WRITE: / lines( lt_fluege ), 'Flüge gefunden'.
  LOOP AT lt_ex_flugliste INTO ls_ex_flugliste.
    WRITE: / ls_ex_flugliste-carrid, ls_ex_flugliste-connid, ls_ex_flugliste-fldate.
  ENDLOOP.
ENDIF.
