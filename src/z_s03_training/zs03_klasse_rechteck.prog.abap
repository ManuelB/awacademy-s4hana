*&---------------------------------------------------------------------*
*& Report ZS03_KLASSE_RECHTECK
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZS03_KLASSE_RECHTECK.


class Rechteck DEFINITION.

  PUBLIC SECTION.
  METHODS:
  constructor
  IMPORTING
    im_l type p
    im_b type p,
    show_flaeche
    importing im_l type p
    im_b type p,
    show_umfang
  importing im_l type p
    im_b type p
      exceptions
        null.
 PRIVATE SECTION.
      DATA:
            laenge TYPE p decimals 2,
            breite TYPE p decimals 2,
            flaeche TYPE p decimals 2,
            umfang type f.


      ENDCLASS.

class Rechteck IMPLEMENTATION.
  METHOD  constructor.
    laenge = im_l.
    breite = im_b.
    ENDMETHOD.
   METHOD show_umfang.
    if im_l = 0 or im_b = 0.
       raise null.
      else.
        umfang = 2 * ( im_b + im_l ).
        WRITE: / 'Länge:', laenge, 'Breite:', breite, 'umfang:', umfang.
     ENDIF.
    ENDMETHOD.
    METHOD show_flaeche.
      if im_l = 0 or im_b = 0.
       raise null.
      else.
        breite = im_l * im_b.
    WRITE: / 'Länge:', laenge, 'Breite:', breite, 'Fläche:', flaeche.
    endif.
    ENDMETHOD.
  ENDCLASS.

* Hauptprogramm

  parameters:
p_laenge type p DECIMALS 2,
p_breite TYPE p DECIMALS 2.
  Data: mein_rechteck TYPE REF TO Rechteck.


  START-OF-SELECTION.
  create OBJECT mein_rechteck
  exporting
    im_l = p_laenge
    im_b = p_breite.
  EXCEPTIONS
      null   = 1
      OTHERS = 99.
  CASE sy-subrc.
    WHEN 0. CALL METHOD mein_rechteck->show_attributes.
    WHEN 1. WRITE: / 'Kein Rechteck'.
    WHEN OTHERS. WRITE: / 'irgendein Fehler'.
  ENDCASE.

  call METHOD mein_rechteck->show_flaeche.
im_l = 3.
    im_b = 5.

  call METHOD mein_rechteck->show_umfang.
  im_l = 3.
    im_b = 5.
