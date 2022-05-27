*&---------------------------------------------------------------------*
*& Report ZS11_DEMO_DYNPRO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs11_demo_alv_aufgabe.

**********************************************************************************
*Übung:
*Kopie des letzten Programms + wie folgt erweitern/Umbauen:
*1. Auf Dynpro: Anzeige ALV-Grid für SCARR
*2. Auf Dynpro: Anzeige ALV-Grid für SPFLI (mit Eingrenzung für CARRID wie bisher)
*3. In Dialogbox: Anzeige Webseite der ausgewählten Fluggesellschaft, falls nichts eingegeben wurde: homepage von AW-Academy aufrufen.
*4. Als Docking-Container (left): Anzeige der Tabelle SCUSTOM
*später:
*Änderung der Docking-Richtung
*************************************************************************************
TABLES:
  scarr, spfli, sflight, scustom.

DATA:
* Container
  cont1    TYPE REF TO cl_gui_custom_container,
  cont2    TYPE REF TO cl_gui_custom_container,
  dia type ref to cl_gui_dialogbox_container,
  dock type ref to cl_gui_docking_container,
*  Anwendung Controls
  alv1     TYPE REF TO cl_gui_alv_grid,
  alv2     TYPE REF TO cl_gui_alv_grid,
  alv3     TYPE REF TO cl_gui_alv_grid,
  web      TYPE REF TO cl_gui_html_viewer,
  my_url   TYPE  scarr-url,

lt_scustom type table of scustom,
  lt_spfli TYPE TABLE OF spfli,
  lt_scarr TYPE TABLE OF scarr.

CALL SCREEN 100.

MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN 'SHOW'.
      select * from scustom into table lt_scustom.
      SELECT * FROM scarr INTO TABLE lt_scarr.

*      * Die URL beschaffen, die ausgegeben werden soll.
         IF spfli-carrid IS INITIAL.
           my_url = 'www.awacademy.de'.
           else.
      SELECT SINGLE url FROM scarr INTO my_url
        WHERE carrid = spfli-carrid.
        endif.
      IF spfli-carrid IS INITIAL. "auch mit is not bound möglich
        SELECT * FROM spfli INTO TABLE lt_spfli.
      ELSE.
        SELECT * FROM spfli INTO TABLE lt_spfli "data beschaffungen
          WHERE carrid = spfli-carrid.
      ENDIF.
      IF sy-subrc <> 0.    "when select query is successful sy-subrc=0.
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
* SET PF-STATUS 'xxxxxxxx'. "stichwort:menu painter
* SET TITLEBAR 'xxx'.

*  * aktuelle Demo-Version:
* auf Dynpro: 2 Bereiche, CUCTRL + CUCTRL2
* angedockt: 1x links
* Dialogbox: 1x

* gefüllt:
* CUCTRL mit ./.
* CUCTRL2 mit scarr
* Docking mit scustom
* Dialogbox mit Webseite der carrid

  IF cont1 IS INITIAL.
*    container erzeugen
    CREATE OBJECT cont1
      EXPORTING
        container_name = 'CUCTRL'. "container object erzeugt
 CREATE OBJECT cont2
      EXPORTING
        container_name = 'CUCTRL2'.

  CREATE OBJECT dia
    EXPORTING
*      parent                      =
      width                       = 300
      height                      = 100.

CREATE OBJECT dock.
*  EXPORTING
*    side                        = DOCK_AT_LEFT

* Anwendungcontrols erzeugen

    CREATE OBJECT alv3
      EXPORTING
        i_parent = cont1.

    CREATE OBJECT alv1
      EXPORTING
        i_parent = dock.
CREATE OBJECT alv2
      EXPORTING
        i_parent = cont2.
CREATE OBJECT web
  EXPORTING
    parent             = dia.

*  CREATE OBJECT web
*      EXPORTING
*        parent = cont1.


  ENDIF.



CALL METHOD alv1->set_table_for_first_display
  EXPORTING
    i_structure_name              = 'SCUSTOM'
  CHANGING
    it_outtab                     = lt_scustom.

CALL METHOD web->show_url
    EXPORTING
      url = my_url. "'https://www.google.de'.


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
