interface ZS05_IF_AIRPLANE
  public .


  types TY_PLANETYPES type ZS05_PLANETYPES .

  constants C_POS_1 type I value 30 ##NO_TEXT.
  data MV_NAME type STRING .
  data MV_PLANETYPE type SAPLANE-PLANETYPE .
  data MV_WEIGHT type SAPLANE-WEIGHT .
  data MV_TANKCAP type SAPLANE-TANKCAP .
  class-data GV_N_O_AIRPLANES type I .
  class-data GT_PLANETYPES type TY_PLANETYPES .

  class-methods DISPLAY_N_O_AIRPLANES .
  class-methods GET_N_NO_AIRPLANES
    returning
      value(RV_COUNT) type I .
  class-methods GET_TECHNICAL_ATTRIBUTES
    importing
      !IV_TYPE type SAPLANE-PLANETYPE
    exporting
      !EV_WEIGHT type SAPLANE-WEIGHT
      !EV_TANKCAP type SAPLANE-TANKCAP
      !EV_SEATS type SAPLANE-SEATSMAX
    exceptions
      WRONG_PLANETYPE .
  methods DISPLAY_ATTRIBUTES .
endinterface.
