#= require_directory ./models
#= require ./data_loader.js.coffee
#= require ./view_model.js.coffee
#= require_directory .

$ ->
    vm = new ViewModel
    ko.applyBindings(vm)
