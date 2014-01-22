class Participation
    constructor: (id, team, staff_id) ->
        @id       = id
        @team     = team
        @staff_id = staff_id

    toParams: ->
        {
            team_id: @team.id,
            staff_id: @staff_id
        }

window.Participation = Participation
