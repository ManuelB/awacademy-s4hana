*&---------------------------------------------------------------------*
*& Report Z_S03_SPERRLOGIK
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S03_SPERRLOGIK.

CALL FUNCTION 'ENQUEUE_EZS03_SP_FLIGHT'
    EXPORTING
      MODE_ZS03_FLIGHT       = 'E'
      MANDT                  = SY-MANDT
*      CONNID                 =
*      X_CONNID               = ' '
*      _SCOPE                 = '2'
*      _WAIT                  = ' '
*      _COLLECT               = ' '
    EXCEPTIONS
      FOREIGN_LOCK           = 1
      SYSTEM_FAILURE         = 2
      OTHERS                 = 3
             .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.

****************************************************************

CALL FUNCTION 'DEQUEUE_EZS03_SP_FLIGHT'
* EXPORTING
*   MODE_ZS03_FLIGHT       = 'E'
*   MANDT                  = SY-MANDT
*   CONNID                 =
*   X_CONNID               = ' '
*   _SCOPE                 = '3'
*   _SYNCHRON              = ' '
*   _COLLECT               = ' '
          .
