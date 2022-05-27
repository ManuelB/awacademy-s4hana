*&---------------------------------------------------------------------*
*& Report Z_S02_STRUKTUREN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s02_strukturen.


TYPES: lty_num TYPE i,

       BEGIN OF lty_s_mitarbeiter, " lokaler Strukturtyp
         vname(20) TYPE c,
         nname(20) TYPE c,
         gesch(1)  TYPE c,
         alter     TYPE i,
       END OF lty_s_mitarbeiter
       .

DATA lv_nummer TYPE lty_num.

DATA ls_mitarbeiter TYPE lty_s_mitarbeiter.  "Typisierung der lokalen Struktur.


ls_mitarbeiter-vname = 'Heini'.    "ls_mitarbeiter- jetzt strg+Leertaste - die Felder werden vorgeschlagen
ls_mitarbeiter-nname = 'Müller'.
ls_mitarbeiter-gesch = 'm'.
ls_mitarbeiter-alter = '45'.

WRITE: / 'Mitarbeiter 1'.
WRITE: / 'Vorname:', ls_mitarbeiter-vname.
WRITE: / 'Nachname:', ls_mitarbeiter-nname.
WRITE: / 'Alter:', ls_mitarbeiter-alter.
WRITE: / 'Geschlecht:', ls_mitarbeiter-gesch.
ULINE.

CLEAR ls_mitarbeiter. " damit kann man die Werte in Felder auf die Initialwerte zurücksetzen. Hier: wäre das Alter leer bei der Diana, würde dasjenige vom Heini übernommen werden.

ls_mitarbeiter-vname = 'Diana'.
ls_mitarbeiter-nname = 'Schmidt'.
ls_mitarbeiter-gesch = 'w'.
ls_mitarbeiter-alter = '35'.

WRITE: / 'Mitarbeiter 2'.
WRITE: / 'Vorname:', ls_mitarbeiter-vname.
WRITE: / 'Nachname:', ls_mitarbeiter-nname.
WRITE: / 'Alter:', ls_mitarbeiter-alter.
WRITE: / 'Geschlecht:', ls_mitarbeiter-gesch.

*BREAK-POINT.

*ls_mitarbeiter-vname
