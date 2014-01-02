$ ->
    class ViewModel
        constructor: (teams, staffs) ->
            @teams  = ko.observableArray(teams)
            @staffs = ko.observableArray(staffs)

    class Staff
        constructor: (id, grade, gender, name, participations) ->
            @id      = ko.observable(id)
            @grade   = ko.observable(grade)
            @gender  = ko.observable(gender)
            @name    = ko.observable(name)
            @participations = ko.observableArray(participations)
            @teamIds = ko.computed =>
                $.map @participations(), (participation) ->
                    participation.team_id

        participateIn: (team) ->
            if @teamIds().indexOf(team.id) == -1 then false else true

        participate: (team) =>
            $.ajax "/staffs/#{@id()}/participate/#{team.id}.json",
                dataType: 'json',
                type: 'POST',
                success: =>
                    @teamIds.push(team.id)

        unparticipate: (team) =>
            $.ajax "/staffs/#{@id()}/unparticipate/#{team.id}.json",
                dataType: 'json',
                type: 'POST',
                success: =>
                    @teamIds.splice(@teamIds.indexOf(team.id), 1)

        toggle: (team) =>
            if @participateIn(team)
                @unparticipate(team)
            else
                @participate(team)

    teams = []
    $.ajax '/teams.json',
        async: false,
        dataType: 'json',
        success: (data) ->
            teams = data

    participations = []
    $.ajax '/participations.json',
        async: false,
        dataType: 'json',
        success: (data) ->
            participations = data

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
                    $.grep participations, (participation) ->
                        if staff.id == participation.staff_id then true else false

    vm = new ViewModel(teams, staffs)
    ko.applyBindings vm
