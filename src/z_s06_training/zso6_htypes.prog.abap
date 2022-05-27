*&---------------------------------------------------------------------*
*& Report ZSO6_HTYPES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSO6_HTYPES.

TYPES: BEGIN OF ty_test,
  ebeln TYPE ebeln,
  ebelp TYPE ebelp,
  END OF ty_test,

  tty_test TYPE TABLE OF ty_test,
  tty_test TYPE SORTED TABLE OF ty_test
  WITH NON-UNIQUE KEY ebeln.

  DATA:  s_test TYPE ty_test,
        ty_test TYPE tty_test.
