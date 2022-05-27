*&---------------------------------------------------------------------*
*& Report ZS04_FLUGLISTE_FUBA
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs04_flugliste_fuba.

*
*SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME.
*  PARAMETERS p_carrid TYPE s_carr_id.
*SELECTION-SCREEN END OF BLOCK a1.

DATA: lt_fluege    TYPE TABLE OF sflight,
      lt_flugliste TYPE sflight_tab2,
      ls_sflight   TYPE sflight.



CALL FUNCTION 'ZS04_FUBA_FLUGLISTE_DET'
* EXPORTING
*   IM_CARRID           =
  IMPORTING
    ex_flugliste = lt_flugliste
*   ABFLUGSTADT  =
*   ABFLUGLAND   =
*   ANKUNFTSTADT =
*   ANKUNFTLAND  =
*   DISTANZ      =
*   FLUGZEIT     =
*   FLUGZEUGTYP  =
*   PREIS        =
  TABLES
    flugliste    = lt_fluege
* EXCEPTIONS
*   NOTHING_FOUND       = 1
*   OTHERS       = 2
  .


*WRITE: / | Alle Flugverbindungen der Fluggesellschaft: { p_carrid } |.
*ULINE.





*IF sy-subrc <> 0.
** Implement suitable error handling here
*  WRITE: / 'Fehler!'.
*ELSE.
*  WRITE: / lines( lt_fluege ), 'Flüge gefunden'.
*ENDIF.
