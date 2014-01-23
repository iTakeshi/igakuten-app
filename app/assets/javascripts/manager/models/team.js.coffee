class Team
    constructor: (id, name, quorums) ->
        @id   = id
        @name = name
        @quorums = ko.observableArray(quorums)

    quorum: (period) ->
        q = $.grep(@quorums(), (quorum) ->
            if period.id == quorum.period.id then true else false
        )[0]
        q.quorum

window.Team = Team
