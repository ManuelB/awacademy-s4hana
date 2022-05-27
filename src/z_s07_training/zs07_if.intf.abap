interface ZS07_IF
  public .


  types TY_PLANETTYPES type SAPLANE .

  data MV_NAME type STRING .
  data MV_PLANETYPE type SAPLANE-PLANETYPE .
  data MV_WEIGHT type SAPLANE-WEIGHT .
  data MV_TANKCAP type SAPLANE-TANKCAP .
  constants C_POS_1 type I value 30 ##NO_TEXT.
endinterface.
