CLASS lhc_Travel DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Travel RESULT result.

    METHODS acceptTravel FOR MODIFY
      IMPORTING keys FOR ACTION Travel~acceptTravel RESULT result.

    METHODS CalculateTravelKey FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Travel~CalculateTravelKey.

ENDCLASS.

CLASS lhc_Travel IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD acceptTravel.
  ENDMETHOD.

  METHOD CalculateTravelKey.
  ENDMETHOD.

ENDCLASS.
