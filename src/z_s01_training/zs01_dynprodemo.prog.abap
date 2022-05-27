REPORT z02_dynpro_demo1.


TABLES:
  spfli.

CALL SCREEN 100.



MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN 'SHOW'.
      SELECT SINGLE * FROM spfli
        WHERE carrid = spfli-carrid
        AND connid = spfli-connid.
        if sy-subrc <> 0.
        spfli-cityfrom = 'Nicht da'.
        clear spfli.
        ENDIF.
            WHEN 'BACK'.
      LEAVE PROGRAM.
  ENDCASE.


ENDMODULE.
