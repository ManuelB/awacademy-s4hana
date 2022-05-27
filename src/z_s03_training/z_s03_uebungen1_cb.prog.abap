*&---------------------------------------------------------------------*
*& Report Z_S03_SCHLEIFENCB
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s03_uebungen1_cb.

*DATA lv_zahl TYPE i VALUE 1.
*DATA lv_times TYPE i VALUE 5.
*
*DO lv_times TIMES.
*  WRITE: | { lv_zahl } |.
*  ADD 2 TO lv_zahl.
*  IF lv_Zahl GT 10.
*    EXIT.
*  ENDIF.
*
*ENDDO.
*
*ULINE.
*
*lv_zahl = 11.
*WHILE lv_zahl GT 0.
*  SUBTRACT 2 FROM lv_zahl.
*  IF lv_zahl LE 0.
*    EXIT.
*  ENDIF.
*  WRITE: | { lv_zahl } |.
*ENDWHILE.
*
*ULINE.

*WRITE: / |Kalender 2022 von Januar bis März|.
*
*DATA lv_Tag TYPE i VALUE 1.
*DATA lv_Monat TYPE i VALUE 1.
*DATA lv_Jahr TYPE i VALUE 2022.
*
*DATA lv_TAGREP TYPE i.
*
*
*DO 3 TIMES.
*  CASE lv_Monat.
*    WHEN 1.
*      lv_tagrep = 31.
*
*    WHEN 2.
*      lv_tagrep = 28.
*
*    WHEN 3.
*      lv_tagrep = 31.
*
*    WHEN OTHERS.
*  ENDCASE.
*
*  DO  lv_tagrep TIMES.
*   WRITE: / | { lv_tag } - { lv_monat } - { lv_jahr } |.
*   add 1 to lv_tag.
*
*  ENDDO.
*add 1 to lv_monat.
*lv_tag = 1.
*
*ENDDO.

*ULINE.
*
*DATA lv_timestampl TYPE timestampl.
*
*get TIME STAMP FIELD lv_timestampl.
*
*WRITE: / | { lv_timestampl TIMESTAMP = USER } |.
*
*WRITE: / | { sy-datlo DATE = ISO } |.
*
*ULINE.
*
*WRITE: / | Struktur Für Schlüler |.
*
*TYPES:
*BEGIN: OF lty_s_schueler,
*  vname(10) TYPE c,
*  nname(10) TYPE c,
*  alter TYPE i,
*  email(50) TYPE c,
*  END OF lty_s_schueler.
*
*  DATA ls_schueler type lty_s_schueler.
*
*ls_schueler-vname = |Chrystelle|.
*ls_schueler-nname = |Bastien|.
*ls_schueler-alter = |100|.
*ls_schueler-email = |chrystelle@awacademy.com|.
*
*
*
*  WRITE: / |Vorname: { ls_schueler-vname } |.
*  WRITE: / |Nachname: { ls_schueler-nname } |.
*  WRITE: / |Alter: { ls_schueler-alter ALIGN = RIGHT WIDTH = 7 } |.
*  WRITE: / |E-Mail: { ls_schueler-email } |.

*  ULINE.
*
*  DATA count TYPE i VALUE 3.
*  DO 3 TIMES.
*    WHILE count < 5.
*      count = count + 1.
*      IF count = 2.
*        CONTINUE.
*        ELSE.
*          count = count + 2.
*
*      ENDIF.
*
*    ENDWHILE.
*
*  ENDDO.
*  WRITE: / count.

*DO 3 TIMES.
*  WRITE: / sy-index.
*  DO 8 TIMES.
*     WRITE: sy-index.
*ENDDO.
*  ENDDO.
*  WRITE: / 'Ende'.

ULINE.

TYPES:
BEGIN OF lty_s_Hund,
  hname(8) TYPE c,
  hbessitzer(20) TYPE c,
  halter TYPE i,
  EssMenge(10) TYPE c,

  END OF lty_s_hund.

  data ls_Hund TYPE lty_s_hund.
  DATA lt_Hund TYPE STANDARD TABLE OF lty_s_hund.

ls_Hund-hname = |Paf|.
  ls_Hund-hbessitzer = |Maria|.
  ls_Hund-halter = 2.
   APPEND ls_hund to lt_hund.


  ls_Hund-hname = |Pif|.
  ls_Hund-hbessitzer = |Werner|.
  ls_Hund-halter = 8.
  APPEND ls_hund to lt_hund.

  ls_Hund-hname = |Paf|.
  ls_Hund-hbessitzer = |Maria|.
  ls_Hund-halter = 2.
   APPEND ls_hund to lt_hund.

  ls_Hund-hname = |Pouf|.
  ls_Hund-hbessitzer = |Oskar|.
  ls_Hund-halter = 5.
   APPEND ls_hund to lt_hund.

SORT lt_hund BY hname ASCENDING.
DELETE ADJACENT DUPLICATES FROM lt_hund.

LOOP AT lt_hund INTO ls_hund.
  IF ls_hund-halter GE 5.
    ls_hund-essmenge = |wenig|.
    ELSE.
     ls_hund-essmenge = |viel|.
  ENDIF.
  MODIFY lt_hund FROM ls_hund INDEX sy-tabix.


WRITE: / |Hundname: { ls_hund-hname } |.
   WRITE: / |Hundbesitzer: { ls_hund-hbessitzer } |.
   WRITE: / |Hundalter: { ls_hund-halter } |.
   WRITE: / |HundEssMenge: { ls_hund-essmenge } |.
   ULINE.
ENDLOOP.
