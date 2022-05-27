*&---------------------------------------------------------------------*
*& Report Z_S02_DYNPRO_DEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s02_alv_demo_3.

TABLES:
  spfli, sflight.

DATA:
* Container
  cont1      TYPE REF TO cl_gui_custom_container,        " damit kommt das webfenster schwebend als separates Fenster
* Anwendungs-Controls
  alv1       TYPE REF TO cl_gui_alv_grid,

  lt_sflight TYPE TABLE OF sflight
*  lt_spfli   TYPE TABLE OF spfli
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

      IF spfli-carrid IS INITIAL.
        SELECT * FROM sflight INTO TABLE lt_sflight.
      ELSE.
        SELECT * FROM sflight INTO TABLE lt_sflight
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


* Anwendungscontrolls erzeugen
    CREATE OBJECT alv1                       " MUSTER > ABAP-Object
      EXPORTING
        i_parent = cont1.                    "
  ENDIF.



* Methoden aufrufen
  CALL METHOD alv1->set_table_for_first_display     " MUSTER > CALL-FUNCTION
    EXPORTING
      i_structure_name = 'SFLIGHT'
    CHANGING
      it_outtab        = lt_sflight.


  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

ENDMODULE.
