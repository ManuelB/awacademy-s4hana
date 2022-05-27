*&---------------------------------------------------------------------*
*& Report Z_S09_STRUKTUREN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s09_strukturen.

TYPES: lty_num TYPE i,

       BEGIN OF lty_s_mitarbeiter, "Lokaler Strukturtyp"
         personalnummer(3)          TYPE i,
         vname(20)                  TYPE c,
         nname(20)                  TYPE c,
         alter                      TYPE i,
         standort(40)               TYPE c,
         betriebszugehoerigkeit(40) TYPE c,

       END OF lty_s_mitarbeiter.



DATA lv_nummer TYPE lty_num.

DATA ls_mitarbeiter TYPE lty_s_mitarbeiter. "Typisierung der lokal Struktur"

ls_mitarbeiter-personalnummer = '111'.
ls_mitarbeiter-vname = 'Heinrich'.
ls_mitarbeiter-nname = 'Müller'.
ls_mitarbeiter-alter = 45.
ls_mitarbeiter-standort = 'München'.
ls_mitarbeiter-betriebszugehoerigkeit = '16 Jahre'.

WRITE: / 'Personalnummer:' , ls_mitarbeiter-personalnummer.

WRITE: / 'Vorname:' , ls_mitarbeiter-vname.

WRITE: / 'Nachname:' , ls_mitarbeiter-nname.

WRITE: / 'Alter:' , ls_mitarbeiter-alter.

WRITE: / 'Standort:' , ls_mitarbeiter-standort.

WRITE: / 'Betriebszugehörigkeit:' , ls_mitarbeiter-betriebszugehoerigkeit.

ULINE.

ls_mitarbeiter-personalnummer = '333'.
ls_mitarbeiter-vname = 'Max'.
ls_mitarbeiter-nname = 'Mustermann'.
ls_mitarbeiter-alter = 20.
ls_mitarbeiter-standort = 'Frankfurt am Main'.
ls_mitarbeiter-betriebszugehoerigkeit = '3 Jahre'.

WRITE: / 'Personalnummer:' , ls_mitarbeiter-personalnummer.

WRITE: / 'Vorname:' , ls_mitarbeiter-vname.

WRITE: / 'Nachname:' , ls_mitarbeiter-nname.

WRITE: / 'Alter:' , ls_mitarbeiter-alter.

WRITE: / 'Standort:' , ls_mitarbeiter-standort.

WRITE: / 'Betriebszugehörigkeit:' , ls_mitarbeiter-betriebszugehoerigkeit.


ULINE.

ls_mitarbeiter-personalnummer = '222'.
ls_mitarbeiter-vname = 'Erika'.
ls_mitarbeiter-nname = 'Musterfrau'.
ls_mitarbeiter-alter = 30.
ls_mitarbeiter-standort = 'Hamburg'.
ls_mitarbeiter-betriebszugehoerigkeit = '5 Jahre'.

WRITE: / 'Personalnummer:' , ls_mitarbeiter-personalnummer.

WRITE: / 'Vorname:' , ls_mitarbeiter-vname.

WRITE: / 'Nachname:' , ls_mitarbeiter-nname.

WRITE: / 'Alter:' , ls_mitarbeiter-alter.

WRITE: / 'Standort:', ls_mitarbeiter-standort.

WRITE: / 'Betriebszugehörigkeit:' , ls_mitarbeiter-betriebszugehoerigkeit.

ULINE.





"BREAK-POINT
