*&---------------------------------------------------------------------*
*& Report Z_AW07_UEBUNGEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_aw07_uebungen_3.



PARAMETERS p_a TYPE CACSMAPFACTOR DEFAULT 2.
PARAMETERS p_op  TYPE c DEFAULT '/'.
PARAMETERS p_b TYPE i DEFAULT 17.

DATA lv_erg TYPE cacsmapfactor.

CALL FUNCTION 'Z_S07_UEBUNG_R_E'
  EXPORTING
    i_a                     = p_a
    i_op                    = p_op
    i_b                     = P_b
  IMPORTING
    lv_erg                  = lv_erg
  EXCEPTIONS
    falscher_operator       = 1
    division_nicht_moeglich = 2
    OTHERS                  = 3.

CASE sy-subrc.
  WHEN 0.
    CALL FUNCTION 'Z_S07_UEBUNG_R_A'
      EXPORTING
        erg = lv_erg
      IMPORTING
        a   = p_a
        op  = p_op
        b   = P_b.
  WHEN 1.
    WRITE: / 'Null-Division'(001) COLOR COL_NEGATIVE.
  WHEN 2.
    WRITE: / TEXT-002 COLOR COL_GROUP.
  WHEN 3.
    WRITE: / 'ein anderer Fehler'.
  WHEN OTHERS.
*    WRITE: / 'neuer Fehler'.
ENDCASE.
