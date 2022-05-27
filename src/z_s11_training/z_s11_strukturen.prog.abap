*&---------------------------------------------------------------------*
*& Report Z_S11_STRUKTUREN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s11_strukturen.

TYPES : lty_num TYPE i,
        BEGIN OF lty_s_mitarbeiter,
          vname(20) TYPE c,
          nname(20) TYPE c,
          alter     TYPE i,
          Address(50) Type c,
        END OF lty_s_mitarbeiter
        .



DATA lv_nummer TYPE lty_num.

Data ls_mitarbeiter type lty_s_mitarbeiter. "Typisierung der lokalen Struktur.

ls_mitarbeiter-vname = 'Mira'.
ls_mitarbeiter-nname = 'Weinert'.
ls_mitarbeiter-alter = 30.
ls_mitarbeiter-address = 'New Delhi'.

write :/ 'Empployee 1'.
write :/ ls_mitarbeiter-vname.
write :/ ls_mitarbeiter-nname.
write :/ ls_mitarbeiter-alter.
write :/ ls_mitarbeiter-address.

clear  ls_mitarbeiter.

uline.
*BREAK-POINT.
ls_mitarbeiter-vname = 'Tom'.
ls_mitarbeiter-nname = 'Hanks'.
ls_mitarbeiter-alter = 30.
ls_mitarbeiter-address = 'China'.

write :/ 'Empployee 2'.
write :/ 'Vorname', ls_mitarbeiter-vname.
write :/ 'Nachname',ls_mitarbeiter-nname.
write :/ 'Age',ls_mitarbeiter-alter.
write :/ 'Address',ls_mitarbeiter-address.
