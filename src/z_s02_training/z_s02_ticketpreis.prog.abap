*&---------------------------------------------------------------------*
*& Report Z_S02_TICKETPREIS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S02_TICKETPREIS.


**** unter Springen > Eigenschaften ist das Häkchen unter Festpunktarithmetik entfernt.

PARAMETERS:
preis TYPE p LENGTH 4 DECIMALS 1 DEFAULT '207.00'.

preis = 207 / 1.

WRITE: 'Ticketpreis:', preis.
