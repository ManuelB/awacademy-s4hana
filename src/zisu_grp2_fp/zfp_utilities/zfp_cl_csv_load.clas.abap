class ZFP_CL_CSV_LOAD definition
  public
  final
  create public .

public section.

  methods GET_CSV_DATA
    importing
      !I_TABLENAME type STRING .
  methods LOAD_CSV_FILE
    importing
      !I_FILENAME type STRING .
  methods TRANSFORM_CSV_DATA
    importing
      !I_TABLENAME type STRING .
protected section.
private section.

  data G_CSV_DATA type STRINGTAB .
  data G_ERROR_FLAG type ABAP_BOOL value ABAP_FALSE ##NO_TEXT.
  data G_TAB_FIELDS type STRINGTAB .
ENDCLASS.



CLASS ZFP_CL_CSV_LOAD IMPLEMENTATION.


  METHOD get_csv_data.

    "-Structures----------------------------------------------------------
    TYPES: BEGIN OF l_typ_confrontation,
             intfieldname TYPE string,
             intfieldpos  TYPE i,
             intfieldtyp  TYPE string,
             csvfieldpos  TYPE i,
             csvfieldname TYPE string,
           END OF l_typ_confrontation.

    "-Variables-----------------------------------------------------------
    DATA l_rda_data TYPE REF TO data.
    DATA l_rda_wa TYPE REF TO data.
    DATA l_rcl_descr_tab TYPE REF TO cl_abap_tabledescr.
    DATA l_rcl_descr_struc TYPE REF TO cl_abap_structdescr.
    DATA l_comp_descr TYPE abap_compdescr.
    DATA l_tab_content TYPE STANDARD TABLE OF string.
    DATA l_line TYPE string VALUE ''.
    DATA l_tab_confrontation TYPE STANDARD TABLE OF l_typ_confrontation
      WITH KEY csvfieldpos.
    DATA l_fieldname TYPE string VALUE ''.
    DATA l_content TYPE string VALUE ''.
    DATA l_conf TYPE l_typ_confrontation.

    FIELD-SYMBOLS  <l_table> TYPE STANDARD TABLE.
    FIELD-SYMBOLS  <l_comp> TYPE any.
    FIELD-SYMBOLS  <l_wa> TYPE any.

    "-Main----------------------------------------------------------------
    IF g_csv_data IS NOT INITIAL AND g_error_flag = abap_false.

      "-Reference to Table----------------------------------------------
      CREATE DATA l_rda_data TYPE STANDARD TABLE OF (i_tablename).
      ASSIGN l_rda_data->* TO  <l_table>.
      "-Get Structure of Table------------------------------------------
      l_rcl_descr_tab ?= cl_abap_typedescr=>describe_by_data( <l_table> ).
      l_rcl_descr_struc ?= l_rcl_descr_tab->get_table_line_type( ).
      "-Define Line of Table--------------------------------------------
      CREATE DATA l_rda_wa LIKE LINE OF  <l_table>.
      ASSIGN l_rda_wa->* TO  <l_wa>.

      "-Compare Field Names of the Table with Headline of CSV-----------
      "-
      "- With this step is the position of the column indifferent. It
      "- is only necessary that the field of the table and the column
      "- of the CSV file must have the same name.
      "-
      "-----------------------------------------------------------------
      LOOP AT l_rcl_descr_struc->components INTO l_comp_descr.
        l_conf-intfieldname = l_comp_descr-name.
        l_conf-intfieldpos = sy-tabix.
        l_conf-intfieldtyp = l_comp_descr-type_kind.
        LOOP AT g_tab_fields INTO l_fieldname.
          l_conf-csvfieldpos = -1.
          l_conf-csvfieldname = 'UNKNOWN'.
          IF l_comp_descr-name = l_fieldname.
            l_conf-csvfieldname = l_fieldname.
            l_conf-csvfieldpos = sy-tabix.
            EXIT.
          ENDIF.
        ENDLOOP.
        APPEND l_conf TO l_tab_confrontation.
      ENDLOOP.
      DELETE l_tab_confrontation WHERE csvfieldpos = -1.
      SORT l_tab_confrontation BY csvfieldpos.

      "-Copy Data-------------------------------------------------------
      LOOP AT g_csv_data INTO l_line FROM 2.
        SPLIT l_line AT ';' INTO TABLE l_tab_content.
        LOOP AT l_tab_content INTO l_content.
          CONDENSE l_content.
          READ TABLE l_tab_confrontation WITH KEY csvfieldpos = sy-tabix
            INTO l_conf.
          IF sy-subrc = 0.
            ASSIGN COMPONENT l_conf-intfieldname OF STRUCTURE  <l_wa>
              TO  <l_comp>.
            IF l_conf-intfieldtyp = 'P'.
              REPLACE ALL OCCURRENCES OF '.' IN l_content WITH ''.
              REPLACE ',' IN l_content WITH '.'.
              <l_comp> = l_content.
            ELSE.
              <l_comp> = l_content.
            ENDIF.
          ENDIF.
        ENDLOOP.
        APPEND  <l_wa> TO  <l_table>.
        CLEAR  <l_wa>.
      ENDLOOP.

      "-Write Data into Table-------------------------------------------
      INSERT (i_tablename) FROM TABLE  <l_table>.
      IF sy-subrc  <> 0.
        g_error_flag = abap_true.
      ELSE.
        DATA: entries TYPE i.
        DESCRIBE TABLE <l_table> LINES entries.
        MESSAGE s009 WITH entries.
      ENDIF.

    ENDIF.

    "-End-------------------------------------------------------------------
  ENDMETHOD.


  METHOD load_csv_file.

    CALL FUNCTION 'GUI_UPLOAD'
      EXPORTING
        filename = i_filename
        filetype = 'ASC'
      TABLES
        data_tab = g_csv_data
      EXCEPTIONS
        OTHERS   = 1.

    IF sy-subrc  <> 0.
      g_error_flag = abap_true.
    ELSE.
      REPLACE ALL OCCURRENCES OF '%' IN TABLE g_csv_data WITH ''.
      REPLACE ALL OCCURRENCES OF '€' IN TABLE g_csv_data WITH ''.
    ENDIF.

  ENDMETHOD.


  METHOD transform_csv_data.

    DATA l_fld1 TYPE string VALUE ''.
    DATA l_fld2 TYPE string VALUE ''.
    DATA l_fld3 TYPE string VALUE ''.
    DATA l_fldrest TYPE string VALUE ''.

    FIELD-SYMBOLS  <line> TYPE string.

    "-Main----------------------------------------------------------------
    IF g_csv_data IS NOT INITIAL AND g_error_flag = abap_false.

      "-Manipulate Headline---------------------------------------------
      READ TABLE g_csv_data INDEX 1 ASSIGNING  <line>.
      <line> = 'MANDT;' &&  <line>.

      CONDENSE  <line> NO-GAPS.
      SPLIT  <line> AT ';' INTO TABLE g_tab_fields.

    ENDIF.

    "-Transformation----------------------------------------------------
    LOOP AT g_csv_data FROM 2 ASSIGNING  <line>.
      <line> = sy-mandt && ';' &&  <line>.
    ENDLOOP.

    "-End-------------------------------------------------------------------
  ENDMETHOD.
ENDCLASS.
