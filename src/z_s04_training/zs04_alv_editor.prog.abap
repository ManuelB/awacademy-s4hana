*&---------------------------------------------------------------------*
*& Report ZS04_ALV_EDITOR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs04_alv_editor.

DATA: cont1 TYPE REF TO cl_gui_custom_container,
      dock  TYPE REF TO cl_gui_docking_container,
      edit  TYPE REF TO cl_gui_textedit.

CALL SCREEN 100.

MODULE status_0100 OUTPUT.
  IF cont1 IS INITIAL.
    CREATE OBJECT:
    cont1 EXPORTING container_name = 'CUCTRL',
      dock,
      edit EXPORTING parent = dock.
  ENDIF.
ENDMODULE.

MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN 'EXIT'. LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.
