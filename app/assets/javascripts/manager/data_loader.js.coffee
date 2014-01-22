class DataLoader
    @loadParticipations = (teams) ->
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
        participations

    @loadPeriods = ->
        periods = []
        $.ajax '/periods.json',
            async: false,
            dataType: 'json',
            success: (data) ->
                periods = data
        periods

    @loadQuorums = (periods) ->
        quorums = []
        $.ajax '/quorums.json',
            async: false,
            dataType: 'json',
            success: (data) ->
                quorums = $.map data, (quorum) ->
                    new Quorum quorum.id,
                        $.grep(periods, (period) ->
                            if quorum.period_id == period.id then true else false
                        )[0],
                        quorum.team_id,
                        quorum.quorum
        quorums

    @loadShifts = (participations, periods) ->
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
        shifts

    @loadStaffs = (participations, shifts) ->
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
        staffs

    @loadTeams = (quorums) ->
        teams = []
        $.ajax '/teams.json',
            async: false,
            dataType: 'json',
            success: (data) ->
                teams = $.map data, (team) ->
                    new Team team.id,
                        team.name
                        $.grep quorums, (quorum) ->
                            if team.id == quorum.team_id then true else false
        teams

window.DataLoader = DataLoader
