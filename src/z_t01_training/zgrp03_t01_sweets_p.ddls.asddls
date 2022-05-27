@EndUserText.label: 'Projektion'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZGRP03_T01_SWEETS_P as projection on zgrp03_t01_sweets {
    @UI.facet: [ { id:              'Artikelnummer',
                     purpose:         #STANDARD,
                     type:            #IDENTIFICATION_REFERENCE,
                     label:           'Artikelnummer',
                     position:        10 } ]
    key Artikelnummer,
    Artikelgruppe,
     @UI: {
      lineItem:       [ { position: 60, importance: #HIGH },
                        { type: #FOR_ACTION,  label: 'Auslisten', url: 'Activeflag' } ],
      identification: [ { position: 60, label: 'Artikelname' } ]  }
     
    Artikelname,
    MinBestand,
    MaxBestand,
    AktuellerLagerbestand,
    EinkaufNetto,
    MindBrutto,
    VkBrutto,
    Activeflag,
    Datum,
    Uname
}
