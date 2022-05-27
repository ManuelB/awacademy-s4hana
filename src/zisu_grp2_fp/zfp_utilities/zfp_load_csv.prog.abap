*&---------------------------------------------------------------------*
*& Report ZFP_LOAD_CSV
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zfp_load_csv MESSAGE-ID zmsg_fp_grp2.

*--
DATA: csv   TYPE REF TO zfp_cl_csv_load,
      table TYPE string,
      file  TYPE string.
*--
PARAMETERS: p_table TYPE tabname   DEFAULT 'ZISU_FP_TARIFE25',
            p_file  TYPE localfile DEFAULT 'C:\Users\labuser\Desktop\stromanbieter2.csv'.

START-OF-SELECTION.

*--
  CREATE OBJECT csv.
*--
  table = p_table. file = p_file.
  csv->load_csv_file( file ).
  csv->transform_csv_data( table ).
  csv->get_csv_data( table ).
