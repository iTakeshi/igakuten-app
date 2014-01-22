$ ->
    class ViewModel
        constructor: (staffs, periods, teams) ->
            @staffs  = ko.observableArray(staffs)
            @periods = ko.observableArray(periods)
            @teams   = ko.observableArray(teams)
            @selectedTeam = ko.observable()

    periods        = window.DataLoader.loadPeriods()
    quorums        = window.DataLoader.loadQuorums(periods)
    teams          = window.DataLoader.loadTeams(quorums)
    participations = window.DataLoader.loadParticipations(teams)
    shifts         = window.DataLoader.loadShifts(participations, periods)
    staffs         = window.DataLoader.loadStaffs(participations, shifts)

    vm = new ViewModel(staffs, periods, teams)
    ko.applyBindings vm
