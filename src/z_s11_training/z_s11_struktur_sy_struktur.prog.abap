*&---------------------------------------------------------------------*
*& Report Z_S11_STRUKTUR_SY_STRUKTUR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S11_STRUKTUR_SY_STRUKTUR.

Data lv_nummer type i.
Data lv_string type string Value 'TESTTEXT'.
lv_nummer = 3.

Find 'T' IN lv_string.
if sy-subrc EQ 0.
  Write : / 'T wurde gefunden'.
  else.
  Write : / 'T wurde nicht gefunden'.
  endif.
*if lv_nummer gt 2.
*Write : 'lv_nummer', lv_nummer.
*endif.

write : 'Ende des Programs'.
Data lv_datum type sy-datlo.



Data lv_ausgabe Type string.
Data lv_tag Type string.
Data lv_monat Type string.
Data lv_jahr Type string.

lv_datum = sy-datlo.
write :/ lv_datum+6(2).
write :/ sy-datlo.

lv_tag = lv_datum+6(2).
lv_monat = lv_datum+4(2).
lv_jahr = lv_datum(4).

Concatenate lv_tag lv_monat lv_jahr into lv_ausgabe SEPARATED BY '.'.
write :/ 'Date in German format', lv_ausgabe.

uline.

Data lv_zeit type sy-uzeit.
Data lv_uhr Type string.
Data lv_min Type string.
Data lv_sekunde Type string.

lv_zeit = sy-uzeit.

lv_sekunde = lv_zeit+4(2).
lv_min = lv_zeit+2(2).
lv_uhr = lv_zeit(2).

write :/ lv_zeit.


*SPLIT lv_zeit AT ':' INTO : lv_uhr lv_min lv_sekunde.

Write :/ 'Hour :', lv_uhr.
Write :/ 'Minute :', lv_min.
Write :/ 'Second :', lv_sekunde.
