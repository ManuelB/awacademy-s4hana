*&---------------------------------------------------------------------*
*& Report Z_S05_UA7
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s05_ua7.

PARAMETERS:
p_op TYPE zs05_operator2 DEFAULT '+'.


DATA: ergebnis TYPE p LENGTH 7 DECIMALS 2.


TYPES:
  BEGIN OF lty_rech,
    op  TYPE i,
    p0  TYPE p LENGTH 3 DECIMALS 2,
    p1  TYPE p LENGTH 3 DECIMALS 2,
    p2  TYPE p LENGTH 3 DECIMALS 2,
    p3  TYPE p LENGTH 3 DECIMALS 2,
    p4  TYPE p LENGTH 3 DECIMALS 2,
    p5  TYPE p LENGTH 3 DECIMALS 2,
    p6  TYPE p LENGTH 3 DECIMALS 2,
    p7  TYPE p LENGTH 3 DECIMALS 2,
    p8  TYPE p LENGTH 3 DECIMALS 2,
    p9  TYPE p LENGTH 3 DECIMALS 2,
    p10 TYPE p LENGTH 3 DECIMALS 2,
  END OF lty_rech.

DATA ls_rech TYPE lty_rech.
DATA lt_rech TYPE TABLE OF lty_rech.



*
*IF p_op EQ '+'.
*
*
**  ls_rech-p0   = 0.
*  ls_rech-p1   = 1.
*  ls_rech-p2   = 2.
*  ls_rech-p3   = 3.
*  ls_rech-p4   = 4.
*  ls_rech-p5   = 5.
*  ls_rech-p6   = 6.
*  ls_rech-p7   = 7.
*  ls_rech-p8   = 8.
*  ls_rech-p9   = 9.
*  ls_rech-p10  = 10.
**  APPEND ls_rech TO lt_rech.
*
*  PERFORM sum CHANGING ls_rech.
**   ls_rech-p0
*   ls_rech-p1
*   ls_rech-p2
*   ls_rech-p3
*   ls_rech-p4
*   ls_rech-p5
*   ls_rech-p6
*   ls_rech-p7
*   ls_rech-p8
*   ls_rech-p9
*   ls_rech-p10.
*
*  APPEND ls_rech TO lt_rech.
*  cl_demo_output=>display( lt_rech ).
*ELSEIF p_op EQ '*'.
*
*
*  ls_rech-p0   = 0.
*  ls_rech-p1   = 1.
*  ls_rech-p2   = 2.
*  ls_rech-p3   = 3.
*  ls_rech-p4   = 4.
*  ls_rech-p5   = 5.
*  ls_rech-p6   = 6.
*  ls_rech-p7   = 7.
*  ls_rech-p8   = 8.
*  ls_rech-p9   = 9.
*  ls_rech-p10  = 10.








*
*  PERFORM mul CHANGING lt_rech.
*  PERFORM mul CHANGING ls_rech-p0.
*  PERFORM mul CHANGING ls_rech-p1.
*  PERFORM mul CHANGING ls_rech-p2.
*  PERFORM mul CHANGING ls_rech-p3.
*  PERFORM mul CHANGING ls_rech-p4.
*  PERFORM mul CHANGING ls_rech-p5.
*  PERFORM mul CHANGING ls_rech-p6.
*  PERFORM mul CHANGING ls_rech-p7.
*  PERFORM mul CHANGING ls_rech-p8.
*  PERFORM mul CHANGING ls_rech-p9.
*  PERFORM mul CHANGING ls_rech-p10.
*
*ELSE.
*
*ENDIF.

*
**
*FORM sum CHANGING ls_rech.
*   ls_rech1
*   ls_rech2
*   ls_rech3
*   ls_rech4
*   ls_rech5
*   ls_rech6
*   ls_rech7
*   ls_rech8
*   ls_rech9
*   ls_rech10.
*
*
*
*
**
*DO 10 TIMES.
*ls_rech = ls_rech + 1.
*     "ADD 1 TO ls_rech-p1.
*
*   APPEND ls_rech TO lt_rech.
*
**enddo.
**cl_demo_output=>display( lt_rech ).
*ENDFORM.
ls_rech-op = 0.
ls_rech-p0   = 0.
ls_rech-p1   = 1.
ls_rech-p2   = 2.
ls_rech-p3   = 3.
ls_rech-p4   = 4.
ls_rech-p5   = 5.
ls_rech-p6   = 6.
ls_rech-p7   = 7.
ls_rech-p8   = 8.
ls_rech-p9   = 9.
ls_rech-p10  = 10.
*APPEND ls_rech TO lt_rech.

CASE p_op.
  WHEN '+'.



    DO 10 TIMES.

      ADD 1 TO ls_rech-op.
      ADD 1 TO ls_rech-p0.
      ADD 1 TO ls_rech-p1.
      ADD 1 TO ls_rech-p2 .
      ADD 1 TO ls_rech-p3  .
      ADD 1 TO ls_rech-p4 .
      ADD 1 TO ls_rech-p5 .
      ADD 1 TO ls_rech-p6 .
      ADD 1 TO ls_rech-p7  .
      ADD 1 TO ls_rech-p8  .
      ADD 1 TO ls_rech-p9  .
      ADD 1 TO ls_rech-p10 .


*    IF ls_rech-op1 GT 10.
*      EXIT.
*    ENDIF.
      APPEND ls_rech TO lt_rech.
    ENDDO.

    cl_demo_output=>display( lt_rech ).
    CLEAR ls_rech.

  WHEN '*'.
    DO 1 TIMES.
ls_rech-op = 0.
ls_rech-p0 = 0.
ls_rech-p1 = 0.
ls_rech-p2 = 0.
ls_rech-p3  = 0.
ls_rech-p4  = 0.
ls_rech-p5  = 0.
ls_rech-p6  = 0.
ls_rech-p7  = 0.
ls_rech-p8  = 0.
ls_rech-p9  = 0.
ls_rech-p10 = 0.
APPEND ls_rech TO lt_rech.
ENDDO.

      DO 10 TIMES.

        ADD 1 TO ls_rech-op.
        MULTIPLY ls_rech-p0 BY 1.
        ADD 1 TO ls_rech-p1.
        ADD 2 TO ls_rech-p2 .
        ADD 3 TO ls_rech-p3  .
        ADD 4 TO ls_rech-p4 .
        ADD 5 TO ls_rech-p5 .
        ADD 6 TO ls_rech-p6 .
        ADD 7 TO ls_rech-p7  .
        ADD 8 TO ls_rech-p8  .
        ADD 9 TO ls_rech-p9  .
        ADD 10 TO ls_rech-p10 .
*ls_rech-op->set_short_text( '+' ).
*  alv->get_columns( )->get_column( 'op' )->set_short_text( '+' ).
        APPEND ls_rech TO lt_rech.

      ENDDO.

      cl_demo_output=>display( lt_rech ).
  ENDCASE.

*ls_rech-op = 0.

*   DO 10 TIMES.
*
*  ADD 1 TO ls_rech-op2.
*  if ls_rech-op2 GT 10.
*    EXIT.
*    ENDIF.


*  ENDDO.
