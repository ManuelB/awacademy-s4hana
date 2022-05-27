*&---------------------------------------------------------------------*
REPORT Z_S11_MAKROS.
* Makro-Demo
DATA: result TYPE p LENGTH 5 DECIMALS 3,
      n1     TYPE i VALUE 5,
      n2     TYPE i VALUE 7.
* Deklaration
DEFINE operation.
  result = &1 &2 &3.
  output   &1 &2 &3 result.
END-OF-DEFINITION.
* Deklaration
DEFINE output.
  WRITE: / 'The result of &1 &2 &3 is', &4.
END-OF-DEFINITION.

* Aufruf
operation 4 + 3.
operation 2 ** 7.
operation n2 - n1.
operation 23 / 7.
*
define calculate.
 &4 = &1 &2 &3.
 "output2 &4.
 "write result to &4.
end-OF-DEFINITION.
DEFINE output2.
 WRITE: &4.
end-OF-DEFINITION.
*
DATA: res TYPE char20.
calculate 4 + 5 res.
WRITE: / res.
calculate 4 - 9 res.
WRITE: / res.
