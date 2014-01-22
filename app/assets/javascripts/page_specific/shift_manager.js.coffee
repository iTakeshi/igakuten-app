$ ->
    class ViewModel
        constructor: (staffs, periods, teams) ->
            @staffs  = ko.observableArray(staffs)
            @periods = ko.observableArray(periods)
            @teams   = ko.observableArray(teams)
            @selectedTeam = ko.observable()



    periods = []
    $.ajax '/periods.json',
        async: false,
        dataType: 'json',
        success: (data) ->
            periods = data

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
            participations = $.map data, (participation) ->
                new window.Participation participation.id,
                    $.grep(teams, (team) ->
                        if participation.team_id == team.id then true else false
                    )[0],
                    participation.staff_id

    shifts = []
    $.ajax '/shifts.json',
        async: false,
        dataType: 'json',
        success: (data) ->
            shifts = $.map data, (shift) ->
                new window.Shift shift.id,
                    $.grep(participations, (participation) ->
                        if shift.participation_id == participation.id then true else false
                    )[0],
                    $.grep(periods, (period) ->
                        if shift.period_id == period.id then true else false
                    )[0]

    staffs = []
    $.ajax '/staffs.json',
        async: false,
        dataType: 'json',
        success: (data) ->
            staffs = $.map data, (staff) ->
                new window.Staff staff.id,
                    staff.grade,
                    staff.gender_to_s,
                    staff.full_name,
                    $.grep participations, (participation) ->
                        if staff.id == participation.staff_id then true else false
                    $.grep shifts, (shift) ->
                        if staff.id == shift.participation.staff_id then true else false

    vm = new ViewModel(staffs, periods, teams)
    ko.applyBindings vm
