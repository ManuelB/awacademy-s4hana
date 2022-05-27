*&---------------------------------------------------------------------*
*& Report Z_S05_XPROBE2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_XPROBE2.


INCLUDE z_t04_i_flugdaten.

*DATA ls_spfli   TYPE spfli   .
DATA ls_sflight TYPE sflight .
*DATA ls_scarr   TYPE  scarr   .
DATA ls_sbook   TYPE sbook   .
DATA ls_scustom TYPE scustom .
*DATA ls_scounter TYPE scounter.
*DATA ls_SBUSPART TYPE  SBUSPART.
DATA lt_sbook_result TYPE TABLE OF sbook.

TABLES scustom.

DATA ls_custom TYPE scustom.
DATA total TYPE p DECIMALS 2.

SELECT-OPTIONS so_scust FOR scustom-id DEFAULT 00000001 NO INTERVALS.

SORT lt_scustom BY id.

 LOOP AT lt_scustom INTO ls_custom WHERE id IN so_scust.
 WRITE: / |{ ls_custom-form } { ls_custom-name } |.
 WRITE: /.
 WRITE: / |Stadt: { ls_custom-city }|.
 WRITE: /.
 ULINE.


 APPEND ls_scustom to lt_scustom.

ENDLOOP.
IF sy-subrc NE 0.
  MESSAGE |"Fehler: Falshe Kundennummer!"| TYPE 'S'.
  ENDIF.



  RANGES lr_forc FOR sbook-forcuram.
  DATA lr_curr TYPE sbook-forcurkey VALUE 'EUR'.
  DATA lv_punkte TYPE i.

  lr_forc-sign = 'I'.
  lr_forc-option = 'BT'.
  lr_forc-low = 600.
  lr_forc-high = 800.
  APPEND lr_forc TO lr_forc.



  LOOP AT lt_sbook INTO ls_sbook
    WHERE forcuram IN lr_forc
    AND forcurkey EQ lr_curr
    AND customid IN so_scust.

IF ls_sbook-forcuram GT 600.
  lv_punkte = 100.
  ENDIF.

    WRITE: / |{ ls_sbook-forcuram } { ls_sbook-forcurkey } |.
    WRITE: /.
 WRITE: / |Der Kunde hat für diesen Flug { lv_punkte } Punkte erhalten|.
 WRITE: /.
 ULINE.
 APPEND ls_scustom to lt_scustom.

ENDLOOP.
IF sy-subrc NE 0.
  WRITE: / |Der Kunde hat noch keine Bonuspunkte|.
  ENDIF.



    APPEND ls_sbook TO lt_sbook_result.



    BREAK-POINT.
