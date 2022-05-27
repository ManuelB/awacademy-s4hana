*&---------------------------------------------------------------------*
*& Report Z_S12_SQL_SELECTDISTINCT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S12_SQL_SELECTDISTINCT.


*select DISTINCT cityto
*  from spfli
*  where carrid = 'LH'
*  and cityfrom = 'FRANKFURT'
*  into table @DATA(destinations).
*  cl_demo_output=>display( destinations ).

  DATA: Von TYPE spfli-cityto VALUE ' '.
  cl_demo_input=>new( )->add_field( CHANGING field = Von )->request( ).
  select DISTINCT cityfrom
  from spfli
  where carrid = 'LH'
  and cityfrom = @Von
  into table @DATA(Ziel).
  cl_demo_output=>display( Ziel ).
