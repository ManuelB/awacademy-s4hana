*&---------------------------------------------------------------------*
*& Report Z_S01_SPERRLOGIK
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s01_sperrlogik.

*Verstanden.

CALL FUNCTION 'ENQUEUE_EZ_S01_SP_FLIGHT'
* EXPORTING
*   MODE_ZS01_FLIGHT       = 'E'
*   MANDANT                = SY-MANDT
*   CONNID                 =
*   X_CONNID               = ' '
*   _SCOPE                 = '2'
*   _WAIT                  = ' '
*   _COLLECT               = ' '
  EXCEPTIONS
    foreign_lock   = 1
    system_failure = 2
    OTHERS         = 3.
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.


CALL FUNCTION 'DEQUEUE_EZ_S01_SP_FLIGHT'
  EXPORTING
    mode_zs01_flight = 'E'
    mandant          = sy-mandt
*   CONNID           =
*   X_CONNID         = ' '
*   _SCOPE           = '3'
*   _SYNCHRON        = ' '
*   _COLLECT         = ' '
  .

*Muss sagen, dass er Sperrlogik implementieren muss mit muster.
*Kommentare sind für returncode.
