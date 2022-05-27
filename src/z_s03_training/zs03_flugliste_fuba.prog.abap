*&---------------------------------------------------------------------*
*& Report ZS03_FLUGLISTE_FUBA
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZS03_FLUGLISTE_FUBA.

DATA: lt_fluege type TABLE OF sflight,
lt_flugliste type sflight_tab2,
ls_flugliste type sflight.


CALL FUNCTION 'ZS03_FLUGLISTE'
* EXPORTING
*   I_CARRID            =
 IMPORTING
   EX_FLUGLISTE        = lt_flugliste
  TABLES
    flugliste           = lt_fluege
 EXCEPTIONS
   NOTHING_FOUND       = 1
   OTHERS              = 2
*   si on ne ´met pas les exceptions, on aura un Laufzeitfehler
*quand  on entrera le nom d'une compagnie inexistante.
          .

          .
IF sy-subrc <> 0.
* Implement suitable error handling here
  WRITE: / 'Fehler'.
  ELSE.
    WRITE: / lines( lt_fluege ), 'Flüge gefunden'.
    WRITE: / lines( lt_flugliste ), 'Flüge gefunden'.
    loop at lt_flugliste INTO ls_flugliste.

*      aller sur Muster puis write muster et sélectionner les cases voulues.
      write: / ls_flugliste-carrid, ls_flugliste-connid, ls_flugliste-fldate.
ENDLOOP.
ENDIF.
