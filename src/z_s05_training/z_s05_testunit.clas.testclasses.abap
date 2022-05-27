*"* use this source file for your ABAP unit test classes

CLASS lcl_test DEFINITION FOR TESTING
  "#AU Risk_Level Harmless
  "#AU Duration   Short
.
public section.


methods: test_1 for testing.
endclass.


CLASS lcl_test implementation.
method test_1.
data: lo_zahl type ref to z_s05_testunit,
lv_result type i.

create object lo_zahl.
lv_result = lo_zahl->write_zahl( 1 ).
cl_aunit_assert=>assert_equals(
        EXP                  = 2
        act                  = lv_result
        msg                  = 'etwas ist falsch'
         ).

endmethod.


endclass.
