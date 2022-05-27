*&---------------------------------------------------------------------*
*& Report ZS03_DYNPRO_DEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs03_alv_demo.
TABLES:
  scarr, spfli, sflight.
DATA:
* Wir brauchen einen Container, um einen Anwendungs Control da rein zu stopfen.
  cont1    TYPE REF TO cl_gui_custom_container,
  cont2    TYPE REF TO cl_gui_custom_container,
  dia TYPE REF TO cl_gui_dialogbox_container,
*  da kommen die Anwendungs controls,
  alV1     TYPE REF TO cl_gui_alv_grid,
  alV2     TYPE REF TO cl_gui_alv_grid,
  web TYPE REF TO cl_gui_html_viewer,
  my_url TYPE scarr-url,
  lt_scarr TYPE TABLE OF scarr,
  lt_spfli TYPE TABLE OF spfli.

CALL SCREEN 100.

MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN 'SHOW'.
      SELECT * FROM scarr INTO TABLE lt_scarr.
*        die url beschaffen, die gezeigt werden soll, hier unten
        SELECT SINGLE url FROM scarr INTO my_url
          where carrid = spfli-carrid.
      IF spfli-carrid IS INITIAL.
        SELECT * FROM spfli INTO TABLE lt_spfli.
*        je lui dis l.21 de me donner ttes les Flugverbindungen si je laisse carrid vide.
      ELSE.
        SELECT * FROM spfli INTO TABLE lt_spfli
      WHERE carrid = spfli-carrid.
      ENDIF.
      IF sy-subrc <> 0.
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

  IF cont1 IS INITIAL. "is not bound
*    pr que le create object se fasse pas 2 fois a chaque fois.
    CREATE OBJECT cont1
      EXPORTING
        container_name = 'CUCTRL'.
    CREATE OBJECT cont2
      EXPORTING
        container_name = 'CUCTRL2'.

CREATE OBJECT dia.
*  EXPORTING
*
*    width                       = 30
*    height                      = 30
*


*    CREATE OBJECT alv1
*      EXPORTING
*        i_parent = cont1.
*alv wird in cont1 eingebettet.
** on peut pas créer alv1 et web en même tps.


* webseite my_url wird angezeigt.
*    CREATE OBJECT web
*      EXPORTING
*        parent             = cont1.

 CREATE OBJECT web
      EXPORTING
        parent             = dia.



    CREATE OBJECT alv2
      EXPORTING
        i_parent = cont2.
  ENDIF.






* Si je veux inverser les 2 listes, j'échange CUCTRL et CUCTRL2 ci dessus l.51 et 54

*  CALL METHOD alv1->set_table_for_first_display
*    EXPORTING
*      i_structure_name = 'SPFLI'
**    daraus kommt die Dict Namen dazu.
*    CHANGING
*      it_outtab        = lt_spfli.

CALL METHOD web->show_url
  EXPORTING
*   url                    = 'www.google.de'.
url = my_url.

  CALL METHOD alv2->set_table_for_first_display
    EXPORTING
      i_structure_name = 'SCARR'
*    daraus kommt die Dict Namen dazu.
    CHANGING
      it_outtab        = lt_scarr.

ENDMODULE.
