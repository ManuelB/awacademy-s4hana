*&---------------------------------------------------------------------*
*& Report Z_S05_VERSCHATTUNG
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_VERSCHATTUNG.

DATA:
      op1 TYPE i,
      op2 TYPE i,
      res TYPE i.

op1 = 1.
op2 = 1.
"call funktion 'hello'.
perform add using op1 op2 res.
write: / 'ergebnis', res.

form add using value(p_op1) Value(P_op2) p_res.
  data:

        op1 type i value 5.
  p_res = op1 + op2.

  endform.
