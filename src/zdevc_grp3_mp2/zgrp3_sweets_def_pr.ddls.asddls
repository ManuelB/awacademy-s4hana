@EndUserText.label: 'ASweets Projektion'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZGRp3_SWEETS_DEF_PR as projection on zgrp3_sweets_DEF {
    key Artikelnummer,
    Artikelgruppe,
    Artikelname,
//     Activeflag as Activeflag,
//      Datum as Datum,
    Uname
}
