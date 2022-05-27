*&---------------------------------------------------------------------*
*& Report Z_S04_STRUKTUREN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s04_strukturen.

TYPES: lty_num TYPE i,

       BEGIN OF lty_s_mitarbeiter, "lokaler Strukturtyp.
         vname(20)   TYPE c,
         nname(20)   TYPE c,
         alter       TYPE i,
         wohnort(20) TYPE c,
         ma_nr       TYPE i,
       END OF lty_s_mitarbeiter.


DATA lv_num TYPE lty_num.

DATA ls_mitarbeiter TYPE lty_s_mitarbeiter. "Typisierung der lokalen STruktur.

WRITE: 'MA-Nr.:     | Vorname:             | Nachname:            | Alter:      | Wohnort:'.

ULINE.
ULINE.

ls_mitarbeiter-ma_nr = 01.
ls_mitarbeiter-vname = 'Kevin'.
ls_mitarbeiter-nname = 'Horst'.
ls_mitarbeiter-alter = 45.
ls_mitarbeiter-wohnort = 'Bielefeld'.

WRITE: / ls_mitarbeiter-ma_nr, '|',
ls_mitarbeiter-vname, '|',
ls_mitarbeiter-nname, '|',
ls_mitarbeiter-alter, '|',
ls_mitarbeiter-wohnort.

ULINE.

ls_mitarbeiter-ma_nr = 02.
ls_mitarbeiter-vname = 'Chantal'.
ls_mitarbeiter-nname = 'Müller'.
ls_mitarbeiter-alter = 39.
ls_mitarbeiter-wohnort = 'Buxdehude'.

WRITE: / ls_mitarbeiter-ma_nr, '|',
ls_mitarbeiter-vname, '|',
ls_mitarbeiter-nname, '|',
ls_mitarbeiter-alter, '|',
ls_mitarbeiter-wohnort.

ULINE.
