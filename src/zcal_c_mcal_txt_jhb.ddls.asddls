@EndUserText.label: 'Holiday text'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity ZCAL_C_MCAL_TXT_JHB
 as projection on zcal_i_mcal_txt_JHB
{
      @Consumption.valueHelpDefinition: [ {entity: {name: 'I_Language', element: 'Language' }} ]
      @ObjectModel.text.element:['LanguageDescription']
  key Language,
  key Holiday,
      @Consumption.hidden: true
      HolidayAllID,
      HolidayDescription,
      _LanguageText.LanguageName as LanguageDescription : localized,
      _Public_Holiday : redirected to parent ZCAL_C_MCAL_JHB,
      _HolidayAll     : redirected to ZCAL_C_MCAL_ALL_JHB
}
