#= require active_admin/base
#= require knockout
#= require_tree ./manager

$ ->
    vm = new ViewModel
    ko.applyBindings vm
