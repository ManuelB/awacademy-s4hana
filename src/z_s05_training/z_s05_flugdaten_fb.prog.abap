*&---------------------------------------------------------------------*
*& Report Z_S05_FLUGDATEN_FB
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_FLUGDATEN_FB.

*
*
DATA:
  lt_flugliste TYPE sflight_tab2,
  ls_fluege    TYPE sflight,
  lt_fluege    TYPE TABLE OF sflight.
*


CALL FUNCTION 'ZS05_FS_SFLIG'
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
  WRITE: / 'irgendein Fehler'.
ELSE.
  WRITE: / lines( lt_flugliste ), 'Flüge gefunden'.
  WRITE: / lines( lt_fluege ), 'Flüge gefunden'.
  LOOP AT lt_fluege INTO ls_fluege.
    WRITE: / ls_fluege-carrid,
           ls_fluege-connid,
           ls_fluege-fldate,
           ls_fluege-price,
           ls_fluege-currency,
           ls_fluege-paymentsum,
           ls_fluege-seatsocc.


  ENDLOOP.
ENDIF.
