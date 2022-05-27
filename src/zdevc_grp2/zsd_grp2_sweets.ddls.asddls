@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Data Model for Sweets'

//define root view entity zsd_grp2_Sweets as select from zsd_grp2_arst
// {
//    key artikelnummer as Artikelnummer,
//    artikelname as Artikelname,
//    artikelgruppe as Artikelgruppe,
//    @Semantics.amount.currencyCode: 'Waehrung'  
//    ek_netto as EkNetto,
//    @Semantics.amount.currencyCode: 'Waehrung'  
//    mvp_brutto as MvpBrutto,
//    @Semantics.amount.currencyCode: 'Waehrung'  
//    vp_brutto as VpBrutto,
//    @EndUserText.label: 'Ist der Artikel aktiv?'
//    activeflag as Activeflag,
//    dat_anlage as DatAnlage,
//    user_name_anlage as UserNameAnlage,
//    waehrung as Waehrung
//}

define root view entity zsd_grp2_Sweets as select from zsd_grp2_arst as art_stamm
inner join zsd_grp2_bes as bestand
on (art_stamm.artikelnummer = bestand.artikelnummer) 
inner join zsd_grp2_filbest as filial_stamm
on (bestand.filialnummer = filial_stamm.filialnummer)

 {
     @UI.facet: [ { id:              'Sweets',
                     purpose:         #STANDARD,
                     type:            #IDENTIFICATION_REFERENCE,
                     label:           'Sweets',
                     position:        110 } ]

       @UI.hidden: true
     key art_stamm.artikelnummer as Artikelnummer,
           
     @UI: {
          selectionField: [ { position: 10 } ] ,
          lineItem:       [ { position: 10} ],
          identification: [ { position: 10 } ] }
    filial_stamm.filialnummer as Filialnummer,
         @UI: {
      
          lineItem:       [ { position: 30} ],
          identification: [ { position: 30 } ] }
    filial_stamm.filialbezeichnung as FilialeBezeichnung,

          @UI: {
          selectionField: [ { position: 20 } ] ,
          lineItem:       [ { position: 20} ],
          identification: [ { position: 20 } ] }
    art_stamm.artikelgruppe as Artikelgruppe,
         @UI: {
     
          lineItem:       [ { position: 40} ],
          identification: [ { position: 40 } ] }
    art_stamm.artikelname as Artikelnamme,
     @Semantics.amount.currencyCode: 'Waehrung' 
          @UI: {
      
          lineItem:       [ { position: 50} ],
          identification: [ { position: 50 } ] }
    art_stamm.ek_netto as Lagereinkaufswert,
    @Semantics.amount.currencyCode: 'Waehrung'
         @UI: {
        
          lineItem:       [ { position: 60} ],
          identification: [ { position: 60 } ] }
    art_stamm.mvp_brutto as Verkaufspreis,
    @Semantics.quantity.unitOfMeasure: 'Mengeneinheit'
         @UI: {
       
          lineItem:       [ { position: 70} ],
          identification: [ { position: 70 } ] }
 bestand.akt_lagerbestand as Lagerbestand,
//       @UI: {
//       
//          lineItem:       [ { position: 80} ],
//          identification: [ { position: 80 } ] }
 art_stamm.waehrung as Waehrung,
//       @UI: {
//       
//          lineItem:       [ { position: 90} ],
//          identification: [ { position: 90 } ] }
//     
          
 bestand.menge_einheit as Mengeneinheit
 
 
}
