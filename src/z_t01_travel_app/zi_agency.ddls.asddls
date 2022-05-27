@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Agency View - CDS Data Model'
@Search.searchable: true
define view entity ZI_AGENCY
  as select from stravelag as Agency

  association [0..1] to I_Country as _Country on $projection.CountryCode = _Country.Country

{
      @Search.defaultSearchElement: true
      @ObjectModel.text.element: ['Name']
  key Agency.agencynum     as AgencyID,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @Semantics.text: true
      Agency.name          as Name,

      Agency.street        as Street,

      Agency.postcode      as PostalCode,

      @Search.defaultSearchElement: true
      Agency.city          as City,

      @Consumption.valueHelpDefinition: [{entity: { name: 'I_Country', element: 'Country' } }]
      Agency.country       as CountryCode,

      Agency.telephone     as PhoneNumber,

      Agency.url           as WebAddress,

      /* Associations */
      _Country
}
