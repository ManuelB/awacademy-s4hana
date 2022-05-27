*&---------------------------------------------------------------------*
*& Report ZAWT03_SEARCHHELP
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zawt03_searchhelp_r.

*Verstanden.

*SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001.
*  PARAMETERS p_airp TYPE zawt03_airpfrom.
*SELECTION-SCREEN END OF BLOCK a1.
*
*START-OF-SELECTION.

*Was ist hier geschehen? Datentyp wurde erstellt mit eigener Domäne. Zusätzlich Überschrift bei Rahmen.
*Zusätzlich haben wir eine Search help eingerichtet.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001.
  PARAMETERS p_airp TYPE z_s01_d_airp.
SELECTION-SCREEN END OF BLOCK a1.

START-OF-SELECTION.
