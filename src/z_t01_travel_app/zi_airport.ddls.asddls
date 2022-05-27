@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Airport View - CDS Data Model'
@Search.searchable: true
define view entity ZI_AIRPORT
  as select from sairport
{
      @Search.defaultSearchElement: true
      @ObjectModel.text.element: ['Name']
 key id as AirportId,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @Semantics.text: true    
      name as Name,
    
      time_zone as TimeZn
}
