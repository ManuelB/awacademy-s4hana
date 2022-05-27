*&---------------------------------------------------------------------*
*& Report Z_S05_QUIZ_PROBE2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_QUIZ_PROBE2.

DATA:
*        s_amount TYPE  ZS05_DEC5_2,
*        s_curr  TYPE CHAR03,
*        t_curr   TYPE CHAR03,
*        t_factor  TYPE TCURR-UKURS,
        T_AMOUNT TYPE  ZS05_DEC5_2.


PARAMETERS:

* s_amount TYPE  ZS05_DEC5_2,
*        s_curr  TYPE CHAR03,
*        t_curr   TYPE CHAR03,
*        t_factor  TYPE TCURR-UKURS.
*

 s_amount TYPE  ZS05_DEC5_2,
        s_curr  TYPE tcurr-fcurr,
        t_curr   TYPE tcurr-tcurr,
        t_factor  TYPE TCURR-ukurs.




CALL FUNCTION 'ZS5_CONVERT_CURRENCY'
  EXPORTING
    source_amount       = s_amount
    source_curr         = s_curr
    target_curr         =  t_curr
    target_factor       =  t_factor
 IMPORTING
   TARGET_AMOUNT       =  T_AMOUNT


   .
          .
WRITE: t_factor.
