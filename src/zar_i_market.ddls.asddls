@AbapCatalog.sqlViewName: 'ZARIMRKT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Basic view - Markets'
define view ZAR_I_MARKET
  as select from zar_d_market
{
  key mrktid   as MarketId,
      mrktname as MarketName,
      imageurl as ImageUrl
}
