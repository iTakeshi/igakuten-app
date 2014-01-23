class Shift
    constructor: (id, participation, period) ->
        @id            = id
        @participation = participation
        @period        = period

    toParams: ->
        {
            participation_id: @participation.id,
            period_id: @period.id
        }

window.Shift = Shift
