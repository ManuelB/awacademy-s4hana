*&---------------------------------------------------------------------*
*& Report ZS06_PKW_UBUNG
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs06_pkw_ubung.

CLASS pkw1 DEFINITION.
  PUBLIC SECTION."<-can be disp
    METHODS:
      constructor
        IMPORTING
          im_kz   TYPE string DEFAULT 'pkw1'    "kennzeichnen
          im_kmsa TYPE i DEFAULT 5              "km insgesamt
          im_kmst TYPE i                        "km tages
          im_sprm TYPE i DEFAULT 25             "sprit im tank
          im_ort  TYPE string DEFAULT 'Raubling'"Start Ort
          im_zeil TYPE string,

      set_kennz
        EXPORTING im_kz TYPE string,get_kennz,
      set_kmsa
        EXPORTING im_kmsa TYPE i, get_kmsa,
      set_kmst
        EXPORTING im_kmst TYPE i, get_kmst,
      set_sprm
        EXPORTING im_sprm TYPE i, get_sprm,
      set_ort
        EXPORTING im_ort TYPE string, get_ort,
      set_ziel
        EXPORTING im_ziel TYPE string, get_ziel.

  PRIVATE SECTION."<- cannot be disp
    DATA:

      voltank TYPE i VALUE 25,
      trip    TYPE i.

ENDCLASS.
CLASS pkw2 DEFINITION.
  PUBLIC SECTION."<-can be called to action
    METHODS:
      constructor
        IMPORTING
          im_kz   TYPE string DEFAULT 'pkw2'    "kennzeichnen
          im_kmsa TYPE i DEFAULT 5              "km insgesamt
          im_kmst TYPE i                        "km tages
          im_sprm TYPE i DEFAULT 25             "sprit im tank
          im_ort  TYPE string DEFAULT 'Raubling'"Start Ort
          im_zeil TYPE string,

      set_kennz
        IMPORTING im_kz TYPE string,get_kennz,
      set_kmsa
        IMPORTING im_kmsa TYPE i, get_kmsa,
      set_kmst
        IMPORTING im_kmst TYPE i, get_kmst,
      set_sprm
        IMPORTING im_sprm TYPE i, get_sprm,
      set_ort
        IMPORTING im_ort TYPE string, get_ort,
      set_ziel
        IMPORTING im_ziel TYPE string, get_ziel.

  PRIVATE SECTION."<- cannot be called to action
    DATA:
      voltank TYPE i VALUE 25,
      trip    TYPE i.

ENDCLASS.
CLASS pkw3 DEFINITION.
  PUBLIC SECTION."<-can be called to action
    METHODS:
      constructor
        IMPORTING
          im_kz   TYPE string DEFAULT 'pkw3'    "kennzeichnen
          im_kmsa TYPE i DEFAULT 5              "km insgesamt
          im_kmst TYPE i                        "km tages
          im_sprm TYPE i DEFAULT 25             "sprit im tank
          im_ort  TYPE string DEFAULT 'Raubling'"Start Ort
          im_zeil TYPE string,

      set_kennz
        IMPORTING im_kz TYPE string,get_kennz,
      set_kmsa
        IMPORTING im_kmsa TYPE i, get_kmsa,
      set_kmst
        IMPORTING im_kmst TYPE i, get_kmst,
      set_sprm
        IMPORTING im_sprm TYPE i, get_sprm,
      set_ort
        IMPORTING im_ort TYPE string, get_ort,
      set_ziel
        IMPORTING im_ziel TYPE string, get_ziel.

  PRIVATE SECTION."<- cannot be called to action
    DATA:
      voltank TYPE i VALUE 25,
      trip    TYPE i.

ENDCLASS.

CLASS pkw IMPLEMENTATION.

  METHOD constructor.
    kz =    im_kz.
    kmsa =  im_kmsa.
    kmst =  im_kmst.
    sprm =  im_sprm.
    ort =   im_ort.
    ziel =  im_ziel,
  ENDMETHOD.

  METHOD show_attributes.

    WRITE: /
    'KZ:', kz,
    'ODO:', kmsa,
    'Abstand gefahren:', kmst,
    'Losgefahren von:', ort,
    'Angekommen im:', ziel,
    'Sprit Ubrig:', inhalt.

  ENDMETHOD.
  METHOD kennz.

START-OF-SELECTION."auswahlen welche pkw

  CASE 'X'.
    WHEN pkw1.
      CALL METHOD pkw1."PKW1

    WHEN pkw2.
      CALL METHOD pkw2."PKW2

    WHEN pkw3.
      CALL METHOD pkw3. "PKW3

      exporting
      im_kz = kz
      im_kmsa = kmsa
      im_kmst = kmst
      im_sprm = sprm
      im_ort = ort
      im_ziel = zeil.
  ENDCASE.

ENDCLASS.
* Hauptprogramm
PARAMETERS:
  pkw_1    RADIOBUTTON GROUP rb_1,
  pkw_2    RADIOBUTTON GROUP rb_1,
  pkw_2    RADIOBUTTON GROUP rb_1,
  wie_weid TYPE i DEFAULT 0.


DATA:
wir_fahren TYPE REF TO pkw.
*
START-OF-SELECTION.
  CREATE OBJECT wir_fahren.
  "EXPORTING "im_kz = 'A-BC 999'
  "im_ort = 'Berlin'.
  mein_auto->farbe = 'rot'.
  " mein_auto->kennz = 'A-RK 1024'.
  CALL METHOD mein_auto->show_attributes.
  CALL METHOD mein_auto->set_kennz
    EXPORTING
      im_kz = 'A-RK 1024'.
* Methode mit Returning-Parameter:
*  CALL METHOD mein_auto->get_kennz
*    RECEIVING re_kz = akt_kz.
*    akt_kz = mein_auto->get_kennz( ).
  WRITE: /5 'returning kz:', mein_auto->get_kennz( ).

  CALL METHOD mein_auto->show_attributes.
  CALL METHOD mein_auto->fahren
    EXPORTING
      im_ziel = 'Augsburg'
      im_dist = p_dist
    EXCEPTIONS
      zu_weit = 3
      OTHERS  = 99.
  CASE sy-subrc.
    WHEN 0.
      CALL METHOD mein_auto->show_attributes.
    WHEN 3.
      WRITE: / 'Reichweite überschritten' COLOR COL_NEGATIVE.
    WHEN OTHERS.
      WRITE: / 'irgendein Fehler'.
  ENDCASE.
