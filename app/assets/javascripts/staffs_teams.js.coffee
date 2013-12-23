$ ->
    class StaffsTeamsModel
        constructor: (staffs, teams) ->
            @staffs = ko.observableArray(staffs)
            @teams = ko.observableArray(teams)

    staffs = []
    $.ajax '/staffs.json',
        async: false,
        dataType: 'json',
        success: (data) ->
            staffs = data

    teams = []
    $.ajax '/teams.json',
        async: false,
        dataType: 'json',
        success: (data) ->
            teams = data

    staffsTeamsModel = new StaffsTeamsModel(staffs, teams)
    ko.applyBindings staffsTeamsModel, $('#staffs-teams')[0]
