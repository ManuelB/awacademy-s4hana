*&---------------------------------------------------------------------*
*& Report Z_S12_STRUKTUREN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s12_strukturen.
"Strukturen werden hauptsächlich verwendet um Tabellen zu befüllen.
TYPES: lty_num TYPE i, "einzeilige Struktur

       BEGIN OF lty_s_mitarbeiter, "lokaler Strukturtyp
         vname(20) TYPE c,
         nname(20) TYPE c, "Charakter also buchstaben
         alter     TYPE i, "Zahlen
         wort(30)  TYPE c,
       END OF lty_s_mitarbeiter
       . "Kettensatz mit Punkt wieder abschließen + Punkt in neuer Zeile ermöglich einfacheres Auskommentieren

*DATA lv_nummer TYPE lty_num.

DATA ls_mitarbeiter TYPE lty_s_mitarbeiter. "ls = lokale Struktur; Typisierung der lokalen Struktur
*DATA ls_mitarbeiter2 TYPE lty_s_mitarbeiter.
*DATA ls_mitarbeiter3 TYPE lty_s_mitarbeiter.
*ls_mitarbeiter-vname = 'Heinrich'. "Befüllen der Werte der Struktur - exaktes Feld muss gewählt werden
*ls_mitarbeiter-nname = 'Müller'.
*ls_mitarbeiter-alter = 45.
*ls_mitarbeiter-wort = 'München'.
*
*ls_mitarbeiter2-vname = 'Hans'.
*ls_mitarbeiter2-nname = 'Peter'.
*ls_mitarbeiter2-alter = 56.
*ls_mitarbeiter2-wort = 'Ausgburg'.
*
*ls_mitarbeiter3-vname = 'Gisela'.
*ls_mitarbeiter3-nname = 'Regen'.
*ls_mitarbeiter3-alter = 49.
*ls_mitarbeiter3-wort = 'Flenzburg'.
*
*WRITE: / 'Mitarbeiter 1'.
*WRITE: / ls_mitarbeiter-vname.
*WRITE: / ls_mitarbeiter-nname.
*WRITE: / ls_mitarbeiter-alter.
*WRITE: / ls_mitarbeiter-wort.
*ULINE.
*WRITE: / 'Mitarbeiter 2'.
*WRITE: / ls_mitarbeiter2-vname.
*WRITE: / ls_mitarbeiter2-nname.
*WRITE: / ls_mitarbeiter2-alter.
*WRITE: / ls_mitarbeiter2-wort.
*ULINE.
*WRITE: / 'Mitarbeiter 3'.
*WRITE: / ls_mitarbeiter3-vname.
*WRITE: / ls_mitarbeiter3-nname.
*WRITE: / ls_mitarbeiter3-alter.
*WRITE: / ls_mitarbeiter3-wort.
*ULINE.


WRITE: / 'Elegantere Lösung'.
ULINE.
clear ls_mitarbeiter. "Löscht alle vorangegenagen Werte aus der Struktur
ls_mitarbeiter-vname = 'Heinrich'. "Befüllen der Werte der Struktur - exaktes Feld muss gewählt werden
ls_mitarbeiter-nname = 'Müller'.
ls_mitarbeiter-alter = 45.
ls_mitarbeiter-wort = 'München'.

WRITE: / 'Mitarbeiter 1'.
WRITE: / ls_mitarbeiter-vname.
WRITE: / ls_mitarbeiter-nname.
WRITE: / ls_mitarbeiter-alter.
WRITE: / ls_mitarbeiter-wort.
ULINE.

clear ls_mitarbeiter.
ls_mitarbeiter-vname = 'Hans'.
ls_mitarbeiter-nname = 'Peter'.
ls_mitarbeiter-alter = 56.
ls_mitarbeiter-wort = 'Ausgburg'.
WRITE: / 'Mitarbeiter 2'.
WRITE: / ls_mitarbeiter-vname.
WRITE: / ls_mitarbeiter-nname.
WRITE: / ls_mitarbeiter-alter.
WRITE: / ls_mitarbeiter-wort.
ULINE.

clear ls_mitarbeiter.
ls_mitarbeiter-vname = 'Gisela'.
ls_mitarbeiter-nname = 'Regen'.
ls_mitarbeiter-alter = 49.
ls_mitarbeiter-wort = 'Flenzburg'.
WRITE: / 'Mitarbeiter 3'.
WRITE: / ls_mitarbeiter-vname.
WRITE: / ls_mitarbeiter-nname.
WRITE: / ls_mitarbeiter-alter.
WRITE: / ls_mitarbeiter-wort.

ULINE.
*BREAK-POINT.
