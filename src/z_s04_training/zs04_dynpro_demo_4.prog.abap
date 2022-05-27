*&---------------------------------------------------------------------*
*& Report ZS04_DYNPRO_DEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs04_dynpro_demo_4.

TABLES: spfli, sflight, saplane, scarr.


CALL SCREEN 100.


*FIELD-SYMBOLS: <carrid>    TYPE spfli-carrid,
*               <connid>    TYPE spfli-connid,
*               <planetype> TYPE sflight-planetype,
*               <carrid2>   TYPE spfli-carrid.



MODULE user_command_0100 INPUT.


  CASE sy-ucomm.

    WHEN 'SHOW'.
*      ASSIGN: spfli-carrid      TO <carrid>,
*              spfli-connid      TO <connid>,
*              spfli-carrid      TO <carrid2>,
*              sflight-planetype TO <planetype>.

      SELECT  SINGLE * FROM spfli
        WHERE carrid =  spfli-carrid
        AND   connid = spfli-connid.

      SELECT SINGLE * FROM sflight
        WHERE carrid = spfli-carrid
        AND connid = spfli-connid.

      SELECT SINGLE * FROM scarr
        WHERE carrid =  spfli-carrid.

      SELECT SINGLE * FROM saplane
        WHERE planetype = sflight-planetype.


      SET SCREEN 200.

      IF sy-subrc <> 0.
        CLEAR: spfli, sflight, saplane, scarr.
        MESSAGE 'Keine Flugverbindung gefunden!' TYPE 'I' DISPLAY LIKE 'W'.
                SET SCREEN 100.
      ENDIF.


    WHEN 'BACK'.
      LEAVE PROGRAM.

  ENDCASE.

ENDMODULE.



MODULE user_command_0200 INPUT.




  CASE sy-ucomm.

    WHEN 'GOTO100'.
      "CLEAR: <carrid>, <connid>, <carrid2>, <planetype>.
       CLEAR: spfli, sflight, saplane, scarr.
      SET SCREEN 100.

    WHEN 'BACK'.
      LEAVE PROGRAM.

  ENDCASE.

ENDMODULE.





MODULE status_0100 OUTPUT.

* SET PF-STATUS 'xxxxxxxx'.
  SET TITLEBAR 'T100'.
  IF spfli-carrid IS INITIAL.
    spfli-carrid = 'LH'.
    spfli-connid = '400'.
  ENDIF.

ENDMODULE.



MODULE status_0200 OUTPUT.

* SET PF-STATUS 'xxxxxxxx'.

  SET TITLEBAR 'T200'.

*  LOOP AT SCREEN.
*    IF screen-name = 'SPFLI-CITYFROM'.
*      screen-input = 1.
*    ENDIF.
*    MODIFY SCREEN.
*  ENDLOOP.

ENDMODULE.
