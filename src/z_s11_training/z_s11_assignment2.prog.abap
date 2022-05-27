*&---------------------------------------------------------------------*
*& Report Z_S11_ASSIGNMENT2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S11_ASSIGNMENT2.

*Parameters : src_amnt type dec5_2,
*      t_fctr type TCURR-FACTOR,
*      src_curr type CHAR03,
*      trgt_curr type CHAR03.
*
*Data : target_amount type p LENGTH 5 DECIMALS 2,
*
*FORM convert_currency
*
*  USING source_amount source_curr target_curr target_factor
*
*  CHANGING target_amount.
**TYPES: dec5_2 TYPE xxxxxx.
**TYPES: dec5_2 TYPE xxxxxx.
*
*  Target_amount = source_curr * target_factor.
*
*ENDFORM.



*TYPES:
* BEGIN OF lty_s_car_attributes,
*  color(16) TYPE c,
*  hp        TYPE i,
*  doors     TYPE p DECIMALS 1,
* END OF lty_s_car_attributes,
*
* BEGIN OF lty_s_car,
*  manufacturer(16) TYPE c,
*  model(16)        TYPE c,
*  attributes       TYPE lty_s_car_attributes,
* END OF lty_s_car.
*
* DATA car TYPE lty_s_car.
*
* PARAMETERS: p_color TYPE lty_s_car_attributes-color.
*
* car-attributes-color = p_color.
*
* BREAK-POINT.

TYPES:
BEGIN OF lty_rech,
  op1 TYPE p length 3 decimals 2,
  operator type ZS05_OPERATOR2,
  op2 TYPE p length 3 decimals 2,
  result TYPE p length 5 decimals 2,
  END OF lty_rech.

  DATA ls_rech TYPE lty_rech.
   DATA lt_rech TYPE TABLE OF lty_rech.

ls_rech-op1 = 0.

 DO 10 TIMES.

  ADD 1 TO ls_rech-op1.
  if ls_rech-op1 GT 10.
    EXIT.
    ENDIF.


  ENDDO.
