*&---------------------------------------------------------------------*
*& Include          Z_S05_INCLUDE
*&---------------------------------------------------------------------*


*daten deklarationen für Selektionsbild interne Berechnungen, ausgabe.
PARAMETERS:
"p_curr TYPE zs05_sflight-currency VALUE CHECK,
"p_oper TYPE ZS05_DEMO123 VALUE CHECK,
a1 TYPE Z05WW_pzahl ,
op1 TYPE  Z05WW_oper VALUE CHECK,
B1 TYPE Z05WW_pzahl,
a2 TYPE Z05WW_pzahl,
op2 TYPE Z05WW_oper  VALUE CHECK,
B2 TYPE Z05WW_pzahl.

DATA:
      RES TYPE Z05WW_pzahl.
