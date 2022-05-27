*&---------------------------------------------------------------------*
*& Report ZAWT03_T83_RTTI
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s11_rtti.

*- type description
*TYPES:
*  my_type TYPE i.
*
*DATA:
*  my_data   TYPE my_type,
*  descr_ref TYPE REF TO cl_abap_typedescr.
*
*START-OF-SELECTION.
*  descr_ref = cl_abap_typedescr=>describe_by_data( my_data ).
*
*  WRITE: / 'Typename:', descr_ref->absolute_name.
*  WRITE: / 'Kind    :', descr_ref->type_kind.
*  WRITE: / 'Length  :', descr_ref->length.
*  WRITE: / 'Decimals:', descr_ref->decimals.

******************************************************************
*  DATA:
*    s_sbook TYPE sbook,
**- reference to structure descriptor
*    lr_rtti TYPE REF TO cl_abap_structdescr,
*    t_comp  TYPE abap_compdescr_tab.
*
*START-OF-SELECTION.
**-- structure description declared in report
*  lr_rtti ?= cl_abap_typedescr=>describe_by_data( s_sbook ).
*  cl_demo_output=>display( lr_rtti->components ).

*-- structure description dynamic generated structure, defined by
*   selected fields

DATA lr_rtti TYPE REF TO cl_abap_structdescr.
SELECT SINGLE carrid, connid INTO @DATA(s_sflight) FROM sflight
WHERE carrid = 'LH'.

lr_rtti ?= cl_abap_typedescr=>describe_by_data( s_sflight ).

cl_demo_output=>display( lr_rtti->components ).
