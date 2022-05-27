
REPORT z_aw07_alv_easy.

TABLES:
  scarr, spfli, sflight.
DATA:
  "Container
  cont1      TYPE REF TO cl_gui_custom_container,
* Anwendungs-Controls
  alv1       TYPE REF TO cl_gui_alv_grid,
  lt_sflight TYPE TABLE OF sflight.
*
CALL SCREEN 100.
*
MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN 'SHOW'.
 IF spfli-carrid IS INITIAL.
   SELECT * from sflight INTO TABLE lt_sflight.
      ELSE.
   SELECT * FROM sflight INTO TABLE lt_sflight
        WHERE carrid = spfli-carrid.
        ENDIF.

      IF sy-subrc <> 0.
        "spfli-cityfrom = 'nichts da'.
        CLEAR sflight.
      ENDIF.
    WHEN 'BACK'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.
*
MODULE status_0100 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.

  IF cont1 IS INITIAL. "is not bound
    CREATE OBJECT cont1
      EXPORTING
        container_name = 'CUCTRL'.
    CREATE OBJECT alv1
      EXPORTING
        i_parent = cont1.
  ENDIF.




  CALL METHOD alv1->set_table_for_first_display
    EXPORTING
      i_structure_name = 'SFLIGHT'
    CHANGING
      it_outtab        = lt_sflight.


ENDMODULE.
