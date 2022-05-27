*&---------------------------------------------------------------------*
*& Report Z_S05_XPROBE13
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_XPROBE13.

TABLES sscrfields.

selection-screen begin of screen 1100.
  SELECTION-SCREEN BEGIN OF LINE.
  parameters: p_par type i.

SELECTION-SCREEN PUSHBUTTON 30(7) text-001 USER-COMMAND PB2.
SELECTION-SCREEN END OF LINE.
selection-screen end of screen 1100.

selection-screen begin of screen 1200.
SELECTION-SCREEN BEGIN OF LINE.
PARAMETERS: p_tmp type c LENGTH 20.
SELECTION-SCREEN PUSHBUTTON 30(7) text-001 USER-COMMAND PB1.
SELECTION-SCREEN END OF LINE.
selection-screen end of screen 1200.

AT SELECTION-SCREEN.


 CASE sscrfields.
    WHEN 'PB1'.
      MESSAGE 'Button 1 was clicked' TYPE 'I'.
CALL SELECTION-SCREEN 1100.


          WHEN 'PB2'.
      MESSAGE 'Go Back' TYPE 'I'.
CALL SELECTION-SCREEN 1200.
      endcase.
