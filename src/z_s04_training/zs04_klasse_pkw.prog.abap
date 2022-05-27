*&---------------------------------------------------------------------*
*& Report ZS04_PKW_KLASSE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs04_klasse_pkw.

*Deklaration der Klasse, Sichtbarkeiten von Komponenten, Definition von Datentypen, Methoden etc.
CLASS pkw DEFINITION.

  PUBLIC SECTION.

    METHODS:
      set_kennz    IMPORTING im_kz      TYPE string,
      set_kmstand0 IMPORTING im_kmstand TYPE i,
      set_startort IMPORTING im_ort     TYPE string,
      fahren       IMPORTING im_ziel TYPE string
                             im_dist TYPE i,
      show_attributes.

    DATA farbe TYPE string.


  PRIVATE SECTION.

    DATA: kennz    TYPE string,
          akt_ort  TYPE string,
          ziel_ort TYPE string,
          km_stand TYPE i.

ENDCLASS.

*Implementierung des Quellcodes der einzelnen Methoden
CLASS pkw IMPLEMENTATION.

  METHOD show_attributes.
    WRITE: / 'Farbe:', farbe, '|', 'Kennzeichen:', kennz, '|', 'Akt. Ort:', akt_ort, '|', 'Ziel-Ort:', ziel_ort, '|', 'KM-Stand:', km_stand.
    ULINE.
  ENDMETHOD.

  METHOD set_kennz.
    kennz = im_kz.
  ENDMETHOD.

  METHOD set_kmstand0.
    km_stand = im_kmstand.
  ENDMETHOD.

  METHOD set_startort.
    akt_ort = im_ort.
  ENDMETHOD.

  METHOD fahren.
    ziel_ort = im_ziel.
    km_stand = km_stand + im_dist.
  ENDMETHOD.

ENDCLASS.



**********************************************************************
*Hauptprogramm

DATA mein_auto TYPE REF TO pkw.

START-OF-SELECTION.

  CREATE OBJECT mein_auto.


  mein_auto->farbe = 'Estoril-Blau'.
*  mein_auto->kennz = 'M-DB 89'.

  CALL METHOD mein_auto->set_kennz EXPORTING im_kz = 'M-DB 89'.
  CALL METHOD mein_auto->set_startort EXPORTING im_ort = 'München'.
  CALL METHOD mein_auto->set_kmstand0 EXPORTING im_kmstand = 18345.
  CALL METHOD mein_auto->show_attributes.

  CALL METHOD mein_auto->set_startort EXPORTING im_ort = 'München'.
  CALL METHOD mein_auto->fahren EXPORTING im_ziel = 'Rosenheim' im_dist = 69.
  CALL METHOD mein_auto->show_attributes.

  CALL METHOD mein_auto->set_startort EXPORTING im_ort = 'Rosenheim'.
  CALL METHOD mein_auto->fahren EXPORTING im_ziel = 'Innsbruck' im_dist = 110.
  CALL METHOD mein_auto->show_attributes.

  CALL METHOD mein_auto->set_startort EXPORTING im_ort = 'Innsbruck'.
  CALL METHOD mein_auto->fahren EXPORTING im_ziel = 'München' im_dist = 164.
  CALL METHOD mein_auto->show_attributes.
