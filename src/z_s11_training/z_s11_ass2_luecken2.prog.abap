*&---------------------------------------------------------------------*
*& Report Z_S11_ASS2_LUECKEN2
REPORT Z_S11_ASS2_LUECKEN2.
CLASS pkw definition.
PUBLIC SECTION.
METHODS: change_owner importing im_owner TYPE string.
DATA:
kennz TYPE string,
owner TYPE string,
akt_ort TYPE string.
ENDCLASS.
CLASS pkw IMPLEMENTATION.
  METHOD change_owner.
    me->owner = im_owner.
ENDMETHOD.
endclass.

DATA: mein_auto TYPE REF TO PKW.
PARAMETERS:
nr TYPE string DEFAULT 'A-RK 256',
own1 TYPE string DEFAult 'Hugo',
Own2 TYPE string DEfAULT 'Susi',
ort TYPE string DEFAulT 'Augsburg'.

START-OF-SELECTION.
create OBJECT mein_auto.
mein_auto->kennz = nr.
mein_auto->owner = own1.
mein_auto->akt_ort = ort.
mein_auto->change_owner( own2 ).
WRITE:/ 'Besitzer: ', mein_auto->owner.
