class Quorum
    constructor: (id, period, team_id, quorum) ->
        @id      = id
        @period  = period
        @team_id = team_id
        @quorum = ko.observable(quorum)

    set: (num) ->
        $.ajax "/quorums/#{@id}",
            type: 'PUT',
            data: { "quorum": { "quorum": num } },
            dataType: 'json',
            success: (data) =>
                @quorum(data.quorum.quorum)

window.Quorum = Quorum
