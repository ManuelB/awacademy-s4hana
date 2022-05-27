*&---------------------------------------------------------------------*
*& Report Z_S02_ASS2_1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S02_ASS2_1.

TYPES:
  betr TYPE p LENGTH 6 DECIMALS 2,
  red TYPE i.

PARAMETERS:
  opreis1 type betr DEFAULT 50,
  rabatt1  TYPE red DEFAULT 15,
  opreis2 type betr DEFAULT 10,
  rabatt2  TYPE red default 1.


DATA:
  rpreis1 TYPE betr,
  rpreis2 TYPE betr.



* ABAP-Code
PERFORM reduzierung USING opreis1 rabatt1 CHANGING rpreis1.
PERFORM reduzierung USING opreis2 rabatt2 CHANGING rpreis2.



* Ausgabe
WRITE:  /'Der Original-Preis 1', opreis1,
        /' bekommt den Rabatt-Prozentsatz:', rabatt1, ' damit ist der reduzierte Preis:', rpreis1.
SKIP.
WRITE:  /'Der Original-Preis 2', opreis2,
        /' bekommt den Rabatt-Prozentsatz:', rabatt2, ' damit ist der reduzierte Preis:', rpreis2.



* FORM-Routine
FORM reduzierung USING opreis rabatt CHANGING rpreis.

*  rpreis = opreis / ( 1 + ( '0.01' * rabatt ) ).
  rpreis = opreis - ( opreis / 100 * rabatt ) .


  ENDFORM.
