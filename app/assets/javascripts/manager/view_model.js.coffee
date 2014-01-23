class ViewModel
    constructor: ->
        periods        = DataLoader.loadPeriods()
        quorums        = DataLoader.loadQuorums(periods)
        teams          = DataLoader.loadTeams(quorums)
        participations = DataLoader.loadParticipations(teams)
        shifts         = DataLoader.loadShifts(participations, periods)
        staffs         = DataLoader.loadStaffs(participations, shifts)
        @periods        = ko.observableArray(periods)
        @quorums        = ko.observableArray(quorums)
        @teams          = ko.observableArray(teams)
        @participations = ko.observableArray(participations)
        @shifts         = ko.observableArray(shifts)
        @staffs         = ko.observableArray(staffs)

    # QuorumManager specific
    updateQuorum: (period, team, num) ->
        q = $.grep(team.quorums(), (quorum) ->
            if period.id == quorum.period.id then true else false
        )[0]
        q.set(num)

window.ViewModel = ViewModel
