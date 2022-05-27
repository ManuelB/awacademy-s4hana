*&---------------------------------------------------------------------*
*& Report ZS05_STRUCTURE_TEST
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZS05_STRUCTURE_TEST.

*types: begin of ty_test,
*  ebeln type ebeln,
*  ebelp type ebelp,
*  end of ty_test,
*  tty_test type table of ty_test, " standard Tabelle mit obere struktur
*  tty_stest type sorted table of ty_test  " sorted table
*  with non-unique key ebenl.
*
*  data: s_test type ty_test,
*        t_test type tty_test.
