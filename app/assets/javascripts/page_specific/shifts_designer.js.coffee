$ ->
    class ShiftDesignerModel
        constructor: (staffs, periods) ->
            @staffs  = ko.observableArray(staffs)
            @periods = ko.observableArray(periods)

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
                    shift[0].team_id()
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

    shiftDesignerModel = new ShiftDesignerModel(staffs, periods)
    ko.applyBindings shiftDesignerModel
