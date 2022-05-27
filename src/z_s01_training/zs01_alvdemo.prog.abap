REPORT z02_dynpro_demo1.


TABLES:
  spfli, scarr, sflight.


DATA:
*      Container
  cont1    TYPE REF TO cl_gui_custom_container,
  cont2    TYPE REF TO cl_gui_custom_container,
  dia TYPE REF TO cl_gui_dialogbox_container,
*  Anwendungs-controls
  alv1     TYPE REF TO cl_gui_alv_grid,
  alv2     TYPE REF TO cl_gui_alv_grid,
  web TYPE REF TO cl_gui_html_viewer,
 my_url TYPE scarr-url,
  lt_spfli TYPE TABLE OF spfli,
  lt_scarr TYPE TABLE OF scarr.




CALL SCREEN 100.



MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN 'SHOW'.
      SELECT * FROM scarr INTO TABLE lt_scarr.
        SELECT SINGLE url from scarr INTO my_url
          WHERE carrid =  spfli-carrid.
      IF spflI-carrid IS INITIAL.
        SELECT * FROM spfli INTO TABLE lt_spfli.
      ELSE.
        SELECT * FROM spfli INTO TABLE lt_spfli
          WHERE carrid = spfli-carrid.
      ENDIF.

      IF sy-subrc <> 0.
        spfli-cityfrom = 'Nicht da'.
        CLEAR spfli.
      ENDIF.
    WHEN 'BACK'.
      LEAVE PROGRAM.
  ENDCASE.


ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.

  IF cont1 IS INITIAL. "Is not bound
    CREATE OBJECT cont1
      EXPORTING
        container_name = 'CUCTRL'.
    CREATE OBJECT cont2
      EXPORTING
        container_name = 'CUCTRL2'.

    CREATE OBJECT dia
      EXPORTING
        width                       = 300
        height                      = 100.


*    CREATE OBJECT web
*      EXPORTING
*        parent             = cont1.
  CREATE OBJECT web
      EXPORTING
        parent             = dia.




*    CREATE OBJECT alv1
*      EXPORTING
**
*        i_parent = cont1.
*
    CREATE OBJECT alv2
      EXPORTING
        i_parent = cont2.
    .
  ENDIF.
*  CALL METHOD alv1->set_table_for_first_display
*    EXPORTING
**
*      i_structure_name = 'SPFLI'
**
*    CHANGING
*      it_outtab        = lt_spfli.
  CALL METHOD web->show_url
    EXPORTING
      url                    = my_url.
*


  CALL METHOD alv2->set_table_for_first_display
    EXPORTING
*
      i_structure_name = 'SCARR'
*
    CHANGING
      it_outtab        = lt_SCARR.



ENDMODULE.
