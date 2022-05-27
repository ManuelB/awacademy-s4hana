class ZS10_CL_AIRPLANE definition
  public
  final
  create public .

public section.

  interfaces ZS10_IF_AIRPLANE1 .

  class-methods CLASS_CONSTRUCTOR .
  class-methods DISPLAY_N_O_AIRPLANES .
  class-methods GET_N_NO_AIRPLANES .
protected section.

  constants C_POS_1 type I value 30 .
private section.

  data MV_NAME type STRING .
  data MV_PLANETYPE type SAPLANE-PLANETYPE .
  data MV_WEIGHT type SAPLANE-WEIGHT .
  data MV_TANKCAP type SAPLANE-TANKCAP .
  class-data GV_N_O_AIRPLANES type I .
  class-data GT_PLANETYPES type ZT03_TTYP_SAPLANE .
  data TY_PLANETYPES type ZT03_TTYP_SAPLANE .
ENDCLASS.



CLASS ZS10_CL_AIRPLANE IMPLEMENTATION.


  method CLASS_CONSTRUCTOR.

  endmethod.


  method DISPLAY_N_O_AIRPLANES.

  endmethod.


  method GET_N_NO_AIRPLANES.
  endmethod.
ENDCLASS.
