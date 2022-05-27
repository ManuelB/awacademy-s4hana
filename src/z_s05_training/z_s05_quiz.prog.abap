*&---------------------------------------------------------------------*
*& Report Z_S05_QUIZ
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_QUIZ.


DO 3 TIMES.
  write: / sy-index.
  DO 2 TIMES.
    IF sy-index = 1.
      WRITE sy-index.
      EXIT.
      ENDIF.
      ENDDO.
      IF sy-index MOD 2 = 0.
        CONTINUE.
        ENDIF.
        WRITE sy-index.
        ENDDO.
