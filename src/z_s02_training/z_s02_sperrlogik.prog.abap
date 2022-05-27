*&---------------------------------------------------------------------*
*& Report Z_S02_SPERRLOGIK
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S02_SPERRLOGIK.
CALL FUNCTION 'ENQUEUE_EZAWS02_SPR'
 EXPORTING
   MODE_ZAWS02_VERTRIEB       = 'E'
   CLIENT                     = SY-MANDT
*   DOKNR                      =
*   X_DOKNR                    = ' '
*   _SCOPE                     = '2'
*   _WAIT                      = ' '
*   _COLLECT                   = ' '
 EXCEPTIONS
   FOREIGN_LOCK               = 1
   SYSTEM_FAILURE             = 2
   OTHERS                     = 3
          .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.

******
**Bearbeitung unserer Datenbankinhalte
******

*Entsperren

 CALL FUNCTION 'DEQUEUE_EZAWS02_SPR'
  EXPORTING
    MODE_ZAWS02_VERTRIEB       = 'E'
    CLIENT                     = SY-MANDT
*    DOKNR                      =
*    X_DOKNR                    = ' '
*    _SCOPE                     = '3'
*    _SYNCHRON                  = ' '
*    _COLLECT                   = ' '
           .
