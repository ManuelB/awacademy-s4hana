*&---------------------------------------------------------------------*
*& Report Z_S05_PKW_KLASSE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_PKW_KLASSE.
*


class pkw DEFINITION.
  PUBLIC SECTION. "+
  methods:
  constructor
  IMPORTING
    im_kz TYPE string
    im_ort TYPE string,
 set_kennz
        IMPORTING im_kz TYPE string,
*          verkaufen
*          IMPORTING
*            im_jahr TYPE i
*            im_altepreis TYPE z05_d
*            EXPORTING
*               EX_neuepreis TYPE z05_d
*               EX_bpreis TYPE z05_d
*            ex_factor TYPE z05_d.

          fahren
  IMPORTING
    im_ziel TYPE string
    im_dist TYPE i,
      show_attributes.
    DATA:
      farbe TYPE string.
    PRIVATE SECTION. "-
    DATA:
          inhalt type i,
          ak_ort type string,
       km_stand type i,
      kennz TYPE string.
ENDCLASS.

*
  class pkw IMPLEMENTATION.
    METHOD show_attributes.
          WRITE: / 'Farbe:', farbe, 'Kennzeichen:', kennz,
           'ak. Ort:', ak_ort, 'km:', km_stand,
           'ak. Inhalt:', inhalt.
      ENDMETHOD.
       METHOD set_kennz.
    kennz = im_kz.
    ENDMETHOD.
    METHOD fahren.

     ak_ort = im_ziel.
      km_stand = km_stand + im_dist.
       WRITE: / |ORT: { ak_ort }|,
       / |km: { km_stand }|.
      ENDMETHOD.
      method constructor.

        ak_ort = im_ort.
        kennz = im_kz.
         WRITE: / |ORT: { ak_ort }|,
       / |km: { kennz }|.
        endmethod.
* METHOD verkaufen.
*   if im_jahr < 2000.
*     ex_factor =  '1.5'.
*     ex_bpreis = im_altepreis * ex_factor.
*      ex_neuepreis = im_altepreis - ( im_altepreis - ex_bpreis ).
*      WRITE: |Alte Preis: { im_altepreis }|,
*      / |Neue Preis: { ex_neuepreis }|.
*       elseif im_jahr BETWEEN 2001 AND 2010.
*     ex_factor = '1,2'.
*      ex_bpreis = im_altepreis * ex_factor.
*      ex_neuepreis = im_altepreis - ( im_altepreis - ex_bpreis ).
*      WRITE: |Alte Preis: { im_altepreis }|,
*      / |Neue Preis: { ex_neuepreis }|.
*       elseif im_jahr > 2010.
*     ex_factor = '1,1'.
*      ex_bpreis = im_altepreis * ex_factor.
*      ex_neuepreis = im_altepreis - ( im_altepreis - ex_bpreis ).
*      WRITE: |Alte Preis: { im_altepreis }|,
*      / |Neue Preis: { ex_neuepreis }|.
*      ENDIF.
*
*     ENDMETHOD.

ENDCLASS.

*Hauptprogram
DATA:
      mein_auto TYPE REF TO pkw.

start-of-selection.
create object mein_auto
exporting
  im_kz = 'A_HP_1023'
  im_ort = 'Berlin'.
mein_auto->farbe = 'rot'.
"mein_auto->kennz = 'A_HP_1024'.
CALL METHOD mein_auto->set_kennz
EXPORTING im_kz = 'A_HP_1024'.
CALL METHOD mein_auto->show_attributes.
call method mein_auto->fahren
exporting
  im_ziel = 'Augsburg'
  im_dist = 30.
*call method mein_auto->verkaufen
*exporting
*  im_jahr = 2005
*im_altepreis = 20000.
