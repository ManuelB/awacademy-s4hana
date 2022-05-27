*&---------------------------------------------------------------------*
*& Report Z_S05_XPROBE14
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_XPROBE14.

TABLES sscrfields.




*SELECTION-SCREEN BEGIN OF LINE.
*SELECTION-SCREEN BEGIN OF screen 2000 AS WINDOW TITLE title.
*PARAMETERS: p_tmp type c LENGTH 20.
*SELECTION-SCREEN PUSHBUTTON 30(7) text-001 USER-COMMAND PB1.
*SELECTION-SCREEN END OF screen 2000.


SELECTION-SCREEN:
  BEGIN OF SCREEN 2000 AS WINDOW TITLE title,
    PUSHBUTTON 2(10)  PB1 USER-COMMAND PB1,
*    PUSHBUTTON 12(30) but2 USER-COMMAND cli2
*                           VISIBLE LENGTH 10,
  END OF SCREEN 2000.

selection-screen begin of screen 1200.
*  SELECTION-SCREEN BEGIN OF LINE.
  parameters: p_par type i.
*
*SELECTION-SCREEN PUSHBUTTON 30(7) text-001 USER-COMMAND PB2.
*SELECTION-SCREEN END OF LINE.
selection-screen end of screen 1200.

AT SELECTION-SCREEN.


 CASE sscrfields.
    WHEN 'PB1'.
      MESSAGE 'Button 1 was clicked' TYPE 'I'.
CALL SELECTION-SCREEN 1200.


*          WHEN 'PB2'.
*      MESSAGE 'Go Back' TYPE 'I'.
*CALL SELECTION-SCREEN 1200.
      endcase.

      START-OF-SELECTION.
  title  = 'Push button'.
  pb1 = 'Button 1'.

   CALL SELECTION-SCREEN '2000'.
