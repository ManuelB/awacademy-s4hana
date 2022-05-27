*&---------------------------------------------------------------------*
*& Report Z09_FLUGLISTE_FUBA
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z09_FLUGLISTE_FUBA.

DATA: lt_fluege TYPE TABLE OF sflight.

CALL FUNCTION 'Z09_FLUGLISTE'
  EXPORTING
    i_carrid            =
* EXCEPTIONS
*   NOTHING_FOUND       = 1
*   OTHERS              = 2
          .
IF sy-subrc <> 0.
  WIRTE: / 'Irgendein Fehler'.
  else.
    WRITE: / lines( lt_fluege ), 'Flüge gefunden'.
* Implement suitable error handling here
ENDIF.
