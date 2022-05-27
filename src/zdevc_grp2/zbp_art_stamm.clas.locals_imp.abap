CLASS lhc_z_art_stamm DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

METHODS get_features               FOR FEATURES IMPORTING keys REQUEST    requested_features FOR z_art_stamm    RESULT result.


    METHODS auslisten FOR MODIFY
      IMPORTING keys FOR ACTION z_art_stamm~auslisten RESULT result.


ENDCLASS.

CLASS lhc_z_art_stamm IMPLEMENTATION.


  METHOD get_features.
    "%control-<fieldname> specifies which fields are read from the entities
    READ ENTITY IN LOCAL MODE z_art_stamm FROM VALUE #( FOR keyval IN keys
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



      " Read changed data for action result
      READ ENTITY IN LOCAL MODE z_art_stamm
           FROM VALUE #( FOR key IN keys (  Artikelnummer = key-Artikelnummer
                                            %control = VALUE #(
                                              Activeflag       = if_abap_behv=>mk-on
                                            ) ) )
           RESULT DATA(lt_travel).

      result = VALUE #( FOR travel IN lt_travel ( Artikelnummer = travel-Artikelnummer
                                                  %param    = travel
                                                ) ).
  ENDMETHOD.


*  METHOD get_instance_features.
*  ENDMETHOD.
*
*  METHOD acceptTravel.
*  ENDMETHOD.
*
*  METHOD CalculateTravelKey.
*  ENDMETHOD.



ENDCLASS.
