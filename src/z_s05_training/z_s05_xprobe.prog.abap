*&---------------------------------------------------------------------*
*& Report Z_S05_XPROBE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_XPROBE.

*define a structure type

TYPES:

BEGIN OF lv_s_customer,
  knumm(5) TYPE c,
  vname(20) TYPE c,
  nname(20) TYPE c,
  email(30) TYPE c,
  punkte TYPE i,
  viplv(20) TYPE c,
  END OF lv_s_customer,

*add structure type to the structure a and table.

lv_t_customer TYPE STANDARD TABLE OF lv_s_customer.

  DATA ls_customer TYPE lv_s_customer.
  DATA lt_customer TYPE STANDARD TABLE OF lv_s_customer WITH DEFAULT KEY.

ls_customer-knumm = 'ID001'.
ls_customer-vname = 'Leah'.
ls_customer-nname = 'Mayer'.
ls_customer-email = 'l_mayer01@gmail.com'.
ls_customer-punkte = 150.
APPEND ls_customer TO lt_customer.



CLEAR ls_customer.

ls_customer-knumm = 'ID002'.
ls_customer-vname = 'Ralph'.
ls_customer-nname = 'Dunkel'.
ls_customer-email = 'ralph02@yahoo.com'.
ls_customer-punkte = 201.
APPEND ls_customer TO lt_customer.


CLEAR ls_customer.


ls_customer-knumm = 'ID003'.
ls_customer-vname = 'Ingrid'.
ls_customer-nname = 'Winter'.
ls_customer-email = 'winteringrid@outlook.co.uk'.
ls_customer-punkte = 341.
APPEND ls_customer TO lt_customer.




READ TABLE lt_customer INTO ls_customer WITH KEY ls_customer-punkte.
IF sy-subrc <> 0.

LOOP AT lt_customer INTO ls_customer.
  IF ls_customer-punkte LT 200.
    ls_customer-viplv = 'Neukunde'.
   MODIFY lt_customer FROM ls_customer TRANSPORTING viplv.
  "  APPEND ls_customer TO lt_customer.
   " MODIFY lt_customer from ls_customer INDEX sy-tabix.
"WRITE: / |Für den Kunden { ls_customer-vname } { ls_customer-nname }  Mit der Kundennumer: { ls_customer-knumm } / Gilt die nachlogende Punktezahl: { ls_customer-punkte }  Das VIP_Level des Kunden ist { ls_customer-viplv } .|.

ELSEIF ls_customer-punkte GE 200.
  ls_customer-viplv = 'Loyal'.
     MODIFY lt_customer FROM ls_customer TRANSPORTING viplv.
" WRITE: / |Für den Kunden { ls_customer-vname } { ls_customer-nname }  Mit der Kundennumer: { ls_customer-knumm } / Gilt die nachlogende Punktezahl: { ls_customer-punkte }  Das VIP_Level des Kunden ist { ls_customer-viplv } .|.
"MODIFY lt_customer from ls_customer INDEX sy-tabix.
 " APPEND ls_customer TO lt_customer.
  ENDIF.



" WRITE: / |Für den Kunden { ls_customer-vname } { ls_customer-nname }  Mit der Kundennumer: { ls_customer-knumm } / Gilt die nachlogende Punktezahl: { ls_customer-punkte }  Das VIP_Level des Kunden ist { ls_customer-viplv } |.
 WRITE: / |Für den Kunden: { ls_customer-vname } { ls_customer-nname } |.
  WRITE: / |Mit der Kundennumer: { ls_customer-knumm } |.
  WRITE: / |Gilt die nachlogende Punktezahl: { ls_customer-punkte }  |.
  WRITE: / |Das VIP Level des Kunden ist: { ls_customer-viplv }  |.
  WRITE : /.



ENDLOOP.

CLEAR ls_customer.
ENDIF.


SELECT-OPTIONS so_knumm FOR ls_customer-knumm NO INTERVALS DEFAULT 'ID001' .

SORT lt_customer BY knumm.

"LOOP AT lt_scarr INTO ls_scarr WHERE carrid IN so_carr.
LOOP AT lt_customer INTO ls_customer WHERE knumm IN so_knumm.

 READ TABLE lt_customer INTO ls_customer WITH KEY ls_customer-knumm.

  IF  sy-tabix <> 0.
 "AND p_kunde EQ ls_customer-knumm.
 WRITE: / |{ ls_customer-vname } { ls_customer-nname } |.
 WRITE: / |Email: { ls_customer-email }|.
 WRITE: /.

 ELSE.

 WRITE: / |Fehler! Es gibt keinen Kunden mit dieser Kundennummer!|.
   ENDIF.

    ENDLOOP.

    BREAK-POINT.
