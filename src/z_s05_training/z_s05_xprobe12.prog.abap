*&---------------------------------------------------------------------*
*& Report Z_S05_XPROBE12
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
Report Z_S05_XPROBE12.
*
select max( fldname ) into ws_next from tablename .......

ws_next = ws_next + 1

*SELECTION-SCREEN:
*  BEGIN OF SCREEN 500,
**     AS WINDOW TITLE title,
*    PUSHBUTTON 2(10)  but1 USER-COMMAND cli1,
*    PUSHBUTTON 12(30) but2 USER-COMMAND cli2
*                           VISIBLE LENGTH 10,
*      END OF SCREEN 500.
*
*      AT SELECTION-SCREEN.
**  CASE sscrfields.
**    WHEN 'CLI1'.
**      ...
**    WHEN 'CLI2'.
**      ...
**  ENDCASE.
*
*START-OF-SELECTION.
**  title  = 'Push button'.
**  but1 = 'Button 1'.
*
*  CALL FUNCTION 'ICON_CREATE'
*    EXPORTING
*      name   = icon_information
*      text   = 'Button 2'
*      info   = 'My quick info'
*    IMPORTING
*      RESULT = but2
*    EXCEPTIONS
*      OTHERS = 0.
*
*  CALL SELECTION-SCREEN '0500' STARTING AT 10 10.
