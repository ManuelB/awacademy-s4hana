*&---------------------------------------------------------------------*
*& Report Z_S02_DYNPRO_DEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s02_alv_demo.

TABLES:
  scarr, spfli, sflight.

DATA:
* Container
  cont1     TYPE REF TO cl_gui_custom_container,
  cont2     TYPE REF TO cl_gui_custom_container,
  dock      TYPE REF TO cl_gui_docking_container,          " Docking-Container - an anderen Container andocken bzw. Erweitern
  dia       TYPE REF TO cl_gui_dialogbox_container,        " damit kommt das webfenster schwebend als separates Fenster
* Anwendungs-Controls
  alv1      TYPE REF TO cl_gui_alv_grid,
  alv2      TYPE REF TO cl_gui_alv_grid,
  web       TYPE REF TO cl_gui_html_viewer,                 " zum Anzeigen von html
* "Inhalte" - lokale Tabellen
  my_url    TYPE scarr-url,                                 " in scarr gibt es eine Zeile mit URLs
  lt_scustom TYPE TABLE OF scustom,
  lt_scarr  TYPE TABLE OF scarr,
  lt_spfli  TYPE TABLE OF spfli
  .


CALL SCREEN 100.



*PROCESS AFTER INPUT.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT. "bein Drücken auf einen Button gibt es code aus in sy-ucomm
  CASE sy-ucomm.
    WHEN 'SHOW'.                "Achtung, SHOW muss gross geschrieben sein.
      SELECT * FROM scarr INTO TABLE lt_scarr.
      SELECT * FROM scustom INTO TABLE lt_scustom.
      SELECT SINGLE url FROM scarr INTO my_url        " URL aus der Datebbanktabelle nehmen
        WHERE carrid = spfli-carrid.
      IF spfli-carrid IS INITIAL.                       "  damit alles angezeigt wird, wenn nichts gesucht wird.
        SELECT * FROM spfli INTO TABLE lt_spfli.
      ELSE.
        SELECT * FROM spfli INTO TABLE lt_spfli
        WHERE carrid = spfli-carrid.
      ENDIF.

      IF sy-subrc <> 0.                                 "Inhalte löschen.
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

CREATE OBJECT dock
*  EXPORTING
*    side                        = DOCK_AT_LEFT
    .



* Anwendungscontrolls erzeugen
    CREATE OBJECT alv1                       " MUSTER > ABAP-Object
      EXPORTING
        i_parent = dock.                    " aus "alv1 TYPE REF TO cl_gui_alv_grid" von oben

*    CREATE OBJECT web
*      EXPORTING
*        parent = cont1.

    CREATE OBJECT web
      EXPORTING
        parent = dia.

    CREATE OBJECT alv2
      EXPORTING
        i_parent = cont2.


  ENDIF.



* Methoden aufrufen
  CALL METHOD alv1->set_table_for_first_display     " MUSTER > CALL-FUNCTION
    EXPORTING
      i_structure_name = 'SCUSTOM'
    CHANGING
      it_outtab        = lt_scustom.


  CALL METHOD web->show_url
    EXPORTING
      url = my_url. " 'https://www.google.de'.
  .

  CALL METHOD alv2->set_table_for_first_display     " MUSTER > CALL-FUNCTION
    EXPORTING
      i_structure_name = 'SCARR'
    CHANGING
      it_outtab        = lt_scarr.



ENDMODULE.
