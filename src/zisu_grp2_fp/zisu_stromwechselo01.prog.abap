*&---------------------------------------------------------------------*
*& Include          ZISU_STROMWECHSELO01
*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*& Module STATUS_1010 OUTPUT
*&---------------------------------------------------------------------*
MODULE status_1010 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.
  LOOP AT SCREEN.
    IF screen-name = 'FRAME1'.
      IF flag IS INITIAL.
        screen-active = 0.
      ELSE.
        screen-active = 1.
      ENDIF.
    ENDIF.
    MODIFY SCREEN.
  ENDLOOP.

  IF cont1 IS INITIAL.        "when this is left, alv report does not show up "behinderst unnötige instanzieren
    CREATE OBJECT cont1
      EXPORTING
        container_name = 'CUCTRL'.

    CREATE OBJECT alv1
      EXPORTING
        i_parent = cont1.

    DATA : my_event TYPE REF TO lcl_listener.
    CREATE OBJECT my_event.
    SET HANDLER my_event->handle_double_click FOR alv1.
  ELSE.
    alv1->refresh_table_display( ).
  ENDIF.


  CALL METHOD alv1->set_table_for_first_display
    EXPORTING
      i_structure_name = 'ZISU_FP_TARIFE'            " Strukturname der internen Ausgabetabelle
    CHANGING
      it_outtab        = lt_tarife.           " Ausgabetabelle
*
*cl_gui_control=>set_focus( alv1 ).

ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_1100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_1100 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_1200 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_1200 OUTPUT.
  SET PF-STATUS 'STATUS_1200'.
  SET TITLEBAR 'T1200'.
ENDMODULE.
