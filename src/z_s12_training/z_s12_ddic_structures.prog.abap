*&---------------------------------------------------------------------*
*& Report Z_S12_DDIC_STRUCTURES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s12_ddic_structures.

*Deklaration von lokalen Strukturen und Tabellen aus Strukturen des Dictionary
DATA ls_user TYPE ZS12_user.

data ls_flights type zs12_flight.
DATA lt_flights TYPE TABLE OF zs12_flight.
BREAK-POINT.
