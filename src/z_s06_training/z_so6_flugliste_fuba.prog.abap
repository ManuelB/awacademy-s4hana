*&---------------------------------------------------------------------*
*& Report Z_SO6_FLUGLISTE_FUBA
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_so6_flugliste_fuba.

DATA:
  lt_flugliste TYPE sflight_tab2,
  lt_fluge     TYPE TABLE OF sflight,
  lt_carrid    TYPE sflight.

CALL FUNCTION 'Z_SO_FLUGLISTE'
  EXPORTING
  i_carrid     = lt_carrid
  IMPORTING
    ex_flugliste = lt_flugliste
  TABLES
    flugliste    = lt_fluge
 EXCEPTIONS
   NOTHING_FOUND       = 1
   OTHERS       = 2
  .
IF sy-subrc <> 0.
* Implement suitable error handling here
  WRITE: / 'ERROR'.
ELSE.
  WRITE: / lines( lt_flugliste ),'Fluge gefunden'.
  WRITE: / lines( lt_fluge ), 'Fluge gefunden'.
ENDIF.
