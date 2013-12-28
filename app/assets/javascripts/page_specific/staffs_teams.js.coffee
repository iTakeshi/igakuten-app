$ ->
    class StaffsTeamsModel
        constructor: (staffs, teams) ->
            @staffs = ko.observableArray(staffs)
            @teams = ko.observableArray(teams)

    class Staff
        constructor: (grade, gender, name, teams) ->
            @grade  = ko.observable(grade)
            @gender = ko.observable(gender)
            @name   = ko.observable(name)
            @teams  = ko.observableArray(teams)

        participate_in: (team_id) ->
            if @teams.indexOf(team_id) == -1 then false else true

    staffs = []
    $.ajax '/staffs.json',
        async: false,
        dataType: 'json',
        success: (data) ->
            staffs = $.map data, (staff) ->
                new Staff staff.grade,
                    staff.gender_to_s,
                    staff.full_name,
                    $.map staff.teams, (team) ->
                        team.id

    teams = []
    $.ajax '/teams.json',
        async: false,
        dataType: 'json',
        success: (data) ->
            teams = data

    staffsTeamsModel = new StaffsTeamsModel(staffs, teams)
    ko.applyBindings staffsTeamsModel
