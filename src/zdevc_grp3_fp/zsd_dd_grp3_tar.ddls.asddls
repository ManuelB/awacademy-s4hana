@AbapCatalog.sqlViewName: 'ZSD_DD_GRP3'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'DD TARIFE'
define root view ZSD_DD_GRP3_TAR as select from zgrp3_tarife {


 @UI.facet: [ { id:              'Tarife',
      purpose:         #STANDARD,
      type:            #IDENTIFICATION_REFERENCE,
      label:           'Tarife',
      position:        110 } ]
      @UI.hidden: true
      
  @UI: {
      lineItem:       [ { position: 10} ],
      identification: [ { position: 10 } ] }
      
    key anbietername as Anbietername,
    
     @UI: {

      lineItem:       [ { position: 20} ],
      identification: [ { position: 20 } ] }
    key anbietertarif as Anbietertarif,
     @UI: {

      lineItem:       [ { position: 30} ],
      identification: [ { position: 30 } ] }
    mon_pauschale as Mon_Pauschale,
     @UI: {

      lineItem:       [ { position: 50} ],
      identification: [ { position: 50 } ] }
    arbeitspreis as Arbeitspreis,
     @UI: {

      lineItem:       [ { position: 100} ],
      identification: [ { position: 100 } ] }
    abschlag as Abschlag,
     @UI: {

      lineItem:       [ { position: 90} ],
      identification: [ { position: 90 } ] }
    bonus as Bonus,
    empfehlungsrate as Empfehlungsrate,
     @UI: {

      lineItem:       [ { position: 80} ],
      identification: [ { position: 80 } ] }
    preisgarantie as Preisgarantie,
     @UI: {

      lineItem:       [ { position: 40} ],
      identification: [ { position: 40 } ] }
    laufzeit as Laufzeit,
    vertverl_monate as Vertverl_Monate,
     @UI: {

      lineItem:       [ { position: 70} ],
      identification: [ { position: 70 } ] }
    frist as Frist,
    oeko_anteil as Oeko_Anteil,
     @UI: {

      lineItem:       [ { position: 60} ],
      identification: [ { position: 60 } ] }
    co2_anteil as Co2_Anteil,
    radioaktiver_abfall as Radioaktiver_Abfall
}
