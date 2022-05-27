*&---------------------------------------------------------------------*
*& Report ZS04_TASCHENRECHNER_2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs04_tr_form_fuba_dict.



PARAMETERS:
  z1 TYPE zdb04_ty_betrag DEFAULT '3.14',
  op TYPE foperator DEFAULT '+',
  z2 TYPE zdb04_ty_betrag   DEFAULT '8.335'.

DATA: result TYPE zdb04_ty_betrag.




CALL FUNCTION 'ZS04_FUBA_RECHNEN_DATEL2'
  EXPORTING
    im_z1           = z1
    im_op           = op
    im_z2           = z2
  IMPORTING
    ex_result          = result
  EXCEPTIONS
    zero_divide    = 1
    wrong_operator = 2
    OTHERS         = 3.




IF sy-subrc <> 0.
    CASE sy-subrc.
    WHEN 1. WRITE: '(Division durch "0" nicht möglich!)' COLOR COL_NEGATIVE.
    WHEN 2. WRITE: '(Ungültiger Operator!)' COLOR COL_NEGATIVE.
    WHEN OTHERS. "Coming soon.
  ENDCASE.
ELSE.

  WRITE: /3 z1,
  / op, z2,
  /3(15) sy-uline,
  / '=', result.
ENDIF.
