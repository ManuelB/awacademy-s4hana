*&---------------------------------------------------------------------*
*& Report Z_S09_RFC
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s09_rfc.

DATA: fil_line  TYPE ZSD_MW_FIL,
      fil_table TYPE TABLE OF ZSD_MW_FIL,
      t_result  TYPE bapiret2_t.

SELECT filialbezeichnung, ort, strasse, TELEFON  FROM ZSD_MW_FIL INTO CORRESPONDING FIELDS OF @fil_line. endselect.

  DATA:
    i_FILIALNUMMER      TYPE ZSD_MW_FIL-filialnummer,
    i_FILIALBEZEICHNUNG TYPE ZSD_MW_FIL-filialbezeichnung,
    i_ORT               TYPE ZSD_MW_FIL-ort,
    i_STRASSE           TYPE ZSD_MW_FIL-strasse,
    i_PLZ               TYPE ZSD_MW_FIL-plz,
    i_TELEFON           TYPE ZSD_MW_FIL-telefon,
    i_benutzer          TYPE sy-uname,
    i_datum             TYPE sy-datlo.


  DATA: new_task TYPE char10.

  LOOP AT fil_table INTO fil_line.

    CALL FUNCTION 'ZS09_FUBA_RFC'
      EXPORTING
        i_filialbezeichnung       = fil_line-FILIALNUMMER
        i_ort                     = fil_line-ort
        i_strasse                 = fil_line-strasse
        i_plz                     = fil_line-plz
       I_TELEFON                 = fil_line-telefon
*     IMPORTING
*       EX_FILNUM                 =
      TABLES
        t_return                  = t_result.
              .


  ENDLOOP.
