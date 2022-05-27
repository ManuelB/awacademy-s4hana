*&---------------------------------------------------------------------*
*& Report Z_S05_XUEBUNG1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_XUEBUNG3.

*******************************************************
*Übung 1 Taschenrechner Basic*
PARAMETERS:

zahl1 TYPE Z05WW_PZAHL,
op TYPE Z05WW_oper ,
zahl2 TYPE Z05WW_PZAHL.

DATA: erg TYPE Z05WW_PZAHL.

*IF p_op CA '+-*/'.
*  "Programm geht weiter
*  ELSE.
*    MESSAGE: 'Das ist leider eine Falsche Eingabe, geben sie bitte einen valieden Rechenoperator an.' TYPE 'E' DISPLAY LIKE 'I'.
*    return.
*    ENDIF.


CALL FUNCTION 'ZS05_FB_TR1_2'
  EXPORTING
    p_zahl1              = zahl1
    p_op                 = op
    p_zahl2              = zahl2
 IMPORTING
   ERGEBNIS             = erg
 EXCEPTIONS
   ZERO_DIVIDE          = 1
   WRONG_OPERATOR       = 2
   OTHERS               = 3
          .

CASE sy-subrc.

  WHEN 0.
    CALL FUNCTION 'ZS05_FB_TR2'
      EXPORTING
        p_zahl1        = zahl1
        p_op           = op
        p_zahl2        = zahl2
        ergebnis       = erg
              .
    WHEN 1.
      WRITE: TEXT-001 COLOR COL_NEGATIVE.
      WHEN 2.
        WRITE: TEXT-002 COLOR COL_GROUP.
        WHEN 3.
          WRITE: TEXT-003 COLOR COL_GROUP.

ENDCASE.






*     FORM ausgabe USING z1 op1 z2 erg1.
*ULINE /.
*write: / | { z1 } { op1 } { z2 }  =  { erg1 } |.
*endform.
