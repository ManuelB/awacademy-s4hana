CLASS lhc_zgrp03_t01_sweets DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

"    METHODS get_instance_features FOR INSTANCE FEATURES
"      IMPORTING keys REQUEST requested_features FOR zgrp03_t01_sweets RESULT result.

    METHODS get_features               FOR FEATURES IMPORTING keys REQUEST    requested_features FOR zgrp03_t01_sweets    RESULT result.


    METHODS auslisten FOR MODIFY
      IMPORTING keys FOR ACTION zgrp03_t01_sweets~auslisten RESULT result.

ENDCLASS.

CLASS lhc_zgrp03_t01_sweets IMPLEMENTATION.

"  METHOD get_instance_features.
"  ENDMETHOD.
  METHOD get_features.
    "%control-<fieldname> specifies which fields are read from the entities
    READ ENTITY IN LOCAL MODE zgrp03_t01_sweets FROM VALUE #( FOR keyval IN keys
                                                      (  %key                    = keyval-%key
                                                       "  %control-Activeflag      = if_abap_behv=>mk-on
                                                       "  %control-overall_status = if_abap_behv=>mk-on
                                                        ) )
                                RESULT DATA(lt_travel_result).


    result =  VALUE #( FOR ls_travel IN lt_travel_result
                       ( %key                           = ls_travel-%key
                         %features-%action-auslisten = if_abap_behv=>fc-o-enabled
                      ) ).
  ENDMETHOD.

  METHOD auslisten.

  " Modify in local mode: BO-related updates that are not relevant for authorization checks
"      MODIFY ENTITIES OF zgrp03_t01_sweets IN LOCAL MODE
"             ENTITY zgrp03_t01_sweets
"                UPDATE FROM VALUE #( FOR key IN keys ( mykey = key-mykey
"                                                       overall_status = 'A' " Accepted
"                                                       %control-overall_status = if_abap_behv=>mk-on ) )
"             FAILED   failed
"             REPORTED reported.

      " Read changed data for action result
      READ ENTITY IN LOCAL MODE zgrp03_t01_sweets
           FROM VALUE #( FOR key IN keys (  Artikelnummer = key-Artikelnummer
                                            %control = VALUE #(
                                              Activeflag       = if_abap_behv=>mk-on
                                            ) ) )
           RESULT DATA(lt_travel).

      result = VALUE #( FOR travel IN lt_travel ( Artikelnummer = travel-Artikelnummer
                                                  %param    = travel
                                                ) ).
  ENDMETHOD.

ENDCLASS.
