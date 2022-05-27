@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Data Model für artikel stamm tabelle'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@UI: {
 headerInfo: { typeName: 'Stamm', typeNamePlural: 'Travels', title: { type: #STANDARD, value: 'Artikelnummer' } } }

@Search.searchable: true
define root view entity z_art_stamm as select from zsd_grp2_arst {
    key artikelnummer as Artikelnummer, 
     @UI: {
          lineItem:       [ { position: 30, importance: #MEDIUM } ],
          identification: [ { position: 30 } ] }
    artikelgruppe as Artikelgruppe,
   @UI.facet: [ { id:              'Sweets',
                     purpose:         #STANDARD,
                     type:            #IDENTIFICATION_REFERENCE,
                     label:           'Sweets',
                     position:        10 } ]

        @UI: {
          lineItem:       [ { position: 40, importance: #MEDIUM } ],
          identification: [ { position: 40 } ] }
       @Search.defaultSearchElement: true
    artikelname as Artikelname,
   
     @UI: {
          lineItem:       [ { position: 60, importance: #MEDIUM } ],
          identification: [ { position: 60 } ] }
      @Semantics.amount.currencyCode: 'Waehrung'
    ek_netto as EkNetto,  
    @Semantics.amount.currencyCode: 'Waehrung'
    mvp_brutto as MvpBrutto,
      @UI: {
          lineItem:       [ { position: 50, importance: #MEDIUM } ],
          identification: [ { position: 50 } ] }
      @Semantics.amount.currencyCode: 'Waehrung'
    vp_brutto as VpBrutto,
    activeflag as Activeflag,
    dat_anlage as DatAnlage,
    user_name_anlage as UserNameAnlage,
 
    waehrung as Waehrung
}
