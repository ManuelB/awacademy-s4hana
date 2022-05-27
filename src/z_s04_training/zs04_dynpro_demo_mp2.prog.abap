*&---------------------------------------------------------------------*
*& Report ZS04_DYNPRO_DEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs04_dynpro_demo_mp2.

TABLES: zsd_grp1_fs.


CALL SCREEN 100.

*CLASS lcl_event DEFINITION.
*PUBLIC SECTION.
*
*EVENTS:
*
*
*  ENDCLASS.
*
*  CLASS lcl_event IMPLEMENTATION.
*
*
*    ENDCLASS.

START-OF-SELECTION.

MODULE user_command_0100 INPUT.


  CASE sy-ucomm.

    WHEN 'SHOW'.

      SELECT  SINGLE * FROM zsd_grp1_fs
        WHERE filnr =  zsd_grp1_fs-filnr.


      IF sy-subrc <> 0.
        CLEAR zsd_grp1_fs.
        MESSAGE 'Filialnummer nicht gefunden!' TYPE 'I' DISPLAY LIKE 'W'.
        CALL SCREEN 105
        STARTING AT 1 1." ENDING AT col2 lin2.
      ELSE.
        SET SCREEN 200.
      ENDIF.

    WHEN 'BACK'.
      LEAVE PROGRAM.

  ENDCASE.

ENDMODULE.



MODULE user_command_0200 INPUT.




  CASE sy-ucomm.


    WHEN 'CHANGE'.

      SELECT SINGLE FOR UPDATE filname, strasse, plz, ort, tel FROM zsd_grp1_fs
        WHERE filnr =  @zsd_grp1_fs-filnr INTO @DATA(ls_fil).

        IF sy-subrc = 0.

      UPDATE zsd_grp1_fs SET
    filname = @zsd_grp1_fs-filname,
    strasse = @zsd_grp1_fs-strasse,
    plz = @zsd_grp1_fs-plz,
    ort = @zsd_grp1_fs-ort,
    tel = @zsd_grp1_fs-tel,
    userid = @sy-uname,
    datum = @sy-datum


    WHERE filnr = @zsd_grp1_fs-filnr.

      MESSAGE 'Filialdaten geändert!' TYPE 'I'.

        ENDIF.

      SET SCREEN 100.


    WHEN 'GOTO100'.
      SET SCREEN 100.

    WHEN 'BACK'.
      LEAVE PROGRAM.

  ENDCASE.

ENDMODULE.





MODULE status_0100 OUTPUT.

* SET PF-STATUS 'xxxxxxxx'.
*                                                                                                                                                                          SET TITLEBAR 'T100'.
*  IF zsd_grp1_fs-filnr IS INITIAL.
*    zsd_grp1_fs-filnr = 'LH'.
*  ENDIF.

ENDMODULE.



MODULE status_0200 OUTPUT.

* SET PF-STATUS 'xxxxxxxx'.

*  SET TITLEBAR 'T200'.
*
*  LOOP AT SCREEN.
*    IF screen-name = 'SPFLI-CITYFROM'.
*      screen-input = 1.
*    ENDIF.
*    MODIFY SCREEN.
*  ENDLOOP.

ENDMODULE.

*MODULE user_command_0105 INPUT.
*
*
*ENDMODULE.
