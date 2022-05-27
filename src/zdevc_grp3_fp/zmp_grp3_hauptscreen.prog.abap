*&---------------------------------------------------------------------*
*& Report ZMP_GRP3_HAUPTSCREEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmp_grp3_hauptscreen.


DATA: my_url   TYPE url_define-url,
      cont1    TYPE REF TO cl_gui_custom_container,
      web      TYPE REF TO cl_gui_html_viewer,
      picture1 TYPE REF TO cl_gui_picture,
      url      TYPE cndp_url.


MODULE user_command_1000 INPUT.

  CASE sy-ucomm.
    WHEN 'BACK'.
      LEAVE PROGRAM.

    WHEN 'URL'.

      CALL FUNCTION 'CALL_BROWSER'
        EXPORTING
          url = 'https://bootcamp.swm.de:44301/sap/bc/ui2/flp?sap-client=100&sap-language=DE#ztarife_app_grp3-display&/?sap-iapp-state--history=TAS0WAOM5K3N79R6ZAXJKZB834Z9D95EMQQLKPRSJ&sap-iapp-state=AS4KQZHHIWOZTQWDSQPC7FL4GNMGKI4G517ZGYQT'.
    WHEN 'URL1'.

      CALL FUNCTION 'CALL_BROWSER'
        EXPORTING
          url = 'http://10.0.0.65:50000/sap/bc/ui5_ui5/sap/zgrp3_swm_vergl/index.html?sap-client=100'.

     WHEN 'REPORT'.
      SUBMIT z_s05_graphs_dynpros AND RETURN.
  ENDCASE.
*
ENDMODULE.

MODULE status_1000 OUTPUT.
  SET PF-STATUS 'S1000'.
  SET TITLEBAR 'MAINTITLE'.
    CREATE OBJECT cont1
      EXPORTING
        container_name = 'CUCTRL'.
*
    CREATE OBJECT picture1
      EXPORTING
        parent = cont1.
    CALL FUNCTION 'DP_PUBLISH_WWW_URL'
      EXPORTING
        objid    = 'ZDEMOGR3'
        lifetime = cndp_lifetime_transaction
      IMPORTING
        url      = url.
    picture1->load_picture_from_url( url ).
ENDMODULE.
