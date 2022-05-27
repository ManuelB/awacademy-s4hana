*&---------------------------------------------------------------------*
*& Report Z_S11_ARITHMETIK
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S11_ARITHMETIK.
**Data syindex type i.
*write sy-index.
*DO 3 TIMES.
*  WRITE / sy-index.
*  DO 3 TIMES.
*    IF sy-index = 1.
*      WRITE sy-index.
*      EXIT.
*    ENDIF.
*  ENDDO.
*  IF sy-index MOD 2 = 0.
*    CONTINUE.
*  ENDIF.
*  WRITE sy-index.
*ENDDO.

*SELECT SINGLE carrid, connid, airpfrom, cityfrom, cityto INTO @DATA(ls_flights)
*  FROM ZS11_spfli
*  WHERE carrid = 'AZ'
*  AND airpfrom = 'FCO'.
*
*IF sy-subrc = 0.
*  cl_demo_output=>display( ls_flights ).
*ELSE.
*  WRITE 'No record found'.
*ENDIF.


*TYPES:
*BEGIN OF lty_rech,
*  op1 TYPE p length 3 decimals 2 DEFAULT 0,
*  operator type ZS05_OPERATOR2,
*  op2 TYPE p length 3 decimals 2 DEAFULAT 0,
*  result TYPE p length 5 decimals 2,
*  END OF lty_rech.
*
*  DATA ls_rech TYPE lty_rech.
*   DATA lt_rech TYPE TABLE OF lty_rech.
*
*ls_rech-op1 = 0.
*
* DO 10 TIMES.
*
*  ADD 1 TO ls_rech-op1.
*  if ls_rech-op1 GT 10.
*    EXIT.
*    ENDIF.
*
*
*  ENDDO.
