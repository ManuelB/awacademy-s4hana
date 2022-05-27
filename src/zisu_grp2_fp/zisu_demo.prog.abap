*&---------------------------------------------------------------------*
*& Report ZISU_DEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZISU_DEMO.

Tables :
  zisu_fp_kunden, zisu_fp_tarife, zisu_fp_wechsel.

Data :
      cont1 type ref to cl_gui_custom_container,
      alv1 type ref to cl_gui_alv_grid,
      ls_tarife type zisu_fp_tarife,
      lt_tarife type table of zisu_fp_tarife.

class lcl_listener definition.
  public section.
  Data answer type c.
  Methods: handle_double_click
  for event double_click of cl_gui_alv_grid
  importing e_row.
  endclass.

  class lcl_listener implementation.

    Method handle_double_click.
      Read table lt_tarife index e_row-index into ls_tarife.
 CALL FUNCTION 'POPUP_TO_CONFIRM'
   EXPORTING
*    TITLEBAR                    = ' '
*    DIAGNOSE_OBJECT             = ' '
     text_question               = 'Sind Sie schon ein Kunde ?'
    TEXT_BUTTON_1               = 'Ja'(001)
*    ICON_BUTTON_1               = ' '
    TEXT_BUTTON_2               = 'Nein'(002)

  IMPORTING
    ANSWER                      = answer
           .
 IF sy-subrc <> 0.
* Implement suitable error handling here
 ENDIF.

   CASE answer.

    WHEN 1.
      CALL SCREEN 1100.
    WHEN 2.
      call screen 1200.

    WHEN OTHERS.

  ENDCASE.
 endmethod.

    endclass.



START-OF-SELECTION.
call screen 1000.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_1000  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_1000 INPUT.

  CASE sy-ucomm.
    when 'SHOW'.
      Select * from zisu_fp_tarife into table lt_tarife.
        when 'BACK'.
          leave program.
          endcase.

ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_1000 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_1000 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.
  if cont1 is initial.        "when this is left, alv report does not show up
  CREATE OBJECT cont1
    EXPORTING
      container_name              = 'CUCTRL'.

  CREATE OBJECT alv1
    EXPORTING
      i_parent          = cont1.

 Data : my_event type ref to lcl_listener.
Create object my_event.
  set handler my_event->handle_double_click for alv1.
  else.
    alv1->refresh_table_display( ).
    endif.


  Call method alv1->set_table_for_first_display
    EXPORTING
      i_structure_name              =      'ZISU_FP_TARIFE'            " Strukturname der internen Ausgabetabelle

    CHANGING
      it_outtab                     =     lt_tarife  .           " Ausgabetabelle
*
*cl_gui_control=>set_focus( alv1 ).

ENDMODULE.
