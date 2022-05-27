*&---------------------------------------------------------------------*
*& Report Z_S11_SPFLI
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s11_spfli.

*Data ls_spfli type spfli.
*Data lt_spfli type table of spfli.
*
*Select * INTO ls_spfli From spfli.

SELECT * INTO TABLE @DATA(lt_spfli)
   FROM spfli.

BREAK-POINT.

INSERT ZS11_spfli FROM TABLE lt_spfli.

IF sy-subrc = 0.
  COMMIT WORK.
ENDIF.


*SELECT * INTO TABLE @DATA(lt_sflight)
* FROM sflight.
*
*BREAK-POINT.
*
*INSERT ZS11_sflight FROM TABLE lt_sflight.
*
*IF sy-subrc = 0.
*  COMMIT WORK.
*ENDIF.
