*&---------------------------------------------------------------------*
*& Report ZS03_TABELLEN_RAINER
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZS03_TABELLEN_RAINER.

TYPES: BEGIN OF ty_test,
  ebeln TYPE ebeln,
  ebelp TYPE ebelp,
  END OF ty_test,
  tty_test TYPE TABLE OF ty_test,
  tty_stest TYPE SORTED TABLE OF ty_test
  WITH NON-UNIQUE KEY ebeln.

  DATA: s_test TYPE ty_test,
        t_test TYPE tty_test.
