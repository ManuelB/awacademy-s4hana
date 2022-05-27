//@AbapCatalog.sqlViewName: 'ZISU_TARIFF'
//@AbapCatalog.compiler.compareFilter: true
//@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Data Model'

define root view entity ZSD_DD_Tarife
  as select from zisu_fp_tarife
{

      @UI: {
      selectionField: [ { position: 10 } ] ,
      lineItem:       [ { position: 10} ],
      identification: [ { position: 10 } ] }


  key anbietername        as Anbietername,
      @UI: {
      selectionField: [ { position: 20 } ] ,
      lineItem:       [ { position: 20} ],
      identification: [ { position: 20 } ]
      }
  key anbietertarif       as Anbietertarif,

//               @UI: {
//                selectionField: [ { position: 10 } ] ,
//                lineItem:       [ { position: 10} ],
//                identification: [ { position: 10 } ] }
//          mon_pauschale as Mon_Pauschale,
      @UI: {
       selectionField: [ { position: 30 } ] ,
       lineItem:       [ { position: 30} ],
       identification: [ { position: 30 } ] }
      arbeitspreis        as Arbeitspreis,
      @UI: {
       selectionField: [ { position: 40 } ] ,
       lineItem:       [ { position: 40} ],
       identification: [ { position: 40 } ] }
      abschlag            as Abschlag,
      @UI: {
       selectionField: [ { position: 50 } ] ,
       lineItem:       [ { position: 50} ],
       identification: [ { position: 50 } ] }
      bonus               as Bonus,
      @UI: {
      selectionField: [ { position: 60 } ] ,
      lineItem:       [ { position: 60} ],
      identification: [ { position: 60 } ] }
      empfehlungsrate     as Empfehlungsrate,
      @UI: {
      selectionField: [ { position: 70 } ] ,
      lineItem:       [ { position: 70} ],
      identification: [ { position: 70 } ] }
      preisgarantie       as Preisgarantie,
      @UI: {
      selectionField: [ { position: 80 } ] ,
      lineItem:       [ { position: 80} ],
      identification: [ { position: 80 } ] }
      laufzeit            as Laufzeit,
      @UI: {
      selectionField: [ { position: 90 } ] ,
      lineItem:       [ { position: 90} ],
      identification: [ { position: 90 } ] }
      vertverl_monate     as Vertverl_Monate,
      @UI: {
      selectionField: [ { position: 100 } ] ,
      lineItem:       [ { position: 100} ],
      identification: [ { position: 100 } ] }
      frist               as Frist,
      @UI: {
      selectionField: [ { position: 110 } ] ,
      lineItem:       [ { position: 110} ],
      identification: [ { position: 110 } ] }
      oeko_anteil         as Oeko_Anteil,
      @UI: {
      selectionField: [ { position: 120 } ] ,
      lineItem:       [ { position: 120} ],
      identification: [ { position: 120 } ] }
      co2_anteil          as Co2_Anteil,
      @UI: {
      selectionField: [ { position: 130 } ] ,
      lineItem:       [ { position: 130} ],
      identification: [ { position: 130 } ] }
      radioaktiver_abfall as Radioaktiver_Abfall
}
