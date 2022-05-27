*&---------------------------------------------------------------------*
*& Report ZAWT03_HASHVALUE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZS01_HASHVALUE.


*MD5, SHA1, SHA256, SHA384, SHA512
DATA(lv_algo) = |MD5|.

* zu kodierende String-Daten
DATA(lv_data) = |SELECT * INTO TABLE @DATA(t_result)FROM vbak WHERE kunnr IN @s_kunnr AND auart IN @s_auart|.

* Hash-Wert als Hex-Encoded String
DATA: lv_hashstring TYPE string.

* Hash-Wert binär als XString
DATA: lv_hashxstring TYPE xstring.

* Hash-Wert als Base64-Encoded String
DATA: lv_hashb64string TYPE string.

TRY.
* Generische Hash-Funktion (Char-Input)
    cl_abap_message_digest=>calculate_hash_for_char( EXPORTING
                                                       if_algorithm     = lv_algo
                                                       if_data          = lv_data
                                                     IMPORTING
                                                       ef_hashstring    = lv_hashstring
                                                       ef_hashxstring   = lv_hashxstring
                                                       ef_hashb64string = lv_hashb64string ).
    cl_demo_output=>write_data( lv_algo ).
    cl_demo_output=>write_data( lv_data ).
    cl_demo_output=>write_data( lv_hashstring ).
    cl_demo_output=>write_data( lv_hashxstring ).
    cl_demo_output=>write_data( lv_hashb64string ).
    cl_demo_output=>display( ).

  CATCH cx_root INTO DATA(e_txt).
    WRITE: / e_txt->get_text( ).

ENDTRY.
