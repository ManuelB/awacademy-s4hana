*&---------------------------------------------------------------------*
*& Report Z_S06_PRACTICE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s06_practice.

*INTERFACE lif. "Interface ist immer public, kan methods und attribute haben/is die sicht.
*  data: farbe type string. "default 'rot'.
*  METHODS: bezahlen.
*ENDINTERFACE.
*
*CLASS pkw DEFINITION.
*
*  PUBLIC SECTION.
*    METHODS: fahren.
*    METHODS: tanken.
*    METHODS: get_farbe RETURNING VALUE(re_farbe) TYPE string."when get, RETURING VALUE followed by (re_value)
*
*  PROTECTED SECTION.
*    DATA:
*      km    TYPE i,
*      farbe TYPE string.
*
*ENDCLASS.
*
*CLASS pkw IMPLEMENTATION.
*  METHOD fahren.
*    me->km = me->km + 123."EXPORTING/IMPORTING
*    WRITE: / 'fahren'.
*  ENDMETHOD.
*
*  METHOD tanken.
*    WRITE: / 'Tanken'.
*  ENDMETHOD.
*
*  METHOD get_farbe.
*    re_farbe = me->farbe. "EXPORTING/IMPORTING
*    WRITE: / 'farbe: ROT'.
*  ENDMETHOD.
*ENDCLASS.
*
*CLASS taxi
*  DEFINITION INHERITING FROM pkw."reference with INHERITING FROM pkw.
*
*  PUBLIC SECTION.
*    METHODS: fahren REDEFINITION."reference methods with REDEFINITION FROM pkw.
*    METHODS: tanken REDEFINITION.
*    METHODS: get_km RETURNING VALUE(re_km) TYPE i."when get, RETURING VALUE followed by (re_value)
*    INTERFACES lif.
*
*ENDCLASS.
*
*CLASS taxi IMPLEMENTATION.
*
*  METHOD fahren.
*    super->fahren( )."reference the SUPER CLASS 'pkw' when using an inherited method.(all public methods are inherited).
*  ENDMETHOD.
*  METHOD tanken.
*    super->tanken( )."reference the SUPER CLASS 'pkw' when using an inherited method.(all public methods are inherited).
*  ENDMETHOD.
*  METHOD get_km.
*    re_km = me->km.
*  ENDMETHOD.
**  METHOD get_farbe.
**     re_farbe = me->farbe. "EXPORTING/IMPORTING
**    WRITE: / 'farbe: ROT'.
**    ENDMETHOD.
*  METHOD lif~bezahlen."reference the INTERFACE (lif) followed by the '~'. Nothing else neccesary.
*    WRITE: 'bezahleng'.
*  ENDMETHOD.
*
*ENDCLASS.
*
*START-OF-SELECTION.
*
**  DATA(my_auto) = NEW pkw( ).
**  DATA(my_taxi) = NEW taxi( ).
*
*  DATA:
*    my_pkw  TYPE REF TO pkw,
*    my_taxi TYPE REF TO taxi,
*    my_lif  TYPE REF TO lif.
*
*create object: my_pkw, my_taxi." my_lif.
*my_lif = my_taxi.
*"Write: my_lif->farbe.farbe entheld null ref
*write: my_taxi->get_km( ).
*write: my_pkw->get_farbe( ).

*
*  my_auto->fahren( ).
*  my_auto->get_farbe( ).
*  my_auto->tanken( ).
*  ULINE.
*  my_taxi->fahren( ).
*  my_taxi->tanken( ).
*  WRITE: / 'km:', my_taxi->get_km( ).
*  my_taxi->lif~bezahlen( )."reference the INTERFACE (lif) followed by the '~'. Nothing else neccesary.
*  ULINE.
*  my_taxi->fahren( ).
*  my_taxi->tanken( ).
*  WRITE: / 'km:', my_taxi->get_km( ).
*  my_taxi->lif~bezahlen( )."reference the INTERFACE (lif) followed by the '~'. Nothing else neccesary.

**********************************************************************

*CLASS pkw DEFINITION.
*  PUBLIC SECTION.
*    METHODS: change_owner
*    IMPORTING im_owner TYPE string.
*    DATA:
*      kennz   TYPE string,
*      owner   TYPE string,
*      akt_ort TYPE string.
*ENDCLASS.
*
*CLASS pkw IMPLEMENTATION.
*  METHOD change_owner.
*    me->owner = im_owner.
*  ENDMETHOD.
*ENDCLASS.
*DATA:mein_auto TYPE REF TO pkw.
*PARAMETERS:
*  nr   TYPE string DEFAULT 'A-RK 256',
*  own1 TYPE string DEFAULT 'Hugo',
*  own2 TYPE string DEFAULT 'Susi',
*  ort  TYPE string DEFAULT 'Augsburg'.
*
*START-OF-SELECTION.
*  CREATE OBJECT mein_auto.
*  mein_auto->kennz = nr.
*  mein_auto->owner = own1.
*  mein_auto->akt_ort = ort.
*  mein_auto->change_owner( own2 ).
*
*  Write: / 'Besitzer:', own1.


*INTERFACE j.
*  EVENTS: e.
*  METHODS: ma,
*    on_e FOR EVENT e OF j.
*  DATA: count TYPE i.
*ENDINTERFACE.
*
*CLASS k DEFINITION.
*  PUBLIC SECTION.
*    INTERFACES: j.
*    METHODS:
*      ma,
*      constructor IMPORTING im_limit TYPE i.
*  PRIVATE SECTION.
*   Data limit type i value 9.
*ENDCLASS.
*CLASS k IMPLEMENTATION.
*METHOD constructor.
*limit = im_limit.
*SET HANDLER j~on_e FOR me.
*ENDMETHOD.
*METHOD ma.
*WHILE j~count < limit.
*WRITE: j~count.
*ADD 1 TO j~count.
*ENDWHILE.
*RAISE EVENT j~e.
*ENDMETHOD.
*METHOD j~ma.
*WHILE j~count > 0.
*WRITE: j~count.
*SUBTRACT 1 FROM j~count.
*ENDWHILE.
*RAISE EVENT j~e.
*ENDMETHOD.
*METHOD j~on_e.
*WRITE: 'ok'. SKIP.
*ENDMETHOD.
*ENDCLASS.
*
*START-OF-SELECTION.
*DATA:
*k_ref TYPE REF TO k.
*PARAMETERS:
*p_limit TYPE i DEFAULT 5.
*CREATE OBJECT k_ref
*EXPORTING
*im_limit = p_limit.
*k_ref->j~count = 3.
*CALL METHOD : k_ref->j~ma, k_ref->ma.

data: l_obj type SMENSAPNEW-REPORT,
      l_rep type SMENSAPNEW-REPORTTYPE,
      l_url type SMEN_BUFFI-URL.

l_obj = 'URL'.
l_rep = 'OT'.
l_url = 'http://bootcamp.swm.de:50000/sap/bc/ui5_ui5/sap/zgrp3_sweet_app/index.html#/?sap-iapp-state--history=1&sap-iapp-state=2'.

CALL FUNCTION 'MENU_START_OBJECT_VIA_INDX'
 EXPORTING
   OBJECT_NAME         = l_obj
   REPORTTYPE          = l_rep
   URL                 = l_url.
