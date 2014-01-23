#= require active_admin/base
#= require knockout
#= require_directory ./manager

$ ->
    vm = new ViewModel
    ko.applyBindings vm
