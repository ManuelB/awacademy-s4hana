*&---------------------------------------------------------------------*
*& Report Z_S05_SCHLEIFEN_AUFGABE_2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_SCHLEIFEN_AUFGABE_2.



DATA lv_tag TYPE i VALUE 1.
DATA lv_monat TYPE i VALUE 1.
DATA lv_jahr TYPE i VALUE 2022.

DO 12 TIMES.





CASE lv_monat.
  WHEN 1.
    DO 30 TIMES.
    ADD 1 TO lv_tag.
     WRITE: / |{ lv_jahr }-{ lv_monat }-{ lv_tag }|.
    ENDDO.

    WHEN 2.
      DO 27 TIMES.
      ADD 1 TO lv_tag.
       WRITE: / |{ lv_jahr }-{ lv_monat }-{ lv_tag }|.
      ENDDO.

      WHEN 3.
        DO 30 TIMES.
      ADD 1 TO lv_tag.
       WRITE: / |{ lv_jahr }-{ lv_monat }-{ lv_tag }|.
      ENDDO.

      WHEN 4.
        DO 29 TIMES.
     ADD 1 TO lv_tag.
      WRITE: / |{ lv_jahr }-{ lv_monat }-{ lv_tag }|.
     ENDDO.

      WHEN 5.
        DO 30 TIMES.
      ADD 1 TO lv_tag.
       WRITE: / |{ lv_jahr }-{ lv_monat }-{ lv_tag }|.
      ENDDO.
      WHEN 6.

        DO 29 TIMES.
      ADD 1 TO lv_tag.
       WRITE: / |{ lv_jahr }-{ lv_monat }-{ lv_tag }|.
      ENDDO.
      WHEN 7.

        DO 30 TIMES.
      ADD 1 TO lv_tag.
       WRITE: / |{ lv_jahr }-{ lv_monat }-{ lv_tag }|.
      ENDDO.

      WHEN 8.
        DO 30 TIMES.
      ADD 1 TO lv_tag.
       WRITE: / |{ lv_jahr }-{ lv_monat }-{ lv_tag }|.
      ENDDO.

      WHEN 9.
        DO 29 TIMES.
      ADD 1 TO lv_tag.
       WRITE: / |{ lv_jahr }-{ lv_monat }-{ lv_tag }|.
      ENDDO.

      WHEN 10.
       DO 30 TIMES.
      ADD 1 TO lv_tag.
       WRITE: / |{ lv_jahr }-{ lv_monat }-{ lv_tag }|.
      ENDDO.

      WHEN 11.
        DO 29 TIMES.
      ADD 1 TO lv_tag.
       WRITE: / |{ lv_jahr }-{ lv_monat }-{ lv_tag }|.
      ENDDO.

      WHEN 12.
        DO 0 TIMES.
       ADD 1 TO lv_tag.
        WRITE: / |{ lv_jahr }-{ lv_monat }-{ lv_tag }|.
       ENDDO.


      ENDCASE.

ADD 1 TO lv_monat.
       lv_tag = 1.



ENDDO.








"DATA  lv_ausgabe TYPE string.
"DATA  lv_jahr_c TYPE string.
"DATA  lv_monat_c TYPE string.
"DATA  lv_tag_c TYPE string.

"DO 12 TIMES.

 "Do 30 TIMES.

    "lv_jahr_c = lv_jahr.
    "lv_mon_c = lv_mon.
    "lv_tag_c = lv_tag.
    "CONCATENATE lv_jahr_c '-' lv_mon_c '-' lv_tag_c INTO lv_ausgabe.2
    "WRITE: lv_ausgabe.

   "WRITE: / |{ lv_jahr }-{ lv_monat }-{ lv_tag }|.

   " ADD 1 TO lv_tag.
    "ENDDO.

   " ADD 1 TO lv_monat.
   " lv_tag = 1.
   " ENDDO.
