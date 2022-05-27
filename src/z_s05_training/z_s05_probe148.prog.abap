*&---------------------------------------------------------------------*
*& Report Z_S05_PROBE148
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_PROBE148.



select * into TABLE @data(tspfli)
  FROM zgrp3_kunde.

  modify ZS05_KUNDE_DEMO FROM TABLE tspfli.

  IF sy-subrc = 0.
    commit work.
    endif.
