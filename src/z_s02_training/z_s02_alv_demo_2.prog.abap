*&---------------------------------------------------------------------*
*& Report Z_S02_DYNPRO_DEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s02_alv_demo_2.

TABLES:
  scarr, spfli, sflight, scustom.

DATA:
* Container
  cont1      TYPE REF TO cl_gui_custom_container,
  cont2      TYPE REF TO cl_gui_custom_container,
  dock       TYPE REF TO cl_gui_docking_container,          " Docking-Container - an anderen Container andocken bzw. Erweitern
  dia        TYPE REF TO cl_gui_dialogbox_container,        " damit kommt das webfenster schwebend als separates Fenster
* Anwendungs-Controls
  alv1       TYPE REF TO cl_gui_alv_grid,
  alv2       TYPE REF TO cl_gui_alv_grid,
  alv3       TYPE REF TO cl_gui_alv_grid,
  web        TYPE REF TO cl_gui_html_viewer,                 " zum Anzeigen von html
* "Inhalte" - lokale Tabellen
  my_url     TYPE scarr-url,                                 " in scarr gibt es eine Zeile mit URLs
  lt_scustom TYPE TABLE OF scustom,
  lt_scarr   TYPE TABLE OF scarr,
  lt_spfli   TYPE TABLE OF spfli
  .

*PARAMETERS:
*p_side type etc --> dock an verschiedenen Postionen setzen

CALL SCREEN 100.



*PROCESS AFTER INPUT.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.             "bein Drücken auf einen Button gibt es code aus in sy-ucomm
  CASE sy-ucomm.
    WHEN 'SHOW'.                            "Achtung, SHOW muss gross geschrieben sein.
      SELECT * FROM scustom INTO TABLE lt_scustom.
      SELECT * FROM scarr INTO TABLE lt_scarr.
      IF spfli-carrid IS INITIAL.
        my_url = 'https://awacademy.de/'.
      ELSE.
        SELECT SINGLE url FROM scarr INTO my_url.
      ENDIF.

      IF spfli-carrid IS INITIAL.
        SELECT * FROM spfli INTO TABLE lt_spfli.
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


*******************************************************************************************
*Erzeugung:
*in Dynpro 100 gehen und:
*PROCESS BEFORE OUTPUT.
*MODULE STATUS_0100. <-- Einkommentieren und als Rahmenporogramm anlegen
*******************************************************************************************


MODULE status_0100 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.


  IF cont1 IS INITIAL.                         " damit die Objekte NICHT bei jeder eingabe wieder generiert werden (weil Roundtrip) --> verwaiste Objekte. Auch mit "is not bound" möglich.
* Container erzeugen
    CREATE OBJECT cont1                       " MUSTER > ABAP-Object
      EXPORTING
        container_name = 'CUCTRL'.            " muss gross sein. Damit ist ein Containerobjekt erstellt

    CREATE OBJECT cont2
      EXPORTING
        container_name = 'CUCTRL2'.

    CREATE OBJECT dia.
*      EXPORTING
*        width  = 800                         " ggf. Größe des Fensters definieren
*        height = 200

*    CREATE OBJECT dock.
*    EXPORTING
*      side = dock_at_left.

    CREATE OBJECT dock.
*  EXPORTING
*    side                        = DOCK_AT_LEFT



* Anwendungscontrolls erzeugen
    CREATE OBJECT alv1                       " MUSTER > ABAP-Object
      EXPORTING
        i_parent = cont1.                    "

    CREATE OBJECT alv2
      EXPORTING
        i_parent = cont2.

    CREATE OBJECT web
      EXPORTING
        parent = dia.

    CREATE OBJECT alv3
      EXPORTING
        i_parent = dock.


  ENDIF.



* Methoden aufrufen
  CALL METHOD alv1->set_table_for_first_display     " MUSTER > CALL-FUNCTION
    EXPORTING
      i_structure_name = 'SCARR'
    CHANGING
      it_outtab        = lt_scarr.


  CALL METHOD alv2->set_table_for_first_display
    EXPORTING
      i_structure_name = 'SPFLI'
    CHANGING
      it_outtab        = lt_spfli.


    CALL METHOD web->show_url
      EXPORTING
        url = my_url.


    CALL METHOD alv3->set_table_for_first_display     "
    EXPORTING
      i_structure_name = 'SCUSTOM'
    CHANGING
      it_outtab        = lt_scustom.


  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.




ENDMODULE.
