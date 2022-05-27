CLASS z_s05_testunit DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

  DATA: lv_zahl type i..
        methods: write_zahl importing im_zahl type i
        returning value(re_zahl) type i.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS z_s05_testunit IMPLEMENTATION.

method write_zahl.
if im_zahl EQ 1.
re_zahl = 2.
elseif
im_zahl EQ 2.
re_zahl = 3.
endif.
endmethod.
ENDCLASS.
