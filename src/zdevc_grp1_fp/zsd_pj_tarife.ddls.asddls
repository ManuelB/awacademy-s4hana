@EndUserText.label: 'Projection View'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZSD_PJ_TARIFE
  as projection on ZSD_DD_Tarife
{

//      @UI.facet: [ {   id:              'Anbietername',
//                         purpose:         #STANDARD,
//                         type:            #IDENTIFICATION_REFERENCE,
//                         label:           'Anbieter',
//                         position:        10 } ]
  key Anbietername,
//          @UI.facet: [ { id:              'Anbietertarif',
//                           purpose:         #STANDARD,
//                           type:            #HEADERINFO_REFERENCE,
//                           label:           'Anbietertarif',
//                           position:        20 } ]
  key Anbietertarif,
      //    @UI.facet: [ { id:              'Arbeitspreis',
      //                     purpose:         #STANDARD,
      //                     label:           'Arbeitspreis',
      //                     position:        30 } ]
      Arbeitspreis,
      //    @UI.facet: [ { id:              'Abschlag',
      //                     purpose:         #STANDARD,
      //                     label:           'Abschlag',
      //                     position:        40 } ]
      Abschlag,
      //    @UI.facet: [ { id:              'Bonus',
      //                     purpose:         #STANDARD,
      //                     label:           'Bonus',
      //                     position:        50 } ]
      Bonus,
      //    @UI.facet: [ { id:              'Empfehlungsrate',
      //                     purpose:         #STANDARD,
      //                     label:           'Empfehlungsrate',
      //                     position:        60 } ]
      Empfehlungsrate,
      //    @UI.facet: [ { id:              'Preisgarantie',
      //                     purpose:         #STANDARD,
      //                     label:           'Preisgarantie',
      //                     position:        70 } ]
      Preisgarantie,
      //    @UI.facet: [ { id:              'Laufzeit',
      //                     purpose:         #STANDARD,
      //                     label:           'Laufzeit',
      //                     position:        80 } ]
      Laufzeit,
      //    @UI.facet: [ { id:              'Vertverl_Monate',
      //                     purpose:         #STANDARD,
      //                     label:           'Vertverl_Monate',
      //                     position:        90 } ]
      Vertverl_Monate,
      //    @UI.facet: [ { id:              'Frist',
      //                     purpose:         #STANDARD,
      //                     label:           'Frist',
      //                     position:        100 } ]
      Frist,
      //    @UI.facet: [ { id:              'Oeko_Anteil',
      //                     purpose:         #STANDARD,
      //                     label:           'Oeko_Anteil',
      //                     position:        110 } ]
      Oeko_Anteil,
      //    @UI.facet: [ { id:              'Co2_Anteil',
      //                     purpose:         #STANDARD,
      //                     label:           'Co2_Anteil',
      //                     position:        120 } ]
      Co2_Anteil,
      //    @UI.facet: [ { id:              'Radioaktiver_Abfall',
      //                     purpose:         #STANDARD,
      //                     label:           'Radioaktiver_Abfall',
      //                     position:        130 } ]
      Radioaktiver_Abfall
}
