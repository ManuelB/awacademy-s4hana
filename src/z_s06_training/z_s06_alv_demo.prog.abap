*&---------------------------------------------------------------------*
*& Report Z_S06_DYNPRO_DEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s06_alv_demo.
TABLES:
  scarr,
  sflight,
  spfli.

DATA:
  "table
  lt_sflight type table of sflight,
  lt_spfli TYPE TABLE OF spfli,                           "def of local table
  lt_scustom TYPE TABLE OF scustom,                           "def of local table
  lt_scarr TYPE TABLE OF scarr,

  "anwendungs controlls alv1     TYPE REF TO cl_gui_alv_grid,
  alv1     TYPE REF TO cl_gui_alv_grid,                   "def of global klasse
  alv2     TYPE REF TO cl_gui_alv_grid,                   "def of global klasse
  "container
  dia      TYPE REF TO cl_gui_dialogbox_container,
  cont1    TYPE REF TO cl_gui_custom_container,           "def of global klasse
  cont2    TYPE REF TO cl_gui_custom_container,
  my_url   TYPE scarr-url,
  web      TYPE REF TO cl_gui_html_viewer.

CALL SCREEN 100.

MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN'SHOW'.
      SELECT * FROM sflight INTO TABLE lt_sflight.
      "SELECT SINGLE url FROM scarr INTO my_url
*        WHERE carrid = spfli-carrid.

      "IF spfli-carrid IS INITIAL.
      "  SELECT * FROM spfli INTO TABLE lt_spfli.          "selecting all

      "ELSE. select * from spfli INTO TABLE lt_spfli           "selecting where
       " where carrid = spfli-carrid.
*      ENDIF.
      IF sy-subrc <> 0.
        CLEAR LT_SFLIGHT.
      ENDIF.
    WHEN 'BACK'.                                          "ALWAYS CAPITAL LETTERS!
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.

MODULE status_0100 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.

  IF cont1 IS INITIAL."is not bound
    CREATE OBJECT cont1
      EXPORTING
        container_name = 'CUCTRL'.                          " muss größ geschrieben sein      "these object are called with every round trip.not good!

* CREATE OBJECT cont2
*      EXPORTING
*        container_name = 'CUCTRL2'.

*    CREATE OBJECT dia.
**    exporting
**     width                       = 100 "in pixel size
**     height                      = 100
*
*    CREATE OBJECT web
*      EXPORTING
*        parent = dia.
    IF sy-subrc <> 0.
*     MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*                WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.


    "
    CREATE OBJECT alv1
      EXPORTING
         i_parent = cont1.

*    CREATE OBJECT web
*      EXPORTING
*        parent = cont1.

*    CREATE OBJECT alv2
*      EXPORTING
*        i_parent = cont2.                                 "after = is the parent controll
  ENDIF.

  CALL METHOD alv1->set_table_for_first_display
    EXPORTING
      i_structure_name = 'SCUSTOM'
    CHANGING
      it_outtab        = lt_sflight.

*  CALL METHOD web->show_url
*    EXPORTING
*      url = my_url.
*
*  CALL METHOD web->show_url
*    EXPORTING
*      url = 'https://awacademy.de/'.
*
*  CALL METHOD alv2->set_table_for_first_display
*    EXPORTING
*      i_structure_name = 'SCARR'
*    CHANGING
*      it_outtab        = lt_scarr.
*


ENDMODULE.
