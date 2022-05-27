class ZS03_CL_AIRPLANE definition
  public
  final
  create public .

public section.

  interfaces ZS03_IF_AIRPLANE .
protected section.
private section.

  data GT_SAPLANE type ZT03_TTYP_SAPLANE .
  data GV_N_O_AIRPLANES type I .
  data EV_WEIGHT type SAPLANE-WEIGHT .
  data EV_TANKCAP type SAPLANE-TANKCAP .

  class-methods CLASSCONSTRUCTOR .
  methods CONSTRUCTOR .
  methods GET_TECHNICAL_ATTRIBUTES
    importing
      !EV_TANKCAP type SAPLANE-TANKCAP
    exporting
      !EV_WEIGHT type SAPLANE-WEIGHT .
ENDCLASS.



CLASS ZS03_CL_AIRPLANE IMPLEMENTATION.


  method CLASSCONSTRUCTOR.
  endmethod.


  method CONSTRUCTOR.
  endmethod.


  method GET_TECHNICAL_ATTRIBUTES.
  endmethod.


  method ZS03_IF_AIRPLANE~DISPLAY_ATTRIBUTES.

  endmethod.


  method ZS03_IF_AIRPLANE~DISPLAY_N_O_AIRPLANES.
  endmethod.
ENDCLASS.
