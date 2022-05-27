*&---------------------------------------------------------------------*
*& Include          ZSD_GRP1_FP_TP_F01
*&---------------------------------------------------------------------*

*Implementierung der Methode für den Doppelklick.
CLASS lcl_eventlistener IMPLEMENTATION.
  METHOD handle_double_click.
    READ TABLE lt_tarife INDEX e_row-index INTO ls_tarife.
        CALL SCREEN 1100.
  ENDMETHOD.
ENDCLASS.
