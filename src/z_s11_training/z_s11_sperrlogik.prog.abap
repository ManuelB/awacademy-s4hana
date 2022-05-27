*&---------------------------------------------------------------------*
*& Report Z_S11_SPERRLOGIK
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S11_SPERRLOGIK.

CALL FUNCTION 'ENQUEUE_EZS11_SP_FLIGHT'
 EXPORTING
   MODE_ZS11_FLIGHT       = 'E'
   MANDANT                = SY-MANDT
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



* ***********************************
* Bearbeitung unserer Datenbankinhalte**********************
*************************************



CALL FUNCTION 'DEQUEUE_EZS11_SP_FLIGHT'
* EXPORTING
*   MODE_ZS11_FLIGHT       = 'E'
*   MANDANT                = SY-MANDT
*   CONNID                 =
*   X_CONNID               = ' '
*   _SCOPE                 = '3'
*   _SYNCHRON              = ' '
*   _COLLECT               = ' '
          .
