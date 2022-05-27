*&---------------------------------------------------------------------*
*& Report Z_S02_ASS2_FINDEFEHLER
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s02_ass2_findefehler.


****** Interface
INTERFACE lif.
  METHODS bezahlen.
  DATA: farbe TYPE string.
ENDINTERFACE.


****** Klasse PKW
CLASS lcl_pkw DEFINITION. " ABSTRACT
  PUBLIC SECTION.
    METHODS: fahren.
    METHODS: tanken.
    METHODS: get_farbe.

  PROTECTED SECTION.
    DATA: km TYPE i.
    DATA: farbe TYPE string.
ENDCLASS.

CLASS lcl_pkw IMPLEMENTATION.
  METHOD fahren.
  ENDMETHOD.

  METHOD tanken.
  ENDMETHOD.

  METHOD get_farbe.
  ENDMETHOD.
ENDCLASS.


****** Subklasse Taxi
CLASS lcl_taxi DEFINITION INHERITING FROM lcl_pkw.
  PUBLIC SECTION.
    INTERFACES lif.
    METHODS: get_km.
ENDCLASS.

CLASS lcl_taxi IMPLEMENTATION.
  METHOD lif~bezahlen.
  ENDMETHOD.

  METHOD get_km.

  ENDMETHOD.
ENDCLASS.


****** Instanziierung Taxi
START-OF-SELECTION.

DATA lo_taxi TYPE REF TO lcl_taxi.

lo_taxi = new lcl_taxi( ).
