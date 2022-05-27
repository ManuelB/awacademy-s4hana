*&---------------------------------------------------------------------*
*& Report ZS03_KLASSE_RECHTECK_CB
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs03_klasse_rechteck_cb.

CLASS rechteck DEFINITION.
  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          im_l TYPE p
          im_b TYPE p,
      set_flaeche
        IMPORTING  im_l TYPE p
                   im_b TYPE p
        EXCEPTIONS
                   null,
      set_umfang
        IMPORTING  im_l TYPE p
                   im_b TYPE p
        EXCEPTIONS
                   null,
      show_flaeche,
      show_umfang.


  PRIVATE SECTION.
    DATA:
      laenge  TYPE p DECIMALS 2,
      breite  TYPE p DECIMALS 2,
      flaeche TYPE p,
      umfang  TYPE p DECIMALS 2.

ENDCLASS.
*
CLASS rechteck IMPLEMENTATION.
  METHOD constructor.
    laenge = im_l.
    breite = im_b.
  ENDMETHOD.

  METHOD set_flaeche.

    IF im_l = 0 OR im_b = 0.
      RAISE null.
    ELSE.
      flaeche = 2 * ( im_l + im_b ).
    ENDIF.
  ENDMETHOD.
  METHOD set_umfang.

    IF im_l = 0 OR im_b = 0.
      RAISE null.
    ELSE.
      umfang = im_l * im_b.
    ENDIF.
  ENDMETHOD.
  METHOD show_flaeche.

    WRITE: / 'Länge:', laenge, 'Breite:', breite,
             'Fläche:', flaeche.

  ENDMETHOD.
  METHOD show_umfang.

    WRITE: / 'Länge:', laenge, 'Breite:', breite,
             'Umfang:', umfang.

  ENDMETHOD.


ENDCLASS.
* Hauptprogramm
PARAMETERS:
  p_laenge TYPE p DEFAULT 3,
  p_breite TYPE p DEFAULT 5.

DATA:

  mein_rechteck TYPE REF TO rechteck.
*
START-OF-SELECTION.
  CREATE OBJECT mein_rechteck
    EXPORTING
      im_l = p_laenge
      im_b = p_breite.

  CALL METHOD mein_rechteck->set_flaeche
    EXPORTING
      im_l   = p_laenge
      im_b   = p_breite
    EXCEPTIONS
      null   = 3
      OTHERS = 99.
  CASE sy-subrc.
    WHEN 0.
      CALL METHOD mein_rechteck->show_flaeche.
    WHEN 3. WRITE: / 'kein Rechteck' COLOR COL_NEGATIVE.
    WHEN OTHERS. WRITE: / 'irgendein Fehler'.
  ENDCASE.

  CALL METHOD mein_rechteck->set_umfang
    EXPORTING
      im_l   = p_laenge
      im_b   = p_breite
    EXCEPTIONS
      null   = 3
      OTHERS = 99.
  CASE sy-subrc.
    WHEN 0. CALL METHOD mein_rechteck->show_umfang.
    WHEN 3. WRITE: / 'kein Rechteck' COLOR COL_NEGATIVE.
    WHEN OTHERS. WRITE: / 'irgendein Fehler'.
  ENDCASE.

*On ne peut pas faire show_attributes pour umfang et Flaeche.
* Sinon le calcul ne sera pas complet pour les 2 lors du 1er show_attribute.
