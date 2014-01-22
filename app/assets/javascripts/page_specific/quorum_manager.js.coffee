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

    periods        = window.DataLoader.loadPeriods()
    quorums        = window.DataLoader.loadQuorums(periods)
    teams          = window.DataLoader.loadTeams(quorums)
    participations = window.DataLoader.loadParticipations(teams)
    shifts         = window.DataLoader.loadShifts(participations, periods)
    staffs         = window.DataLoader.loadStaffs(participations, shifts)

    vm = new ViewModel(periods, teams)
    ko.applyBindings(vm)
