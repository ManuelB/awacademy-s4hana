*&---------------------------------------------------------------------*
*& Report Z_S09_FLUGLISTE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s09_flugliste.

DATA:
  lt_flugliste TYPE sflight_tab2,
  lt_fluege    TYPE TABLE OF sflight,
  lt_carrid    TYPE TABLE OF sflight-carrid.


CALL FUNCTION 'Z09_FLUGLISTE'
  EXPORTING
    i_carrid     = lt_carrid
  IMPORTING
    ex_flugliste = lt_flugliste
  TABLES
    flugliste    = lt_fluege
*                             EXCEPTIONS
*   NOTHING_FOUND       = 1
*   OTHERS       = 2
  .
IF sy-subrc <> 0.

  WRITE: / 'Fehler'.
ELSE.
  WRITE: / lines( lt_flugliste ), 'FLüge gefunden'.
  WRITE: / lines( lt_fluege ), 'Flüge gefunden'.
* Implement suitable error handling here
ENDIF.
