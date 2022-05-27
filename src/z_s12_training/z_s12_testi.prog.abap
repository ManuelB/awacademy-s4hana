*&---------------------------------------------------------------------*
*& Report Z_S12_TESTI
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s12_test.

*DO 3 TIMES.
*  WRITE: / sy-index.
*DO 2 TIMES.
*  WRITE: sy-index.
*ENDDO.
*ENDDO.
*write: / 'Ende'.

*PARAMETERS: b TYPE i DEFAULT 4.
*DATA res TYPE i VALUE 5.
*WRITE: b, res.
*PERFORM rechne USING res changing b.
*WRITE: b, res.
*FORM rechne USING b changing c.
*  DATA: res TYPE i VALUE 6.
*  c = res.
*  WRITE: b, res.
*ENDFORM.

*SELECT carrid, connid, SUM( seatsocc ) AS seatsocc
*
*       FROM sflight
*
*       GROUP BY carrid, connid
*
*       ORDER BY carrid, connid
*
*       INTO TABLE @DATA(fluege).
*
*ENDSELECT.



*Data: a type i value 3,
*      b type i value 7.
*B = a * b - c.

*DO 3 TIMES.
*while count < 5.
*  count = count + 1.
*  if count = 2.
*    continue.
*    else.
*      count = count + 2.
*      endif.
*      endwhile.
*ENDDO.
*Write: / count.


*
*PARAMETERS:
*  Preis  TYPE p LENGTH 6 DECIMALS 2,
*  p_lebm RADIOBUTTON GROUP rb_1,
*  p_hanw RADIOBUTTON GROUP rb_1.
*
*
*DATA:
*  Bruttopreis TYPE p LENGTH 6 DECIMALS 2,
*  Nettopreis  TYPE p LENGTH 6 DECIMALS 2,
*  Netto       TYPE p LENGTH 6 DECIMALS 2,
*  Netto1      TYPE p LENGTH 6 DECIMALS 2.



*CASE 'X'.
*  WHEN p_lebm.
*    PERFORM Lebensmittel USING Preis CHANGING Bruttopreis Nettopreis.
*    WRITE: 'Das folgende Lebensmittel hat einen Nettopreis von', Netto1 , 'Die Mehrwertsteuer beträg', Netto, 'Der Bruttopreis beträgt', Preis.
*  WHEN  p_hanw.
*    PERFORM Handelsware USING Preis CHANGING Bruttopreis Nettopreis.
*    WRITE: 'Die folgende Handelsware hat einen Nettopreis von', Netto1, 'Die Mehrwertsteuer beträgt', Netto.
*  WHEN OTHERS.
*    WRITE: / 'Es tut uns leid, der folgende Warentyp entspricht nicht den Vorgaben.'.
*ENDCASE.
*
*
*
*FORM Lebensmittel USING Preis2 CHANGING Preis bruttopreis.
*  Netto = ( ( 7 / 100 ) * Preis2 ).
*  Netto1 = Preis2 - Netto.
*  Preis = Preis2.
*ENDFORM.
*
*FORM Handelsware USING Preis2 CHANGING Preis bruttopreis.
*  Netto =  ( ( 19 / 100 ) * Preis2 ).
*  Netto1 = Preis2 - Netto.
*  Preis = Preis2.
*ENDFORM.

*FUNCTION z01_taschenrechner.

*  PARAMETERS:
*    z1 TYPE zrk01_ty_betrag DEFAULT '3,14',
*    op TYPE foperator DEFAULT '+',
*    z2 TYPE zrk01_ty_betrag DEFAULT '8.335'.
*  DATA:
*        result TYPE zrk01_ty_betrag.
*  CALL FUNCTION 'ZS12_RECHNEN_DATEL'
*    EXPORTING
*      i_a            = z1
*      i_op           = op
*      i_b            = z2
*    IMPORTING
*      e_res          = result
*    exceptions
*      zero_division  = 2
*      wrong_operator = 1
*      OTHERS         = 3.
*  IF sy-subrc <> 0.
*CASE sy-subrc.
*  WHEN 1. Write: / 'falscher Operator' color COL_GROUP.
*  WHEN 2. Write: / 'Div. durch Null' COLOR COL_NEGATIVE.
*  WHEN OTHERS.
*ENDCASE.
*else.
*  Write: /3 i_a,
*  / foperator, i_b,
* /3(15) sy-uline,
*  / '=', e_res.
*  ENDIF.
*Data:
*      i_a type i value 3,
*      i_b type i value 3,
*      r_res type i value 3,

*  Write: /3 i_a,/ foperator, i_b, /3(15) sy-uline,/ '=', e_res.
*  Write:  sy-uline.



*parameters: preis type quan.
* data     fpreis type quan.
*
*fpreis = preis * 2.


*
*INTERFACE li_fahrezug.
*ENDINTERFACE.
*
*INTERFACE li_auto.
*  METHODS:
*    besitzer
*      IMPORTING
*        im_besitzer TYPE string,
*    max_geschwindigkeit
*      RETURNING VALUE(re_maxv) TYPE i.
*ENDINTERFACE.
*
*CLASS lcl_TeslaModel3 DEFINITION.
*  PUBLIC SECTION.
*    INTERFACES li_auto.
*    METHODS: vollgas.
*
*  PROTECTED SECTION.
*    DATA:
*      batterie        TYPE i,
*      nummernschild   TYPE string,
*      geschwindigkeit TYPE i,
*      besitzer        TYPE string.
*
*ENDCLASS.
*
*CLASS lcl_TeslaModel3 IMPLEMENTATION.
*  METHOD li_auto~besitzer.
*    me->li_auto~besitzer( im_besitzer = 'Hans Peter' ).
*  ENDMETHOD.
*  METHOD li_auto~max_geschwindigkeit.
*    re_maxv = 200.
*  ENDMETHOD.
*  METHOD vollgas.
*    WRITE: / 'Ich geb Gas, ich geb Gas. Ich will Spaß, ich will Spaß!'.
*  ENDMETHOD.
*ENDCLASS.


*CLASS pkw DEFINITION.
*  PUBLIC SECTION.
*    METHODS: change_owner
*      IMPORTING
*        im_owner TYPE string.
*    DATA:
*
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
*
*DATA: mein_auto TYPE REF TO pkw.
*PARAMETERS:
*  nr   TYPE string DEFAULT 'A-RK 256',
*  own1 TYPE string DEFAULT 'Hugo',
*  own2 TYPE string DEFAULT 'Hubert',
*  ort  TYPE string DEFAULT 'München'.
*
*START-OF-SELECTION.
*  CREATE OBJECT mein_auto.
*  mein_auto->kennz = nr.
*  mein_auto->owner = own1.
*  mein_auto->akt_ort = ort.
*  mein_auto->change_owner( own2 ).
*  WRITE: / 'Besitzer :', own2 .


*INTERFACE lif.
*  METHODS: bezahlen.
*  DATA: farbe TYPE string.
*ENDINTERFACE.
**
*CLASS pkw DEFINITION.
*  PUBLIC SECTION.
*    METHODS:
*      fahren,
*      tanken,
*      get_farbe RETURNING VALUE(re_farbe) TYPE string.
*  PROTECTED SECTION.
*    DATA:
*      km
*        TYPE i,
*      farbe TYPE string.
*ENDCLASS.
*
*CLASS pkw IMPLEMENTATION.
*  METHOD fahren.
*  ENDMETHOD.
*  METHOD tanken.
*  ENDMETHOD.
*ENDCLASS.
*
*CLASS taxi DEFINITION INHERITING FROM pkw.
*  PUBLIC SECTION.
*    INTERFACES: lif.
*    METHODS:
*      fahren REDEFINITION,
*      tanken REDEFINITION,
*      get_km RETURNING VALUE(re_km) TYPE i.
*ENDCLASS.
*
*CLASS taxi IMPLEMENTATION.
*  METHOD fahren.
*    "
*  ENDMETHOD.
*  METHOD tanken.
*  ENDMETHOD.
*  METHOD lif~bezahlen.
*    "
*  ENDMETHOD.
*ENDCLASS.
*
*START-OF-SELECTION.
*  DATA:
*    my_pkw  TYPE REF TO pkW,
*    my_taxi TYPE REF TO taxi,
*    my_lif  TYPE REF TO lif.
*  CREATE OBJECT: my_pkw, my_taxi.
*  my_lif = my_taxi.
*  WRITE: / my_lif->farbe, my_taxi->km, my_pkw->farbe.

INTERFACE j.
  EVENTS: e.
  METHODS: ma,
    on_e FOR EVENT e OF j.
  DATA: count TYPE i.
ENDINTERFACE.
CLASS k DEFINITION.
  PUBLIC SECTION.
    INTERFACES: j.
    METHODS:
      ma,
      constructor IMPORTING im_limit TYPE i.
  PRIVATE SECTION.
    DATA: limit TYPE i VALUE 9.
ENDCLASS.
CLASS k IMPLEMENTATION.
  METHOD constructor.
    limit = im_limit.
    SET HANDLER j~on_e FOR me.
  ENDMETHOD.
  METHOD ma.
    WHILE j~count < limit.
      WRITE: j~count.
      ADD 1 TO j~count.
    ENDWHILE.
    RAISE
    EVENT j~e.
  ENDMETHOD.
  METHOD j~ma.
    WHILE j~count > 0.
      WRITE: j~count.
      SUBTRACT 1 FROM j~count.
    ENDWHILE.
    RAISE
    EVENT j~e.
  ENDMETHOD.
  METHOD j~on_e.
    WRITE: 'ok'. SKIP.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  DATA:
  k_ref TYPE REF TO k.
  PARAMETERS:
  P_limit TYPE i DEFAULT 5.
  CREATE OBJECT k_ref
    EXPORTING
      im_limit = p_limit.
  k_ref->j~count = 3.
  CALL METHOD : k_ref->j~ma, k_ref->ma.


INTERFACE lif_organisation.

ENDINTERFACE.

INTERFACE lif_NatuerlichePerson.
  METHODS:
    name
      RETURNING VALUE(re_name) TYPE string,
    istAngestelltBei
      IMPORTING
                im_organisation       TYPE string
      RETURNING VALUE(re_employed) TYPE xfeld. "xfeld als Datenelement, da der eigentliche Typ Boolean, also TRUE/FALSE bzw. ' ' ider 'X' ist
ENDINTERFACE.

CLASS lcl_Praesident DEFINITION.
  PUBLIC SECTION.
    INTERFACES: lif_NatuerlichePerson.

    DATA:
      vorname  TYPE string,
      nachname TYPE string.
ENDCLASS.

CLASS lcl_Praesident IMPLEMENTATION.
  METHOD lif_NatuerlichePerson~name.
    WRITE: / 'Der Name lautet:'. "passendes Datenelement/Attribut einfügen, jenachdem was definiert bzw. über Parameters mitgeliefert wird
  ENDMETHOD.
  METHOD lif_NatuerlichePerson~istAngestelltBei.
    WRITE: / 'Die Person ist angestllt bei:'. "auch hier ein passendes Datenelement/Attribut für im_organisation einfügen, jenachdem was definiert bzw. über Parameters mitgeliefert wird
  ENDMETHOD.
ENDCLASS.
