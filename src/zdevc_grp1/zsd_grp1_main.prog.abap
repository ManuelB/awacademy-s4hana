REPORT zsd_grp1_main.

DATA: my_url TYPE url_define-url,
      cont1  TYPE REF TO cl_gui_custom_container,
      web    TYPE REF TO cl_gui_html_viewer.


MODULE user_command_1000 INPUT.
  CASE sy-ucomm.
    WHEN 'BACK'.
      LEAVE PROGRAM.

    WHEN 'URL'.

      CALL FUNCTION 'CALL_BROWSER'
      EXPORTING
        URL = 'https://bootcamp.swm.de:44301/sap/bc/ui2/flp?sap-client=100&sap-language=DE#zsd_grp1_mp2-display&/?sap-iapp-state=ASZKGA434I1YFO412PD1AS3IGFPLHLSVIQFLN5GQ&sap-iapp-state--history=TASOE20ZTX8WPIH8P7FK60VT8WRX79FRJ7OVOHKMA'.


*      CALL SCREEN 2000.




  ENDCASE.
ENDMODULE.

MODULE status_1000 OUTPUT.
  SET PF-STATUS 'S1000'.
  SET TITLEBAR 'MAINTITLE'.
ENDMODULE.




*MODULE status_2000 OUTPUT.
*  SET PF-STATUS 'S2000'.
** SET TITLEBAR 'xxx'.
*
*  IF cont1 IS INITIAL.
*
*    CREATE OBJECT cont1
*      EXPORTING
*        container_name = 'WEB'.
*
*    CREATE OBJECT web
*      EXPORTING
*        parent = cont1.
*
*    CALL METHOD web->show_url
*      EXPORTING
*        url = 'https://bootcamp.swm.de:44301/sap/bc/ui2/flp?sap-client=100&sap-language=DE#zsd_grp1_mp2-display&/?sap-iapp-state=ASZKGA434I1YFO412PD1AS3IGFPLHLSVIQFLN5GQ&sap-iapp-state--history=TASOE20ZTX8WPIH8P7FK60VT8WRX79FRJ7OVOHKMA'.
*
*  ENDIF.
*
*ENDMODULE.

*MODULE user_command_2000 INPUT.
*
*  CASE sy-ucomm.
*
*    WHEN 'BACK'.
*      LEAVE PROGRAM.
*
*  ENDCASE.
*
*ENDMODULE.
