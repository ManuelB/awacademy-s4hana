*&---------------------------------------------------------------------*
*& Include          ZCS_GRP1_FP_WL_F01
*&---------------------------------------------------------------------*

*Impelementierung der Methode für den Doppelklick.
CLASS lcl_eventlistener IMPLEMENTATION.
  METHOD handle_double_click.
    READ TABLE lt_wt INDEX e_row-index INTO ls_wt.
    CALL SCREEN 2600.
  ENDMETHOD.
ENDCLASS.
