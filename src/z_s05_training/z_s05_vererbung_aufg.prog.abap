*&---------------------------------------------------------------------*
*& Report Z_S05_VERERBUNG_AUFG
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_VERERBUNG_AUFG.

CLASS lcl_rechnung DEFINITION.
  PUBLIC SECTION.
    METHODS: constructor IMPORTING im_zus_const TYPE i.
   METHODS: geschlossen.
    METHODS: pay.
    METHODS: set_status IMPORTING im_zu TYPE i. " importing parameter
    METHODS: get_status RETURNING VALUE(re_zus) TYPE string. " importing parameter

PROTECTED SECTION.
    CONSTANTS: c_offen TYPE i VALUE 1.
    CONSTANTS: c_geschlossen TYPE i VALUE 2.
    CONSTANTS: c_pending TYPE i VALUE 0.

*  PRivate SECTION.
    DATA: zustand TYPE i VALUE c_offen.

ENDCLASS.

CLASS lcl_rechnung IMPLEMENTATION.

  METHOD constructor.
    me->set_status( im_zu = im_zus_const ).

  ENDMETHOD.

  METHOD geschlossen.
*    me->pay( ).
    me->set_status( im_zu = c_geschlossen ).
    WRITE: / |Rechnung Wurde geschlossen|.

  ENDMETHOD.

  method pay.
   WRITE: / |Rechnung Wurde bezahlt|.
  endmethod.
  METHOD set_status.
    me->zustand = im_zu.

  ENDMETHOD.

  METHOD get_status.

    re_zus = me->zustand.

  ENDMETHOD.
  ENDCLASS.


CLASS lcl_teilrechnung DEFINITION INHERITING FROM lcl_rechnung.
    PUBLIC SECTION.
METHODS: pay REDEFINITION.
ENDCLASS.

CLASS lcl_teilrechnung IMPLEMENTATION.
 method pay.
    me->pay( ).
  WRITE: / |Rechnung Wurde teil bezahlt|.
  endmethod.
ENDCLASS.



CLASS lcl_abschlagrechnung DEFINITION INHERITING FROM lcl_rechnung.
  PUBLIC SECTION.
METHODS: pay REDEFINITION.

ENDCLASS.


CLASS lcl_abschlagrechnung IMPLEMENTATION.

  method pay.
     me->pay( ).
  WRITE: / |Rechnung Wurde noch nicht bezahlt|.
  endmethod.
ENDCLASS.



  START-OF-SELECTION.

DATA lo_rechnung TYPE REF TO lcl_rechnung.
DATA lo_teilrechnung TYPE REF TO lcl_teilrechnung.
DATA lo_abschlagrechnung TYPE REF TO lcl_abschlagrechnung.

  CREATE OBJECT lo_rechnung
    EXPORTING
      im_zus_const = 2.
  lo_teilrechnung = NEW lcl_teilrechnung( im_zus_const = 1 ).
  lo_abschlagrechnung  = NEW lcl_abschlagrechnung( im_zus_const = 0 ).

  lo_rechnung->geschlossen( ).
  "lo_beleg->get_status( ).
  WRITE: |BELEG: { lo_rechnung->get_status( ) }|.

*DATA(lv_test) = lo_beleg->get_status( ).

ULINE.

  lo_teilrechnung->geschlossen( ).
  lo_teilrechnung->get_status( ).
WRITE: |GUTSCHRIFT: { lo_teilrechnung->get_status( ) }|.


ULINE.

  lo_abschlagrechnung->geschlossen( ).
  lo_abschlagrechnung->get_status( ).
  WRITE: |RECHNUNG: { lo_abschlagrechnung->get_status( ) }|.
