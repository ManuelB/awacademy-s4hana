*&---------------------------------------------------------------------*
*& Include          ZS03_INCLUDE_DEMO
*&---------------------------------------------------------------------*
PARAMETERS:
  P_curr TYPE sflight-currency DEFAULT 'EUR' VALUE CHECK, "Dtel S_CURRCODE
  p_oper TYPE foperator," value CHECK,
  a1     TYPE zrk02_ty_betrag DEFAULT 3,
  op1    TYPE zrk02_ty_operator DEFAULT '+',
  b1     TYPE zrk02_ty_betrag DEFAULT 4,
  a2     TYPE zrk02_ty_betrag DEFAULT 5,
  op2    TYPE zrk02_ty_operator DEFAULT '*',
  b2     TYPE zrk02_ty_betrag DEFAULT 7.
*
DATA:
  res TYPE zrk02_ty_betrag.
