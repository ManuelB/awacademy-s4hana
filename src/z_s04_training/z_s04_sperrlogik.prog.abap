*&---------------------------------------------------------------------*
*& Report Z_S04_SPERRLOGIK
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s04_sperrlogik.

CALL FUNCTION 'ENQUEUE_EZS04_SP_FLIGHT'
 EXPORTING
   MODE_ZS04_FLIGHT       = 'E'
   S_MANDT                = SY-MANDT
*   CONNID                 =
*   X_CONNID               = ' '
*   _SCOPE                 = '2'
*   _WAIT                  = ' '
*   _COLLECT               = ' '
 EXCEPTIONS
   FOREIGN_LOCK           = 1
   SYSTEM_FAILURE         = 2
   OTHERS                 = 3
          .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.


**********************************************************************
*Bearbeitung unserer Datenbankinhalte.

CALL FUNCTION 'DEQUEUE_EZS04_SP_FLIGHT'
 EXPORTING
   MODE_ZS04_FLIGHT       = 'E'
   S_MANDT                = SY-MANDT
*   CONNID                 =
*   X_CONNID               = ' '
*   _SCOPE                 = '3'
*   _SYNCHRON              = ' '
*   _COLLECT               = ' '
          .
