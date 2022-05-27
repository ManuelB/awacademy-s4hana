class ZCL_SD_GRP1_SACHBEARBEITER definition
  public
  create public .

public section.

  data NAME type ref to NAME .

  class-events WECHSEL_ERFOLGREICH .

  class-methods ANBIETER_PFLEGEN .
  class-methods TARIFE_PFLEGEN .
  class-methods WECHSELSTATUS_AENDERN .
protected section.
private section.
ENDCLASS.



CLASS ZCL_SD_GRP1_SACHBEARBEITER IMPLEMENTATION.


  method ANBIETER_PFLEGEN.
  endmethod.


  method TARIFE_PFLEGEN.
  endmethod.


  method WECHSELSTATUS_AENDERN.
  endmethod.
ENDCLASS.
