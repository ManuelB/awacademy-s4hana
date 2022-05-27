REPORT zs12_picture_edit_short.
*
CONTROLS: tabarea TYPE TABSTRIP.
DATA:
  cust  TYPE REF TO cl_gui_custom_container,
  cust2 TYPE REF TO cl_gui_custom_container,
*  dock TYPE REF TO cl_gui_docking_container,
  pict  TYPE REF TO cl_gui_picture,
  edit  TYPE REF TO cl_gui_textedit,
  url   TYPE cndp_url.
*
CALL SCREEN 100.
*
MODULE status_0100 OUTPUT.
  IF cust IS INITIAL.
    CREATE OBJECT:
      cust EXPORTING container_name = 'CUCTRL_LOGO',
      cust2 EXPORTING container_name = 'CUCTRL',
*        dock,
        pict EXPORTING parent = cust,
     edit
      EXPORTING
*        max_number_chars       =
*        parent                 = dock.
parent = cust2.

    CALL FUNCTION 'DP_PUBLISH_WWW_URL'
      EXPORTING
        "objid    = 'DEMO' "Beispielfoto
        objid    = 'SAP_LOGO.GIF'
        lifetime = cndp_lifetime_transaction
      IMPORTING
        url      = url.
    pict->load_picture_from_url( url ).

  ENDIF.
ENDMODULE.
*
MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN 'DETAIL'. SET SCREEN 200.
    WHEN 'EXIT'. LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0200  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0200 INPUT.
  CASE sy-ucomm.
    WHEN 'BACK'. SET SCREEN 100.
    WHEN 'EXIT'. SET SCREEN 0.

  ENDCASE.
ENDMODULE.
