REPORT z09_picture_edit_short.
*
DATA:
  cust TYPE REF TO cl_gui_custom_container,
  dock TYPE REF TO cl_gui_docking_container,
  pict TYPE REF TO cl_gui_picture,
  edit TYPE REF TO cl_gui_textedit,
  url  TYPE cndp_url.
*
CALL SCREEN 100.
*
MODULE status_0100 OUTPUT.
  IF cust IS INITIAL.
    CREATE OBJECT:
      cust EXPORTING container_name = 'CUCTRL',
        dock,
        pict EXPORTING parent = cust,
     edit
      EXPORTING
*        max_number_chars       =
        parent                 = dock.

    CALL FUNCTION 'DP_PUBLISH_WWW_URL'
      EXPORTING
        "objid    = 'DEMO' "Beispielfoto
        objid = 'SAP_LOGO.GIF'
        lifetime = cndp_lifetime_transaction
      IMPORTING
        url      = url.
    pict->load_picture_from_url( url ).

  ENDIF.
ENDMODULE.
*
MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN 'EXIT'. LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.
