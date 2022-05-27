*&---------------------------------------------------------------------*
*& Report Z_S06_STRUKTUREN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s06_strukturen.

TYPES: lty_num TYPE i, "struktur typen

       BEGIN OF lty_s_mitarbeiter,"s indicates the structure
         vname(20)     TYPE c,
         nname(20)     TYPE c,
         geschlecht(1) TYPE c,
         alter         TYPE i,

       END OF lty_s_mitarbeiter
       ."set fullstop here so that programs works when you comment out fields

DATA lv_nummer TYPE lty_num.

DATA ls_mitarbeiter TYPE lty_s_mitarbeiter. "Typisierung der lokalen Struktur.

ls_mitarbeiter-vname = 'Heinrich'.
ls_mitarbeiter-nname = 'Müller'.
ls_mitarbeiter-alter = 45.
ls_mitarbeiter-geschlecht = 'M'.

WRITE: / 'mitarbeiter 1'.
WRITE: / 'name:', ls_mitarbeiter-vname.
WRITE: / 'nachname:', ls_mitarbeiter-nname.
WRITE: / 'alter:', ls_mitarbeiter-alter.
WRITE: / 'geschlecht:', ls_mitarbeiter-geschlecht.
ULINE.
CLEAR ls_mitarbeiter.

ls_mitarbeiter-vname = 'Christian'.
ls_mitarbeiter-nname = 'Reuter'.
ls_mitarbeiter-alter = 58.
ls_mitarbeiter-geschlecht = 'M'.

WRITE: / 'mitarbeiter 2'.
WRITE: / 'name:', ls_mitarbeiter-vname.
WRITE: / 'nachname:', ls_mitarbeiter-nname.
WRITE: / 'alter:', ls_mitarbeiter-alter.
WRITE: / 'geschlecht:', ls_mitarbeiter-geschlecht.
ULINE.
CLEAR ls_mitarbeiter.

ls_mitarbeiter-vname = 'Claudia'.
ls_mitarbeiter-nname = 'Hager'.
ls_mitarbeiter-alter = 52.
ls_mitarbeiter-geschlecht = 'F'.


WRITE: / 'mitarbeiter 3'.
WRITE: / 'name:', ls_mitarbeiter-vname.
WRITE: / 'nachname:', ls_mitarbeiter-nname.
WRITE: / 'alter:', ls_mitarbeiter-alter.
WRITE: / 'geschlecht:', ls_mitarbeiter-geschlecht.
ULINE.
CLEAR ls_mitarbeiter.
"BREAK-POINT.
