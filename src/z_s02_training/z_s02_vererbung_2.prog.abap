*&---------------------------------------------------------------------*
*& Report Z_S02_VERERBUNG_2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s02_vererbung_2.

**************************
****** Oberklasse Rechnung
**************************
*
*
*
****** Definition *****
*CLASS lcl_rechnung DEFINITION ABSTRACT.     " die Klasse ist dann nicht sichtbar, die dient ausschlieslich dazu, die Unterklassen zu befüllen. Ist nicht instanzierbar, weil sie keinen Sinn macht.
*  PUBLIC SECTION.
*    METHODS: constructor IMPORTING im_zus_con TYPE c.
*    METHODS: pay.
*    METHODS: set_status IMPORTING im_zus TYPE i.
*    METHODS: get_status RETURNING VALUE(re_zus) TYPE string.
*
*  PROTECTED SECTION.
*      CONSTANTS: c_offen    TYPE 1 VALUE '1'.
*    CONSTANTS: c_geschlossen TYPE c VALUE '2'.
*    CONSTANTS: c_pending  TYPE c VALUE '0'.
*    DATA zustand TYPE i.
*
*ENDCLASS.
*
****** Impelementierung *****
*
*CLASS lcl_rechnung IMPLEMENTATION.
*  METHOD constructor.
*   me->set_zustand( im_zus = im_zus_con ).
*       WRITE: | Rechnung ist offen. |.
*  METHOD pay.
*   me->set_zustand( im_zus_con = c_geschlossen ).
*       WRITE: | Rechnung ist beglichen. |.
*  ENDMETHOD.
*
*  METHOD set_status.
*    me->status = im_zus.
*    ENDMETHOD.
*
*  METHOD get_status.
*    re_zus = me->status.
*    ENDMETHOD.
*
*ENDCLASS.
*
*

*************************
***** Unterklasse Teilrechnung
*************************



*************************
***** Unterklasse Abschlagsrechnung
*************************



******>>>>>>> Lösung Robin

**********************************************************************
* OBERKLASSE
**********************************************************************

CLASS lcl_rechnung DEFINITION ABSTRACT.
  PUBLIC SECTION.
    METHODS: constructor.
    METHODS: pay.
    METHODS: set_zustand IMPORTING im_st TYPE i.
*    METHODS: get_zustand RETURNING VALUE(re_st) TYPE i.

  PROTECTED SECTION.
    CONSTANTS: c_open    TYPE i VALUE 1.
    CONSTANTS: c_pending TYPE i VALUE 0.
    CONSTANTS: c_closed  TYPE i VALUE 2.

    DATA zustand TYPE c VALUE c_open.
  PRIVATE SECTION.
ENDCLASS.


CLASS lcl_rechnung IMPLEMENTATION.
  METHOD constructor.
    me->set_zustand( im_st = c_pending ).
  ENDMETHOD.

  METHOD set_zustand.
    me->zustand = im_st.
  ENDMETHOD.

  METHOD pay.
  ENDMETHOD.
ENDCLASS.


**********************************************************************
* UNTERKLASSE Teilrechnungen
**********************************************************************

CLASS lcl_teil DEFINITION INHERITING FROM lcl_rechnung.
  PUBLIC SECTION.

    METHODS: pay REDEFINITION.

ENDCLASS.


CLASS lcl_teil IMPLEMENTATION.
  METHOD pay.
    me->set_zustand( im_st = c_closed ).
    WRITE:/ |Teilrechnung beglichen.|.
  ENDMETHOD.
ENDCLASS.




**********************************************************************
* UNTERKLASSE Abschlagsrechnungen
**********************************************************************
CLASS lcl_abschlag DEFINITION INHERITING FROM lcl_rechnung.
  PUBLIC SECTION.

    METHODS: pay REDEFINITION.

ENDCLASS.


CLASS lcl_abschlag IMPLEMENTATION.
  METHOD pay.
    me->set_zustand( im_st = c_closed ).
    WRITE:/ |Abschlagsrechnung beglichen.|.
  ENDMETHOD.
ENDCLASS.



**********************************************************************
* AUFRUF
**********************************************************************

START-OF-SELECTION.


  DATA lo_teil TYPE REF TO lcl_teil.
  DATA lo_ab TYPE REF TO lcl_abschlag.

  SELECTION-SCREEN BEGIN OF BLOCK b1.
    PARAMETERS p_teil RADIOBUTTON GROUP r1.
    PARAMETERS p_ab RADIOBUTTON GROUP r1.
  SELECTION-SCREEN END OF BLOCK b1.




  IF p_teil EQ abap_true.
    lo_teil = NEW lcl_teil( ).

    lo_teil->pay( ).

  ELSE. "p_ab
    lo_ab = NEW lcl_abschlag( ).

    lo_ab->pay( ).
  ENDIF.
