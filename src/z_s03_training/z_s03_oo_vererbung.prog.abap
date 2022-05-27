*&---------------------------------------------------------------------*
*& Report Z_S03_OO_VERERBUNG
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s03_oo_vererbung.

*********OBERKLASSE

CLASS lcl_beleg DEFINITION.
  PUBLIC SECTION.
    METHODS: constructor IMPORTING im_st_const TYPE c. "OPTIONAL.
*    si je mets optional ci dessus, qd je vais créer l'objet en dessous avec la nvelle écriture, il va me proposer
*    im_st = en option auskommentiert....
    METHODS: close.
    METHODS: set_status IMPORTING im_st TYPE c.
    METHODS: get_status RETURNING VALUE(re_st) TYPE string.
* man braucht set und get methoden, weil die Attribute nicht public sind.
*    get pour savoir ou on en est: va me chercher telle valeur...
  PROTECTED SECTION.
    CONSTANTS: c_open TYPE c VALUE 'O'.
    CONSTANTS: c_pending TYPE c VALUE 'P'.
    CONSTANTS: c_closed TYPE c VALUE 'C'.

    DATA status TYPE c VALUE c_open.

**** Pb: Dinge in der private section werden nicht vererbt.
ENDCLASS.

CLASS lcl_beleg IMPLEMENTATION.
  METHOD constructor.
    me->set_status( im_st = im_st_const ).
*    ich setze meinen Status. me ne peut s'employer que ds une méthode.
*    c l'équivalent de call method, mais à l'intérieur d'une méthode.
  ENDMETHOD.
  METHOD close.
    me->set_status( im_st = c_closed ).
    WRITE: |Beleg wurde geschlossen.|.
  ENDMETHOD.
  METHOD set_status.
    me->status = im_st.
  ENDMETHOD.
  METHOD get_status.
    re_st = me->status.
  ENDMETHOD.
ENDCLASS.

***********UNTERKLASSE

CLASS lcl_gutschrift DEFINITION INHERITING FROM lcl_beleg.
  PUBLIC SECTION.
*  Polymorphie durch Redefinition von Methoden
    METHODS: close REDEFINITION.
*  Pb qd on fait ca, tout ce qui est ds la private section n'est pas reconnu. Dc c_closed en dessous n'est pas reconnu.
*  on va transformer la private section en protected section.
ENDCLASS.
CLASS lcl_gutschrift IMPLEMENTATION.
  METHOD close.
    me->set_status( im_st = c_closed ).
    WRITE: |Gutschrift wurde geschlossen.|.
  ENDMETHOD.
ENDCLASS.

***********WEITERE UNTERKLASSE
CLASS lcl_rechnung DEFINITION INHERITING FROM lcl_beleg.
  PUBLIC SECTION.
  METHODS: close REDEFINITION.

  PRIVATE SECTION.
  METHODS: pay.
ENDCLASS.
CLASS lcl_rechnung IMPLEMENTATION.
  METHOD close.
*    hier unten rufe ich meine Methode pay auf. Mit me-> rufe ich eine Methode innerhalb einer Methode auf.
*    Wenn ich in der Methode pay die Methode pay aufrufe, dann bekomme ich eine endlose Schleife.
*    la machine fait les parenthèses tte seules si on appuie sur str + leerzeichen après pay, puis strg + shift + enter!
    me->pay( ).
    me->set_status( im_st = c_closed ).
    WRITE: |Rechnung wurde geschlossen.|.
  ENDMETHOD.
  METHOD pay.

    WRITE: |Rechnung wurde bezahlt.|.
    ENDMETHOD.
ENDCLASS.

********* AUFRUF

START-OF-SELECTION.

  DATA lo_beleg TYPE REF TO lcl_beleg.
  DATA lo_gutschrift TYPE REF TO lcl_gutschrift.
  DATA lo_rechnung TYPE REF TO lcl_rechnung.



  CREATE OBJECT lo_beleg
    EXPORTING
      im_st_const = 'P'.



*  ci-dessous, nouvelle facon de créer des objets. Attention de bien remplir le paramètre
*  im_st_const dans la Oberklasse ET Unterklasse, par ex 'C', sinon ca marchera pas.

*lo_beleg = NEW lcl_beleg( im_st_const = 'p' ).
  lo_gutschrift = NEW lcl_gutschrift( im_st_const = 'P' ).
  lo_rechnung = NEW lcl_rechnung( im_st_const = 'P' ).

********Call Mehtod: lo_beleg->close( ).ist überflüssig!

  lo_beleg->close( ).
  WRITE: |Beleg Status: { lo_beleg->get_status( ) }|.

  ULINE.

  lo_gutschrift->close( ).
  WRITE: |Gutschrift Status: { lo_gutschrift->get_status( ) }|.

  ULINE.

  lo_rechnung->close( ).
  WRITE: |Rechnung Status: { lo_rechnung->get_status( ) }|.
*  si je mets pas les parenthèses derriere get_status, la machine ne reconnaît pas une méthode, elle croit que c un Feld.
*  si on veut fonctionner sans get et set methode, il faut mettre ts les Attribute en public.
