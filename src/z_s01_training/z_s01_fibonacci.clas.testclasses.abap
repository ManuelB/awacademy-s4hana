*"* use this source file for your ABAP unit test classes

*
CLASS lcl_test DEFINITION FOR TESTING
  "#AU Risk_Level Harmless
  "#AU Duration   Short
.
  PUBLIC SECTION.
    METHODS: test_0_calculate FOR TESTING.
    METHODS: test_1_calculate FOR TESTING.
    METHODS: test_11_calculate FOR TESTING.
ENDCLASS.                    "lcl_test DEFINITION
*
CLASS lcl_test IMPLEMENTATION.
  METHOD test_0_calculate.
    DATA:
         lc_fibonacci TYPE REF TO Z_S01_FIBONACCI,
         lv_result TYPE i.
*
    CREATE OBJECT lc_fibonacci.
    lv_result = lc_fibonacci->calculate( 0 ).
*
    cl_aunit_assert=>assert_equals(
        EXP                  = 0
        act                  = lv_result
        msg                  = 'something wrong'
    ).
  ENDMETHOD.
  METHOD test_1_calculate.
    DATA:
         lc_fibonacci TYPE REF TO Z_S01_FIBONACCI,
         lv_result TYPE i.
*
    CREATE OBJECT lc_fibonacci.
    lv_result = lc_fibonacci->calculate( 1 ).
*
    cl_aunit_assert=>assert_equals(
        EXP                  = 1
        act                  = lv_result
        msg                  = 'something wrong'
    ).
  ENDMETHOD.

  METHOD test_11_calculate.
    DATA:
         lc_fibonacci TYPE REF TO Z_S01_FIBONACCI,
         lv_result TYPE i.
*
    CREATE OBJECT lc_fibonacci.
    lv_result = lc_fibonacci->calculate( 11 ).
*
    cl_aunit_assert=>assert_equals(
        EXP                  = 89
        act                  = lv_result
        msg                  = 'something wrong'
    ).
  ENDMETHOD.

ENDCLASS.
