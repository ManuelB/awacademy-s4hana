*&---------------------------------------------------------------------*
*& Report Z_S12_RECHNER
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s12_rechner_fuba_dict3.

*************************************************************************************************************************************************
*Rechner mit 2 Rechenoperationen
*************************************************************************************************************************************************
INCLUDE ZS12_Rechner_include.
*PARAMETERS:
*  a1  TYPE ZS12_ZAHL DEFAULT 3,
*  op1 TYPE ZS12_operator DEFAULT '+',
*  b1  TYPE ZS12_ZAHL DEFAULT 4,
*  a2  TYPE ZS12_ZAHL DEFAULT 5,
*  op2 TYPE ZS12_operator DEFAULT '*',
*  b2  TYPE ZS12_ZAHL DEFAULT 7.
**
*DATA:
*      res TYPE ZS12_ZAHL.
*1. Berechnung
CALL FUNCTION 'ZS12_RECHNEN_DATEL'
  EXPORTING
    i_a            = a1
    i_op           = op1
    i_b            = b1
  IMPORTING
    e_res          = res
  EXCEPTIONS
    zero_division  = 1
    wrong_operator = 2
    negative_root  = 3
    OTHERS         = 4.

CASE sy-subrc.
  WHEN 0.
    CALL FUNCTION 'ZS12_AUSGABE'
      EXPORTING
        i_a   = a1
        i_op  = op1
        i_b   = b1
      IMPORTING
        i_RES = res.
  WHEN 1.
    WRITE: / 'Division durch Null ist nicht erlaubt!'(001) COLOR COL_NEGATIVE.
  WHEN 2.
    WRITE:/ TEXT-002, 'Ein falscher Operator wurde verwendet!'  COLOR COL_NEGATIVE.
  WHEN 3.
    WRITE: / 'Radizieren einer negativen Zahl nicht erlaubt!'  COLOR COL_NEGATIVE.
  WHEN 4.
    WRITE: / 'Ein anderer Fehler ist aufgetreten!' COLOR COL_NEGATIVE.
  WHEN OTHERS.
ENDCASE.




*PERFORM rechnen USING a1 op1 b1 CHANGING res. "Verwendung von Aktualparametern
*PERFORM ausgabe USING a1 op1 b1 CHANGING res.
*2. Berechung
CALL FUNCTION 'ZS12_RECHNEN_DATEL'
  EXPORTING
    i_a            = a2
    i_op           = op2
    i_b            = b2
  IMPORTING
    i_res          = res
  EXCEPTIONS
    zero_division  = 1
    wrong_operator = 2
    negative_root  = 3
    OTHERS         = 4.

CASE sy-subrc.
  WHEN 0.
    CALL FUNCTION 'ZS12_AUSGABE'
      EXPORTING
        i_a   = a2
        i_op  = op2
        i_b   = b2
      IMPORTING
        e_res = res.
  WHEN 1.
    WRITE: / 'Division durch Null ist nicht erlaubt!' COLOR COL_NEGATIVE.
  WHEN 2.
    WRITE:/ 'Ein falscher operator wurde verwendet!'  COLOR COL_NEGATIVE.
  WHEN 3.
    WRITE: / 'Radizieren einer negativen Zahl nicht erlaubt!'  COLOR COL_NEGATIVE.
  WHEN 4.
    WRITE: / 'Ein anderer Fehler ist aufgetreten!' COLOR COL_NEGATIVE.
  WHEN OTHERS.
    WRITE: / 'Ein noch unbekannter Fehler ist aufgetreten - wir arbeiten daran!' COLOR COL_NEGATIVE.
ENDCASE.
