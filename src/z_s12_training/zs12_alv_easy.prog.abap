*&---------------------------------------------------------------------*
*& Report ZS12_DYNPRO_DEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs12_alv_easy.

TABLES:
  sflight.


DATA:
*Container
  cont1      TYPE REF TO cl_gui_custom_container, "man braucht einen Container
  cont2      TYPE REF TO cl_gui_custom_container, "man braucht einen zweiten Container
  dia        TYPE REF TO cl_gui_dialogbox_container,
  dock       TYPE REF TO cl_gui_docking_container,

*Anwendungs-Controls
  alv1       TYPE REF TO cl_gui_alv_grid, "Anwendungs-Control

  lt_scustom TYPE TABLE OF scustom,
  lt_scarr   TYPE TABLE OF scarr,
  lt_sflight TYPE TABLE OF sflight,
  lt_spfli   TYPE TABLE OF spfli.

CALL SCREEN 100.

MODULE user_command_0100 INPUT.
  CASE sy-ucomm. "Usercommand wird abgefragt "Welcher button gedrückt wird, wird hierhin verschoben
    WHEN 'SHOW'. "Show Button fkt.code - case sensitive
      IF sflight IS not INITIAL.
        SELECT * FROM sflight INTO table lt_sflight.
      ELSE.
        SELECT * FROM sflight INTO table lt_sflight.
      ENDIF.
      IF sy-subrc <> 0.
        CLEAR sflight.
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

*  EXPORTING
*    side                        = DOCK_AT_LEFT

    CREATE OBJECT alv1
      EXPORTING
        i_parent = cont1.
*        i_parent = cont1.


***************************Anwendungscontrol***************************
*Selbe Erzeugungsart wie cont1


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
      i_structure_name = 'SFLIGHT'
    CHANGING
      it_outtab        = lt_sflight.



  .
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.




ENDMODULE.
