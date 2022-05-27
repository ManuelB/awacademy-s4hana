*&---------------------------------------------------------------------*
*& Report Z_AW07_FUBA
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_AW07_FUBA.
DATA:
  lt_flugliste type sflight_tab2,
  lt_fluege TYPE TABLE OF sflight.

CALL FUNCTION 'ZS07_FLUGLISTE'
* EXPORTING
*   I_CARRID            =
 IMPORTING
   EX_FLUGLISTE        = lt_flugliste
  TABLES
    flugliste           = lt_fluege

* EXCEPTIONS
*   NOTHING_FOUND       = 1
*   OTHERS              = 2
          .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.

          .
IF sy-subrc <> 0.
* Implement suitable error handling here
   Write: / 'irgendein Fehler'.
  else.
    WRITE: / lines( lt_flugliste ), 'Flüge gefunden'.
    WRITE: / lines( lt_fluege ), 'Flüge gefunden'.
ENDIF.
