*&---------------------------------------------------------------------*
*& Report Z_S11_TABELLEN_SORTED
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s11_tabellen_sorted.

TYPES : BEGIN OF lty_s_benutzer,
          id(8)     TYPE c,
          vname(10) TYPE c,
          nname(10) TYPE c,
        END OF lty_s_benutzer,

        lty_t_benutzer TYPE SORTED TABLE OF lty_s_benutzer.
DATA : lv_zeilen_anzahl TYPE i,
       lv_dummy       TYPE string,
       lv_max_id_c(6)   TYPE n.

*        Data lt_benutzer TYPE lty_t_benutzer.

DATA ls_benutzer TYPE lty_s_benutzer.
DATA lt_benutzer TYPE SORTED TABLE OF lty_s_benutzer WITH UNIQUE KEY id.

ls_benutzer-id = 'ID000001'.
ls_benutzer-vname = 'Heinz'.
ls_benutzer-nname = 'kriete'.
APPEND ls_benutzer TO lt_benutzer.

ls_benutzer-id = 'ID000002'.
ls_benutzer-vname = 'Tom'.
ls_benutzer-nname = 'Weinert'.
APPEND ls_benutzer TO lt_benutzer.

ls_benutzer-id = 'ID000003'.
ls_benutzer-vname = 'Sara'.
ls_benutzer-nname = 'Blüh'.
APPEND ls_benutzer TO lt_benutzer.


***********************************+
**********Neuen Nutzer Hinzufügen

*READ TABLE lt_benutzer INTO ls_benutzer WITH TABLE KEY id. "TRANSPORTING NO FIELDS .


ls_benutzer-id = 'ID000005'.
ls_benutzer-vname = 'Laura'.
ls_benutzer-nname = 'Peter'.

LOOP AT lt_benutzer INTO ls_benutzer WHERE id EQ ls_benutzer-id.

ENDLOOP.

IF sy-subrc <> 0. "means no record is found in the table whose Id is equal to ls_benutzer_id
  APPEND ls_benutzer TO lt_benutzer.
ELSE.
*MESSAGE : |Benutzer mit der ID: { ls_benutzer-id } ist schon vergeben !| type 'E'.
  MESSAGE : |Benutzer mit der ID: { ls_benutzer-id } ist schon vergeben !| TYPE 'S' DISPLAY LIKE 'E'. "Program brichts nicht, kann weiter arbeiten
  DESCRIBE TABLE lt_benutzer LINES lv_zeilen_anzahl.
  READ TABLE lt_benutzer INDEX lv_zeilen_anzahl INTO ls_benutzer.
  SPLIT ls_benutzer-id AT 'ID' INTO lv_dummy lv_max_id_c .
  ADD 1 TO lv_max_id_c.
  WRITE / |The next possible ID is : ID{ lv_max_id_c }|.
ENDIF.


*IF sy-subrc NE 0.
*  APPEND ls_benutzer TO lt_benutzer.
*ELSE.
*  MESSAGE : | Benutzer mit der ID{ ls_benutzer-id } is schon vergeben!| TYPE 'S' DISPLAY LIKE 'E'.
*
*  lv_zeilen_anzahl = lines( lt_benutzer ).
*
*  READ TABLE lt_benutzer INDEX lv_zeilen_anzahl INTO ls_benutzer. "USING KEY ls_benutzer-id.
*
*  lv_max_id_c = ls_benutzer-id+2(6).
*  lv_max_id_c = lv_max_id_c + 1.
*  WRITE :/ |the next possible id which can be assigned is:' ID{ lv_max_id_c }|.
*ENDIF.
