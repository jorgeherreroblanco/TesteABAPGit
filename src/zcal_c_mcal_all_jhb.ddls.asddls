@EndUserText.label: 'Projection Singleton'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: ['HolidayAllID']
define root view entity ZCAL_C_MCAL_ALL_JHB
  provider contract transactional_query
  as projection on zcal_i_mcal_all_JHB
{
  key HolidayAllID,
      LastChangedAtMax,
      LocalLastChangedAtMax,
      Request,
      HideTransport,
      _Holiday : redirected to composition child ZCAL_C_MCAL_JHB
}
