interface ZS03_IF_AIRPLANE
  public .


  constants C_POS_1 type I value 30 ##NO_TEXT.
  class-data GT_SAPLANE type ZT03_TTYP_SAPLANE .

  class-methods DISPLAY_N_O_AIRPLANES
    importing
      !IV_NAME type STRING
      !IV_PLANETYPE type SAPLANE-PLANETYPE
      !RV_COUNT type I .
  class-methods GET_N_NO_AIRPLANES .
  methods DISPLAY_ATTRIBUTES .
endinterface.
