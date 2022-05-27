*&---------------------------------------------------------------------*
*& Include          ZCS_GRP1_FP_WECHSEL_F01
*&---------------------------------------------------------------------*

CLASS lcl_eventlistener IMPLEMENTATION.
  METHOD handle_double_click.

    READ TABLE lt_tarife INDEX e_row-index INTO ls_tarife.

    CALL SCREEN 3100 STARTING AT 10 5.

  ENDMETHOD.
ENDCLASS.


*CLASS lcl_interessent IMPLEMENTATION.
*ENDCLASS.
