@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'zgrp03_sweets'

@UI: {
 headerInfo: { typeName: 'Sweets', typeNamePlural: 'Travels', title: { type: #STANDARD, value: 'Artikelnummer' } } }

@Search.searchable: true
define root view entity zgrp3_sweets_DEF as select from zgrp3_sweets as Sweets {
@UI.facet: [ { id:              'Sweets',
                     purpose:         #STANDARD,
                     type:            #IDENTIFICATION_REFERENCE,
                     label:           'Sweets',
                     position:        10 } ]

       @UI.hidden: true
       key artikelnummer as Artikelnummer,
       @UI: {
          lineItem:       [ { position: 30, importance: #MEDIUM } ],
          identification: [ { position: 30 } ] }
       artikelgruppe as Artikelgruppe,
        @UI: {
          lineItem:       [ { position: 40, importance: #MEDIUM } ],
          identification: [ { position: 40 } ] }
       @Search.defaultSearchElement: true
       artikelname as Artikelname,
        @UI: {
          lineItem:       [ { position: 50, importance: #MEDIUM } ],
          identification: [ { position: 50 } ] }
//       min_bestand as MinBestand,
////        @UI: {
//          lineItem:       [ { position: 60, importance: #MEDIUM } ],
//          identification: [ { position: 60 } ] }
////       max_bestand as MaxBestand,
////       aktueller_lagerbestand as AktuellerLagerbestand,
//       einkauf_netto as EinkaufNetto,
//       mind_brutto as MindBrutto,
//    vk_brutto as VkBrutto,
//    activeflag as Activeflag,
      datum as Datum,
      uname as Uname }
