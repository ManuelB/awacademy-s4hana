*&---------------------------------------------------------------------*
*& Report Z_S02_RFC
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s02_rfc.

DATA: fil_line TYPE zsd_grp1_fs_cg.
DATA: fil_table TYPE TABLE OF zsd_grp1_fs_cg.
DATA: t_result TYPE bapiret2_t.

SELECT filnr, filname, strasse, plz, ort
  FROM zsd_grp1_fs_cg
  INTO CORRESPONDING FIELDS OF TABLE @fil_table.

DATA i_filialnr TYPE zsd_grp1_fs_cg-filialnr.
DATA i_filname  TYPE zsd_grp1_fs_cg-filname.
DATA i_strasse  TYPE zsd_grp1_fs_cg-strasse.
DATA i_plz      TYPE zsd_grp1_fs_cg-plz.
DATA i_ort      TYPE zsd_grp1_fs_cg-ort.

DATA: new_task TYPE char10.

LOOP AT fil_table INTO fil_line.




  CALL FUNCTION ''  " GROSS
    EXPORTING
      i_filialnr = fil_line-filialnr
      i_filname  = fil_line-filname
      i_strasse  = fil_line-strasse
      i_plz      = fil_line-plz
      i_ort      = fil_line-ort
    TABLES
      t_return   = t_result.
ENDLOOP.
