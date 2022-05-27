*&---------------------------------------------------------------------*
*& Report Z_S01_STRUKTUREN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s01_strukturen.

*VERSTANDEN.


* Es gibt lokale Strukturen und globale Strukturen. Lokale Strukturen = in ABAP-programmen, Globale Strukturen = in DDIC.
*Grundvoraussetzung, um Strukturen für Tabellen zu erzeugen / mit den Inhalten einer Tabelle zu arbeiten/ werte zu erzeugen. lokale/globale Tabellen gibt es auch.
* Strukturen sind eine Gruppe von Komponenten, zusammengefasst mit einem Namen. Komponenten können sein: variablen, Tabellen, andere Strukturen.
*
*lty steht für localtype. Ist für namenskonvention.
TYPES: lty_num TYPE i,
       BEGIN OF lty_s_mitarbeiter, "Lokaler Strukturtyp
         vname(20) TYPE c,
         nname(20) TYPE c,
         alter     TYPE i,
         kinder    TYPE i,

       END OF lty_s_mitarbeiter
       . "Punkt darunter erstellen"


DATA lv_number TYPE lty_num. "Typisierung der lokalen Struktur. braucht man eigentlich hier nicht.
DATA ls_mitarbeiter TYPE lty_s_mitarbeiter.

*spricht lokale Struktur an.
ls_mitarbeiter-vname = 'Heinrich'.
ls_mitarbeiter-alter = 39.
ls_mitarbeiter-nname = 'Krause'.
ls_mitarbeiter-kinder = 3.

WRITE: / 'Mitarbeiter 1'.
WRITE:/ 'Vorname:', ls_mitarbeiter-vname.
WRITE:/ 'Nachname:', ls_mitarbeiter-nname.
WRITE:/ 'Alter: ', ls_mitarbeiter-alter.
WRITE:/ 'Kinder: ', ls_mitarbeiter-kinder.

*clear ls_mitarbeiter "Setzt den Wert auf sein Initialwert zurück.

ULINE.

ls_mitarbeiter-vname = 'Peter'.
ls_mitarbeiter-alter = 21. "Wenn die Werte nicht überschreiben, würde er den alten Wert beahlten"
ls_mitarbeiter-nname = 'Horst'.
ls_mitarbeiter-kinder = 0.

WRITE: / 'Mitarbeiter 2'.
WRITE:/ 'Vorname:', ls_mitarbeiter-vname.
WRITE:/ 'Nachname:', ls_mitarbeiter-nname.
WRITE:/ 'Alter: ', ls_mitarbeiter-alter.
WRITE:/ 'Kinder: ', ls_mitarbeiter-kinder.

ULINE.

ls_mitarbeiter-vname = 'Klaus'.
ls_mitarbeiter-alter = 55.
ls_mitarbeiter-nname = 'Kinski'.
ls_mitarbeiter-kinder = 4.


WRITE: / 'Mitarbeiter 3'.
WRITE:/ 'Vorname:', ls_mitarbeiter-vname.
WRITE:/ 'Nachname:', ls_mitarbeiter-nname.
WRITE:/ 'Alter: ', ls_mitarbeiter-alter.
WRITE:/ 'Kinder: ', ls_mitarbeiter-kinder.

ULINE.







*BREAK-POINT.
