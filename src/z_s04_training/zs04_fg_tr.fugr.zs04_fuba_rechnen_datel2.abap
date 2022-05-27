FUNCTION zs04_fuba_rechnen_datel2 .
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(IM_Z1) TYPE  ZDB04_TY_BETRAG OPTIONAL
*"     REFERENCE(IM_OP) TYPE  FOPERATOR
*"     REFERENCE(IM_Z2) TYPE  ZDB04_TY_BETRAG
*"  EXPORTING
*"     REFERENCE(EX_RESULT) TYPE  ZDB04_TY_BETRAG
*"  EXCEPTIONS
*"      ZERO_DIVIDE
*"      WRONG_OPERATOR
*"----------------------------------------------------------------------

  CASE im_op.
    WHEN '+'. ex_result = im_z1 + im_z2.
    WHEN '-'. ex_result = im_z1 - im_z2.
    WHEN '*'. ex_result = im_z1 * im_z2.
    WHEN '/'.
      IF im_z2 <> 0.
        ex_result = im_z1 / im_z2.
      ELSE.
        RAISE zero_divide.
        WRITE: / 'Divison durch "0" nicht möglich!' COLOR COL_NEGATIVE.
      ENDIF.

    WHEN OTHERS.
      RAISE wrong_operator.
      WRITE: / 'Ungültiger Operator!' COLOR COL_GROUP.
  ENDCASE.

ENDFUNCTION.
