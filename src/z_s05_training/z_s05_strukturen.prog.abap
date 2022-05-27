*&---------------------------------------------------------------------*
*& Report Z_S05_STRUKTUREN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_STRUKTUREN.

TYPES: ITY_NUM type I,

        BEGIN OF ity_s_mitarbeiter, "lokaler Strukturtyp"
          vname(20) TYPE c,
          nname(20) TYPE c,
          alter TYPE i,
          abteilung(20) TYPE c,
          gehalt TYPE i,

          END OF ity_s_mitarbeiter
          .


DATA lv_nummer TYPE ity_num.
DATA ls_mitarbeiter TYPE ity_s_mitarbeiter. "lokaler Struktur."

ls_mitarbeiter-vname = 'Heinrich'.
ls_mitarbeiter-nname = 'Müller'.
ls_mitarbeiter-alter = 45.
ls_mitarbeiter-abteilung = 'HR'.
ls_mitarbeiter-gehalt = 4000.

WRITE: 'Mitarbeiter1'.
WRITE: / '______________'.
WRITE: / 'Vorname', ls_mitarbeiter-vname.
WRITE: / 'Nachname', ls_mitarbeiter-nname.
WRITE: / 'Alter', ls_mitarbeiter-alter.
WRITE: / 'Abteilung', ls_mitarbeiter-abteilung.
WRITE: / 'Gehalt-Brutto', ls_mitarbeiter-gehalt.
WRITE: '€'.

ULINE.

CLEAR ls_mitarbeiter.

ls_mitarbeiter-vname = 'Max'.
ls_mitarbeiter-nname = 'Groß'.
ls_mitarbeiter-alter = 33.
ls_mitarbeiter-abteilung = 'IT'.
ls_mitarbeiter-gehalt = 4300.

WRITE: 'Mitarbeiter2'.
WRITE: / '______________'.
WRITE: / 'Vorname', ls_mitarbeiter-vname.
WRITE: / 'Nachname',ls_mitarbeiter-nname.
WRITE: / 'Alter', ls_mitarbeiter-alter.
WRITE: / 'Abteilung', ls_mitarbeiter-abteilung.
WRITE: /'Gehalt-Brutto', ls_mitarbeiter-gehalt.
WRITE: '€'.

ULINE.

CLEAR ls_mitarbeiter.

ls_mitarbeiter-vname = 'Lara'.
ls_mitarbeiter-nname = 'Lars'.
ls_mitarbeiter-alter = 29.
ls_mitarbeiter-abteilung = 'Marketing'.
ls_mitarbeiter-gehalt = 3100.



WRITE: 'Mitarbeiter3'.
WRITE: / '______________'.
WRITE: / 'Vorname', ls_mitarbeiter-vname.
WRITE: /  'Nachname',ls_mitarbeiter-nname.
WRITE: / 'Alter',ls_mitarbeiter-alter.
WRITE: / 'Abteilung', ls_mitarbeiter-abteilung.
WRITE: / 'Gehalt-Brutto',ls_mitarbeiter-gehalt.
WRITE: '€'.

BREAK-POINT.
