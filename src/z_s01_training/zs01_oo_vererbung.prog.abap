*&---------------------------------------------------------------------*
*& Report ZS01_OO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs01_oo.

*Oberklasse
CLASS lcl_beleg DEFINITION.
  PUBLIC SECTION.
    METHODS: constructor IMPORTING im_st_const TYPE c. "Optional.
    METHODS: close.
    METHODS: set_status IMPORTING im_st TYPE c.
    METHODS: get_status RETURNING VALUE(re_st) TYPE string.

*PRIVATE SECTION.

  PROTECTED SECTION." ALLE ERBEN KÖNNEN DIE ATTRIBUTE VERWENDEN. Private Section der erbenen Unterklassen.

    CONSTANTS: c_open TYPE c VALUE '0'.
    CONSTANTS: c_pending TYPE c VALUE 'P'.
    CONSTANTS: c_closed TYPE c VALUE 'c'.

    DATA status TYPE c VALUE c_open.
ENDCLASS.


CLASS lcl_beleg IMPLEMENTATION.

  METHOD constructor.
    me->set_status( im_st = im_st_const ).
  ENDMETHOD.

  METHOD close.
*    Zeigt auf aktuelle referanz
    me->set_status( im_st = c_closed ).
    me->status = c_closed.
    WRITE:/ |Beleg wurden geschlossen.|.

  ENDMETHOD.


  METHOD set_status.
    me->status = im_st.
  ENDMETHOD.

  METHOD get_status.
    re_st = me->status.
  ENDMETHOD.

ENDCLASS.














*Unterklasse
CLASS lcl_gutschrift DEFINITION INHERITING FROM lcl_beleg.
  PUBLIC SECTION.


*  Polymorphie durch Redefinition von Methoden
    METHODS: close REDEFINITION.

ENDCLASS.


CLASS lcl_gutschrift IMPLEMENTATION.

  METHOD close.

    me->set_status( im_st = c_closed ).
    WRITE: 'Gutschrift wurde geschlossen'.

  ENDMETHOD.

ENDCLASS.












CLASS lcl_Rechnung DEFINITION INHERITING FROM lcl_beleg.
  PUBLIC SECTION.

    METHODS: close REDEFINITION.
    METHODS: pay.

ENDCLASS.



CLASS lcl_rechnung IMPLEMENTATION.
   METHOD close.
    me->pay( ).
    me->set_status( im_st = c_closed ).
    WRITE: 'Rechnung wurde geschlossen'.
  ENDMETHOD.

*Eigene Methode in der Unterklasse.
  METHOD pay.

    WRITE: / 'Rechnung wurde bezahlt'.

  ENDMETHOD.

ENDCLASS.



*Aufruf
START-OF-SELECTION.

*HIER WERDEN DIE SPEICHERORTE für die OBJEKTE DEKLARIERT:
  DATA lo_beleg TYPE REF TO lcl_beleg.
  DATA lo_gutschrift TYPE REF TO lcl_beleg.
  DATA lo_rechnung TYPE REF TO lcl_rechnung.

*  Neue Varaiante. Besser. HIER WERDEN DIE OBJEKTE ERSTELLT.
  lo_beleg = NEW lcl_beleg( im_st_const = 'P' ).
  lo_gutschrift = NEW lcl_gutschrift( im_st_const = 'P' ).
  lo_rechnung = NEW lcl_rechnung( im_st_const = 'P' ).


*Call Methode unnötg.
  lo_beleg->close( ).
  WRITE:/ | Beleg STATUS: { lo_beleg->get_status( ) } |.

  DATA(lv_test) = lo_beleg->get_status( ).

  lo_gutschrift->close( ).
  WRITE:/ | Gutschrift STATUS: { lo_gutschrift->get_status( ) } |.

  lo_rechnung->close( ).
  WRITE:/ | Rechnung STATUS: { lo_Rechnung->get_status( ) } |.

  lo_beleg->get_status( ).
  lo_gutschrift->get_status( ).
  lo_rechnung->get_status( ).



*  Nur im Deklarationsteil einer Klasse möglich. Definiert den Sichtbarkeitsbereich.
* PRIVATE SECTION
*  Sind nur in der Klasse selbst ansprechbar.

*  Protected Section
* sind nur in den Unterklassen der Klasse und in der Klasse selbst ansprechbar.


*PUBLIC SECTION.
*Sind von außerhalb der Klasse, in ihren Unterklassen und in der Klasse selbst ansprechbar.
