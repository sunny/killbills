//= require jquery
//= require jquery_ujs

//= require bootstrap-alert
//= require bootstrap-button

//= require raphael
//= require g.raphael
//= require g.pie
//= require pies

//= require helpers
//= require bills

jQuery ->

  new Bill($('#bill-form'))
  $('#bill-form select').selectNewValue('New friend...', 'Enter name')

  $('#pies').friendsPies('.friend')

  $('html').removeClass('nojs').addClass('jsloaded')

