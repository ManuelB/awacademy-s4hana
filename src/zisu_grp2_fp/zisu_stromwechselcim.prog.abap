*&---------------------------------------------------------------------*
*& Include          ZISU_STROMWECHSELF01
*&---------------------------------------------------------------------*

CLASS lcl_listener IMPLEMENTATION.

  METHOD handle_double_click.
    READ TABLE lt_tarife INDEX e_row-index INTO ls_tarife.
    CALL FUNCTION 'POPUP_TO_CONFIRM'
      EXPORTING
*       TITLEBAR      = ' '
*       DIAGNOSE_OBJECT             = ' '
        text_question = 'Sind Sie schon ein Kunde ?'
        text_button_1 = 'Ja'(001)
*       ICON_BUTTON_1 = ' '
        text_button_2 = 'Nein'(002)
      IMPORTING
        answer        = answer.
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.

    CASE answer.

      WHEN 1.
*        CALL SCREEN 1100.
      WHEN 2.
*        CALL SCREEN 1200.

      WHEN OTHERS.

    ENDCASE.
  ENDMETHOD.

ENDCLASS.
