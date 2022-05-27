*&---------------------------------------------------------------------*
*& Report Z_S02_A7
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S02_A7_FB.



DATA:
      a type p value 0,
      b type p value 0,
      res type p LENGTH 4 DECIMALS 2.

PARAMETERS: operator type c LENGTH 1 DEFAULT '/'.





***** Kopfzeile in der Ausgabe
WRITE:(6) operator CENTERED COLOR COL_KEY.
WRITE '|'.

DO 11 TIMES.
  a = sy-index - 1.
  WRITE: (6) a COLOR COL_KEY, '|'.
ENDDO.




WHILE b <= 10.

  ULINE.
  a = 0.
  WRITE: (6) b COLOR COL_KEY, '|'.   " Spaltenbeschriftung

  DO 11 TIMES.
    CASE operator.
      WHEN '+'. res = a + b.  WRITE: (6) res, '|'.
      WHEN '-'. res = a - b.  WRITE: (6) res, '|'.
      WHEN '*'. res = a * b.  WRITE: (6) res, '|'.
      WHEN '/'.
        IF a = 0.
          WRITE: (6) 'N.A.' CENTERED, '|'.
          ELSEIF b = 0.
          WRITE: (6) 'N.A.' CENTERED, '|'.
          ELSE.
          res = a / b.  WRITE: (6) res, '|'.
        ENDIF.
   ENDCASE.
   a = a + 1.
  ENDDO.
a = 0.
b = b + 1.
ENDWHILE.


ULINE.

IF operator = '/'.
  WRITE: / 'X = Division durch "0". In diesem Universum leider nicht möglich!' COLOR COL_NEGATIVE.
ENDIF.

*BREAK-POINT.


*BREAK-POINT.
