REPORT zs04_alv_editor_subscreen.

*CONTROLS: tsarea TYPE TABSTRIP.

DATA:
  cont1 TYPE REF TO cl_gui_custom_container,
  cont2 TYPE REF TO cl_gui_custom_container,
  pict  TYPE REF TO cl_gui_picture,
  edit  TYPE REF TO cl_gui_textedit,
  url   TYPE cndp_url.

CALL SCREEN 100.

MODULE status_0100 OUTPUT.
  IF cont1 IS INITIAL.
    CREATE OBJECT:
      cont1 EXPORTING container_name = 'CUCTRL_LOGO',
      cont2 EXPORTING container_name = 'CUCTRL',
      pict  EXPORTING parent = cont1,
      edit  EXPORTING parent = cont2.

    CALL FUNCTION 'DP_PUBLISH_WWW_URL'
      EXPORTING
        objid    = 'SAP_LOGO.GIF'
        lifetime = cndp_lifetime_transaction
      IMPORTING
        url      = url.
    pict->load_picture_from_url( url ).

  ENDIF.
ENDMODULE.

MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
*    WHEN 'SHOW'. SET SCREEN 200.
    WHEN 'EXIT'. LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.
