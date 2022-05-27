*&---------------------------------------------------------------------*
*& Report ZS04_TASCHENRECHNER_TAB (A7)
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs04_a07_taschenrechner_tab.

DATA: a   TYPE p VALUE 0,
      b   TYPE p VALUE 0,
      res TYPE p LENGTH 3 DECIMALS 2.

PARAMETERS operator TYPE c DEFAULT '+'.

WRITE:(6) operator CENTERED COLOR COL_KEY.
WRITE '|'.

DO 11 TIMES.
  a = sy-index - 1.
  WRITE: (6) a COLOR COL_KEY, '|'.
ENDDO.

DO 11 TIMES.
  ULINE.
  a = 0.
  WRITE: (6) b COLOR COL_KEY, '|'.
  DO 11 TIMES.
    CASE operator.
      WHEN '+'. res = a + b. WRITE: (6) res, '|'.
      WHEN '-'. res = a - b. WRITE: (6) res, '|'.
      WHEN '*'. res = a * b. WRITE: (6) res, '|'.
      WHEN '/'.
        IF a = 0.
          WRITE: (6) 'X' CENTERED, '|'.
        ELSEIF b = 0.
          WRITE: (6) 'X' CENTERED, '|'.
        ELSE.
          res = a / b. WRITE: (6) res, '|'.
        ENDIF.
    ENDCASE.
    a = a + 1.
  ENDDO.
  a = 0.
  b = b + 1.
ENDDO.

ULINE.

IF operator = '/'.
  WRITE: / 'X = Division durch "0" nicht möglich!' COLOR COL_NEGATIVE.
ENDIF.
