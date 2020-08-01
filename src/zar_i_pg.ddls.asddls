@AbapCatalog.sqlViewName: 'ZARIPG'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Basic view - Product Groups'
define view ZAR_I_PG
  as select from zar_d_prod_group
{
  key pgid,
      pgname,
      imageurl
}
