*&---------------------------------------------------------------------*
*& Report Z_S05_OO_INTERFACES_AUFGABE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s05_oo_interfaces_aufgabe.

INTERFACE lif_verbuchen.
  METHODS verbuchen returning value(im_zahl) type i.
ENDINTERFACE.

CLASS lcl_rechnung DEFINITION ABSTRACT.
  PUBLIC SECTION.
    INTERFACES lif_verbuchen.

    METHODS constructor.
*    METHODS get_status RETURNING VALUE(re_st) TYPE string.
*    METHODS set_status  IMPORTING im_status TYPE i.

  PROTECTED SECTION.
    METHODS: bezahlen,
  set_status IMPORTING im_status TYPE i,
  get_status  exporting ex_status TYPE I.


    CONSTANTS: c_booked TYPE i VALUE 0.
    CONSTANTS: c_closed TYPE i VALUE 1.
    CONSTANTS: c_pending TYPE i VALUE 2.

    DATA: status TYPE i VALUE c_pending.

ENDCLASS.

CLASS lcl_rechnung IMPLEMENTATION.
  METHOD lif_verbuchen~verbuchen.
im_zahl = me->bezahlen( get_status = status ).
    WRITE |Flugticket ist verbucht|.
  ENDMETHOD.
  method constructor.
    me->set_status( im_status = c_pending ).
  METHOD set_status.
    me->status = im_status.
  ENDMETHOD.
  METHOD get_status.
    ex_status = me->status.
  ENDMETHOD.
  METHOD bezahlen.
    WRITE: |Flugticket ist bezahlt.|.
  ENDMETHOD.
ENDCLASS.



CLASS lcl_abschlag DEFINITION INHERITING FROM lcl_rechnung.
  PUBLIC SECTION.
  METHODS lif_verbuchen~verbuchen REDEFINITION.
*  METHODS bezahlen REDEFINITION.
ENDCLASS.


CLASS lcl_abschlag IMPLEMENTATION.
  METHOD lif_verbuchen~verbuchen.
    WRITE |Flugticket ist noch nicht verbucht|.
  ENDMETHOD.
  ENDCLASS.
*  METHOD bezahlen.
*    WRITE: |Flugticket ist teil bezahlt.|.
*  ENDMETHOD.


CLASS lcl_gutschrift DEFINITION.
  PUBLIC SECTION.
    INTERFACES lif_verbuchen.
ENDCLASS.

CLASS lcl_gutschrift IMPLEMENTATION.
  METHOD lif_verbuchen~verbuchen.
    WRITE |Flugticket ist verbucht durch gutschrift|.
  ENDMETHOD.
ENDCLASS.


START-OF-SELECTION.

  DATA:

  lo_rechnung TYPE REF TO lcl_rechnung,
  lo_abschlag TYPE REF TO lcl_abschlag,
  lo_gutschrift TYPE REF TO lcl_gutschrift.

  lo_rechnung = new lcl_rechnung( ).
  lo_abschlag = new lcl_abschlag( ).
  lo_gutschrift = new lcl_gutschrift( ).


  lo_rechnung->get_status( ).
  lo_rechnung->lif_verbuchen~verbuchen( ).
  WRITE: / |RECHNUNG:{ lo_rechnung->get_status( ) }|.

  lo_abschlag->get_status( ).
  lo_abschlag->lif_verbuchen~verbuchen( ).
   WRITE: / |ABSCHLAG:{ lo_abschlag->get_status( ) }|.


  lo_gutschrift->lif_verbuchen~verbuchen( ).
