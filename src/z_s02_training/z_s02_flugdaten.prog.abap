*&---------------------------------------------------------------------*
*& Report Z_S02_FLUGDATEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S02_FLUGDATEN.


INCLUDE Z_T04_I_Flugdaten.


*DATA lt_spfli   TYPE TABLE OF spfli   .
*DATA lt_sflight TYPE TABLE OF sflight .
*DATA lt_scarr   TYPE TABLE OF scarr   .
*DATA lt_sbook   TYPE TABLE OF sbook   .
*DATA lt_scustom TYPE TABLE OF scustom .
*DATA lt_scounter TYPE TABLE OF scounter.
*DATA lt_SBUSPART TYPE TABLE OF SBUSPART.

*BREAK-POINT.

PARAMETERS: p_kunde TYPE scustom-id.

TYPES: BEGIN OF lty_flugkunde,
  id(8) TYPE c,
  name(30) TYPE c,
  cityto(30) TYPE c,
  END OF lty_flugkunde.


DATA ls_flugkunde TYPE lty_flugkunde.
DATA lt_flugkunde TYPE lty_flugkunde.



DATA lty_flugkunde TYPE STANDARD TABLE OF lty_flugkunde.




LOOP AT lt_sbook INTO lt_flugkunde WHERE id EQ 00000034.
 IF lt_spifli .

 ENDIF.

 ENDLOOP.

ENDIF.
ENDLOOP.

IF lt_sbook.

ENDIF.
