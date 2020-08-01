@AbapCatalog.sqlViewName: 'ZARIUOM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Bacis view - UOMs'
define view ZAR_I_UOM
  as select from zar_d_uom
{
      //zbk_d_uom
  key msehi,
      dimid,
      isocode

}
