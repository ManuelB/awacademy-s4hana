CLASS zcl_T01_generate_travel_data DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_T01_generate_travel_data IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    DATA itab TYPE TABLE OF zt01_travel.

*   fill internal travel table (itab)
    itab = VALUE #(
      ( mykey = '02D5290E594C1EDA93815057FD946624' travel_id = '00000022' agency_id = '00000310' customer_id = '00000700' begin_date = '20220624' end_date = '20220628' booking_fee = '60.00' total_price =  '750.00' currency_code = 'USD'
        description = 'traveling with dog' overall_status = 'O' created_by = 'MUSTERMANN' created_at = '20220612133945.5960060' last_changed_by = 'MUSTERFRAU' last_changed_at = '20220702105400.3647680' )
      ( mykey = '02D5290E594C1EDA93815C50CD7AE62A' travel_id = '00000106' agency_id = '00000284' customer_id = '00000699' begin_date = '20220613' end_date = '20220716' booking_fee = '17.00' total_price = '650.00' currency_code = 'EUR'
        description = 'uses cane for walking support' overall_status = 'A' created_by = 'MUSTERMANN' created_at = '20220613111129.2391370' last_changed_by = 'MUSTERMANN' last_changed_at = '20220711140753.1472620' )
      ( mykey = '02D5290E594C1EDA93858EED2DA2EB0B' travel_id = '00000103' agency_id = '00000319' customer_id = '00000695' begin_date = '20220610' end_date = '20220714' booking_fee = '17.00' total_price = '800.00' currency_code = 'EUR'
        description = 'business trip' overall_status = 'X' created_by = 'MUSTERFRAU' created_at = '20220613105654.4296640' last_changed_by = 'MUSTERFRAU' last_changed_at = '20220613111041.2251330' )
    ).

*   delete existing entries in the database table
    DELETE FROM zt01_travel.
    out->write( |Removed { sy-dbcnt } entries from travel table.| ).

*   insert the new table entries
    INSERT zt01_travel FROM TABLE @itab.

*   output the result as a console message
    out->write( |Inserted { sy-dbcnt } entries into travel table successfully!| ).

  ENDMETHOD.
ENDCLASS.

