*&---------------------------------------------------------------------*
*& Report ZS12_DYNPRO_DEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs12_alv_demo_uebung.

TABLES:
  scarr,
  sflight,
  spfli.

DATA:
*Container
  cont1      TYPE REF TO cl_gui_custom_container, "man braucht einen Container
  cont2      TYPE REF TO cl_gui_custom_container, "man braucht einen zweiten Container
  dia        TYPE REF TO cl_gui_dialogbox_container,
  dock       TYPE REF TO cl_gui_docking_container,

*Anwendungs-Controls
  alv1       TYPE REF TO cl_gui_alv_grid, "Anwendungs-Control
  alv2       TYPE REF TO cl_gui_alv_grid, "Anwendungs-Control
  alv3       TYPE REF TO cl_gui_alv_grid, "Anwendungs-Control
  web        TYPE REF TO cl_gui_html_viewer,
  my_url     TYPE scarr-url,
  lt_scustom TYPE TABLE OF scustom,
  lt_scarr   TYPE TABLE OF scarr,
  lt_spfli   TYPE TABLE OF spfli.

CALL SCREEN 100.

MODULE user_command_0100 INPUT.
  CASE sy-ucomm. "Usercommand wird abgefragt "Welcher button gedrückt wird, wird hierhin verschoben
    WHEN 'SHOW'. "Show Button fkt.code - case sensitive
      SELECT * FROM scustom INTO TABLE lt_scustom.
      SELECT * FROM scarr INTO TABLE lt_scarr.
      IF spfli-carrid IS NOT INITIAL.
        SELECT SINGLE url FROM scarr INTO my_url. "Beschaffung der auszugebenden URL
      ELSE.
        my_url = 'https://awacademy.de/'.
      ENDIF.

*      where carrid = spfli-carrid.
      IF spfli-carrid IS INITIAL.
        SELECT * FROM spfli INTO TABLE lt_spfli.
      ELSE.
        SELECT * FROM spfli INTO TABLE lt_spfli
          WHERE carrid = spfli-carrid.
      ENDIF.
*      CASE spfli-carrid.
*        WHEN sy-subrc NE 0.
*          MESSAGE 'Keine gültige Fluggesellschaft eingegeben' TYPE 'E'.
*
*      ENDCASE.
*      CASE spfli-connid.
*        WHEN sy-subrc <> 0.
*          MESSAGE 'Keine gültige Flugverbindung eingegeben' TYPE 'E'.
*
*      ENDCASE.
      IF sy-subrc <> 0.
        CLEAR spfli.
      ENDIF.
    WHEN 'BACK'. "back button fkt.code - case sensitive
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
***************************Container***************************
*Erzeugung: Muster -> ABAP Objects Muster -> Create Object
*Instanz cont1 - Klasse: cl_gui_custom_container

* aktuelle Demo-Version:
* auf Dynpro: 2 Bereiche, CUCTRL + CUCTRL2
* angedockt: 1x links
* Dialogbox: 1x

* gefüllt:
* CUCTRL mit ./.
* CUCTRL2 mit scarr
* Docking mit scustom
* Dialogbox mit Webseite der carrid


  IF cont1 IS INITIAL. "Damit die Objekte nur ein mal erzeugt werden
    CREATE OBJECT cont1
      EXPORTING
        container_name = 'CUCTRL'. "Bereich auf Dynpro zuweisen - UI Element
*In Dynpro 100 gehen und Custom Control erzeugen mit dem Namen CUCTRL
    CREATE OBJECT cont2
      EXPORTING
        container_name = 'CUCTRL2'.
    CREATE OBJECT dia.
*  EXPORTING
*    width                       = 30
*    height                      = 30

    CREATE OBJECT dock.
*  EXPORTING
*    side                        = DOCK_AT_LEFT

    CREATE OBJECT alv1
      EXPORTING
        i_parent = dock.
*        i_parent = cont1.


***************************Anwendungscontrol***************************
*Selbe Erzeugungsart wie cont1
*    CREATE OBJECT alv1 "Anwendungscontrol
*      EXPORTING
*        i_parent = cont1. "alv1 wird dem Parent cont1 zugewiesen und in cont1 eingebettet.

*    CREATE OBJECT web
*      EXPORTING
*        parent = cont1.

    CREATE OBJECT web
      EXPORTING
        parent = dia.

    CREATE OBJECT alv2 "Anwendungscontrol
      EXPORTING
        i_parent = cont2.
    CREATE OBJECT alv3
      EXPORTING
        i_parent = cont1.

    .
    IF sy-subrc <> 0.
*     MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*                WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.


  ENDIF.

* Methoden der Anwendungscontrols anwenden: Tabelle anzeigen, Webseite anzeigen

*Erzeugung wie oben nur jetzt 'Call Method' - vom "Child" angeben
*Instanz: alv1
*Klasse/Interface: cl_gui_alv_grid
*Methode: set_table_for_first_display
*  CALL METHOD alv1->set_table_for_first_display
*    EXPORTING
*      i_structure_name = 'SPFLI'
*Strukturkomponente von SPFLI
*    CHANGING
*      it_outtab        = lt_spfli.
*Implementierung eines URL-Fensters

  CALL METHOD alv1->set_table_for_first_display
    EXPORTING
      i_structure_name = 'SCUSTOM'
    CHANGING
      it_outtab        = lt_scustom.


  CALL METHOD web->show_url
    EXPORTING
      url = my_url. "'https://www.google.de'.

  CALL METHOD alv3->set_table_for_first_display
    EXPORTING
      i_structure_name = 'SCARR'
    CHANGING
      it_outtab        = lt_scarr.

  CALL METHOD alv2->set_table_for_first_display
    EXPORTING
      i_structure_name = 'SPFLI'
    CHANGING
      it_outtab        = lt_spfli.

  .
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.




ENDMODULE.
