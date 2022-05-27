class ZS01_CL_AIRPLANE definition
  public
  final
  create public .

public section.

  interfaces ZS01_IF_AIRPLANE .

  data IV_NAME type STRING .
  data IV_PLANETYPE type SAPLANE-PLANETYPE .

  methods CONSTRUCTOR .
  class-methods CLASS_CONSTRUCTOR .
protected section.

  data C_POS_1 type I value 30 ##NO_TEXT.
private section.

  types TY_PLANETYPES type S_PLANETYE .

  class-data IV_TYPE type SAPLANE-PLANETYPE .
  data RV_COUNT type I .
  data MV_NAME type STRING .
  data MV_PLANETYPE type SAPLANE-PLANETYPE .
  data MV_WEIGHT type SAPLANE-WEIGHT .
  data MV_TANKCAP type SAPLANE-TANKCAP .
  data GV_N_O_AIRPLANES type I .
  data GT_PLANETYPES type TY_PLANETYPES .
  data EV_WEIGHT type SAPLANE-WEIGHT .
  data EV_TANKCAP type SAPLANE-TANKCAP .

  events WRONG_PLANETYPE .
  events DISPLAY_ATTRIBUTES .

  methods DISPLAY_N_O_AIRPLANES .
  methods GET_N_NO_AIRPLANES .
  methods GET_TECHNICAL_ATTRIBUTES .
ENDCLASS.



CLASS ZS01_CL_AIRPLANE IMPLEMENTATION.


  method CLASS_CONSTRUCTOR.
  endmethod.


  method CONSTRUCTOR.
  endmethod.


  method DISPLAY_N_O_AIRPLANES.
  endmethod.


  method GET_N_NO_AIRPLANES.
  endmethod.


  method GET_TECHNICAL_ATTRIBUTES.
  endmethod.


  method ZS01_IF_AIRPLANE~DISPLAY_ATTRIBUTES.
  endmethod.
ENDCLASS.
