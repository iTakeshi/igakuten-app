$ ->
    class ViewModel
        constructor: (periods, teams) ->
            @periods = ko.observableArray(periods)
            @teams   = ko.observableArray(teams)

        updateQuorum: (period, team, num) ->
            q = $.grep(team.quorums(), (quorum) ->
                if period.id == quorum.period.id then true else false
            )[0]
            q.set(num)



    periods = []
    $.ajax '/periods.json',
        async: false,
        dataType: 'json',
        success: (data) ->
            periods = data

    quorums = []
    $.ajax '/quorums.json',
        async: false,
        dataType: 'json',
        success: (data) ->
            quorums = $.map data, (quorum) ->
                new window.Quorum quorum.id,
                    $.grep(periods, (period) ->
                        if quorum.period_id == period.id then true else false
                    )[0],
                    quorum.team_id,
                    quorum.quorum

    teams = []
    $.ajax '/teams.json',
        async: false,
        dataType: 'json',
        success: (data) ->
            teams = $.map data, (team) ->
                new window.Team team.id,
                    team.name
                    $.grep quorums, (quorum) ->
                        if team.id == quorum.team_id then true else false

    vm = new ViewModel(periods, teams)
    ko.applyBindings(vm)
