*&---------------------------------------------------------------------*
*& Report ZS03_FRAGE12_ASSESSMENT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZS03_FRAGE12_ASSESSMENT.

PARAMETERS: b TYPE i DEFAULT 3.
DATA: res TYPE i VALUE 5.
WRITE: b, res.
PERFORM rechne USING res CHANGING b.
WRITE: b, res.
FORM rechne USING b CHANGING c.
  DATA: res TYPE i VALUE 6.
  c = res.
  WRITE: b, res.
  ENDFORM.
