*&---------------------------------------------------------------------*
*& Report z_s12_assessment2_aufgabe_adt
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s12_assessment2_aufgabe_adt.

*Folgende Punkte:
*
*Nutzung von 2 Interfaces mit richtigen Namen (2 Punkte)
*Definition von 2 Methoden mit richtigen Signaturen im Interface (2 Punkte)
*Erstellung von Klasse mit richtigen Namen (1 Punkt)
*Implementierung eines Interfaces (1 Punkt)
*Erstellung von 2 Attributen mit richtigen Namen (2 Punkte)
*Nutzung der richtigen Signaturen der Methoden (2 Punkte)
*Korrekt Implementierung der 2 Methoden (2 Punkte)
*Nutzung von richtigen Modifiern (2 Punkte)
*Code kompiliert (1 Punkt)


INTERFACE li_auto.
  METHODS: besitzer IMPORTING im_owner TYPE string.
  METHODS: max_geschwindigkeit RETURNING VALUE(re_maxv) TYPE i.

ENDINTERFACE.

INTERFACE li_fahrzeug.
ENDINTERFACE.

CLASS lcl_TeslaModel3 DEFINITION.

  PUBLIC SECTION.
    INTERFACES li_auto.


    METHODS: vollgas.

    DATA batterie TYPE i.
    DATA nummernschild TYPE string.
    DATA Besitzer TYPE string.
    DATA Geschwindigkeit TYPE i.

ENDCLASS.



CLASS lcl_TeslaModel3 IMPLEMENTATION.
  METHOD li_auto~besitzer.
    me->li_auto~besitzer( im_owner = 'Elon Musk' ).
*Write: / 'Elon Musk'.
  ENDMETHOD.

  METHOD vollgas.
    WRITE: 'Wir geben vollgas'.
  ENDMETHOD.
  METHOD li_auto~max_geschwindigkeit.
*me->li_auto~geschwindigkeit( re_maxv = 9000. )
    re_maxv = 900.
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

  DATA lo_tesla TYPE REF TO lcl_teslamodel3.

  lo_tesla = NEW lcl_teslamodel3( ).
* Write:/ |Autobesitzer ist: {  } |.
 lo_tesla->li_auto~besitzer( im_owner = 'Horst' ).

* lo_tesla->li_auto~besitzer( im_owner = 'Horst' ).
  lo_tesla->li_auto~max_geschwindigkeit( ).
  lo_tesla->vollgas( ).
