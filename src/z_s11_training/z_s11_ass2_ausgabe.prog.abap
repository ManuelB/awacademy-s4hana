*&---------------------------------------------------------------------*
*& Report Z_S11_ASS2_AUSGABE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S11_ASS2_AUSGABE.


iNTERfACE J.
EVENTS: e.
METHODS: ma,
on_e FOR EVENT e OF j.
DATA: count TYPE i.
ENDINTERFACE.
*
CLASS k DEFINITION.
PUBLIC SECTION.
INTERFACES: j.
METHODS:
ma,
constructor IMPORTING im_limit TYPE i.
PRIVATE SECTION.
DATA: limit TYPE i VALUE 9.
ENDCLASS.
CLASS k IMPLEMENTATION.
METHOD cOnstructor.
limit = im_limit.
SET HANDLER J~on_e FOR me.
ENDMETHOD.
METHOD ma.
WHILE j~count < limit.
WRITE: j~count.
ADD 1 TO j~count.
ENDWHiLE.
RAISE EVENT j~e.
eNDMETHOD.
METHOD J~ma.
WHILE j~count > 0.
WRITE: j~count.
SUBTRACT 1 FROM J~Count.
ENDWHILE.
RAISE EVENT j~e.
ENDMETHOD.
METHOD j~on_e.
WRITE:'ok'. SKIP.
eNDMETHOD.
endclass.

START-OF-SELECTION.
DATA:
k_ref TYPE REF TO k.
PARAMETERS:
p_limit TYPE i DEFAULT 5.
CREATE OBJECT k_ref
 EXPORTING
im_limit = p_limit.
k_ref->j~count = 3.
CALL METHOD : k_ref->j~ma, k_ref->ma.
