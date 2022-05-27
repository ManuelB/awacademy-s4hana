FUNCTION ZS12_RECHNEN_DATEL.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(I_A) TYPE  ZS12_ZAHL
*"     REFERENCE(I_OP) TYPE  ZS12_OPERATOR
*"     REFERENCE(I_B) TYPE  ZS12_ZAHL
*"  EXPORTING
*"     REFERENCE(E_RES) TYPE  ZS12_ZAHL
*"  EXCEPTIONS
*"      ZERO_DIVISION
*"      WRONG_OPERATOR
*"      NEGATIVE_ROOT
*"      OTHERS
*"----------------------------------------------------------------------
  CASE i_op.
    WHEN '+'.
      e_res = i_a + i_b.
    WHEN '-'.
      e_res = i_a - i_b.
    WHEN '*'.
      e_res = i_a * i_b.
    WHEN '/'.
      IF i_b = 0.
        RAISE zero_division.
        WRITE: / 'Division durch Null!' COLOR COL_NEGATIVE. "Roter Hintergrund der Meldung.
      ELSE.
        e_res = i_a / i_b.
      ENDIF.
    WHEN 'R' OR 'r'.
      IF i_a < 0.
        RAISE negative_root.
        WRITE: / 'Radizieren einer negativen Zahl nicht erlaubt!' COLOR COL_NEGATIVE.
      ELSE.
        e_res = sqrt( i_a ).
      ENDIF.
    WHEN OTHERS.
      RAISE Wrong_Operator.
      RAISE others.
      WRITE: / 'Falscher Operator.' COLOR COL_GROUP. "Oranger Hintergrund der Meldung.
  ENDCASE.



ENDFUNCTION.
