*&---------------------------------------------------------------------*
*& Report Z_S12_SPERRLOGIK
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S12_SPERRLOGIK.

CALL FUNCTION 'ENQUEUE_EZS12_SP_FLIGHT'
 EXPORTING
   MODE_ZS12_FLIGHT       = 'E'
   MDT                    = SY-MANDT
*   CONNID                 =
*   X_CONNID               = ' '
*   _SCOPE                 = '2'
*   _WAIT                  = ' '
*   _COLLECT               = ' '
 EXCEPTIONS " Returncodes
   FOREIGN_LOCK           = 1
   SYSTEM_FAILURE         = 2
   OTHERS                 = 3
          .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.

CALL FUNCTION 'DEQUEUE_EZS12_SP_FLIGHT'
 EXPORTING
   MODE_ZS12_FLIGHT       = 'E'
   MDT                    = SY-MANDT
*   CONNID                 =
*   X_CONNID               = ' '
*   _SCOPE                 = '3'
*   _SYNCHRON              = ' '
*   _COLLECT               = ' '
          .
"Returncodes: 0 = hat geklappt, 1 = ist bereits gesperrt
