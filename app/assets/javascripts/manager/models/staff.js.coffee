class Staff
    constructor: (id, grade, gender, name, participations, shifts) ->
        @id     = ko.observable(id)
        @grade  = ko.observable(grade)
        @gender = ko.observable(gender)
        @name   = ko.observable(name)
        @participations = ko.observableArray(participations)
        @shifts         = ko.observableArray(shifts)

    findParticipation: (team) ->
        $.grep(@participations(), (participation) ->
            if team.id == participation.team.id then true else false
        )[0]

    participate: (team) ->
        participation = new Participation null,
            team,
            @id()
        $.ajax "/participations",
            type: 'POST',
            data: { "participation": participation.toParams() },
            dataType: 'json',
            success: (data) =>
                participation.id = data.participation.id
                @participations.push(participation)

    unparticipate: (team) ->
        p = @findParticipation(team)
        $.ajax "/participations/#{p.id}",
            type: 'DELETE',
            dataType: 'json',
            success: =>
                @participations.splice(@participations.indexOf(p), 1)

    toggleParticipation: (team) ->
        if @findParticipation(team)
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
            ""

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
