*&---------------------------------------------------------------------*
*& Include          Z_S11_INCLUDE_FUGR
*&---------------------------------------------------------------------*

PARAMETERS:
p_curr type sflight-currency VALUE CHECK,
p_oper type foperator value check,
  a1  TYPE zrk02_ty_betrag DEFAULT 3,
  op1 TYPE zrk02_ty_operator DEFAULT '+',
  b1  TYPE zrk02_ty_betrag DEFAULT 4,
  a2  TYPE zrk02_ty_betrag DEFAULT 5,
  op2 TYPE  zrk02_ty_operator DEFAULT '*',
  b2  TYPE zrk02_ty_betrag DEFAULT 7.
*
DATA:
  res TYPE zrk02_ty_betrag.
