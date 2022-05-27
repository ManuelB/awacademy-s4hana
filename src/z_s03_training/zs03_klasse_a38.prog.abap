*&---------------------------------------------------------------------*
*& Report ZS03_KLASSE_A38
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs03_klasse_a38.

CLASS pkw DEFINITION.
  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          im_kz  TYPE string
          im_ort TYPE string OPTIONAL,
      set_kennz
        IMPORTING im_kz TYPE string,
      get_kennz
        RETURNING VALUE(re_kz) TYPE string,
      fahren_nach
        IMPORTING
          im_ziel TYPE string
          im_dist TYPE i,
      get_kmstand_tag
        RETURNING VALUE(re_kmt) TYPE i,
      get_kmstand_abs
        RETURNING VALUE(re_km) TYPE i,
      tanken
        IMPORTING  im_menge TYPE i DEFAULT '20'
        EXCEPTIONS
                   einmal_tanken,
                   show_attributes.

  PRIVATE SECTION.
    DATA:
      inhalt   TYPE i,
      akt_ort  TYPE string,
      km_stand TYPE i,
      kennz    TYPE string.
ENDCLASS.
*
CLASS pkw IMPLEMENTATION.
  METHOD constructor.
    kennz = im_kz.
    akt_ort = im_ort.
  ENDMETHOD.
  METHOD show_attributes.
    WRITE: /  'Kennzeichen:', kennz,
           'akt. Ort:', akt_ort, 'km:', km_stand,
           'akt. Inhalt:', inhalt.
  ENDMETHOD.
  METHOD set_kennz.
    kennz = im_kz.
  ENDMETHOD.
*  METHOD get_kennz.
*    re_kz = kennz.
*  ENDMETHOD.
  METHOD fahren_nach.


ENDMETHOD.
METHOD tanken.
  inhalt = inhalt + im_menge.
  IF inhalt <= 5.
    RAISE einmal_tanken.
  ELSE.
    akt_ort = im_ziel.
    km_stand = km_stand + im_dist.
  ENDMETHOD.
ENDCLASS.
* Hauptprogramm
PARAMETERS:
  p_dist1 TYPE i,
  p_ziel1 TYPE string,
  p_dist2 TYPE i,
  p_ziel2 TYPE string,
  p_dist3 TYPE i,
  p_ziel3 TYPE string.

DATA:

  mein_auto1 TYPE REF TO pkw.
mein_auto2 type ref to pkw.
mein_auto3 type ref to pkw.
*
START-OF-SELECTION.
  CREATE OBJECT mein_auto1
    EXPORTING
      im_menge          = '25'
      im_ort            = 'München'
      mein_auto1->kennz = 'CB-1'.
  CALL METHOD mein_auto->show_attributes.
  CALL METHOD mein_auto->set_kennz
    EXPORTING
      im_kz = 'CB-1'.
* Methode mit Returning-Parameter:
*  CALL METHOD mein_auto->get_kennz
*    RECEIVING re_kz = akt_kz.
*    akt_kz = mein_auto->get_kennz( ).
  WRITE: /5 'returning kz:', mein_auto->get_kennz( ).


  CALL METHOD mein_auto1->fahren
    EXPORTING
      im_ziel       = 'Augsburg'
      im_dist       = p_dist
    EXCEPTIONS
      einmal_tanken = 3
      OTHERS        = 99.
  CASE sy-subrc.
    WHEN 0.
      CALL METHOD mein_auto->show_attributes.
    WHEN 3.
      WRITE: / 'Bitte einmal tanken' COLOR COL_NEGATIVE.
    WHEN OTHERS.
      WRITE: / 'irgendein Fehler'.
  ENDCASE.
