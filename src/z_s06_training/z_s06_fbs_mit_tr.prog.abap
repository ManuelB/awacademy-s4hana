REPORT z_s06_fbs_mit_tr.
*FUNCTION z_s06_taschenrechner.
**"----------------------------------------------------------------------
**"*"Lokale Schnittstelle:
**"  IMPORTING
**"     REFERENCE(E1) TYPE  ZRK02_TY_BETRAG DEFAULT 0
**"     REFERENCE(EOP) TYPE  ZRK02_TY_OPERATOR
**"     REFERENCE(E2) TYPE  ZRK02_TY_BETRAG DEFAULT 0
**"  EXPORTING
**"     REFERENCE(IRES) TYPE  ZRK02_TY_BETRAG
**"  EXCEPTIONS
**"      DEVIDE_BY_ZERO_NOT_ALLOWED
**"      WRONG_OPERATOR
**"----------------------------------------------------------------------
*  CASE eop.
*    WHEN '+'. ires = e1 + e2.
*    WHEN '-'. ires = e1 - e2.
*    WHEN '*'. ires = e1 * e2.
*    WHEN '/'. ires = e1 / e2.
*  ENDCASE.
*
*ENDFUNCTION.

PARAMETERS:
  p_ein1 TYPE zrk02_ty_betrag DEFAULT 0,
  p_op   TYPE zrk02_ty_operator DEFAULT '+',
  p_ein2 TYPE zrk02_ty_betrag DEFAULT 0.

DATA:
result TYPE zrk02_ty_betrag.

CALL FUNCTION 'Z_S06_TASCHENRECHNER'
  EXPORTING
    e1             = p_ein1
    eop            = p_op
    e2             = p_ein2
  IMPORTING
    ires = result
  EXCEPTIONS
    zero_devide    = 1
    wrong_operator = 2
    OTHERS         = 3.

IF sy-subrc <> 0.
  CASE sy-subrc.
    WHEN 0. PERFORM rechnen USING p_ein1 p_op p_ein2 CHANGING result.
    WHEN 1. WRITE: / 'Cannot devide by 0'.
    WHEN 2. WRITE: / 'Wrong operator'.
    WHEN OTHERS. WRITE: / 'Unbekante Fehler!'.
  ENDCASE.
ENDIF.

WRITE: / p_ein1, / p_op, / p_ein2, / '=' ,result.

FORM rechnen
  USING p_ein1 p_op p_ein2 CHANGING result.
ENDFORM.
