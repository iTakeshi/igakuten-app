$ ->
    class StaffsTeamsModel
        constructor: (staffs, teams) ->
            @staffs = ko.observableArray(staffs)
            @teams = ko.observableArray(teams)

    class Staff
        constructor: (id, grade, gender, name, teams) ->
            @id     = ko.observable(id)
            @grade  = ko.observable(grade)
            @gender = ko.observable(gender)
            @name   = ko.observable(name)
            @teams  = ko.observableArray(teams)

        participateIn: (team) ->
            if @teams.indexOf(team.id) == -1 then false else true

        participate: (team) =>
            $.ajax "/staffs/#{@id()}/participate/#{team.id}.json",
                dataType: 'json',
                type: 'POST',
                success: =>
                    @teams.push(team.id)

        unparticipate: (team) =>
            $.ajax "/staffs/#{@id()}/unparticipate/#{team.id}.json",
                dataType: 'json',
                type: 'POST',
                success: =>
                    @teams.splice(@teams.indexOf(team.id), 1)

        toggle: (team) =>
            if @participateIn(team)
                @unparticipate(team)
            else
                @participate(team)

    staffs = []
    $.ajax '/staffs.json',
        async: false,
        dataType: 'json',
        success: (data) ->
            staffs = $.map data, (staff) ->
                new Staff staff.id,
                    staff.grade,
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
