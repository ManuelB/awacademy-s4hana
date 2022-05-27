*&---------------------------------------------------------------------*
*& Report Z_AW07_STRUKTUREN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_AW07_STRUKTUREN.

TYPES:
*      lty_num TYPE i,

       BEGIN OF lty_s_mitarbeiter, " lokaler Strukturtyp
         vname(20) TYPE c,
         nname(20) TYPE c,
         alter     TYPE i,
         Email(50) TYPE c,
       END OF lty_s_mitarbeiter
       .

*DATA lv_nummer TYPE lty_num.

DATA ls_mitarbeiter TYPE lty_s_mitarbeiter.  "Typisierung der lokalen Struktur.

ls_mitarbeiter-vname = 'Heinrich'.
ls_mitarbeiter-nname = 'Müller'.
ls_mitarbeiter-alter = 45.
ls_mitarbeiter-email = 'abapisttoll@online.de'.

WRITE: 'Mitarbeiter 1'.
WRITE: / 'Vorname:',  ls_mitarbeiter-vname.
WRITE: / 'Nachname:', ls_mitarbeiter-nname.
WRITE: / 'Alter:',    ls_mitarbeiter-alter.
WRITE: / 'Email:',    ls_mitarbeiter-email.

CLEAR ls_mitarbeiter.

ls_mitarbeiter-vname = 'Ute'.
ls_mitarbeiter-nname = 'Schmidt'.
ls_mitarbeiter-alter = '65'.
ls_mitarbeiter-email = 'abapistdoof@online.de'.

ULINE.
WRITE: / 'Mitarbeiter 2'.
WRITE: / 'Vorname:',  ls_mitarbeiter-vname.
WRITE: / 'Nachname:', ls_mitarbeiter-nname.
WRITE: / 'Alter:',    ls_mitarbeiter-alter.
WRITE: / 'Email:',    ls_mitarbeiter-email.



*BREAK-POINT.
