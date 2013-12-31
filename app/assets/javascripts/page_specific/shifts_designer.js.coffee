$ ->
    class ShiftDesignerModel
        constructor: (staffs, periods, teams) ->
            @staffs  = ko.observableArray(staffs)
            @periods = ko.observableArray(periods)
            @teams   = ko.observableArray(teams)
            @selectedTeam = ko.observable()

            @createShift = (staff, period) =>
                if @selectedTeam()
                    shift = new Shift period.id,
                        @selectedTeam().id
                        staff.id()
                    $.ajax '/shifts',
                        type: 'POST',
                        data: { "shift": ko.toJS(shift) }
                        dataType: 'json',
                        success: (data) =>
                            staff.shifts.push(shift)
                        error: (data) =>
                            console.log JSON.stringify data.responseJSON.errors
                else
                    return false

    class Staff
        constructor: (id, grade, gender, name, shifts) ->
            @id     = ko.observable(id)
            @grade  = ko.observable(grade)
            @gender = ko.observable(gender)
            @name   = ko.observable(name)
            @shifts = ko.observableArray(shifts)

        teamWorkingWith: (period) ->
            shift = $.grep @shifts(), (shift) ->
                if period.id == shift.period_id() then true else false
            switch shift.length
                when 0
                    ""
                when 1
                    team = $.grep Staff.teams, (team) ->
                        if shift[0].team_id() == team.id then true else false
                    team[0].name
                else
                    console.log 'Error: conflicting shifts'
                    ""

    class Shift
        constructor: (period_id, team_id, staff_id) ->
            @period_id = ko.observable(period_id)
            @team_id   = ko.observable(team_id)
            @staff_id  = ko.observable(staff_id)

    shifts = []
    $.ajax '/shifts.json',
        async: false,
        dataType: 'json',
        success: (data) ->
            shifts = $.map data, (shift) ->
                new Shift shift.period_id,
                    shift.team_id,
                    shift.staff_id

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
                    $.grep shifts, (shift) ->
                        if staff.id == shift.staff_id() then true else false

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
    Staff.teams = teams

    shiftDesignerModel = new ShiftDesignerModel(staffs, periods, teams)
    ko.applyBindings shiftDesignerModel
