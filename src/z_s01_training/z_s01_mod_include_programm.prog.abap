*&---------------------------------------------------------------------*
*& Include          Z_S01_MOD_INCLUDE_PROGRAMM
*&---------------------------------------------------------------------*

*ISt kein Report, sondern dient nur zum einbinen von code. Ist in MOD_FUBA_"




*Wichtig: hier definitiv die Datentypen ändern, wenn du die bausteine änderst.
  PARAMETERS:
    a  TYPE BRUTEIL, "Länge 9, 3 Dezimalstellen, 6 Vorkommastellen
    op TYPE zrk02_ty_operator,
    b  TYPE BRUTEIL.




*Typisierung muss stimmen.
DATA:
      res TYPE BRUTEIL value '-123456.789'.
