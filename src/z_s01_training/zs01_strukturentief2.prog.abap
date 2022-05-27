*&---------------------------------------------------------------------*
*& Report Z_S01_STRUCTURES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S01_STRUCTURES.

*Verstanden

*Called Strukturen & Tabellen.
*Deklarationen von lokaen Strukturen und Tabellen aus Strukturen des Dictionary.
*Tiefe Strukturen sind Strukturen mit Strukturen mit eigenen Feldern.

*Flache Struktur = Einzilige Struktur
*Tiefe Struktur = Datenelemente das Eigene Felder besitzt, bzw. eine eigene Struktur hat.
*Ein Feld das wir haben müssen, um ein Feld darin anzusprechen.


DATA ls_user type ZS01_Struktur.
DATA ls_flights type zs01_flight.
