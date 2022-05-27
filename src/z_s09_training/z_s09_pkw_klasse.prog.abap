*&---------------------------------------------------------------------*
*& Report Z_S09_PKW_KLASSE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s09_pkw_klasse.

CLASS pkw DEFINITION.
  PUBLIC SECTION.

    METHODS:
      set_kennz
        IMPORTING im_kz TYPE string,
          fahren
          IMPORTING
          im_ziel TYPE string
          im_dist TYPE i.

      show_attributes.
    DATA:
          farbe TYPE string.

  PRIVATE SECTION.
    DATA:
          akt_ort TYPe string,
          km_stand TYPei,
          kennz TYPE string,
    anzsitze TYPE i.


ENDCLASS.

CLASS pkw IMPLEMENTATION.
  METHOD show_attributes.
    WRITE: / 'Farbe:', farbe, 'Kennzeichen:', kennz.
  ENDMETHOD.
  METHOD set_kennz.
    kennz = im_kz.
  ENDMETHOD.
ENDCLASS.
"Hauptprogramm

DATA:

      mein_auto TYPE REF TO pkw.

START-OF-SELECTION.
  CREATE OBJECT mein_auto.
  mein_auto->farbe = 'rot'.
  "mein_auto->kennz = 'M-UC-1337'.
  CALL METHOD mein_auto->set_kennz
    EXPORTING
      im_kz = 'M-UC-1337'.
  CALL METHOD mein_auto->show_attributes.
