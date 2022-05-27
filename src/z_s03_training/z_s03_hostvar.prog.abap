*&---------------------------------------------------------------------*
*& Report Z_S03_HOSTVAR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s03_hostvar.

*SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME.
*  PARAMETERS p_carr TYPE ZS03_D_AIRPFROM.
*  SELECTION-SCREEN END OF BLOCK a1.
*
*  START-OF-SELECTION.
*
*  select single * into @data(flights)
*    from sflight
*    where carrid = @p_carr.

********** Aufgabe*

*    SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME.
*  PARAMETERS: p_carr TYPE s_carr_id,
*  p_fltime TYPE s_fltime.
*  SELECTION-SCREEN END OF BLOCK a1.
*
*  START-OF-SELECTION.
*
*  select single carrid, fltime into @data(flights)
*    from spfli
*    where carrid = @p_carr
*    and fltime = @p_fltime.

****************

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME.
  PARAMETERS: p_carr   TYPE s_carr_id DEFAULT 'AA',
              p_airpf  TYPE s_fromairp,
              p_airpto TYPE s_toairp,
              p_fltime TYPE s_fltime DEFAULT '361'.
SELECTION-SCREEN END OF BLOCK a1.

START-OF-SELECTION.

  SELECT SINGLE FOR UPDATE carrid, fltime
    FROM spfli
    WHERE carrid = @p_carr
    INTO @DATA(flights).

  UPDATE spfli SET fltime = 222 WHERE carrid = @p_carr.
  IF sy-subrc EQ 0.
    COMMIT WORK.
  ENDIF.
