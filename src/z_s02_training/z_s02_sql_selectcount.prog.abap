*&---------------------------------------------------------------------*
*& Report Z_S02_SQL_SELECTCOUNT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s02_sql_selectcount.

*** Bestimmung unterschiedlicher Werte


*SELECT COUNT( DISTINCT carrid )
*  FROM spfli
*  WHERE cityto = 'TOKYO'
*  INTO @DATA(ziel_tk).
*
*cl_demo_output=>display( ziel_TK ).


DATA: ziel TYPE spfli-cityto VALUE ' '.

cl_demo_input=>new( )->add_field( CHANGING field = ziel )->request( ).

SELECT COUNT( DISTINCT carrid )
  FROM spfli
  WHERE cityto = @ziel
  INTO @DATA(fziel).

cl_demo_output=>display( fziel ).
