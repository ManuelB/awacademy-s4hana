*&---------------------------------------------------------------------*
*& Report z_grp03_copy_table
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_grp03_copy_table.

Data: itab1 type table of ZGRP03_SWEETS,
      itab2 type table of ZGRP3_SWEETS.

* itab2 is of new table type created from some fields of tab1

* In the select statement below you can select few fields depending upon your requirement
select * from ZGRP03_SWEETS into table itab1.

APPEND LINES OF itab1 TO itab2.

INSERT ZGRP3_SWEETS CLIENT SPECIFIED FROM TABLE itab2.
