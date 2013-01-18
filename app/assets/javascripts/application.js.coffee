### Kill Bills ###
#
#= require_self
#
#// Gems
#= require jquery
#= require turbolinks
#= require jquery.turbolinks
#= require jquery_ujs
#= require underscore
#= require backbone
#= require bootstrap-alert
#= require bootstrap-button
#= require bootstrap-collapse
#= require bootstrap-dropdown
#= require i18n
#= require i18n/translations
#
#// Helpers
#= require pies
#= require helpers
#
#// App
#= require_tree ./models
#= require_tree ./collections
#= require_tree ./views
#= require_tree ./templates
#= require killbills

@KillBills ||= {}
@KillBills.Models ||= {}
@KillBills.Collections ||= {}
@KillBills.Routers ||= {}
@KillBills.Views ||= {}
@KillBills.topView ||= null
