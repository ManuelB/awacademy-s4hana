*&---------------------------------------------------------------------*
*& Report ZS01_TABELLENTYP
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZS01_TABELLENTYPEN.

Types: Begin of ty_test,
  ebeln Type ebeln,
  ebelp TYPE ebelp,
  END OF ty_test,
  tty_test TYPE TABLE OF ty_test
  with NON-UNIQUE Key ebeln.

  DATA: s_test TYPE ty_Test,
        t_test TYPE tty_test.


*  Domäne = Technische Beschreibung, beinhaltet datentyp
*  Datenelemnt = Semantisch, gibt Kontext.
