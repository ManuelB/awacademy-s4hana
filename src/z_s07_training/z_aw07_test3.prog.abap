*&---------------------------------------------------------------------*
*& Report Z_AW07_TEST
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*


REPORT z_aw07_test3.


INTERFACE z_s07_Organisation.

ENDINTERFACE.

INTERFACE z_s07_NatuerlichePerson.

  METHODS:
    name IMPORTING name type string,
    istAngestellt IMPORTING my_test TYPE xfeld.

ENDINTERFACE.

CLASS z_s07_Preasident DEFINITION.
  PUBLIC SECTION.

    INTERFACES z_s07_natuerlicheperson.

    METHODS: name IMPORTING name TYPE string.
    METHODS: istAngestellt IMPORTING istangestellt TYPE xfeld.


    DATA:
      vorname  TYPE string,
      nachname TYPE string.

    ENDCLASS.
*
*
*
CLASS z_s07_preasident IMPLEMENTATION.


  METHOD z_s07_natuerlicheperson~name.
    me->nachname = name.
  ENDMETHOD.


  METHOD z_s07_natuerlicheperson~istangestellt.

  ENDMETHOD.


ENDCLASS.








*CLASS pkw DEFINITION.
*PUBLIC SECTION.
*METHODS: change_owner
*IMPORTING im_owner TYPE string.
*DATA:
*kennz TYPE string,
*Owner TYPE string,
*akt_ort TYPE string.
*ENDCLASS.
*CLASS pkw IMPLEMENTATION.
*METHOD change_owner.
*me->owner = im_owner.
*ENDMETHOD.
*ENDCLASS.
*
*DATA: mein_auto TYPE REF TO pkw.
*PARAMETERS:
*nr TYPE string DEFAULT 'A-RK 256',
*own1 TYPE string DEFAULT 'Hugo',
*own2 TYPE string DEFAULT 'Susi',
*ort TYPE string DEFAULT 'Augsburg'.
*
*START-OF-SELECTION.
*
*CREATE OBJECT mein_auto.
*mein_auto->kennz = nr.
*mein_auto->owner = own1.
*mein_auto->Akt_ort = ort.
*mein_auto->change_owner( own2 ).
*
*WRITE: / 'Besitzer:', own1.








*CLASS pkw DEFINITION.
*  PUBLIC SECTION.
*    METHODS:
*      fahren,
*      tanken,
*      get_farbe RETURNING VALUE(re_farbe) TYPE string.
**  PROTECTED SECTION.
*    DATA:
*      km    TYPE i,
*      farbe TYPE string.
*ENDCLASS.
*
*CLASS pkw IMPLEMENTATION.
*  METHOD fahren.
**    me->km = me->km + 100.
*  ENDMETHOD.
*  METHOD tanken.
*  ENDMETHOD.
*  METHOD get_farbe.
*  ENDMETHOD.
*ENDCLASS.
*
*INTERFACE lif.
*  METHODS: bezahlen.
*
*  DATA: farbe TYPE string.
*ENDINTERFACE.
*
*CLASS taxi DEFINITION INHERITING FROM pkw.
*  PUBLIC SECTION.
*    INTERFACES: lif.
*
*    METHODS:
*      fahren REDEFINITION,
*      tanken REDEFINITION,
*      get_km RETURNING VALUE(re_km) TYPE i.
*ENDCLASS.
*
*CLASS taxi IMPLEMENTATION.
*
*  METHOD lif~bezahlen.
*  ENDMETHOD.
*
*  METHOD fahren.
*
*  ENDMETHOD.
*
*  METHOD tanken.
*
*  ENDMETHOD.
*
*  METHOD get_km.
*
*  ENDMETHOD.
*  ENDCLASS.
*
*START-OF-SELECTION.
*DATA:
*my_pkw TYPE REF TO pkw,
*my_taxi TYPE REF TO taxi,
*my_lif TYPE REF TO lif.
*
*CREATE OBJECT: my_pkw, my_taxi.
*my_lif = my_taxi.
*
*WRITE: / my_lif->farbe, my_taxi->km, my_pkw->farbe.
