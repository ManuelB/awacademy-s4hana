*&---------------------------------------------------------------------*
*& Report Z_SO6_TASCHENRECHNER_FUBA_DICT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_so6_taschenrechner_fuba_dict.

PARAMETERS:
  a1      TYPE zrk02_ty_betrag DEFAULT 0,
  op1     TYPE zrk02_ty_operator DEFAULT '+',
  b1      TYPE zrk02_ty_betrag DEFAULT 0,
  ausgabe TYPE zrk02_ty_betrag.
DATA:
  res TYPE zrk02_ty_betrag.

CALL FUNCTION 'Z_S06_FUBA_RECHNEN'
  EXPORTING
    i_a               = a1
    i_op              = op1
    i_b               = b1
  IMPORTING
    e_res             = res
  EXCEPTIONS
    zero_divide       = 1
    wrong_operator    = 2
    negative_argument = 17
    OTHERS            = 3.

CALL FUNCTION 'Z_S06_TASCHENRECHNER'
  EXPORTING
    i_a                              =
    i_op                             =
    i_b                              =

IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.

.

*CASE sy-subrc.
*  "WHEN 0. PERFORM ausgabe USING a1 op1 b1 res.
*  WHEN 1. WRITE: / 'Null-Division'(001) COLOR COL_NEGATIVE.
*  WHEN 2. WRITE: / 'Icorrect OperatorTEXT-002 COLOR COL_GROUP'.
*
*  WHEN 3. WRITE: / 'Unknown Error'.
*  WHEN OTHERS.
*
*ENDCASE.

z_s06_fuba_rechnen
