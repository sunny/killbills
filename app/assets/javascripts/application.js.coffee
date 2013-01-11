### Kill Bills ###
#
#= require_self
#
#// Gems
#= require jquery
#= require jquery_ujs
#= require underscore
#= require backbone
#= require bootstrap-alert
#= require bootstrap-button
#= require bootstrap-collapse
#= require bootstrap-dropdown
#= require turbolinks
#= require i18n
#= require i18n/translations
#
#// Vendor
#= require raphael
#= require g.raphael
#= require g.pie
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

@KillBills ||=
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}
  topView: null
