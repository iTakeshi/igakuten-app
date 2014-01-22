class Staff
    constructor: (id, grade, gender, name, participations, shifts) ->
        @id     = ko.observable(id)
        @grade  = ko.observable(grade)
        @gender = ko.observable(gender)
        @name   = ko.observable(name)
        @participations = ko.observableArray(participations)
        @shifts         = ko.observableArray(shifts)
        @teamIds = ko.computed =>
            $.map @participations(), (participation) ->
                participation.team_id

    participateIn: (team) ->
        if @teamIds().indexOf(team.id) == -1 then false else true

    participate: (team) ->
        participation = { team_id: team.id, staff_id: @id() }
        $.ajax "/participations",
            type: 'POST',
            data: { "participation": participation },
            dataType: 'json',
            success: (data) =>
                @participations.push(data.participation)

    unparticipate: (team) ->
        p = $.grep(@participations(), (participation) =>
            if team.id == participation.team_id then true else false
        )[0]
        $.ajax "/participations/#{p.id}",
            type: 'DELETE',
            dataType: 'json',
            success: =>
                @participations.splice(@participations.indexOf(p), 1)

    toggleParticipation: (team) ->
        if @participateIn(team)
            @unparticipate(team)
        else
            @participate(team)

    teamWorkingWith: (period) ->
        shift = $.grep(@shifts(), (shift) ->
            if period.id == shift.period.id then true else false
        )[0]
        if shift
            shift.participation.team.name
        else
            false

    createShift: (period, team) ->
        if team
            participation = $.grep(@participations(), (participation) ->
                if team.id == participation.team.id then true else false
            )[0]
            unless participation
                console.log 'A staff can NOT work with the team he/she doesn\'t participate in'
                return false
            shift = new Shift null,
                participation,
                period
            $.ajax '/shifts',
                type: 'POST',
                data: { "shift": shift.toParams() },
                dataType: 'json',
                success: (data) =>
                    shift.id = data.shift.id
                    @shifts.push(shift)
        else
            return false

    destroyShift: (period) ->
        shift = $.grep(@shifts(), (shift) ->
            if period.id == shift.period.id then true else false
        )[0]
        return false unless shift
        $.ajax "/shifts/#{shift.id}",
            type: 'DELETE',
            dataType: 'json',
            success: (data) =>
                @shifts.splice(@shifts.indexOf(shift), 1)

window.Staff = Staff
