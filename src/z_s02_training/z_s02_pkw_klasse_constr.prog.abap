*&---------------------------------------------------------------------*
*& Report Z_S02_PKW_KLASSE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s02_pkw_klasse_constr.


***** constructor:automatically called when the class is being used

***** Definition *****
***** hier Parameter definieren.
CLASS pkw DEFINITION.     "Schnittstelle - Blackboxsicht
  PUBLIC SECTION.
    METHODS:
        constructor
        IMPORTING
          im_kz  TYPE string DEFAULT 'B-XX 9876'
          im_ort TYPE string,
      set_kennz
        IMPORTING im_kz TYPE string,
      get_kennz
        EXPORTING ex_kz TYPE string,
      fahren
        IMPORTING
          im_ziel TYPE string
          im_dist TYPE i
          EXCEPTIONS
            zu_weit,
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
  METHOD constructor.
    kennz = im_kz.
    akt_ort = im_ort.
    ENDmethod.
  METHOD set_kennz.
    kennz = im_kz.
  ENDMETHOD.
  METHOD get_kennz.
    ex_kz = kennz.
  ENDMETHOD.
  METHOD fahren.
    IF im_dist >= 400.
      RAISE zu_weit.
    ELSE.
      akt_ort = im_ziel.
      km_stand = km_stand + im_dist.
    ENDIF.
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
  CREATE OBJECT mein_auto
  Exporting
    im_kz = 'A-BC 999'
    im_ort = 'Berlin'.
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
      im_dist = '30'
      EXCEPTIONS zu_weit = 3
        OTHERS = 99.
  case sy-subrc.
       WHEN 0. CALL METHOD mein_auto->show_attributes.
    WHEN 3. WRITE: / 'Reichweite überschritten' COLOR COL_NEGATIVE.
    WHEN OTHERS. WRITE: / 'irgendein Fehler'.
    ENDCASE.

  CALL METHOD mein_auto->fahren
    EXPORTING
      im_ziel = 'Honolulu'
      im_dist = '14000'.

  CALL METHOD mein_auto->show_attributes.
