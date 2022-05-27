*&---------------------------------------------------------------------*
*& Report ZS04_DYNPRO_DEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs04_dynpro_demo.

TABLES: spfli.

CALL SCREEN 100.

*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*

MODULE user_command_0100 INPUT.

  CASE sy-ucomm.
    WHEN 'SHOW'.
      SELECT  SINGLE * FROM spfli
        WHERE carrid =  spfli-carrid
        AND   connid = spfli-connid.
      IF sy-subrc <> 0.
        CLEAR spfli.
        MESSAGE 'Keine Flugverbindung gefunden!' TYPE 'I' DISPLAY LIKE 'E'.

      ENDIF.
    WHEN 'BACK'.
      LEAVE PROGRAM.
  ENDCASE.

ENDMODULE.
