$ ->
    class ViewModel
        constructor: (teams, staffs) ->
            @teams  = ko.observableArray(teams)
            @staffs = ko.observableArray(staffs)


    teams = []
    $.ajax '/teams.json',
        async: false,
        dataType: 'json',
        success: (data) ->
            teams = data

    participations = []
    $.ajax '/participations.json',
        async: false,
        dataType: 'json',
        success: (data) ->
            participations = data

    staffs = []
    $.ajax '/staffs.json',
        async: false,
        dataType: 'json',
        success: (data) ->
            staffs = $.map data, (staff) ->
                new window.Staff staff.id,
                    staff.grade,
                    staff.gender_to_s,
                    staff.full_name,
                    $.grep participations, (participation) ->
                        if staff.id == participation.staff_id then true else false

    vm = new ViewModel(teams, staffs)
    ko.applyBindings vm
