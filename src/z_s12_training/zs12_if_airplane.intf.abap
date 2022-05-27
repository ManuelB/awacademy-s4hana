interface ZS12_IF_AIRPLANE
  public .


  data IV_NAME type STRING .
  data IV_PLANETYPE type SAPLANE-PLANETYPE .
  data IV_SEATS type S_SEATSMAX .
  data IV_CARGO type SCPLANE-CARGOMAX .
  constants C_POS_1 type I value 30 ##NO_TEXT.

  class-methods CLASS_CONSTRUCTOR .
  methods DISPLAY_ATTRIBUTES .
endinterface.
