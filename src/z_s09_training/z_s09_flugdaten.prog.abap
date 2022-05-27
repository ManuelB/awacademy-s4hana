*&---------------------------------------------------------------------*
*& Report Z_S09_FLUGDATEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S09_FLUGDATEN.

"DATA lt_spfli   TYPE TABLE OF spfli   .
"DATA lt_sflight TYPE TABLE OF sflight .
"DATA lt_scarr   TYPE TABLE OF scarr   .
"DATA lt_sbook   TYPE TABLE OF sbook   .INCLUDE Z_T04_I_FLUGDATEN.
"DATA lt_scustom TYPE TABLE OF scustom .
"DATA lt_scounter TYPE TABLE OF scounter.BREAK-POINT.
"DATA lt_SBUSPART TYPE TABLE OF SBUSPART.

INCLUDE Z_T04_I_FLUGDATEN.

PARAMETERS: p_kunde TYPE scustom-id.

TYPES: BEGIN OF spfli,
         vname(20) TYPE c,
         nname(20) TYPE c,
         flug(20)  TYPE c,
       END OF spfli.

DATA ls_user TYPE spfli.

DATA lt_user TYPE TABLE OF spfli.
