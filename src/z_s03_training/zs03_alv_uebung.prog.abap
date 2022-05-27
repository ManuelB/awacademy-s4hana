*&---------------------------------------------------------------------*
*& Report ZS03_DYNPRO_DEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs03_alv_uebung.
TABLES:
  scarr, spfli, sflight.
DATA:
* Wir brauchen einen Container, um einen Anwendungs Control da rein zu stopfen.
  cont1    TYPE REF TO cl_gui_custom_container,
  cont2    TYPE REF TO cl_gui_custom_container,
  cont3    TYPE REF TO cl_gui_custom_container,
  dia TYPE REF TO cl_gui_dialogbox_container,
*  da kommen die Anwendungs controls
  dock TYPE REF TO cl_gui_docking_container,
  alV1     TYPE REF TO cl_gui_alv_grid,
  alV2     TYPE REF TO cl_gui_alv_grid,
  alV3     TYPE REF TO cl_gui_alv_grid,
  web TYPE REF TO cl_gui_html_viewer,
  my_url TYPE scarr-url,
  lt_scustom TYPE TABLE OF scustom,
  lt_scarr TYPE TABLE OF scarr,
  lt_spfli TYPE TABLE OF spfli.

PARAMETERS:
  p_side TYPE i DEFAULT 1.

CALL SCREEN 100.

MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN 'SHOW'.
      SELECT * FROM scarr INTO TABLE lt_scarr.
      SELECT * FROM scustom INTO TABLE lt_scustom.
      SELECT * FROM spfli INTO TABLE lt_spfli.

        SELECT SINGLE url FROM scarr INTO my_url
          where carrid = spfli-carrid.
      IF spfli-carrid IS INITIAL.
        SELECT * FROM spfli INTO TABLE lt_spfli.
     my_url = 'https://awacademy.de/'.
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
*    Mon cont1 est vide!
    CREATE OBJECT cont2
      EXPORTING
        container_name = 'CUCTRL2'.
    CREATE OBJECT cont3
      EXPORTING
        container_name = 'CUCTRL3'.

CREATE OBJECT dia
  EXPORTING
*
    width                       = 300
    height                      = 100.
*

CREATE OBJECT dock
  EXPORTING
side = p_side.
*    side                        = dock->DOCK_AT_LEFT.
*    side                        = dock->DOCK_AT_bottom.





    CREATE OBJECT alv1
      EXPORTING
        i_parent = dock.


 CREATE OBJECT web
      EXPORTING
        parent             = dia.


    CREATE OBJECT alv2
      EXPORTING
        i_parent = cont2.

    CREATE OBJECT alv3
      EXPORTING
        i_parent = cont3.

  ENDIF.






* Si je veux inverser les 2 listes, j'échange CUCTRL et CUCTRL2 ci dessus l.51 et 54

  CALL METHOD alv1->set_table_for_first_display
    EXPORTING
      i_structure_name = 'SCUSTOM'
**    daraus kommt die Dict Namen dazu.
    CHANGING
      it_outtab        = lt_scustom.

CALL METHOD web->show_url
  EXPORTING
url = my_url.

  CALL METHOD alv2->set_table_for_first_display
    EXPORTING
      i_structure_name = 'SCARR'
    CHANGING
      it_outtab        = lt_scarr.


  CALL METHOD alv3->set_table_for_first_display
    EXPORTING
      i_structure_name = 'SPFLI'
    CHANGING
      it_outtab        = lt_spfli.

ENDMODULE.
