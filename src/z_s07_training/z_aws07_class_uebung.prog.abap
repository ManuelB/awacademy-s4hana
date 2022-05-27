*&---------------------------------------------------------------------*
*& Report Z_AWS07_CLASS_UEBUNG
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_aws07_class_uebung.


*Interface****************************************************
INTERFACE lif_rechnung.
  METHODS verbuchen.
ENDINTERFACE.



* Klasse Gutschrift******************************************
CLASS lcl_gutschrift DEFINITION.
PUBLIC SECTION.
INTERFACES lif_rechnung.
ENDCLASS.

CLASS lcl_gutschrift IMPLEMENTATION.
METHOD lif_rechnung~verbuchen.
    WRITE: |Zahlung wurde gebucht.|.
    ENDMETHOD.
ENDCLASS.




*oberklasse************************************************
CLASS lcl_rechnung DEFINITION ABSTRACT.
PUBLIC SECTION.
INTERFACES lif_rechnung.
 METHODS: constructor IMPORTING im_const TYPE c.
  METHODS: set_status IMPORTING im_st TYPE c.
  METHODS: get_status RETURNING VALUE(re_st) TYPE string.
PROTECTED SECTION.

  CONSTANTS: c_open TYPE c VALUE 'O'.
  CONSTANTS: c_pending TYPE c VALUE 'P'.
  CONSTANTS: c_closed TYPE c VALUE 'C'.

  DATA status TYPE c VALUE c_open.
PRIVATE SECTION.
  METHODS: bezahlen.
ENDCLASS.

CLASS lcl_rechnung IMPLEMENTATION.
  method lif_rechnung~verbuchen.
    WRITE: |Zahlung wurde gebucht.|.
    ENDMETHOD.
  METHOD constructor.
    me->set_status( im_st = im_const ).
    ENDMETHOD.
METHOD set_status.
    me->status = im_st.
  ENDMETHOD.

  METHOD get_status.
    re_st = me->status.
  ENDMETHOD.

  METHOD bezahlen.
      WRITE: / |Rechnung wurde bezahlt.|.
      ENDMETHOD.


ENDCLASS.

*  unterklasse Abschlag*************************************
CLASS lcl_abschlag DEFINITION INHERITING FROM lcl_rechnung.
  PUBLIC SECTION.
*  METHODS: bezahlen REDEFINITION.

ENDCLASS.

CLASS lcl_abschlag IMPLEMENTATION.
ENDCLASS.
