*&---------------------------------------------------------------------*
*& Report Z_S02_PKW_KLASSE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s02_pkw_klasse.


***** Definition *****
***** hier Parameter definieren.
CLASS pkw DEFINITION.     "Schnittstelle - Blackboxsicht
  PUBLIC SECTION.
    METHODS:
      set_kennz
        IMPORTING im_kz TYPE string,
      get_kennz
        EXPORTING ex_kz TYPE string,
      fahren
        IMPORTING
          im_ziel TYPE string
          im_dist TYPE i,
      show_attributes
      .
    DATA:
      farbe TYPE string.
  PRIVATE SECTION.
    DATA:
      akt_ort  TYPE string,
      km_stand TYPE i,
      kennz    TYPE string.

ENDCLASS.


***** Implementation *****
CLASS pkw IMPLEMENTATION.
  METHOD set_kennz.
    kennz = im_kz.
  ENDMETHOD.
  METHOD get_kennz.
    ex_kz = kennz.
  ENDMETHOD.
  METHOD fahren.
    akt_ort = im_ziel.
    km_stand = km_stand + im_dist.
  ENDMETHOD.

  METHOD show_attributes.
    WRITE: /
    'Farbe:', farbe,
    'Kennzeichen', kennz,
    'Aktueller Ort', akt_ort,
    'Km-Stand', km_stand.
  ENDMETHOD.

ENDCLASS.


***** Hauptprogramm *****
DATA:
      mein_auto TYPE REF TO pkw.    "Objektreferenz


START-OF-SELECTION.
  CREATE OBJECT mein_auto.
  mein_auto->farbe = 'rot'.
*  mein_auto->kennz = 'EBE-EB383'.
  CALL METHOD mein_auto->show_attributes.

  CALL METHOD mein_auto->set_kennz
    EXPORTING
      im_kz = 'EBE-EB383'.
  CALL METHOD mein_auto->show_attributes.
  CALL METHOD mein_auto->fahren
    EXPORTING
      im_ziel = 'Piusheim'
      im_dist = '30'.

  CALL METHOD mein_auto->fahren
    EXPORTING
      im_ziel = 'Honolulu'
      im_dist = '14000'.

  CALL METHOD mein_auto->show_attributes.
