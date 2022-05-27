*&---------------------------------------------------------------------*
*& Report Z_S05_DATUM_PROBE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_DATUM_PROBE.

DATA lv_tag TYPE string VALUE 0.
DATA lv_monat(30) TYPE c.
DATA lv_jahr TYPE string VALUE 2022.
DATA lv_datum TYPE string.



DO 31 TIMES.


  ADD 01 TO lv_tag.
  lv_monat = 'Januar'.
  CONCATENATE  lv_tag lv_monat lv_jahr  INTO lv_datum SEPARATED BY '-'.
  CONDENSE lv_datum NO-GAPS.
   WRITE: / lv_datum.
  ENDDO.

  ULINE.

  DO 28 TIMES.

lv_tag = 0.
  ADD 01 TO lv_tag.
  lv_monat = 'Februar'.
CONCATENATE  lv_tag lv_monat lv_jahr  INTO lv_datum SEPARATED BY '-'.
  CONDENSE lv_datum NO-GAPS.
   WRITE: / lv_datum.
  ENDDO.

  ULINE.

  DO 31 TIMES.

lv_tag = 0.
  ADD 01 TO lv_tag.
  lv_monat = 'März'.
CONCATENATE  lv_tag lv_monat lv_jahr  INTO lv_datum SEPARATED BY '-'.
  CONDENSE lv_datum NO-GAPS.
   WRITE: / lv_datum.
  ENDDO.

    ULINE.

    DO 30 TIMES.

lv_tag = 0.
  ADD 01 TO lv_tag.
  lv_monat = 'April'.
CONCATENATE  lv_tag lv_monat lv_jahr  INTO lv_datum SEPARATED BY '-'.
  CONDENSE lv_datum NO-GAPS.
   WRITE: / lv_datum.
  ENDDO.

    ULINE.


    DO 31 TIMES.

lv_tag = 0.
  ADD 01 TO lv_tag.
  lv_monat = 'Mai'.
CONCATENATE  lv_tag lv_monat lv_jahr  INTO lv_datum SEPARATED BY '-'.
  CONDENSE lv_datum NO-GAPS.
   WRITE: / lv_datum.
  ENDDO.

    ULINE.

    DO 30 TIMES.

lv_tag = 0.
  ADD 01 TO lv_tag.
  lv_monat = 'Juni'.
CONCATENATE  lv_tag lv_monat lv_jahr  INTO lv_datum SEPARATED BY '-'.
  CONDENSE lv_datum NO-GAPS.
   WRITE: / lv_datum.
  ENDDO.

    ULINE.

    DO 31 TIMES.

lv_tag = 0.
  ADD 01 TO lv_tag.
  lv_monat = 'Juli'.
CONCATENATE  lv_tag lv_monat lv_jahr  INTO lv_datum SEPARATED BY '-'.
  CONDENSE lv_datum NO-GAPS.
   WRITE: / lv_datum.
  ENDDO.

  ULINE.

    DO 31 TIMES.

lv_tag = 0.
  ADD 01 TO lv_tag.
  lv_monat = 'August'.
CONCATENATE  lv_tag lv_monat lv_jahr  INTO lv_datum SEPARATED BY '-'.
  CONDENSE lv_datum NO-GAPS.
   WRITE: / lv_datum.
  ENDDO.

  ULINE.

      DO 30 TIMES.

lv_tag = 0.
  ADD 01 TO lv_tag.
  lv_monat = 'September'.
CONCATENATE  lv_tag lv_monat lv_jahr  INTO lv_datum SEPARATED BY '-'.
  CONDENSE lv_datum NO-GAPS.
   WRITE: / lv_datum.
  ENDDO.

  ULINE.

      DO 31 TIMES.

lv_tag = 0.
  ADD 01 TO lv_tag.
  lv_monat = 'Oktober'.
CONCATENATE  lv_tag lv_monat lv_jahr  INTO lv_datum SEPARATED BY '-'.
  CONDENSE lv_datum NO-GAPS.
   WRITE: / lv_datum.
  ENDDO.

  ULINE.

      DO 30 TIMES.

lv_tag = 0.
  ADD 01 TO lv_tag.
  lv_monat = 'November'.
CONCATENATE  lv_tag lv_monat lv_jahr  INTO lv_datum SEPARATED BY '-'.
  CONDENSE lv_datum NO-GAPS.
   WRITE: / lv_datum.
  ENDDO.

  ULINE.

      DO 31 TIMES.

lv_tag = 0.
  ADD 01 TO lv_tag.
  lv_monat = 'Dezember'.
CONCATENATE  lv_tag lv_monat lv_jahr  INTO lv_datum SEPARATED BY '-'.
  CONDENSE lv_datum NO-GAPS.
   WRITE: / lv_datum.
  ENDDO.

  ULINE.




"DO 12 TIMES.
  "CONCATENATE  lv_tag lv_monat lv_jahr  INTO lv_datum SEPARATED BY '-'.
  "CONDENSE lv_datum NO-GAPS.
 " WRITE: / lv_datum.


"lv_tag = 0.

 " DO 31 TIMES.

"ADD 1 to lv_tag.
 "IF lv_monat = 31.
  " AND  lv_monat = lv_mae.

   "ENDIF.
   "WRITE: / lv_tag, lv_monat, lv_jahr.
   "ENDDO.







 " CONCATENATE  lv_tag lv_monat lv_jahr  INTO lv_datum SEPARATED BY '-'.
 " CONDENSE lv_datum NO-GAPS.
  " WRITE: / lv_datum.

 " ADD 01 TO lv_tag.




 "ADD 1 TO lv_monat.
 " lv_tag = 01.
"  ENDDO.
