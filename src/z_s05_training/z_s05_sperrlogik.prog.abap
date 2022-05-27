*&---------------------------------------------------------------------*
*& Report Z_S05_SPERRLOGIK
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_SPERRLOGIK.

    CALL FUNCTION 'ENQUEUE_EZS05_SP_FLIGHT'
    EXPORTING
       MODE_ZAWS05_FLIGHT       = 'E'
      MANDAT                   = SY-MANDT
*       CONNID                   =
*       X_CONNID                 = ' '
*       _SCOPE                   = '2'
*       _WAIT                    = ' '
*       _COLLECT                 = ' '
    EXCEPTIONS  " Funktionsbausteine als RETURN CODE---KOMMT IM IF
       FOREIGN_LOCK             = 1
       SYSTEM_FAILURE           = 2
       OTHERS                   = 3
                        .
  IF sy-subrc <> 0. "RETURN CODE VON EXCEPTIONS wenn 0 LOCK FUNKTIONIERT --ES IST GESPERT
*Implement suitable error handling here
  ENDIF.

****************************************




CALL FUNCTION 'DEQUEUE_EZS05_SP_FLIGHT'
 EXPORTING
   MODE_ZAWS05_FLIGHT       = 'E'
   MANDAT                   = SY-MANDT
*   CONNID                   =
*   X_CONNID                 = ' '
*   _SCOPE                   = '3'
*   _SYNCHRON                = ' '
*   _COLLECT                 = ' '
                  .
