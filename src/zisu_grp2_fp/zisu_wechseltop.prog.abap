*&---------------------------------------------------------------------*
*& Include ZISU_WECHSELTOP                          - Modulpool        ZISU_WECHSEL
*&---------------------------------------------------------------------*


*----------Nachrichtenklassen---------
PROGRAM zisu_wechsel MESSAGE-ID ZMSG_FP_GRP2.


*----------Tabellen---------

TABLES: zisu_fp_kunden, zisu_fp_wechsel.

*----------Referenzen---------

DATA: lo_ref TYPE REF TO z_grp2_wechsel.

*----------Strukturen---------

DATA: ls_wechsel TYPE zisu_fp_wechsel.

*----------Variablen---------

*gv_kunnr dient zur Übernahme der Kundennummer von Dynpro 1001 zu 1002 .
    DATA:  gv_kunnr   TYPE zgrp3_kunnr.
