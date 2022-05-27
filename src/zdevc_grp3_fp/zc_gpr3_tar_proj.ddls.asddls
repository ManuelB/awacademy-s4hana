@AbapCatalog.sqlViewName: 'ZSD_DD_GRP3_PRO'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection view Tarife'
define root view ZC_GPR3_TAR_PROJ as select from ZSD_DD_GRP3_TAR {


 @UI.facet: [ { id:              'Anbieternamme',
                     purpose:         #STANDARD,
                     type:            #IDENTIFICATION_REFERENCE,
                     label:           'Anbieternamme',
                     position:        10 } ]
    key Anbietername,
    key Anbietertarif,
    Mon_Pauschale,
    Arbeitspreis,
    Abschlag,
    Bonus,
    Empfehlungsrate,
    Preisgarantie,
    Laufzeit,
   Vertverl_Monate,
    Frist,
    Oeko_Anteil,
    Co2_Anteil,
    Radioaktiver_Abfall
}
