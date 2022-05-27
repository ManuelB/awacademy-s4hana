*&---------------------------------------------------------------------*
*& Report ZS04_WAEHRUNGSUMRECHNER_TAB (A9)
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs04_a09_waehrungsumrechn_tab.

DATA: a   TYPE p VALUE 0,
      b   TYPE p VALUE 0,
      res TYPE p LENGTH 3 DECIMALS 2.


SELECTION-SCREEN BEGIN OF BLOCK a WITH FRAME TITLE TEXT-100.

SELECTION-SCREEN COMMENT 1(79) TEXT-101.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME.
  PARAMETERS curr TYPE c LENGTH 3 DEFAULT 'CHF'.
SELECTION-SCREEN END OF BLOCK a1.

SELECTION-SCREEN END OF BLOCK a.




WRITE:(6) curr CENTERED COLOR COL_KEY.
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
    CASE curr.
      WHEN 'AUD'. res = ( a + b ) * '0.75109'. WRITE: (6) res, '|'.
      WHEN 'CAD'. res = ( a + b ) * '1.43864'. WRITE: (6) res, '|'.
      WHEN 'CHF'. res = ( a + b ) * '1.48699'. WRITE: (6) res, '|'.
      WHEN 'GBP'. res = ( a + b ) * '0.62035'. WRITE: (6) res, '|'.
      WHEN 'JPY'. res = ( a + b ) * '1.10558'. WRITE: (6) res, '|'.

    ENDCASE.
    a = a + 1.
  ENDDO.
  a = 0.
  b = b + 10.
ENDDO.

ULINE.
