//= require jquery
//= require jquery_ujs
//= require bootstrap-alert
//= require bootstrap-button
//= require helpers
//= require bills

jQuery ->
  billForm = $('#bill-form')
  if billForm.length
    new Bill(billForm)
    billForm.find(".people select")
             .selectNewValue("New friend...", "Enter name")

