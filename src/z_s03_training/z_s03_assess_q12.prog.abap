*&---------------------------------------------------------------------*
*& Report Z_S03_ASSESS_Q12
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s03_assess_q12.

*CLASS pkw DEFINITION.
*  PUBLIC SECTION.
*    METHODS: change_owner
*      IMPORTING im_owner TYPE string.
*    DATA:
*      kennz   TYPE string,
*      Owner   TYPE string,
*      akt_ort TYPE string.
*ENDCLASS.
*
*CLASS pkw IMPLEMENTATION.
*  METHOD change_owner.
*    me->owner = im_owner.
*  ENDMETHOD.
*  ENDCLASS.
*
*  DATA: mein_auto TYPE REF TO pkw.
*  PARAMETERS:
*    nr   TYPE string DEFAULT 'A-RK 256',
*    Own1 TYPE string DEFAULT 'Hugo',
*    own2 TYPE string DEFAULT 'Susi',
*    ort  TYPE string DEFAULT 'Augsburg'.
*
*START-OF-SELECTION.
*  CREATE OBJECT mein_auto.
*  mein_auto->kennz = nr.
*  mein_auto->owner = own1.
*  mein_auto->akt_ort = ort.
*  mein_auto->change_owner( own2 ).
*  WRITE:/ 'Besitzer: ', own2.

INTERFACE z_S03_organisation.
ENDINTERFACE.

INTERFACE z_S03_NATUERLICHE_PERSON.
  METHODS: istangestelltbei
    IMPORTING organisation           TYPE string
    RETURNING VALUE(re_organisation) TYPE xfeld,
    name
      RETURNING VALUE(re_name) TYPE string.
ENDINTERFACE.

CLASS z_S03_PRAESIDENT DEFINITION.
  PUBLIC SECTION.
    INTERFACES z_S03_NATUERLICHE_PERSON.
    DATA:
      vorname  TYPE string,
      nachname TYPE string.
ENDCLASS.



CLASS z_S03_PRAESIDENT IMPLEMENTATION.
  METHOD z_S03_NATUERLICHE_PERSON~name.
    me->vorname = re_name.
  ENDMETHOD.
  METHOD z_S03_NATUERLICHE_PERSON~istangestelltbei.
    WRITE: / 'Diese Person ist angestellt bei folgender Organisation', Organisation.
  ENDMETHOD.
ENDCLASS.
