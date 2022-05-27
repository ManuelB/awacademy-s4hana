*&---------------------------------------------------------------------*
*& Report ZA_S05_DEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT za_s05_demo2233_fuba.

INCLUDE z_s05_include.


CALL FUNCTION 'ZS05_RECHNEN2'
  EXPORTING
    i_a            = a1
    i_op           = op1
    i_b            = b1
  IMPORTING
    e_res          = res
  EXCEPTIONS
    zero_divide    = 1
    wrong_operator = 2
    n_argu         = 3
    OTHERS         = 4.
"  IF sy-subrc <> 0.
CASE sy-subrc.
  WHEN 0.
    CALL FUNCTION 'ZS05_AUSGABE'
      IMPORTING
        a   = a1
        op  = op1
        b   = b1
        res = res.
  WHEN 1. WRITE: / 'DIVISION DURCH 0'(001) COLOR COL_NEGATIVE.
  WHEN 2. WRITE: / TEXT-002 COLOR COL_GROUP.
  WHEN 4. WRITE: / 'negatives argument' COLOR COL_GROUP.
  WHEN 3. WRITE: / 'UNBEKANNTE FEHLER' COLOR COL_NEGATIVE.
  WHEN OTHERS.

    WRITE: / 'neue Fehler' COLOR COL_GROUP.

ENDCASE.




CALL FUNCTION 'ZS05_RECHNEN2'
  EXPORTING
    i_a            = a2
    i_op           = op2
    i_b            = b2
  IMPORTING
    e_res          = res
  EXCEPTIONS
    zero_divide    = 1
    wrong_operator = 2
    n_argu         = 3
    OTHERS         = 4.
"IF sy-subrc <> 0.
CASE sy-subrc.
  WHEN 0.
    CALL FUNCTION 'ZS05_AUSGABE'
      IMPORTING
        a   = a2
        op  = op2
        b   = b2
        res = res.

  WHEN 1. WRITE: / 'DIVISION DURCH 0'(001) COLOR COL_NEGATIVE.
  WHEN 2. WRITE: / TEXT-002 COLOR COL_GROUP.
  WHEN 3. WRITE: / 'negatives argument' COLOR COL_GROUP.
  WHEN 4. WRITE: / 'UNBEKANNTE FEHLER' COLOR COL_NEGATIVE.
  WHEN OTHERS.
    WRITE: / 'neue Fehler' COLOR COL_GROUP.
ENDCASE.
