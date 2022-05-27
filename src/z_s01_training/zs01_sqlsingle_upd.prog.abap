*&---------------------------------------------------------------------*
*& Report ZAWT03_ABAP_SQL_SEL_SINGLE_UPD
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZS01_SQLSINGLE_UPD.

DELETE FROM demo_expressions.
INSERT demo_expressions FROM @( VALUE #( id = 'X' ) ).
COMMIT CONNECTION default.

SELECT SINGLE FOR UPDATE id, num1
       FROM demo_expressions
       WHERE id = 'X'
       INTO @DATA(wa).

  SELECT SINGLE FOR UPDATE id, num1
       FROM demo_expressions
       WHERE id = 'X'
       INTO @DATA(wa1).

UPDATE demo_expressions SET num1 = 111 WHERE id = 'X'.

BREAK-POINT.
