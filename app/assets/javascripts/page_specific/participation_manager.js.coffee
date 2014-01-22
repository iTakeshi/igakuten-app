$ ->
    class ViewModel
        constructor: (teams, staffs) ->
            @teams  = ko.observableArray(teams)
            @staffs = ko.observableArray(staffs)

    periods        = window.DataLoader.loadPeriods()
    quorums        = window.DataLoader.loadQuorums(periods)
    teams          = window.DataLoader.loadTeams(quorums)
    participations = window.DataLoader.loadParticipations(teams)
    shifts         = window.DataLoader.loadShifts(participations, periods)
    staffs         = window.DataLoader.loadStaffs(participations, shifts)

    vm = new ViewModel(teams, staffs)
    ko.applyBindings vm
