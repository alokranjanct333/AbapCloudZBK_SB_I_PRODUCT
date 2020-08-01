@AbapCatalog.sqlViewName: 'ZARCPROD'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Product'
@Search.searchable: true
@Metadata.allowExtensions: true
define root view ZAR_C_PRODUCT
  as select from zar_d_product as _Product
  association [0..1] to ZAR_I_PG            as _ProdGr     on _Product.pgname         = _ProdGr.pgname
  association [0..1] to ZAR_I_PHASES        as _Phase      on _Product.phase          = _Phase.phase
  association [0..1] to ZAR_I_CURRENCY      as _Currency   on _Product.price_currency = _Currency.Currency
  association [0..1] to ZAR_C_USER_CONTACTS as _CreateUser on _Product.created_by     = _CreateUser.userid
  association [0..1] to ZAR_C_USER_CONTACTS as _ChangeUser on _Product.changed_by     = _ChangeUser.userid
  composition [0..*] of ZAR_C_PROD_MRKT     as _Market 
{

  key _Product.prod_uuid,
  
      @Search: {
         defaultSearchElement: true,
         ranking: #HIGH,
         fuzzinessThreshold: 0.8
        }
      _Product.prodid,
      
      @Search: {
         defaultSearchElement: true,
         ranking: #HIGH,
         fuzzinessThreshold: 0.8
      }

      @Consumption.valueHelpDefinition: [{  entity: {   name:   'ZAR_I_PG',
                                                        element:'pgid' } }]
      _ProdGr.pgid,

      @Consumption.valueHelpDefinition: [{  entity: {   name:   'ZAR_I_PG',
                                                        element:'pgname' } }]
      _Product.pgname,
      
      _ProdGr.imageurl as ImgUrl,
        
      @Consumption.valueHelpDefinition: [{  entity: {   name:    'ZAR_I_PHASES',
                                                        element: 'phase' } }]
      _Product.phase,

      case _Product.phase
             when 'PLAN' then 1
             when 'DEV'  then 2
             when 'PROD' then 3
             when 'OUT'  then 0
             else 0
      end                                                                                                     as criticality,

      @Semantics.quantity.unitOfMeasure: 'size_uom3'
      _Product.height,

      @Semantics.quantity.unitOfMeasure: 'size_uom3'
      _Product.depth,

      @Semantics.quantity.unitOfMeasure: 'size_uom3'
      _Product.width,
      @Consumption.valueHelpDefinition: [{  entity: {   name:    'ZAR_I_UOM',
                                                        element: 'msehi' } }]
      @Semantics.unitOfMeasure: true
      _Product.size_uom3,

      concat_with_space( concat_with_space(( concat_with_space( cast(_Product.height as abap.char( 11 )), 'X', 1 ) ),
                                           ( concat_with_space( cast(_Product.depth  as abap.char( 11 )), 'X', 1 ) ), 1 ),
                                                                cast(_Product.width  as abap.char( 11 )), 1 ) as size_dim,

      @Semantics.amount.currencyCode: 'price_currency'
      _Product.price,
      @Consumption.valueHelpDefinition: [{  entity: {   name:    'ZAR_I_CURRENCY',
                                                        element: 'Currency' } }]

      @Semantics.currencyCode: true
      _Product.price_currency,

      _Product.taxrate,

      _CreateUser.appuser as createuser,
      @Semantics.user.createdBy: true
      _Product.created_by,
      @Semantics.systemDateTime.createdAt: true
      cast( _Product.creation_time as timestamp )                                    as creation_time,
      
      _ChangeUser.appuser as changeuser,
      @Semantics.user.lastChangedBy: true
      _Product.changed_by,
      @Semantics.systemDateTime.lastChangedAt: true
      cast( _Product.change_time as timestamp )                                      as change_time,
//      concat(concat('/webapp/images/', cast(_ProdGr.pgid as abap.char( 3 )) ),'.jpg')     as ImgUrl
      _ProdGr,
      _Phase,
      _Currency,
      _CreateUser,
      _ChangeUser,
      _Market
}
