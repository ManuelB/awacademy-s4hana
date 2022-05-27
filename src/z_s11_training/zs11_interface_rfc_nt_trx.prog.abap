*&---------------------------------------------------------------------*
*& Report ZBC_INTERFACE_RFC_NT_TRX
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs11_interface_rfc_nt_trx.

DATA: it_params TYPE STANDARD TABLE OF tpara.

START-OF-SELECTION.
* Parameter für die Transaktion
  it_params = VALUE #( ( paramid = 'BUK' partext = '0001' )
                       ( paramid = 'BLN' partext = '12345678' )
                       ( paramid = 'GJR' partext = '2016' ) ).

* RFC-Aufruf für Transaktion FB03 in neuem Task
  CALL FUNCTION 'CC_CALL_TRANSACTION_NEW_TASK' STARTING NEW TASK 'FB03_TASK' DESTINATION 'NONE'
    EXPORTING
      transaction           = 'FB03'
      skip_first_screen     = abap_false
    TABLES
      paramtab              = it_params
    EXCEPTIONS
      communication_failure = 97
      system_failure        = 98
      OTHERS                = 99.

  IF sy-subrc NE 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.
