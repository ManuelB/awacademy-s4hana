*&---------------------------------------------------------------------*
*& Report Z_S11_RANGES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s11_ranges.

INCLUDE Z_T04_I_Flugdaten.
*
*select * from scarr   INTO TABLE lt_scarr  .
*
*TABLES scarr.
*
*
*DATA ls_scarr TYPE scarr.
*
*SELECT-OPTIONS so_carr FOR scarr-carrid .
*SORT lt_scarr BY carrid.
*
*LOOP AT lt_scarr INTO ls_scarr WHERE carrid IN so_carr.
*
*  WRITE : / |{ ls_scarr-carrid } - { ls_scarr-carrname }|.
*
*ENDLOOP.
*  IF sy-subrc NE 0.
*    MESSAGE: |Keine Fluggesellschaft gefunden| TYPE 'S'.
*  ENDIF.



*.............Range Reichveiten...
*
**DATA lt_tstc TYPE TABLE OF tstc.
**DATA ls_tstc TYPE tstc.
*
**Neue Deklarierung
*Data lr_range type range of scarr-carrid.
*Data ls_range like line of lr_range.
*
**Obsolete Dekalrierung
*
**Ranges lr_range For scarr-carrid. "Die erzeugte Tabelle mit Kopfzeile  funktioniert so nicht in objektorientierter programmieung
*
**Befüllung der Rnge
*ls_range-sign = 'I'.
*ls_range-option = 'EQ'.
*ls_range-low = 'LH'.
*ls_range-high = ''.
*
*Append ls_range to lr_range.
*
*ls_range-sign = 'I'.
*ls_range-option = 'BT'.
*ls_range-low = 'AA'.
*ls_range-high = 'BA'.
*
*Append ls_range to lr_range.
**
**Data lt_obsolet type table of scarr WITH HEADER LINE.
**lt_obsolet[].

*BREAK-POINT.

********Aufgabe....Eine Buchung Liste von datum 29.03.2021 und price zwischen 500 und 10000

*DATA ls_sbook TYPE sbook.
*DATA lt_book_result TYPE table of  sbook.
*
**Obsolete Deklarierung
**RANGES lr_range1 FOR sbook-order_date.
*
*Data lr_range1 type range of sbook-order_date. "ForDatum
*Data ls_range1 like LINE OF lr_range1.
*
*ls_range1-sign = 'I'.
*ls_range1-option = 'EQ'.
**ls_range1-low = '20211022'.
*ls_range1-low = '20210329'.
*ls_range1-high = ''.
*APPEND ls_range1 TO lr_range1.
*
**RANGES lr_range2 FOR sbook-loccuram*
*
*Data lr_range2 type RANGE OF sbook-loccuram. "For Price
*Data ls_range2 LIKE LINE OF lr_range2.
*
*ls_range2-sign = 'I'.
*ls_range2-option = 'BT'.
*ls_range2-low = '500'.
*ls_range2-high = '1000'.
*APPEND ls_range2 TO lr_range2.
*
*LOOP AT lt_sbook INTO ls_sbook
*  WHERE
*  order_date IN lr_range1
*  AND loccuram IN lr_range2
*  .
*APPEND ls_sbook to lt_book_result.
*WRITE :/ ls_sbook-bookid, ls_sbook-class, ls_sbook-loccuram.
*ENDLOOP.
*
*  IF sy-subrc NE 0.
**    MESSAGE: |Keine buchung gefunden| TYPE 'S'.
*  write 'No flight for this date and given price'.
*  ENDIF.

**********************Asessment Aufgabe**********************++++++++++++++++
types : begin of ls_i,
  tab_lin type i,
  end of ls_i.
Data lt_i type table of ls_i.
Data ls1_i type ls_i.

Data lr_range1 type range of i.
Data ls_range1 LIKE LINE OF lr_range1.


ls_range1-sign = 'I'.
ls_range1-option = 'BT'.
ls_range1-low = '3'.
ls_range1-high = '10'.
APPEND ls_range1 TO lr_range1.
ls_range1-sign = 'I'.
ls_range1-option = 'EQ'.
ls_range1-low = '1'.
ls_range1-high = '0'.
APPEND ls_range1 TO lr_range1.
ls_range1-sign = 'I'.
ls_range1-option = 'EQ'.
ls_range1-low = '17'.
ls_range1-high = '0'.
APPEND ls_range1 TO lr_range1.

BREAK-POINT.

lt_i = VALUE #( ( tab_lin = 1 )
                 ( tab_lin = 2 )
                 ( tab_lin = 4  )
                 ( tab_lin = 5  )
                 ( tab_lin = 6 )
                 ( tab_lin = 41 )
                 ( tab_lin = 8  )
                 ( tab_lin = 9  )
                 ( tab_lin = 10 )
                 ( tab_lin = 11 )
                 ( tab_lin = 12  )
                ).

loop at lt_i ASSIGNING FIELD-SYMBOL(<fs>) where tab_lin in lr_range1.
  write : | { <fs>-tab_lin } |.
  ENDLOOP.


*loop at lt_i into ls1_i where tab_lin in lr_range1.
*  write : |{ ls1_i-tab_lin }|.
*  ENDLOOP.
