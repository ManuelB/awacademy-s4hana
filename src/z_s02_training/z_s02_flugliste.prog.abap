*&---------------------------------------------------------------------*
*& Report Z_S02_FLUGLISTE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s02_flugliste.

DATA:
  lt_flugliste TYPE sflight_tab2,
  lt_fluege    TYPE TABLE OF sflight,
  ls_flugliste TYPE sflight.


PARAMETERS p_carrid TYPE sflight-carrid.






CALL FUNCTION 'Z_S02_FLUGLISTE'
 EXPORTING
   I_CARRID            = p_carrid
  IMPORTING
    ex_flugliste = lt_flugliste
  TABLES
    flugliste    = lt_fluege
* EXCEPTIONS
*   NOTHING_FOUND       = 1
*   OTHERS              = 2
  .


*IF sy-subrc <> 0.
** Implement suitable error handling here
*  WRITE: / 'irgendein Fehler'.
*ELSE.
*  WRITE: / lines( lt_flugliste ), 'Flüge gefunden'.
*  WRITE: / lines( lt_fluege ), 'Flüge gefunden'.
*ENDIF.


IF sy-subrc <> 0.
* Implement suitable error handling here
  WRITE: / 'irgendein Fehler'.
ELSE.
  WRITE: / lines( lt_flugliste ), 'Flüge gefunden'.
  LOOP AT  lt_flugliste INTO ls_flugliste.
    WRITE :/ ls_flugliste-carrid,
    ls_flugliste-connid,
    ls_flugliste-fldate,
    ls_flugliste-price,
    ls_flugliste-currency
    .
  ENDLOOP.
*    cl_demo_output=>display( lt_flugliste ).



ENDIF.
