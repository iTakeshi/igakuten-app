$ ->
    class ViewModel
        constructor: (staffs, periods, teams) ->
            @staffs  = ko.observableArray(staffs)
            @periods = ko.observableArray(periods)
            @teams   = ko.observableArray(teams)
            @selectedTeam = ko.observable()

            @createShift = (staff, period) =>
                if @selectedTeam()
                    shift = new Shift null,
                        period.id,
                        @selectedTeam().id
                        staff.id()
                    $.ajax '/shifts',
                        type: 'POST',
                        data: { "shift": ko.toJS(shift) },
                        dataType: 'json',
                        success: (data) =>
                            shift.id(data.shift.id)
                            staff.shifts.push(shift)
                        error: (data) =>
                            console.log JSON.stringify data.responseJSON.errors
                else
                    return false

    class Staff
        constructor: (id, grade, gender, name, participations, shifts) ->
            @id     = ko.observable(id)
            @grade  = ko.observable(grade)
            @gender = ko.observable(gender)
            @name   = ko.observable(name)
            @participations = ko.observableArray(participations)
            @shifts         = ko.observableArray(shifts)

        teamWorkingWith: (period) ->
            shift = $.grep(@shifts(), (shift) ->
                if period.id == shift.period.id then true else false
            )[0]
            if shift
                shift.participation.team.name
            else
                false

        destroyShift: (period) ->
            shift = $.grep @shifts(), (shift) ->
                if period.id == shift.period_id() then true else false
            return false unless shift[0]
            $.ajax "/shifts/#{shift[0].id()}",
                type: 'DELETE',
                dataType: 'json',
                success: (data) =>
                    @shifts.splice(@shifts.indexOf(shift[0]), 1)

    class Participation
        constructor: (id, team, staff_id) ->
            @id       = id
            @team     = team
            @staff_id = staff_id

    class Shift
        constructor: (id, participation, period) ->
            @id            = id
            @participation = participation
            @period        = period

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
                new Participation participation.id,
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
                new Shift shift.id,
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
                new Staff staff.id,
                    staff.grade,
                    staff.gender_to_s,
                    staff.full_name,
                    $.grep participations, (participation) ->
                        if staff.id == participation.staff_id then true else false
                    $.grep shifts, (shift) ->
                        if staff.id == shift.participation.staff_id then true else false

    vm = new ViewModel(staffs, periods, teams)
    ko.applyBindings vm
