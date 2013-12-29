$ ->
    class StaffsRecessesModel
        constructor: (staffs, periods) ->
            @staffs  = ko.observableArray(staffs)
            @periods = ko.observableArray(periods)

    class Staff

        constructor: (id, grade, gender, name, recesses) ->
            @id        = ko.observable(id)
            @grade     = ko.observable(grade)
            @gender    = ko.observable(gender)
            @name      = ko.observable(name)
            @recesses  = ko.observableArray(recesses)

        recessing: (period) ->
            if @recesses.indexOf(period.id) == -1 then false else true

        recess: (period) =>
            $.ajax "/staffs/#{@id()}/recess/#{period.id}.json",
                dataType: 'json',
                type: 'POST',
                success: =>
                    @recesses.push(period.id)

        return: (period) =>
            $.ajax "/staffs/#{@id()}/return/#{period.id}.json",
                dataType: 'json',
                type: 'POST',
                success: =>
                    @recesses.splice(@recesses.indexOf(period.id), 1)

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
                    $.map staff.recesses, (period) ->
                        period.id

    periods = []
    $.ajax '/periods.json',
        async: false,
        dataType: 'json',
        success: (data) ->
            periods = data

    staffsRecessesModel = new StaffsRecessesModel(staffs, periods)
    ko.applyBindings staffsRecessesModel
