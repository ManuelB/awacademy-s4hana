FUNCTION ZS12_TEST.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(IM_Z1) TYPE  ZS12_ZAHL DEFAULT 5.67
*"     REFERENCE(IM_OP) TYPE  FOPERATOR
*"     REFERENCE(IM_Z2) TYPE  ZS12_ZAHL
*"  EXPORTING
*"     REFERENCE(EX_RESULT) TYPE  ZS12_ZAHL
*"  EXCEPTIONS
*"      WRONG_OPERATOR
*"      ZERO_DIVIDE
*"----------------------------------------------------------------------
  CASE im_op.
    WHEN '+'.
      ex_result = im_z1 + im_z2.
    WHEN '-'.
      ex_result = im_z1 - im_z2.
    WHEN '*'.
      ex_result = im_z1 * im_z2.
    WHEN '/'.
      IF im_z2 NE 0.
        ex_result = im_z1 / im_z2.
      ELSE.
*           write :/ 'division durch 0' color col_negative.
        RAISE zero_divide.
      ENDIF.


    WHEN OTHERS.
      RAISE wrong_operator.
      WRITE :/ 'Falscher operator' COLOR COL_GROUP.

  ENDCASE.




ENDFUNCTION.
