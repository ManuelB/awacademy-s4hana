*&---------------------------------------------------------------------*
*& Report Z_AW07_SPEERLOGIK
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_AW07_SPEERLOGIK.

CALL FUNCTION 'ENQUEUE_EZS07_SP_FLIGHT'
* EXPORTING
*   MODE_ZS07_FLIGHT       = 'E'
*   MANDANT                = SY-MANDT
*   CONNIN                 =
*   X_CONNIN               = ' '
*   _SCOPE                 = '2'
*   _WAIT                  = ' '
*   _COLLECT               = ' '
* EXCEPTIONS
*   FOREIGN_LOCK           = 1
*   SYSTEM_FAILURE         = 2
*   OTHERS                 = 3
          .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.
