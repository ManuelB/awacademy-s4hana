*&---------------------------------------------------------------------*
*& Report Z_S05_GRAPHS_PROBE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_GRAPHS_PROBE.

*DATA : Y_VALUES TYPE TABLE OF GPRVAL WITH HEADER LINE ,
*X_TEXTS TYPE TABLE OF GPRTXT WITH HEADER LINE .
*data Ok_code like sy-ucomm.
*REFRESH Y_VALUES.
*REFRESH X_TEXTS.
*Y_VALUES-ROWTXT = 'Revenue - Dept1' .
*Y_VALUES-VAL1 = 5000 .
*Y_VALUES-VAL2 = 8000 .
*Y_VALUES-VAL3 = 3000 .
*Y_VALUES-VAL4 = 10000 .
*APPEND Y_VALUES.
*Y_VALUES-ROWTXT = 'Revenue - Dept2' .
*Y_VALUES-VAL1 = 6000 .
*Y_VALUES-VAL2 = 7000 .
*Y_VALUES-VAL3 = 6000 .
*Y_VALUES-VAL4 = 5000 .
*APPEND Y_VALUES.
*X_TEXTS-COLTXT = '2009' .
*APPEND X_TEXTS.
*X_TEXTS-COLTXT = '2010' .
*APPEND X_TEXTS.
*X_TEXTS-COLTXT = '2011' .
*APPEND X_TEXTS.
*X_TEXTS-COLTXT = '2012' .
*APPEND X_TEXTS.
*
*
*call screen 510 .
**&---------------------------------------------------------------------*
**& Module STATUS_0100 OUTPUT
**&---------------------------------------------------------------------
*MODULE STATUS_0100 OUTPUT .
*SET PF-STATUS 'PF_100' .
*SET TITLEBAR 'GRAPHICS' .
**
*CALL FUNCTION 'GFW_PRES_SHOW'
*EXPORTING
*CONTAINER = 'CONTAINER' "A screen with an empty container must be
*PRESENTATION_TYPE = gfw_prestype_vertical_bars
** PRESENTATION_TYPE = gfw_prestype_time_axis
** PRESENTATION_TYPE = gfw_prestype_area
** PRESENTATION_TYPE = gfw_prestype_horizontal_bars
*TABLES
*VALUES = Y_VALUES
*COLUMN_TEXTS = X_TEXTS
*EXCEPTIONS
*ERROR_OCCURRED = 1
*OTHERS = 2 .
*ENDMODULE . " STATUS_0100 OUTPUT
**&---------------------------------------------------------------------*
**& Module USER_COMMAND_0100 INPUT
**&---------------------------------------------------------------------
*MODULE USER_COMMAND_0510 INPUT .
*case ok_code.
*when 'BACK' .
*leave PROGRAM .
*endcase .
*ENDMODULE.
**&---------------------------------------------------------------------*
**& Module STATUS_0510 OUTPUT
**&---------------------------------------------------------------------*
**&
**&---------------------------------------------------------------------*
*MODULE status_0510 OUTPUT.
** SET PF-STATUS 'xxxxxxxx'.
** SET TITLEBAR 'xxx'.
*ENDMODULE.
