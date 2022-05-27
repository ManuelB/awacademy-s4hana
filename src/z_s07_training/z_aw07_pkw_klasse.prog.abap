*&---------------------------------------------------------------------*
*& Report Z_AW07_PKW_KLASSE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_aw07_pkw_klasse.

CLASS pkw DEFINITION.
  PUBLIC SECTION.
    METHODS:

      set_kennz
        IMPORTING im_kz TYPE string,

      show_attributes.
    DATA:
      farbe TYPE string.
*  PRIVATE SECTION.
    DATA:
      kennz      TYPE string,
      anz_sitze  TYPE INT8,
      tankinhalt TYPE int8,
      kmstand    TYPE int8.
ENDCLASS.
*
CLASS pkw IMPLEMENTATION.
  METHOD show_attributes.
    WRITE: / 'Farbe:', farbe, 'Kennzeichen:', kennz.
    Write: / 'Anzahl Sitzte:', anz_sitze, 'Tankinhalt:', tankinhalt.
  ENDMETHOD.
  METHOD set_kennz.
    kennz = im_kz.
  ENDMETHOD.
ENDCLASS.
* Hauptprogramm
DATA:
  mein_auto TYPE REF TO pkw.
*
START-OF-SELECTION.
  CREATE OBJECT mein_auto.
  mein_auto->farbe = 'GRAU'.

  CALL METHOD mein_auto->set_kennz
    EXPORTING
      im_kz = 'EBE-HK 3101'.

*  CALL METHOD mein_auto->show_attributes.

  Create OBJECT mein_auto.
  mein_auto->anz_sitze = '5'.
