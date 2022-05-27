*&---------------------------------------------------------------------*
*& Report Z_S09_WRITE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s09_write.



CLASS pkw DEFINITION.
  PUBLIC SECTION.
  METHODS: change_owner
  XXX im_owner TYPE string.
  DATA:
        kennz TYPE string,
        owner TYPE string,
        akt_ort TYPE string.
  ENDCLASS.
  *
  CLASS pkw IMPLEMENTATION.
  METHOD change_owner().
    me->owner = im_owner.
    ENDMETHOD.
    ENDCLASS.

    DATA: mein_auto TYPE REF TO pkw.
    PARAMETERS:
    nr TYPE string DEFAULT 'A-RK 256',
    own1 TYPE string DEFAULT 'Hugo',
    own2 TYPE string DEFAULT 'Hubert',
    ort TYPE string DEFAULT 'München'.

    START-OF-SELECTION.
    CREATE OBJECT mein_auto.
    mein_auto->kenz = nr.
    mein_auto-<owner = own1.
    mein auto->akt-_ort = ort.
    mein_auto->change_owner( own2 ).

    WRITE: / 'Besitzer:', XXX.






*
*INTERFACE j.
*  EVENTS: e.
*  METHODS: ma,
*    on_e FOR EVENT e OF j.
*  DATA: count TYPE i.
*ENDINTERFACE.
**
*CLASS k definition.
*PUBLIC SECTION.
*  INTERFACES: j.
*  METHODS:
*    ma,
*    constructor IMPORTING im_limit TYPE i.
*PRIVATE SECTION.
*  DATA: limit TYPE i VALUE 9.
*ENDCLASS.
*CLASS k IMPLEMENTATION.
*METHOD constructor.
*  limit = im_limit.
*  SET HANDLER j~on_e FOR me.
*ENDMETHOD.
*METHOD ma.
*  WHILE j~count < limit.
*    WRITE: j~count.
*    ADD 1 TO j~count.
*  ENDWHILE.
*  RAISE EVENT j~e.
*ENDMETHOD.
*METHOD j~ma.
*  WHILE j~count > 0.
*    WRITE: j~count.
*    SUBTRACT 1 FROM j~count.
*  ENDWHILE.
*  RAISE EVENT j~e.
*ENDMETHOD.
*METHOD j~on_e.
*  WRITE: 'ok'. SKIP.
*ENDMETHOD.
*ENDCLASS.
**
*START-OF-SELECTION.
*DATA:
*      k_ref TYPE REF TO k.
*PARAMETERS:
*p_limit TYPE i DEFAULT 5.
**
*CREATE OBJECT k_ref
*EXPORTING
*  im_limit = p_limit.
*k_ref->j~count = 3.
*CALL METHOD: k_ref->j~ma, k_ref->ma.


"DATA lv_hello(5) TYPE c VALUE 'HELLO'.


"WRITE: 'Hello', 'World'.

"ULINE.

"WRITE: lv_hello, lv_hello.

"ULINE.
