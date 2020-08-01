@AbapCatalog.sqlViewName: 'ZARCPRODMRKT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Basic view - Product Markets'
@Metadata.allowExtensions: true
@Search.searchable: true
define view ZAR_C_PROD_MRKT
  as select from zar_d_prod_mrkt as _Market
  association        to parent ZAR_C_PRODUCT as _Product     on _Product.prod_uuid = $projection.prod_uuid
  association [0..*] to ZAR_I_MARKET         as _MID         on _Market.mrktid     = _MID.MarketName
  association [0..*] to ZAR_C_USER_CONTACTS  as _CreateUser  on _Market.created_by = _CreateUser.userid
  association [0..*] to ZAR_C_USER_CONTACTS  as _ChangeUser  on _Market.changed_by = _ChangeUser.userid
  composition [0..*] of ZAR_C_MRKT_ORDER     as _Order      
//  association [0..*] to ZAR_I_MRKT_ORDERS    as _total    on _mrkt.mrkt_uuid = _total.mrkt_uuid
{

  key _Market.mrkt_uuid,
      _Market.prod_uuid,
      _MID.MarketId as id,
      _MID.ImageUrl as MrktImgUrl,
      @Consumption.valueHelpDefinition: [{  entity: {   name: 'ZAR_I_MARKET',
                                            element:    'MarketName' } }]
      @Search: {
         defaultSearchElement: true,
         ranking: #HIGH,
         fuzzinessThreshold: 0.8
        }
      _Market.mrktid,
      _Market.status,
      case status
      when 'X' then 3
      else 1
      end                                        as criticality,
      _Market.startdate,
      _Market.enddate,
      //Admin Data
      _CreateUser.appuser as createuser,
      @Semantics.user.createdBy: true
      _Market.created_by,
      @Semantics.systemDateTime.createdAt: true
      cast( _Market.creation_time as timestamp ) as creation_time,
      _ChangeUser.appuser as changeuser,
      @Semantics.user.lastChangedBy: true
      _Market.changed_by,
      @Semantics.systemDateTime.lastChangedAt: true
      cast( _Market.change_time as timestamp )   as change_time,

//      @ObjectModel.readOnly: true
//      concat(concat('/webapp/images/markets/', cast(_mid.MarketId as abap.char( 3 )) ),'.png') as MrktImg,
//
//      @ObjectModel.readOnly: true
//      _total.MarketQuantity                                                                    as TotalQuantity,
//      @ObjectModel.readOnly: true
//      _total.MarketGrossAmount                                                                 as TotalGrossAmount,
//      @ObjectModel.readOnly: true
//      _total.MarketNetAmount                                                                   as TotalNetAmount,
      _Product,
      _MID,
      _CreateUser,
      _ChangeUser,
      _Order
}
