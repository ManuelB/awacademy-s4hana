*&---------------------------------------------------------------------*
*& Report ZS01_AUFGABE12
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZS01_AUFGABE12.




PARAMETERS: b TYPE i DEFAULT 4.
DATA: res TYPE i VALUE 5.

WRITE: b, res.

PERFORM rechne USING res CHANGING b.

WRITE: b, res.


FORM rechne USING b CHANGING C.
DATA: res TYPE i VALUE 6. C = res.
WRITE: b, res. ENDFORM.
