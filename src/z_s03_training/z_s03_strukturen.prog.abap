*&---------------------------------------------------------------------*
*& Report Z_S03_STRUKTUREN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S03_STRUKTUREN.

*TYPES: lty_num TYPE i,
Types :
BEGIN OF lty_s_mitarbeiter,
  vname(20) TYPE c,
  nname(20) TYPE c,
  alter TYPE i,
  wohnort(20) TYPE c,
  END OF lty_s_mitarbeiter
  .

*DATA lv_nummer TYPE lty_num.

DATA ls_mitarbeiter TYPE lty_s_mitarbeiter.
ls_mitarbeiter-vname = 'Klara'.
ls_mitarbeiter-nname = 'Klon'.
ls_mitarbeiter-alter = 45.
ls_mitarbeiter-wohnort = 'München'.

WRITE: / ls_mitarbeiter-vname.
WRITE: / ls_mitarbeiter-nname.
WRITE: / ls_mitarbeiter-alter.
WRITE: / ls_mitarbeiter-wohnort.

*BREAK-POINT.
ULINE.


ls_mitarbeiter-vname = 'Konrad'.
ls_mitarbeiter-nname = 'Meier'.
ls_mitarbeiter-alter = 100.
ls_mitarbeiter-wohnort = 'Starnberg'.

WRITE: / ls_mitarbeiter-vname.
WRITE: / ls_mitarbeiter-nname.
WRITE: / ls_mitarbeiter-alter.
WRITE: / ls_mitarbeiter-wohnort.

ULINE.

* CLEAR ls_mitarbeiter.
ls_mitarbeiter-vname = 'Karl'.
ls_mitarbeiter-nname = 'Bot'.
ls_mitarbeiter-alter = 40.
ls_mitarbeiter-wohnort = 'Starnberg'.

WRITE: / ls_mitarbeiter-vname.
WRITE: / ls_mitarbeiter-nname.
WRITE: / ls_mitarbeiter-alter.
WRITE: / ls_mitarbeiter-wohnort.
