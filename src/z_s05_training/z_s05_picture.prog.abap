*&---------------------------------------------------------------------*
*& Report Z_S05_PICTURE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s05_picture.

SET SCREEN 100.


DATA:
  cust    TYPE REF TO cl_gui_custom_container,
  dock    TYPE REF TO cl_gui_docking_container,
  url     TYPE cndp_url,
  picture TYPE REF TO cl_gui_picture,
  edit    TYPE REF TO cl_gui_textedit.



MODULE status_0100 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.
  IF cust IS INITIAL.
    CREATE OBJECT cust
      EXPORTING
        container_name = 'CUCTRL1'.
    CREATE OBJECT dock.
    CREATE OBJECT picture
      EXPORTING
        parent = cust.
    CREATE OBJECT edit
      EXPORTING
        parent = dock.

CALL FUNCTION 'DP_PUBLISH_WWW_URL'
  EXPORTING
    objid                       = 'SD_FT_GOV_FLAG_DE'
    lifetime                    = cndp_lifetime_transaction
    IMPORTING
    url                   = url.
picture->load_picture_from_url( url ).
endif.




ENDMODULE.

MODULE user_command_0100 INPUT.
case sy-ucomm.
  WHEN 'EXIT'.
    SET SCREEN 0.
    LEAVE SCREEN.
    ENDCASE.


ENDMODULE.
