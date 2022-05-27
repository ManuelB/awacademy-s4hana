*&---------------------------------------------------------------------*
*& Report ZA_S05_DEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZA_S05_DEMO_FUBA.

"PARAMETERS:
"persnr TYPE n LENGTH 4 DEFAULT 123,
"id TYPE C LENGTH 4 DEFAULT '1A2B3C'."

"WRITE: / persnr, id.
"persnr = id.
"WRITE: / persnr.



PARAMETERS:
a1 TYPE i DEFAULT 3,
op1 TYPE c LENGTH 1 DEFAULT '+',
B1 TYPE I DEFAULT 4,
a2 TYPE i DEFAULT 5,
op2 TYPE c LENGTH 1 DEFAULT '*',
B2 TYPE I DEFAULT 7.

DATA:
      RES TYPE i.

CALL FUNCTION 'ZS05_RECHNEN'
  EXPORTING
    i_a           = a1
    i_op          = op1
    i_b           = b1
 IMPORTING
  E_RES         = res
   EXCEPTIONS
     ZERO_DIVIDE          = 1
    WRONG_OPERATOR       = 2
    N_ARGU = 3
 OTHERS               = 4.
"  IF sy-subrc <> 0.
case sy-subrc.
   WHEN 0. PERFORM AUSGABE USING A1 OP1 B1 RES.
  WHEN 1. WRITE: / 'DIVISION DURCH 0'(001) COLOR COL_NEGATIVE.
  WHEN 2. WRITE: / text-002 COLOR COL_GROUP.
WHEN 4. WRITE: / 'negatives argument' COLOR COL_GROUP.
  WHEN 3. WRITE: / 'UNBEKANNTE FEHLER' COLOR COL_NEGATIVE.
  WHEN OTHERS.

   WRITE: / 'neue Fehler' COLOR COL_GROUP.

    ENDCASE.


  "ENDIF.
"PERFORM RECHNEN USING A2 OP2 B2 CHANGING RES.


          .

"PERFORM RECHNEN USING A1 OP1 B1 CHANGING RES.
"PERFORM AUSGABE USING A1 OP1 B1 RES.


CALL FUNCTION 'ZS05_RECHNEN'
  EXPORTING
    i_a           = a2
    i_op          = op2
    i_b           = b2
 IMPORTING
  E_RES         = res
     EXCEPTIONS
     ZERO_DIVIDE          = 1
    WRONG_OPERATOR       = 2
    N_ARGU = 3
 OTHERS               = 4.          .
  "IF sy-subrc <> 0.
case sy-subrc.
    WHEN 0. PERFORM AUSGABE USING A2 OP2 B2 RES.
   WHEN 1. WRITE: / 'DIVISION DURCH 0'(001) COLOR COL_NEGATIVE.
  WHEN 2. WRITE: / text-002 COLOR COL_GROUP.
  WHEN 3. WRITE: / 'negatives argument' COLOR COL_GROUP.
  WHEN 4. WRITE: / 'UNBEKANNTE FEHLER' COLOR COL_NEGATIVE.
  WHEN OTHERS.
     WRITE: / 'neue Fehler' COLOR COL_GROUP.
    ENDCASE.


 " ENDIF.
"PERFORM RECHNEN USING A2 OP2 B2 CHANGING RES.



"ENDFORM.

  FORM AUSGABE USING A OP B RES.
  WRITE: /3 A,
        / OP, B.
  ULINE /3(12).
  WRITE: /3 RES.
endform.
