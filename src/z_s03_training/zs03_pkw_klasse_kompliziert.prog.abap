*&---------------------------------------------------------------------*
*& Report ZS03_PKW_KLASSE_KOMPLIZIERT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs03_pkw_klasse_kompliziert.

CLASS pkw DEFINITION.
  PUBLIC SECTION.
    METHODS:
      set_kennz
        IMPORTING im_kz TYPE string,
      set_anzsitze
        IMPORTING im_anzs TYPE i,
          fahren
          IMPORTING im_kmst TYPE i
          im_dist TYPE i
          im_ziel TYPE string,
      show_attributes.
    DATA:
      farbe TYPE string.
*  PRIVATE SECTION.
    DATA:
      kennz    TYPE string,
      anzsitze TYPE i,
      kmst TYPE i,
    dist TYPE i,
    ziel TYPE string.
ENDCLASS.
*
CLASS pkw IMPLEMENTATION.
  METHOD show_attributes.
    WRITE: / 'Farbe:', farbe, 'Kennzeichen:', kennz, 'Anzahl der Sitzplätze:', anzsitze, 'Kilometerstand:',
    kmst, 'Fahren nach:', ziel, 'Kilometerstand:', kmst.
  ENDMETHOD.
  METHOD set_kennz.
    kennz = im_kz.
  ENDMETHOD.
  METHOD set_anzsitze.
    anzsitze = im_anzs.
  ENDMETHOD.
  METHOD fahren.
    kmst = im_kmst + im_dist.
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

  CALL METHOD mein_auto->set_anzsitze
    EXPORTING
      im_anzs = '4'.
  CALL METHOD mein_auto->show_attributes.
