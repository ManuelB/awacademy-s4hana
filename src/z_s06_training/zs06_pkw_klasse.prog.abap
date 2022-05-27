*&---------------------------------------------------------------------*
*& Report ZS06_PKW_KLASSE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs06_pkw_klasse.

CLASS pkw DEFINITION."blackbox sicht, hier wird definiert

  "*******************************************************

  PUBLIC SECTION."sichbar von aussen

    METHODS:
    "constructor can only have imports
    constructor
    importing
      im_kz type string
      im_ort type string,
      set_kennz IMPORTING im_kz TYPE string,
      set_sitz IMPORTING im_sitz TYPE i,
      set_tank IMPORTING im_tank TYPE i,
      set_kms IMPORTING im_kms TYPE i,
      set_farb IMPORTING im_farb TYPE string.

    show_attributes.

    DATA:
    farbe TYPE string.

  PRIVATE SECTION.

    DATA:
      akt_ort  TYPE string,
      km_stand TYPE i,
      kennz    TYPE string.

ENDCLASS.

"*******************************************************

CLASS pkw IMPLEMENTATION."wie es implimitiert wird, was hier gemacht wird
  METHOD
    show_attributes.
    WRITE: / 'Farbe:', im_farb, 'Kennzeichen:', im_kz, 'Sitze:',im_sitz, 'Tankinhalt:', im_tank, 'KM Stand:',im_kms.
  ENDMETHOD.
  METHOD
    set_kennz.
    kennz = im_kz.
    km_stand = km_stand + im_kms.
  ENDMETHOD.
ENDCLASS.

"Hauptprogram

DATA:
      mein_auto TYPE REF TO pkw.  "object reference vereinbared. pkw ist die klasse

START-OF-SELECTION.  "<- muss HIER sein wegen alten ereignis Logic

  CREATE OBJECT mein_auto."erst hier wird das objekt erzeugt, speicher allokiert.

  mein_auto->farbe = 'SCHWARZ'.
  "mein_auto->kennz = 'RO-CK 999'.
  "mein_auto->anz_sitze = '5'.
  "mein_auto->tankinhalt = '25'.
  "mein_auto->kmstand = '1456'.
  CALL METHOD mein_auto->set_kennz
    EXPORTING
      im_kz = 'RO-ck_999'

              call METHOD mein_auto->show_attributes. "you can see this as"display current state

  "CONSTRUCTOR!! makes your code more secure
