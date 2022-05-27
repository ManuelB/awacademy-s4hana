
REPORT z_aw06_alv_demo_2.

TABLES:
  scarr, spfli, sflight.
DATA:
  "Container
  cont1    TYPE REF TO cl_gui_custom_container,
  cont2    TYPE REF TO cl_gui_custom_container,
  dia      TYPE REF TO cl_gui_dialogbox_container,
* Anwendungs-Controls
  alv1     TYPE REF TO cl_gui_alv_grid,
  alv2     TYPE REF TO cl_gui_alv_grid,
  web      TYPE REF TO cl_gui_html_viewer,
  my_url   TYPE scarr-url VALUE 'https://awacademy.de/',
  lt_scarr TYPE TABLE OF scarr,
  lt_spfli TYPE TABLE OF spfli.

CALL SCREEN 100.

CLASS lcl_doubleclick_handler DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS:
      on_double_click FOR EVENT double_click OF cl_gui_alv_grid
        IMPORTING e_row.
    "<--------------!!
ENDCLASS.

DATA:
my_event TYPE REF TO lcl_doubleclick_handler.

CLASS lcl_doubleclick_handler IMPLEMENTATION.

  METHOD on_double_click.

    DATA:
          ls_doubleclick TYPE scarr.

    READ TABLE lt_scarr INTO ls_doubleclick
    INDEX e_row.

    CALL METHOD web->show_url
      EXPORTING
        url = ls_doubleclick-url.

  ENDMETHOD.

ENDCLASS.
MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN 'SHOW'.
      SELECT * INTO TABLE lt_scarr
        FROM scarr
        WHERE carrid = spfli-carrid.


*     SELECT SINGLE url FROM lt_scarr INTO my_url "to get the url
*        WHERE carrid = spfli-carrid.
*      IF spfli-carrid IS INITIAL.
*        SELECT * FROM spfli INTO TABLE lt_spfli.
*      ELSE.
*        SELECT * FROM spfli INTO TABLE lt_spfli
*          WHERE carrid = spfli-carrid.
*      ENDIF.
*      IF sy-subrc <> 0.
*        CLEAR spfli.
*      ENDIF.
    WHEN 'BACK'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.
*
MODULE status_0100 OUTPUT.
  IF cont1 IS INITIAL. "is not bound
    CREATE OBJECT cont1
      EXPORTING
        container_name = 'CUCTRL'.
    CREATE OBJECT cont2
      EXPORTING
        container_name = 'CUCTRL2'.


    CREATE OBJECT web
      EXPORTING
        parent = cont1.

    CREATE OBJECT alv2
      EXPORTING
        i_parent = cont2.
  ENDIF.

  CREATE OBJECT my_event.
  SET HANDLER my_event->on_double_click FOR alv2.

  CALL METHOD web->show_url
    EXPORTING
      url = my_url.

  CALL METHOD alv2->set_table_for_first_display
    EXPORTING
      i_structure_name = 'SCARR'
    CHANGING
      it_outtab        = lt_scarr.

ENDMODULE.
