*&---------------------------------------------------------------------*
*& Report Z_S05_RFC_AUFGABE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s09_rfc_2.

DATA: fil_line  TYPE zsd_grp2_filbest,
      fil_table TYPE TABLE OF zsd_grp2_filbest,
      t_result  TYPE bapiret2_t.

SELECT filialbezeichnung, ort, strasse, TELEFON  FROM zsd_grp2_filbest INTO CORRESPONDING FIELDS OF @fil_line. endselect.

  DATA:
    i_FILIALNUMMER      TYPE zsd_grp2_filbest-filialnummer,
    i_FILIALBEZEICHNUNG TYPE zsd_grp2_filbest-filialbezeichnung,
    i_ORT               TYPE zsd_grp2_filbest-ort,
    i_STRASSE           TYPE zsd_grp2_filbest-strasse,
    i_PLZ               TYPE zsd_grp2_filbest-plz,
    i_TELEFON           TYPE zsd_grp2_filbest-telefon,
    i_benutzer          TYPE sy-uname,
    i_datum             TYPE sy-datlo.


  DATA: new_task TYPE char10.

  LOOP AT fil_table INTO fil_line.

    CALL FUNCTION 'ZS505_FUBA_RFC'
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
