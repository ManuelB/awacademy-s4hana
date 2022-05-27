*&---------------------------------------------------------------------*
*& Report ZS03_PKW_KLASSE_RAINER
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZS03_PKW_KLASSE_RAINER.

*CLASS pkw DEFINITION.
*  PUBLIC SECTION.
*    METHODS:
*      set_kennz
*        IMPORTING im_kz TYPE string,
*      show_attributes.
*    DATA:
*      farbe TYPE string.
*    PRIVATE SECTION.
*    DATA:
*      kennz TYPE string.
*ENDCLASS.
**
*CLASS pkw IMPLEMENTATION.
*  METHOD show_attributes.
*    WRITE: / 'Farbe:', farbe, 'Kennzeichen:', kennz.
*  ENDMETHOD.
*  METHOD set_kennz.
*    kennz = im_kz.
*    ENDMETHOD.
*ENDCLASS.
** Hauptprogramm
*DATA:
*  mein_auto TYPE REF TO pkw.
**
*START-OF-SELECTION.
*  CREATE OBJECT mein_auto.
*  mein_auto->farbe = 'rot'.
* " mein_auto->kennz = 'A-RK 1024'.
*  CALL METHOD mein_auto->set_kennz
*    EXPORTING im_kz = 'A-RK 1024'.
*  CALL METHOD mein_auto->show_attributes.

****  CORRECTION FAHREN RAINER
  CLASS pkw DEFINITION.
  PUBLIC SECTION.
    METHODS:
      set_kennz
        IMPORTING im_kz TYPE string,
      fahren
        IMPORTING
          im_ziel TYPE string
          im_dist TYPE i,
      show_attributes.
    DATA:
      farbe TYPE string.
  PRIVATE SECTION.
    DATA:
      akt_ort TYPE string,
      km_stand TYPE i,
      kennz    TYPE string.
ENDCLASS.
*
CLASS pkw IMPLEMENTATION.
  METHOD show_attributes.
    WRITE: / 'Farbe:', farbe, 'Kennzeichen:', kennz,
           'akt. Ort:', akt_ort, 'km:', km_stand.
  ENDMETHOD.
  METHOD set_kennz.
    kennz = im_kz.
  ENDMETHOD.
  METHOD fahren.
    akt_ort = im_ziel.
    km_stand = km_stand + im_dist.
  ENDMETHOD.
ENDCLASS.
* Hauptprogramm
DATA:
  mein_auto TYPE REF TO pkw.
*
START-OF-SELECTION.
  CREATE OBJECT mein_auto.
  mein_auto->farbe = 'rot'.
  " mein_auto->kennz = 'A-RK 1024'.
  CALL METHOD mein_auto->set_kennz
    EXPORTING
      im_kz = 'A-RK 1024'.
  CALL METHOD mein_auto->show_attributes.
  call METHOD mein_auto->fahren
    EXPORTING
      im_ziel = 'Augsburg'
      im_dist = 30.
   CALL METHOD mein_auto->show_attributes.
  call METHOD mein_auto->fahren
    EXPORTING
      im_ziel = 'München'
      im_dist = 85.
  CALL METHOD mein_auto->show_attributes.
